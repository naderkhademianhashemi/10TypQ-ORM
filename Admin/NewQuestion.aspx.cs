using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Windows.Forms;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;



public partial class NewQuestion : System.Web.UI.Page
{
    String _FID;

    protected void Page_Load(object sender, EventArgs e)
    {
        Int64 Tint = 0;
        if (Request.QueryString["FID"] == null || !Int64.TryParse(Request.QueryString["FID"], out Tint))
            Response.Redirect("homepage.aspx", true);
        _FID = Tint.ToString();
        if (!IsPostBack)
        {

            ORM.Forms thisform = new ORM.Forms(_FID);
            databind();
            Label9.Text = thisform.Form_Name;

            if (Request.QueryString["FID"] != null)
            {
                _FID = Request.QueryString["FID"].ToString();
            }
        }
    }

    #region functions

    public String GetStatus(object obj)
    {
        if (Convert.ToBoolean(obj))
            return "اختياري";
        else
            return "اجباري";
    }
    public String GetActive(object obj)
    {
        if (Convert.ToBoolean(obj))
            return " فعال";
        else
            return "غیر فعال";
    }
    public int GetselectIndex(object obj)
    {
        int index = 0;
        if (!Convert.ToBoolean(obj.ToString().Trim()))
            index = 1;
        return index;
    }

    public bool GetSelect(object obj, object obj2)
    {
        if (obj.ToString() == obj2.ToString())
            return true;
        return false;
    }
    public bool linkIsEnable(object obj)
    {
        Question_Type temptype = ORM.ORM_Types.Get_Question_Type(int.Parse(obj.ToString()));
        if (temptype == Question_Type.Text ||
            temptype == Question_Type.Number ||
            temptype == Question_Type.Date)
            return false;
        return true;
    }
    public String GetType(object obj)
    {
        switch (obj.ToString())
        {
            case "1": return "متنی";
            case "2": return "چندگزینه ای چند جوابی";
            case "3": return "چند گزینه ای تک جوابی ";
            case "4": return "چند گزینه ای تک جوابی نمایش به صورت آبشاری";
            case "5": return "مقدار عددی";
            case "6": return "تاریخ";
            case "7": return "جدول";
            case "8": return " چند جوابی و متنی";
            case "9": return " تک جوابی و متنی";
            case "10": return " آبشاری و متنی";
            default:
                return "";
        }
    }

    private void databind()
    {
        GridView_Form_Questions.DataSource = ORM.Question.Get_DT_Questions(_FID);
        String[] keys = { "QID" };
        GridView_Form_Questions.DataKeyNames = keys;
        GridView_Form_Questions.DataBind();


    }

    #endregion functions
    #region un  use fun
    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;

        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;

            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
        }

        return newSortDirection;
    }
    String GetSqlStringType()
    {
        String output = "";
        switch (rblTypeQue.SelectedValue)
        {
            case "txt":
                output = "Nvarchar(100)";
                break;
            case "date":
                output = "DateTime";
                break;
            case "rbl":
                output = "Nvarchar(200)";
                break;
            case "ddl":
                output = "Nvarchar(200)";
                break;
            case "cbl":
                output = "NvarChar(200)";
                break;
            case "num":
                output = "Decimal(38,6)";
                break;
        }
        return output;
    }

    #endregion
    #region Events

    protected void btnAddQue_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;

        Boolean optional = (rblStatus.SelectedIndex == 0);

        var IsEnable = true;
        var QueTyp = ORM.ORM_Types.Get_Question_Type(int.Parse(rblTypeQue.SelectedValue));
        IsEnable = rblIsEnable.SelectedIndex == 0;
        ORM.Question newquestion = new ORM.Question(txtQue.Text, _FID, optional,
        QueTyp, IsEnable);

        newquestion.Save();
        Response.Redirect("NewQuestion.aspx?FID=" + _FID + "", true);

    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton l = sender as ImageButton;
        Response.Redirect("editoption.aspx?Qid=" + l.CommandArgument);
    }

    protected void Button1_Click(object sender, ImageClickEventArgs e)
    {
        String FID = Request.QueryString["FID"].ToString();
        String First_ID = ((sender as ImageButton).CommandArgument.Split(';')[0]);
        int Question_index = int.Parse(((sender as ImageButton).CommandArgument.Split(';')[1]));

        if (Question_index == 1)
            return;
        else
        {
            String Seccond_ID = ORM.Question.Get_Question_ID(FID, (Question_index - 1).ToString());
            ORM.Forms.Swap_Qestion(First_ID, Seccond_ID, FID);
            databind();
        }

    }
    protected void Button2_Click(object sender, ImageClickEventArgs e)
    {
        String FID = Request.QueryString["FID"].ToString();
        String First_ID = ((sender as ImageButton).CommandArgument.Split(';')[0]);
        int Question_index = int.Parse(((sender as ImageButton).CommandArgument.Split(';')[1]));

        if (Question_index >= GridView_Form_Questions.Rows.Count)
            return;
        else
        {
            String Seccond_ID = ORM.Question.Get_Question_ID(FID, (Question_index + 1).ToString());
            ORM.Forms.Swap_Qestion(First_ID, Seccond_ID, FID);
            databind();
        }


    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        try
        {
            if (ORM.Question.isvalid(txtQue.Text, _FID))
            {
                args.IsValid = false;
                return;
            }

            args.IsValid = true;
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
            args.IsValid = false;
        }
    }





    protected void txtQue_TextChanged(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    #endregion Events

    #region gridEvents

    protected void GridView_Form_Questions_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowState & DataControlRowState.Edit) > 0)
        {

            System.Web.UI.WebControls.ImageButton btnUpdate = 
                (System.Web.UI.WebControls.ImageButton)e.Row
                .FindControl("ImageButton23");

            this.Form.DefaultButton = btnUpdate.UniqueID;

        }
    }

    protected void GridView_Form_Questions_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void GridView_Form_Questions_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "Delete")
        {
            ORM.Forms thisform = new ORM.Forms(_FID);
            thisform.delete_question((String)e.CommandArgument);
            Response.Redirect("NewQuestion.aspx?FID=" + _FID + "", true);
        }

    }
    protected void GridView_Form_Questions_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void GridView_Form_Questions_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView_Form_Questions.EditIndex = e.NewEditIndex;
        databind();
    }


    protected void GridView_Form_Questions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView_Form_Questions.EditIndex = -1;
        databind();
    }

    protected void GridView_Form_Questions_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        var editindex = GridView_Form_Questions.EditIndex;
        var QID = GridView_Form_Questions.DataKeys[editindex].Value.ToString();
        var que = new ORM.Question(QID);
        que.Description = ((System.Web.UI.WebControls.TextBox)
            GridView_Form_Questions.Rows[editindex].FindControl("TextBox2")).Text;
        que.Question_Optional = Convert.ToBoolean(((DropDownList)
            GridView_Form_Questions.
            Rows[editindex].FindControl("DropDownList2")).Items[0].Selected);
        que.Question_active= Convert.ToBoolean(((DropDownList)
            GridView_Form_Questions.
            Rows[editindex].FindControl("drpQueIsActive")).Items[0].Selected);
        que.update();

        GridView_Form_Questions.EditIndex = -1;
        databind();
    }
    protected void GridView_Form_Questions_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView_Form_Questions.PageIndex = e.NewPageIndex;
        databind();
    }

    #endregion gridEvents

}
