using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class EditUser : System.Web.UI.Page
{

    
    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUser myuser = Membership.GetUser(Server.HtmlDecode(Request.QueryString["u"]));
        
        if (Request.QueryString["u"] == null || myuser == null)
            Response.Redirect("homepage.aspx");
        if (!IsPostBack)
        {
            chkSetActive.Checked = myuser.IsLockedOut;
            DropDownList1.DataBind();
            DropDownList2.DataBind();
            if (DropDownList1.Items.Count == 0 || DropDownList2.Items.Count == 0)
            {
                Alert.Show("جداول استان و دپارتمان خالی هستند. لطفا بعدا اقدام کنید.");
                Response.Redirect("homepage.aspx", true );
            }
            GridView1.DataSource = Membership.FindUsersByName(Server.HtmlDecode(Request.QueryString["u"]));
            GridView1.DataBind();
            ProfileCommon p = Profile.GetProfile(Server.HtmlDecode(Request.QueryString["u"]));
            DropDownList1.SelectedValue = p.Department.ToString();
            DropDownList2.SelectedValue = p.Location.ToString();
            if (Roles.IsUserInRole(Server.HtmlDecode(Request.QueryString["u"]), "admin"))
                DropDownList3.SelectedIndex=0;// "کاربر مدیر سایت";
            else if (Roles.IsUserInRole(Server.HtmlDecode(Request.QueryString["u"]), "FillFormer"))
                DropDownList3.SelectedIndex = 1;// = "کاربر پرکننده اطلاعات";
        }
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {

        String strConnection1 = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ORM_ConnectionString"].ConnectionString;
        SqlConnection cnn1 = new SqlConnection(strConnection1);
        SqlCommand com = new SqlCommand();
        SqlDataReader dr = null;
        com.Connection = cnn1;
        com.Parameters.AddWithValue("@uname", " ");
        try
        {
            cnn1.Open();
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                ProfileCommon p = Profile.GetProfile(GridView1.Rows[i].Cells[0].Text);
                //com.CommandText = "select locname from _prisk_location where locid = " + p.Location.ToString();
                //GridView1.Rows[i].Cells[2].Text = com.ExecuteScalar().ToString();
                com.CommandText = "select depname from department where depid = " + p.Department.ToString();
                GridView1.Rows[i].Cells[3].Text = com.ExecuteScalar().ToString();
                string sx = p.UserName.ToString();

                com.Parameters[0].Value = sx;


                com.CommandText = "select Semat from [FG_DB].[dbo].[Orm_Personnel_Info] where U_Name = @uname";
                GridView1.Rows[i].Cells[6].Text = com.ExecuteScalar().ToString();


                com.CommandText = "select CodeMahalKhedmat from [FG_DB].[dbo].[Orm_Personnel_Info] where U_Name = @uname";
                GridView1.Rows[i].Cells[7].Text = com.ExecuteScalar().ToString();

                com.CommandText = "select MahalKhedmat from [FG_DB].[dbo].[Orm_Personnel_Info] where U_Name = @uname";
                GridView1.Rows[i].Cells[8].Text = com.ExecuteScalar().ToString();
                if (Roles.IsUserInRole(GridView1.Rows[i].Cells[0].Text, "admin"))
                    GridView1.Rows[i].Cells[4].Text = "کاربر مدیر سایت";
                else if (Roles.IsUserInRole(GridView1.Rows[i].Cells[0].Text, "FillFormer"))
                    GridView1.Rows[i].Cells[4].Text = "کاربر پرکننده اطلاعات";
            }
            cnn1.Close();

        }
        catch (Exception exp)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(exp.Message);
            cnn1.Close();
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        String uname = Server.HtmlDecode(Request.QueryString["u"]);
        MembershipUser myuser = Membership.GetUser(Server.HtmlDecode(Request.QueryString["u"]));
        ProfileCommon p = Profile.GetProfile(uname );
        p.Location = Int64.Parse(DropDownList2.SelectedValue);
        p.Department = Int64.Parse(DropDownList1.SelectedValue);
        p.Save();
        if (Roles.IsUserInRole(uname, "admin"))
            Roles.RemoveUserFromRole(uname,"admin");
        if (Roles.IsUserInRole(uname, "FillFormer"))
            Roles.RemoveUserFromRole(uname ,"FillFormer");
        switch (DropDownList3.SelectedValue)
        {
            case "FillFormer":
                Roles.AddUserToRole(uname, "FillFormer");
                break;
            case "admin":
                Roles.AddUserToRole(uname, "admin");
                break;
        }
        if (!chkSetActive.Checked && myuser.IsLockedOut)
        {
            myuser.UnlockUser();
            chkSetActive.Checked = false;
        }
        else if (!myuser.IsLockedOut)
            chkSetActive.Checked = false;
        
        GridView1.DataSource = Membership.FindUsersByName(Server.HtmlDecode(Request.QueryString["u"]));
        GridView1.DataBind();
    }
    
}
