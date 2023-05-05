﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;

public partial class Editoption : System.Web.UI.Page
{
    String _Que;
    ORM.List_Items listItems = new ORM.List_Items();
    protected void Page_Load(object sender, EventArgs e)
    {
        Int64 Tint = 0;
        if (Request.QueryString["qid"] == null || Int64.TryParse("qid", out Tint))
            Response.Redirect("homepage.aspx", true);

        _Que = Request.QueryString["qid"];
        if (!IsPostBack)
        {
            ORM.Question QUE = new ORM.Question(_Que);

            try
            {
                if (QUE.List.List_Items.Count > 0)
                    Panel2.Visible = false;
                else
                    Panel2.Visible = true;
            }
            catch(Exception ex)
            {
                Logger.Error(ex.Message);
                Panel2.Visible = false;
            }
            if (QUE.Question_Type == Question_Type.RadioButtonList ||
                QUE.Question_Type == Question_Type.DropDownList ||
                QUE.Question_Type == Question_Type.ComboBoxList ||
                QUE.Question_Type == Question_Type.ChckBxLstTxt ||
                QUE.Question_Type == Question_Type.RdoBtnLstTxt ||
                QUE.Question_Type == Question_Type.DrpDnLstTxt)
            {
                if (QUE.Template_Type == Template_Type.Branch)
                    MultiView1.ActiveViewIndex = 0;
                if (QUE.Template_Type == Template_Type.State)
                    MultiView1.ActiveViewIndex = 1;
                if (QUE.Template_Type == Template_Type.Department)
                    MultiView1.ActiveViewIndex = 3;
                if (QUE.Template_Type == Template_Type.Manual)
                {
                    MultiView1.ActiveViewIndex = 2;
                    DataTable dt = QUE.List.get_dt_items();
                    if (dt == null || dt.Rows.Count ==0 ) 
                    {
                        GridView_options.Visible = false;
                        Panel2.Visible = true;
                    }
                    else 
                    {
                        GridView_options.Visible = true;
                        Panel2.Visible = false;
                    }

                    GridView_options.DataSource = dt;
                    String [] keys = {"Item_ID"};
                    GridView_options.DataKeyNames = keys;
                    GridView_options.DataBind();
                }
                
            }
            if (QUE.Question_Type == Question_Type.Table)
            {
                Panel2.Visible = true;
                GridView_options.Visible = true;
                SQL_Connector connector = new SQL_Connector();
                String SQL_query = "SELECT [ID],[Name],[Description],[Fname] FROM [FG_DB].[dbo].[Tables]";
                DataTable dt = connector.Select(SQL_query);
                cmbFieldFilled.DataSource = dt;
                cmbFieldFilled.DataValueField = "ID";
                cmbFieldFilled.DataTextField = "Fname";
                cmbFieldFilled.DataBind();
                SQL_query = "SELECT [ID],[Fname] FROM [FG_DB].[dbo].[BaseData]";
                DataTable  dt1 = connector.Select(SQL_query);
                cmbFieldtype.DataSource = dt1;
                cmbFieldtype.DataValueField = "ID";
                cmbFieldtype.DataTextField = "Fname";
                cmbFieldtype.DataBind();
                GridView_ListItem.DataSource = listItems.get_Dt_All_Items(_Que);
                GridView_ListItem.DataBind();
            }
                     
        }
    }

    private void databind()
    {
        _Que = Request.QueryString["qid"];
        ORM.Question localquestion = new ORM.Question(_Que);
        DataTable dt = localquestion.List.get_dt_items();
        GridView_options.DataSource = dt;
        String[] keys = { "Item_ID" };
        GridView_options.DataKeyNames = keys;
        GridView_options.DataBind();
    }

    public String GetStatus(object obj)
    {
        if (Convert.ToBoolean(obj))
            return "اختياري";
        else 
            return "اجباري";

    }
    public int GetselectIndex(object obj)
    {
        int index = 0;
        try
        {
            return Convert.ToInt16(obj.ToString().Trim());
        }
        catch (Exception ex)
        {
            Logger.Error(ex.Message);
            return index;
        }
    }

    private void Binder()
    {
        GridView_ListItem.DataSource = null;
        if (listItems.get_Dt_All_Items(_Que) != null)
        {
            GridView_ListItem.DataSource = listItems.get_Dt_All_Items(_Que);
            GridView_ListItem.DataBind();

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        _Que = Request.QueryString["QID"];
        ORM.Question localquestion = new ORM.Question(_Que);
        localquestion.Template_Type = Template_Type.State;
        localquestion.removelist();
        localquestion.update();
        MultiView1.SetActiveView(location);

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        _Que = Request.QueryString["QID"];
        ORM.Question localquestion = new ORM.Question(_Que);
        localquestion.Template_Type = Template_Type.Branch ;
        localquestion.removelist();
        localquestion.update();
        MultiView1.SetActiveView(Branch);

        
      
    }
    
   
    protected void Button3_Click(object sender, EventArgs e)
    {

        GridView_options.DataSource = null;
        GridView_options.DataBind();
        GridView_options.Visible = false;
        _Que = Request.QueryString["QID"];
        ORM.Question localquestion = new ORM.Question(_Que);
        localquestion.Template_Type = Template_Type.Manual;
        localquestion.removelist();
        localquestion.update();
        MultiView1.SetActiveView(Queitem);
        Panel2.Visible = true;

    }
    
    
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        SQL_Connector connector = new SQL_Connector();
        String SQL_query = "SELECT Form_ID FROM dbo.Questions where Question_ID = " + _Que;
        string Formid = connector.execute_scalar(SQL_query);
        Response.Redirect("NewQuestion.aspx?fid=" + Formid, true);
    }

  
    protected void btnAdd_Click(object sender, ImageClickEventArgs e)
    {
        _Que = Request.QueryString["qid"];
        TextBox txt = (TextBox)GridView_options.FooterRow.FindControl("txtAddItem");
        if (txt.Text == null || txt.Text == "")
            txt.Text = "UnKnown Item";
        else
        {
            ASP.global_asax a = new ASP.global_asax();
            txt.Text = a.NormalizePersianCharacters(txt.Text);
        }
        ORM.Question myquestion = new ORM.Question(_Que);
        if (myquestion.List != null && myquestion.List.List_Items != null && myquestion.List.List_Items.Count > 0)
            myquestion.List.Add(new ORM.List_Items(txt.Text, myquestion.List.List_ID,false,1,false,0));
        else
        {
            ORM.List templist = new ORM.List(_Que, "", null);
            templist.save(txt.Text, chkField_Optional.Checked, Convert.ToInt16(cmbFieldtype.SelectedValue), chkField_Filled.Checked, Convert.ToInt32(cmbFieldFilled.SelectedValue));
        }
        Response.Redirect(Request.Url.ToString());

    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        _Que = Request.QueryString["QID"];
        ORM.Question localquestion = new ORM.Question(_Que);
        localquestion.Template_Type = Template_Type.Department;
        localquestion.removelist();
        localquestion.update();
        MultiView1.SetActiveView(Department);
    }

    protected void chkField_Filled_CheckedChanged(object sender, EventArgs e)
    {
        if (chkField_Filled.Checked)
        {
            lbl_fieldfill.Visible = true;
            cmbFieldFilled.Visible = true;
        }
        else
        {
            lbl_fieldfill.Visible = false;
            cmbFieldFilled.Visible = false;
        }
    }

    protected void button_add_Click(object sender, ImageClickEventArgs e)
    {
        _Que = Request.QueryString["qid"];
        if (TextBox_Add.Text == null || TextBox_Add.Text == "")
            TextBox_Add.Text = "UnKnown Item";
        ORM.Question myquestion = new ORM.Question(_Que);

        if (myquestion.List != null && myquestion.List.List_Items != null && myquestion.List.List_Items.Count > 0)
        {
            if (myquestion.Question_Type.ToString() == "Table")
                myquestion.List.Add(new ORM.List_Items(TextBox_Add.Text, myquestion.List.List_ID,
                 chkField_Optional.Checked, Convert.ToInt16(cmbFieldtype.SelectedValue), chkField_Filled.Checked, Convert.ToInt32(cmbFieldFilled.SelectedValue)));
            else
                myquestion.List.Add(new ORM.List_Items("", TextBox_Add.Text, myquestion.List.List_ID));
        }
        else
        {
            ORM.List templist = new ORM.List(_Que, "", null);
            if (myquestion.Question_Type.ToString() == "Table")
                templist.save(TextBox_Add.Text, chkField_Optional.Checked, Convert.ToInt16(cmbFieldtype.SelectedValue), chkField_Filled.Checked, Convert.ToInt32(cmbFieldFilled.SelectedValue));
            else
                templist.save(TextBox_Add.Text);
        }
        Response.Redirect(Request.Url.ToString());
    }


    protected void GridView_options_RowEditing(object sender, GridViewEditEventArgs e)
    {
        int editindex = e.NewEditIndex;
        GridView_options.EditIndex = editindex;
        databind();

    }
    protected void GridView_options_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowState & DataControlRowState.Edit) > 0)
        {

            System.Web.UI.WebControls.ImageButton btnUpdate = (System.Web.UI.WebControls.ImageButton)e.Row.FindControl("lbtnEdit");

            this.Form.DefaultButton = btnUpdate.UniqueID;

        }
    }
    
    protected void GridView_options_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView_options.EditIndex = -1;
        databind();
    }
    protected void GridView_options_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        String item_text = ((TextBox)GridView_options.Rows[GridView_options.EditIndex].FindControl("TextBox1")).Text;
        ASP.global_asax a = new ASP.global_asax();
        item_text = a.NormalizePersianCharacters(item_text);
        String item_value = GridView_options.DataKeys[GridView_options.EditIndex].Value.ToString();
        ORM.List_Items item = new ORM.List_Items(item_value);
        item.Item_Text = item_text;
        item.Item_ID = item_value;
        item.Update();
        GridView_options.EditIndex = -1; 
        databind();
    }
    protected void GridView_options_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {

            ORM.List_Items item = new ORM.List_Items(e.CommandArgument.ToString());
            item.Delete();
            databind();
        }
    }
    protected void GridView_options_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    protected void GridView_ListItem_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowState & DataControlRowState.Edit) > 0)
        {

            System.Web.UI.WebControls.ImageButton btnUpdate = (System.Web.UI.WebControls.ImageButton)e.Row.FindControl("ImageButton23");

            this.Form.DefaultButton = btnUpdate.UniqueID;
            DropDownList drptabel1 = (DropDownList)e.Row.FindControl("drd_table");
            DropDownList drptype1 = (DropDownList)e.Row.FindControl("drd_type");
            DataRowView dr = e.Row.DataItem as DataRowView;
            if (dr["Table_Id"] != DBNull.Value)
                drptabel1.SelectedIndex = Convert.ToInt32(dr["Table_Id"]) - 1;
            drptype1.SelectedIndex = Convert.ToInt32(dr["TypeId"]) - 1;
        }
    }
    protected void GridView_ListItem_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "Delete")
        {
            listItems.Delete((String)e.CommandArgument);
            Binder();
        }

    }

    protected void GridView_ListItem_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void GridView_ListItem_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView_ListItem.EditIndex = -1;
        Binder();

    }
    protected void GridView_ListItem_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView_ListItem.EditIndex = e.NewEditIndex;
        Binder();
        DropDownList drptabel1 = (DropDownList)GridView_ListItem.Rows[GridView_ListItem.EditIndex].FindControl("drd_table");
        SQL_Connector connector = new SQL_Connector();
        String SQL_query = "SELECT [ID] AS [Table_Id],[Name],[Description],[Fname] FROM [FG_DB].[dbo].[Tables]";
        DataTable dt = connector.Select(SQL_query);
        drptabel1.DataSource = dt;
        drptabel1.DataValueField = "Table_Id";
        drptabel1.DataTextField = "Fname";
        drptabel1.DataBind();
        DropDownList drptype1 = (DropDownList)GridView_ListItem.Rows[GridView_ListItem.EditIndex].FindControl("drd_type");
        SQL_query = "SELECT [ID],[Fname] FROM [FG_DB].[dbo].[BaseData]";
        DataTable dt1 = connector.Select(SQL_query);
        drptype1.DataSource = dt1;
        drptype1.DataValueField = "ID";
        drptype1.DataTextField = "Fname";
        drptype1.DataBind();
    }
    protected void GridView_ListItem_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int editindex = GridView_ListItem.EditIndex;
            ORM.List_Items UpdateItem = new ORM.List_Items();
            UpdateItem.Item_ID = GridView_ListItem.DataKeys[editindex].Value.ToString(); 
            UpdateItem.Item_Text = ((System.Web.UI.WebControls.TextBox)GridView_ListItem.Rows[editindex].FindControl("txt_ItemText")).Text;
            UpdateItem.Item_Option = Convert.ToBoolean(((DropDownList)GridView_ListItem.Rows[editindex].FindControl("drd_optional")).SelectedIndex);
            UpdateItem.Item_Type = Convert.ToInt16(((DropDownList)GridView_ListItem.Rows[editindex].FindControl("drd_type")).SelectedItem.Value);
            UpdateItem.Item_Filled = Convert.ToBoolean(((DropDownList)GridView_ListItem.Rows[editindex].FindControl("drd_filled")).SelectedIndex);
            if (UpdateItem.Item_Filled)
                UpdateItem.Item_Table = Convert.ToInt32(((DropDownList)GridView_ListItem.Rows[editindex].FindControl("drd_table")).SelectedItem.Value);
            UpdateItem.UpdateItems();
            GridView_ListItem.EditIndex = -1;
            Binder();
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
        }
    }
    
}
