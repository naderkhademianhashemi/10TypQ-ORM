using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.DirectoryServices;
using System.DirectoryServices.Protocols;
using System.DirectoryServices.ActiveDirectory;
using System.DirectoryServices.AccountManagement;
using System.Net;
using System.Security.Principal;
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    List<string> userList = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Application["Users"] == null)
            userList = new List<string>();
        else
            userList = Application["Users"] as List<string>;

    }
    protected void Login1_LoggedIn(object sender, EventArgs e)
    {
        userList.Add(Login1.UserName);
        Application["Users"] = userList;


        if (Roles.IsUserInRole(Login1.UserName, "admin"))
            Response.Redirect("admin/homepage.aspx", true);
        else
            Response.Redirect("Fillformer/homepage.aspx", true);
    }
    //only SSO users can login (OPriskAspdb_1 database Users can not login)
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        e.Authenticated = validateUserInAD(Login1.UserName, Login1.Password);
        if (e.Authenticated)
            FormsAuthentication.RedirectFromLoginPage(
                userName: Login1.UserName, createPersistentCookie: false);
    }

    protected void LoginButton_Click(object sender, EventArgs e)
    {
        bool valUser = false;

        if (Login1.UserName != null && Login1.Password != null)
        {
            string username = Login1.UserName;
            string password = Login1.Password;
            String strConnection1 = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            SqlConnection cnn1 = new SqlConnection(strConnection1);
            SqlCommand com = new SqlCommand();
            valUser = validateUserInAD(Login1.UserName, Login1.Password);
            try
            {

                if (valUser == true)
                {
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@ApplicationName", "orm");
                    com.Parameters.AddWithValue("@UserName", Login1.UserName.ToString());
                    com.Parameters.AddWithValue("@NewPassword", Login1.Password.ToString());
                    com.Parameters.AddWithValue("@PasswordFormat", "0");
                    com.Parameters.AddWithValue("@PasswordSalt", "1");
                    com.Parameters.AddWithValue("@CurrentTimeUtc", DateTime.Now);
                    com.CommandText = "aspnet_Membership_SetPassword";
                    com.Connection = cnn1;
                    cnn1.Open();
                    com.ExecuteNonQuery();
                    cnn1.Close();
                }
            }
            catch (Exception ex)
            {


            }
            finally
            {
                cnn1.Close();
            }
        }
    }

    public static bool validateUserInAD(string uname, string pass)
    {
        bool isValid = false;
        using (PrincipalContext pc = new PrincipalContext(ContextType.Domain, "AB.NET"))
        {
            isValid = pc.ValidateCredentials(uname, pass);
        }
        return isValid;
    }

}
