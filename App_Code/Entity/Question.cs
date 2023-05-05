using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;


/// <summary>
/// Summary description for ORM_Question
/// </summary>
/// 
namespace ORM
{
    public class Question : BaseQuestion
    {
        //8
        public Question(String question_id, 
            String description, 
            String form_id,
            Boolean question_optional,
            Question_Type question_type,
            Template_Type temlate_type, 
            int question_index,
            bool question_active)
        {
            _question_ID = question_id;
            _description = description;
            _form_ID = form_id;
            _question_optional = question_optional;
            _question_type = question_type;
            _template_type = temlate_type;
            _question_index = question_index;
            _question_active = question_active;
            _list = null;

        }
        //5
        public Question(String description, 
            String frmID, 
            Boolean isOptnl,
            Question_Type question_type
            , bool isActive)
        {
            _question_ID = "";
            _description = description;
            _form_ID = frmID;
            _question_optional = isOptnl;
            _question_type = question_type;
            _template_type = Template_Type.Manual;
            _question_index = 0;
            _list = null;
            _question_active = isActive;
        }

        public Question(String QueId, String frmID)
        {
            SQL_Connector connector = new SQL_Connector();
            String sql_query = "select Question_ID as[QID] ,Question_index , "+
                " [description] ,Question_optional , question_type , template_type " +
            ",QueIsActive from Questions where Form_ID =" + frmID + 
            " AND Question_ID = " + QueId;
            DataTable dt = connector.Select(sql_query);
            foreach (DataRow dr in dt.Rows)
            {
                this._question_active = Convert.ToBoolean((dr["QueIsActive"].ToString()));
                this._form_ID = frmID;
                this._question_ID = QueId;
                this._description = dr["Description"].ToString();
                this._question_index = int.Parse(dr["Question_index"].ToString());
                this._question_optional = Convert.ToBoolean((dr["Question_optional"].ToString()));
                this._question_type = ORM_Types.Get_Question_Type(Convert.ToInt16(dr["question_type"]));
                this._template_type = ORM_Types.Get_Template_Type(Convert.ToInt16(dr["template_type"]));
                if (this.Question_Type == Question_Type.ComboBoxList ||
                    this.Question_Type == Question_Type.DropDownList ||
                    this.Question_Type == Question_Type.Table ||
                    this.Question_Type == Question_Type.RadioButtonList ||
                    this.Question_Type == Question_Type.ChckBxLstTxt ||
                    this.Question_Type == Question_Type.RdoBtnLstTxt ||
                    this.Question_Type == Question_Type.DrpDnLstTxt)
                    if (this.Template_Type != Template_Type.Manual)
                        _list = new List(QueId);
                    else
                        _list = null;
            }

        }

        public Question(String QueId)
        {
            SQL_Connector connector = new SQL_Connector();
            String sql_query = "select Question_ID as[QID] ,Question_index , [description] "+
                ",Question_optional , question_type , template_type ,Form_ID " +
            ",QueIsActive from Questions where Question_ID = " + QueId;
            DataTable dt = connector.Select(sql_query);
            foreach (DataRow dr in dt.Rows)
            {
                this._question_active = Convert.ToBoolean((dr["QueIsActive"].ToString()));
                this._form_ID = dr["Form_ID"].ToString();
                this._question_ID = QueId;
                this._description = dr["Description"].ToString();
                this._question_index = int.Parse(dr["Question_index"].ToString());
                this._question_optional = Convert.ToBoolean((dr["Question_optional"].ToString()));
                this._question_type = ORM_Types.Get_Question_Type(Convert.ToInt16(dr["question_type"]));
                this._template_type = ORM_Types.Get_Template_Type(Convert.ToInt16(dr["template_type"]));
                if (this.Question_Type == Question_Type.ComboBoxList ||
                    this.Question_Type == Question_Type.DropDownList ||
                    this.Question_Type == Question_Type.Table ||
                    this.Question_Type == Question_Type.RadioButtonList ||
                    this.Question_Type == Question_Type.ChckBxLstTxt ||
                    this.Question_Type == Question_Type.RdoBtnLstTxt ||
                    this.Question_Type == Question_Type.DrpDnLstTxt)
                    if (this.Template_Type == Template_Type.Manual)
                        _list = new List(QueId);
                    else
                        _list = null;
            }

        }

        public Question()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public void delete_question()
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "Begin transaction my_transaction";
            ///  توضیح کد کامنت شده زیر
            ///  اگر کد زیر اجرا شود مشکل تکرار شماره سوال حل شده ولی تمامی جواب های سوال مربوطه از دیتا بیس پاک خواهد شد
            /////  Sql_query += "delete   FROM [FG_DB].[dbo].[Form_Question_Instance]   WHERE Question_ID =" + this._question_ID;
            Sql_query += " DELETE FROM [Questions] WHERE Question_ID =" + this._question_ID + " AND Form_ID =" + this._form_ID;
            Sql_query += " update Questions Set [Question_index] = [Question_index]-1 where [Question_index]>" + this.Question_Index +
                " AND [Form_ID] =" + this.Form_ID;
            Sql_query += " Commit transaction my_transaction";
            connector.Execute(Sql_query);
        }

        public void update()
        {
            var QueOptional = Convert.ToByte(this.Question_Optional);
            var QueTyp = ORM.ORM_Types.Get_Question_Type(this.Question_Type);
            var Template_Type = ORM.ORM_Types.Get_Template_Type(this.Template_Type);
            var QueActiv = Convert.ToByte(this.Question_active);
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "UPDATE [Questions] SET [Description] = N'" 
                + this.Description +
                "' , [Form_ID] =" + this.Form_ID + 
                " , [Question_Optional] = " + QueOptional + 
                " , [Question_Type] = " +     QueTyp + 
                " , [Template_Type] = " + Template_Type +
                " , [Question_Index] = " + Question_Index +
                " ,QueIsActive= " + QueActiv
                +" WHERE  [Question_ID] = " + this.Question_ID;

            connector.Execute(Sql_query);
        }

        public void removelist()
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "";
            if (List != null)
            {
                Sql_query = " DELETE FROM [List] WHERE List_ID =" + this.List.List_ID;
                connector.Execute(Sql_query);
            }
        }

        public String Save()
        {
            var CN = new SQL_Connector();
            var QueIsActv = Convert.ToSByte(this.Question_active);
            var QueIsOptn = Convert.ToSByte(this.Question_Optional);
            var QueTyp = ORM_Types.Get_Question_Type(this.Question_Type);
            var QueTmpTyp = ORM.ORM_Types.Get_Template_Type(this.Template_Type);
            string Sql_query = "";

            Sql_query = "declare @local int " +
                "set @local = (select count(*) from questions where form_id =" 
                + this.Form_ID + ")" +
                " INSERT INTO [Questions] ([Description],[Form_ID],[Question_Optional],QueIsActive,[Question_Type]" +
                ",[Template_Type],[Question_Index])" +
                " VALUES(N'" + this.Description + "'," + this.Form_ID + "," 
                + QueIsOptn + "," +
                QueIsActv + "," + QueTyp + "," + QueTmpTyp +
                ",@local+1)";


            var dt = CN.Select(Sql_query);
            if (dt.Rows.Count > 0)
                return dt.Rows[0][0].ToString();
            else
                return "";
        }

        public static List<Question> Get_Form_Questions(String formid)
        {
            try
            {
                var CN = new SQL_Connector();
                var QUERY = "select Question_ID as[QID] ,Question_index , [description] " +
                    ",Question_optional , question_type , template_type ,QueIsActive " +
                " from Questions where Form_ID =" + formid + " order by Question_index";
                var DT = CN.Select(QUERY);
                var output = new List<Question>();
                foreach (DataRow dr in DT.Rows)
                {
                    var active = Convert.ToBoolean((dr["QueIsActive"].ToString()));
                    var isOptn = Convert.ToBoolean(dr["Question_optional"].ToString());
                    var qtype = ORM_Types.Get_Question_Type(Convert.ToInt16(dr["question_type"].ToString()));
                    var ttype = ORM_Types.Get_Template_Type(Convert.ToInt16(dr["template_type"].ToString()));
                    var qIndex = int.Parse(dr["Question_index"].ToString());
                    var qDes = dr["Description"].ToString();
                    var qID = dr["QID"].ToString();
                    var que = new Question(qID, qDes, formid, isOptn, qtype, ttype, qIndex, active);
                    output.Add(que);
                }
                return output;
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
                return null;
            }

        }

        public static DataTable Get_DT_Questions(String formid)
        {
            try
            {
                var CN = new SQL_Connector();
                var QUERY = "select QID , QueNum , Que , Status, Type, QID1, Condition,Que1,QueNum1,QRelationID " +
                    ",QueIsActive  from V_Questions " +
                    " WHERE form_id = " + formid + " order by QueNum";
                return CN.Select(QUERY);
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
                return null;
            }
        }

        public void Get_Instance()
        {

        }

        public static bool isvalid(String qname, String fid)
        {
            try
            {
                SQL_Connector connector = new SQL_Connector();
                String Sql_query = "select count(*) from Questions where Form_id = " 
                    + fid + " AND Description = N'" + qname + "'";
                DataTable dt = connector.Select(Sql_query);
                if (dt != null && dt.Rows[0][0].ToString() != "0")
                    return true;
                else
                    return false;

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
                return false;
            }
        }

        public static String Get_Question_ID(String fid, String index_id)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "select Question_ID from Questions where form_ID=" + fid + " And Question_index =" + index_id;
            DataTable dt = connector.Select(Sql_query);
            return dt.Rows[0]["Question_ID"].ToString();
        }

        public static String Get_Question_Index(String Question_id)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "select Question_index from Questions where Question_ID =" + Question_id;
            DataTable dt = connector.Select(Sql_query);
            return dt.Rows[0]["Question_Index"].ToString();
        }

        public static Template_Type get_template(String Qid)
        {
            SQL_Connector connector = new SQL_Connector();
            String sql_query = "select Question_ID as[QID] , question_type , template_type " +
            "from Questions where Question_ID =" + Qid;
            DataTable dt = connector.Select(sql_query);
            return ORM_Types.Get_Template_Type(int.Parse(dt.Rows[0]["template_type"].ToString()));
        }

        public static Question_Type get_type(String Qid)
        {
            SQL_Connector connector = new SQL_Connector();
            String sql_query = "select Question_ID as[QID] , question_type , template_type " +
            "from Questions where Question_ID =" + Qid;
            DataTable dt = connector.Select(sql_query);
            return ORM_Types.Get_Question_Type(int.Parse(dt.Rows[0]["question_type"].ToString()));

        }


    }
}