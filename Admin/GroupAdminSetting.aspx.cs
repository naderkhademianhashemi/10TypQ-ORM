using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_GroupAdminSetting : System.Web.UI.Page
{
    SQL_Connector _SQL_Connector = new SQL_Connector();
    FG_DB_DataSet _ds = new FG_DB_DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
            return;

        txtUserName.Focus();
        bindGrid1();
        lblGruop.Text = lblGroup2.Text = Request.QueryString["GName"];
        lblUserSetting.Text = " تعیین کاربران گروه" + "&nbsp" +
            Request.QueryString["GName"];
        lblFormSetting.Text = " تعیین فرم های گروه" + "&nbsp" +
            Request.QueryString["GName"];
    }

    public void bindGrid1()
    {
        var tmpDt = _ds.GetDT_PRSNL_GRP_ByGroupId(
            int.Parse(Request.QueryString["GID"]));

        GridView1.DataSource = tmpDt;
        GridView1.DataBind();
    }

    public void bindGridByUser(string userName)
    {
        var tmpDt = _ds.GetDT_PRSNL_GRP_ByUserName(
            int.Parse(Request.QueryString["GID"])
            , userName.Trim());

        GridView1.DataSource = tmpDt;
        GridView1.DataBind();
    }

    protected void bindGridByCodePersenely(string input)
    {
        var tmpDt = _ds.GetDT_PRSNL_GRP_ByCodPrsn(
            int.Parse(Request.QueryString["GID"])
            , input.Trim());
        
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
    }//end bindGridByCodePersenely

    #region Events

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        if (txtUserName.Text.Length > 0)
        {
            bindGridByUser(txtUserName.Text);
        }
        else if (txtCodePerson.Text.Length > 0)
        {
            bindGridByCodePersenely(txtCodePerson.Text);
        }
        else
        {
            bindGrid1();
        }
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        if (txtUserName.Text.Length > 0)
        {
            bindGridByUser(txtUserName.Text);
        }
        else if (txtCodePerson.Text.Length > 0)
        {
            bindGridByCodePersenely(txtCodePerson.Text);
        }
        else
        {
            bindGrid1();
        }

    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        bool chk = false;
        string UserName = (GridView1.Rows[e.RowIndex].FindControl("lblUserName") as Label).Text;
        string Group_ID = Request.QueryString["gid"].ToString();

        //if checked
        //UPDATE Group_Users Table --- IsAdmin
        chk = (GridView1.Rows[e.RowIndex].FindControl("cbSelect") as CheckBox).Checked;

        string str = "UPDATE Group_Users SET IsAdmin = "
            + Convert.ToInt16(chk) + " WHERE Group_ID = "
            + Group_ID + " AND User_Name = N'" + UserName + "'";

        _SQL_Connector.Execute(str);

        GridView1.EditIndex = -1;

        if (txtUserName.Text.Length > 0)
        {
            bindGridByUser(txtUserName.Text);
        }
        else if (txtCodePerson.Text.Length > 0)
        {
            bindGridByCodePersenely(txtCodePerson.Text);
        }
        else
        {
            bindGrid1();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        if (txtUserName.Text.Length > 0)
        {
            bindGridByUser(txtUserName.Text);
        }
        else
        {
            bindGrid1();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.PageIndex = 0;
        txtCodePerson.Text = string.Empty;

        bindGridByUser(txtUserName.Text);
    }

    protected void btnUserSetting_Click(object sender, EventArgs e)
    {
        Response.Redirect("UserSetting.aspx?GID=" + Request.QueryString["GID"].ToString() +
            "&GName=" + Request.QueryString["GName"].ToString(), true);
    }

    protected void btnFormSetting_Click(object sender, EventArgs e)
    {
        Response.Redirect("FormSetting.aspx?GID=" + Request.QueryString["GID"].ToString() +
           "&GName=" + Request.QueryString["GName"].ToString(), true);
    }

    protected void btnSearchCodePerson_Click(object sender, EventArgs e)
    {
        GridView1.PageIndex = 0;

        txtUserName.Text = string.Empty;

        int result;
        bool isInteger = Int32.TryParse(txtCodePerson.Text, out result);

        //چک کردن فرمت تکس باکس 
        if (isInteger)
        {
            bindGridByCodePersenely(txtCodePerson.Text);
        }
        else
        {
            bindGrid1();
            txtCodePerson.Text = string.Empty;

        }

    }//end btnSearchCodePerson_Click

    #endregion Events

}