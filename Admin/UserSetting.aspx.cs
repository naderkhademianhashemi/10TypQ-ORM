using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;

public partial class UserSetting : System.Web.UI.Page
{
    FG_DB_DataSet _ds = new FG_DB_DataSet();
    SQL_Connector _sql_con = new SQL_Connector();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
            return;

        txtSearch.Focus();
        Label1.Text = lblGroup.Text = Request.QueryString["GName"];
        FillGridView_01();
        lblAdminSetting.Text = " تعیین ارشد گروه" + "&nbsp" + Request.QueryString["GName"];
        lblFormSetting.Text = " تعیین فرم های گروه" + "&nbsp" + Request.QueryString["GName"];
    }


    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        //تیک گذاشتن یا برداشتن تیک عضویت
        GridView1_CheckBoxBound();
    }

    /// <summary>
    /// تیک گذاشتن یا برداشتن تیک عضویت
    /// </summary>
    public void GridView1_CheckBoxBound()
    {
        ORM.Groups localgroup = new ORM.Groups(Request.QueryString["gid"]);
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            var tmpUserName = (GridView1.Rows[i].FindControl("lblUser_Name") as Label)
                .Text.Trim().ToLower();
            var tmpCbSelect = GridView1.Rows[i].FindControl("cbSelect") as CheckBox;
            //آیا نام کاربری سطر فعلی آی در گروه لوکال گروپ هست 
            if (localgroup.Have_User(tmpUserName))
                tmpCbSelect.Checked = true;
            else
                tmpCbSelect.Checked = false;
        }//end for
    }
    //دقیقا قبل از تغییر ایندکس صفحه ،این متد اجرا می شود
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;

        if (txtSearch.Text.Length > 2 && txtSearch.Text.Length < 50)
        {
            FillGridViewBySematOrUserName(txtSearch.Text);
        }
        else
        {
            FillGridView_01();
        }

    }

    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        //با هر بار جستجوی جدید ایندکس صفحه به مقدار اولیه اش بر می گردد. 
        GridView1.PageIndex = 0;
        txtCodePerson.Text = string.Empty;
        if (txtSearch.Text.Length > 2 && txtSearch.Text.Length < 50)
        {
            FillGridViewBySematOrUserName(txtSearch.Text);
        }
        else
        {
            FillGridView_01();
        }
    }

    /// <summary>
    /// select username and semat  and Fill GridView1
    /// </summary>
    protected void FillGridView_01()
    {
        DataTable dt = _ds.GetDT_PRSNL();

        GridView1.DataSource = null;
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }

    /// <summary>
    /// select username and semat based on username or Semat entered in txtSearch TextBox and Fill GridView1
    /// </summary>
    /// <param name="input"></param>
    protected void FillGridViewBySematOrUserName(string input)
    {
        DataTable dt = _ds.GetDT_PRSNL_ByUser(input.Trim());
        DataTable dt2 = _ds.GetDT_PRSNL_BySemat(input.Trim());

        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = null;
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        if (dt.Rows.Count <= 0 && dt2.Rows.Count > 0)
        {
            GridView1.DataSource = null;
            GridView1.DataSource = dt2;
            GridView1.DataBind();
        }
        if (dt.Rows.Count <= 0 && dt2.Rows.Count <= 0)
        {
            txtSearch.Text = "";
            FillGridView_01();
        }
    }


    #region تغییر عضویت
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

        if (txtSearch.Text.Length <= 0 || txtCodePerson.Text.Length <= 0)
        {
            GridView1.EditIndex = e.NewEditIndex;
            if (txtSearch.Text.Length > 2 && txtSearch.Text.Length < 50)
            {
                FillGridViewBySematOrUserName(txtSearch.Text);
            }
            int result;
            bool isInteger = Int32.TryParse(txtCodePerson.Text, out result);
            //چک کردن فرمت تکس باکس و طول آن
            if (txtCodePerson.Text.Length > 0 && isInteger)
            {
                SearchByCodePersenely(txtCodePerson.Text);
            }
            if (txtCodePerson.Text.Length <= 0 && txtSearch.Text.Length <= 0)
            {
                FillGridView_01();
            }
        }
        //اگر 2 تکس باکس همزمان تکمیل شده بودند .
        else
        {
            txtSearch.Text = string.Empty;

            string cleanMessage = "در هنگام ویرایش تک سطری ، هر دو ورودی نام کاربری و شماره پرسنلی همزمان نباید تکمیل باشند ";
            string script = "<script type=\"text/javascript\">alert('" + cleanMessage + "');</script>";

            this.ClientScript.RegisterClientScriptBlock(typeof(Alert), "alert", script);
        }
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        if (txtSearch.Text.Length > 2 && txtSearch.Text.Length < 50)
        {
            FillGridViewBySematOrUserName(txtSearch.Text);
        }
        int result;
        bool isInteger = Int32.TryParse(txtCodePerson.Text, out result);
        //چک کردن فرمت تکس باکس و طول آن
        if (txtCodePerson.Text.Length > 0 && isInteger)
        {
            SearchByCodePersenely(txtCodePerson.Text);
        }
        if (txtCodePerson.Text.Length <= 0 && txtSearch.Text.Length <= 0)
        {
            FillGridView_01();
        }
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        bool chk = false;
        string lblUser_Name = (GridView1.Rows[e.RowIndex].FindControl("lblUser_Name") as Label).Text;
        string Group_ID = Request.QueryString["gid"].ToString();


        //if checked
        //insert into [FG_DB].[dbo].[Group_Users] Table 
        chk = (GridView1.Rows[e.RowIndex].FindControl("cbSelect") as CheckBox).Checked;
        SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["ORM_ConnectionString"].ConnectionString);
        if (chk == true)
        {
            String sqlInsert = @"INSERT INTO Group_Users (Group_ID,User_Name)
                                                    VALUES(@Group_ID,@User_Name)";

            SqlCommand cmd = new SqlCommand(sqlInsert, con);
            cmd.Parameters.AddWithValue("@Group_ID", Group_ID);
            cmd.Parameters.AddWithValue("@User_Name", lblUser_Name);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        //else 
        //delete from [FG_DB].[dbo].[Group_Users] Table
        else
        {
            String sqlDelete = @"DELETE FROM Group_Users 
                           WHERE Group_ID=@Group_ID AND User_Name=@User_Name";

            SqlCommand cmd = new SqlCommand(sqlDelete, con);
            cmd.Parameters.AddWithValue("@Group_ID", Group_ID);
            cmd.Parameters.AddWithValue("@User_Name", lblUser_Name);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        GridView1.EditIndex = -1;
        if (txtSearch.Text.Length > 2 && txtSearch.Text.Length < 50)
        {
            FillGridViewBySematOrUserName(txtSearch.Text);
        }
        int result;
        bool isInteger = Int32.TryParse(txtCodePerson.Text, out result);
        //چک کردن فرمت تکس باکس و طول آن
        if (txtCodePerson.Text.Length > 0 && isInteger)
        {
            SearchByCodePersenely(txtCodePerson.Text);
        }
        if (txtCodePerson.Text.Length <= 0 && txtSearch.Text.Length <= 0)
        {
            FillGridView_01();
        }
    }

    #endregion تغییر عضویت

    #region تغییر عضویت براساس سمت 
    protected void btnAddMembers_Click(object sender, EventArgs e)
    {
        if (txtSemat.Text.Length < 3 || txtSemat.Text.Length > 50 || Request.QueryString["gid"] == null)
            return;


        var Group_ID = Request.QueryString["gid"].ToString();
        string Sql = "DELETE FROM Group_Users WHERE Group_ID=" + Group_ID +
                                                       @"AND User_Name IN 
                                                        (SELECT  UserName FROM V_OLTP_PRSNL_FG_DB_GRP 
                                                        WHERE Semat= N'" + txtSemat.Text + "') ";
        Sql += @"INSERT INTO Group_Users(Group_ID,User_Name)
                                            SELECT " + Group_ID + @",UserName
                                            FROM V_OLTP_PRSNL_FG_DB_GRP 
                                            WHERE Semat = N'" + txtSemat.Text + "'";
        _sql_con.Transaction(Sql);

        txtSemat.Text = string.Empty;
        GridView1_CheckBoxBound();
    }

    protected void btnRemoveMembers_Click(object sender, EventArgs e)
    {
        if (txtSemat.Text.Length < 3 || txtSemat.Text.Length > 50
            || Request.QueryString["gid"] == null)
            return;

        var Group_ID = Request.QueryString["gid"].ToString();

        string Sql = "DELETE FROM Group_Users WHERE Group_ID=" + Group_ID +
                        @" AND User_Name IN 
                       (SELECT  UserName FROM V_OLTP_PRSNL_FG_DB_GRP 
                       WHERE Semat = N'" + txtSemat.Text + "') ";

        _sql_con.Execute(Sql);
        txtSemat.Text = string.Empty;

        GridView1_CheckBoxBound();
    }

    #endregion تغییر عضویت براساس سمت 

    /// <summary>
    /// ثبت اررورر در فوتر سایت
    /// </summary>
    /// <param name="message"></param>
    public void SetMessages(string message)
    {
        MasterPage master = (MasterPage)Page.Master;
        Literal lit;
        lit = (Literal)master.FindControl("litMessage");
        if (lit != null)
            lit.Text = message;
    }

    /// <summary>
    /// جستجو بر اساس شماره پرسنلی
    /// </summary>
    /// <param name="input"></param>
    protected void SearchByCodePersenely(string input)
    {
        var tmpDt = _ds.GetDT_PRSNL_ByCodPrsn(input.Trim());

        if (tmpDt.Rows.Count > 0)
        {
            GridView1.DataSource = null;
            GridView1.DataSource = tmpDt;
            GridView1.DataBind();
        }
        else
        {
            txtCodePerson.Text = string.Empty;
            Alert.Show("شخصی با شماره پرسنلی" + input + " یافت نشد ");
        }
    }

    protected void ImgBtnCodePerson_Click(object sender, ImageClickEventArgs e)
    {
        txtSearch.Text = string.Empty;

        int result;
        bool isInteger = Int32.TryParse(txtCodePerson.Text, out result);

        //چک کردن فرمت تکس باکس 
        if (isInteger)
        {
            SearchByCodePersenely(txtCodePerson.Text);
        }
        else
        {
            txtCodePerson.Text = string.Empty;
            //FillGridView_01();
        }
    }


    protected void btnAdminSetting_Click(object sender, EventArgs e)
    {

        Response.Redirect("GroupAdminSetting.aspx?GID="
            + Request.QueryString["GID"].ToString() +
            "&GName=" + Request.QueryString["GName"].ToString(), true);

    }

    protected void btnFormSetting_Click(object sender, EventArgs e)
    {

        Response.Redirect("FormSetting.aspx?GID=" +
            Request.QueryString["GID"].ToString() +
           "&GName=" + Request.QueryString["GName"].ToString(), true);
    }


}//end class