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
    
    protected void Page_Load(object sender, EventArgs e)
    {

        String FID = Request.QueryString["Fid"];
        String Ansid;
                
        ORM.HTML_Forms thisform = new ORM.HTML_Forms(new ORM.Forms(FID),this);
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

    protected void Button1_Click1(object sender, EventArgs e)
    {
        string userIdentityName = User.Identity.Name;

        String FID = Request.QueryString["fid"];
        String TYPE = "1";
        ORM.HTML_Forms localform = new ORM.HTML_Forms(new ORM.Forms(FID),this);
        if (localform.register_form(Panel1, FID, userIdentityName))
            Response.Redirect("ViewQuestionResult.aspx?fid=" + Request.QueryString["fid"] + "&type=" + TYPE);
        else
        {
            Alert.Show("لطفاَ به تمام سئوالات به صورت مناسب پاسخ دهید");
            
        }
    }
}
