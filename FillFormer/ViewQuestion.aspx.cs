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
using System.Data.SqlClient;
using AjaxControlToolkit;
using PersianDateControls;


public partial class ViewQuestion : System.Web.UI.Page
{
    String FID;
    String Ansid;
    String mode;
    bool completepage = true;
    bool numquestion = false;
    bool noquestion = false;
    bool nooption = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        String FID = Request.QueryString["Fid"];
        if (!ORM.Group_Permissions.get_Permission(FID, Profile.UserName)._writable)
            Response.Redirect("error.aspx", true);
        else
        {
            ORM.HTML_Forms thisform = new ORM.HTML_Forms(new ORM.Forms(FID), this);
            Panel1.Controls.Add(thisform.Get_Html());
            Int64 fid = 0;

            if (Request.QueryString["FID"] == null
                || !Int64.TryParse(Request.QueryString["FID"], out fid)
                || (Request.QueryString["AnsID"] != null
                && !Int64.TryParse(Request.QueryString["AnsID"], out fid)))
                Response.Redirect("homepage.aspx", true);

            FID = Request.QueryString["Fid"];
            Ansid = Request.QueryString["ansid"];

            // آيا Fid وجود دارد.
            if (Request.QueryString["FID"] != null)
            {
                FID = Request.QueryString["FID"].ToString();
                ORM.Forms thisform1 = new ORM.Forms(FID);
                lblFname.Text = thisform1.Form_Name;
            }
        }
    }

    Literal GetLiteral(String litstr)
    {
        Literal l = new Literal();
        l.Text = litstr;
        return l;
    }

    void AddFirstSection()
    {
        Panel1.Controls.Add(GetLiteral("<Table width='100%' style='Border:solid 1px #0676c4;background-color:#d0e4f2;'><tr><td>"));
    }

    void AddLastSection()
    {
        Panel1.Controls.Add(GetLiteral("</td></tr></table><br/>"));
    }

    int Select(ListItemCollection licol, String val)
    {
        for (int i = 0; i < licol.Count; i++)
        {
            if (licol[i].Value == val)
            {
                licol[i].Selected = true;
                return i;
            }
        }
        return -1;
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        string userIdentityName = User.Identity.Name;
               
        String FID = Request.QueryString["fid"];
        ORM.HTML_Forms localform = new ORM.HTML_Forms(new ORM.Forms(FID), this);
        if (localform.register_form(Panel1, FID, userIdentityName))
            Response.Redirect("ViewQuestionResult.aspx?fid=" + Request.QueryString["fid"]);
        else
        {
            Alert.Show("لطفاَ به تمام سئوالات پاسخ دهید");

        }
    }
}
