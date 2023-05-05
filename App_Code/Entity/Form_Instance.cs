using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Linq;
using System.Linq.Expressions;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;
using System.Globalization;

/// <summary>
/// Summary description for ORM_Form_Instance
/// </summary>
/// 
namespace ORM
{
    public class Form_Instance: BaseFrmInstnc
    {

        public Form_Instance()
        {
            _answers = null;
            //
            // TODO: Add constructor logic here
            //
        }

        public Form_Instance(String instanceid)
        {
            _instance_id = instanceid;
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "select [Instance_ID] , filldate , [User_name] , Form_ID "+
                " from form_instance where Instance_ID = " + instanceid;
            DataTable dt = connector.Select(Sql_query);
            foreach (DataRow dr in dt.Rows)
            {
                _filldate = dr["filldate"].ToString();
                _user_name = dr["User_name"].ToString();
                _form_id = dr["Form_ID"].ToString();
            }

            //ORM.Forms localform = new Forms(_form_id);
            _answers = new List<Form_Question_Instance>();
            var temp = new Form_Question_Instance();
            _answers = temp.get_answers(instanceid, _form_id);

        }

        
        public DataTable return_value2(String QID)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query_answer = "Select text,answer_id,item_id,item_text From V_Answers where Question_ID = " +
                                      QID + " AND Form_Instance_ID = " + _instance_id;
            DataTable dt_answers = connector.Select(Sql_query_answer);
            DataTable dt = new DataTable();

            foreach (var VARIABLE in ORM.List.get_dt_items(QID).AsEnumerable())
                dt.Columns.Add(VARIABLE.Field<Int64>("Item_id").ToString());

            if (dt_answers.Rows.Count != 0)
            {

                for (int i = 0; i < dt_answers.AsEnumerable().Max(w => w.Field<Int64>("answer_id")); i++)
                    dt.Rows.Add();

                foreach (var VARIABLE in dt_answers.AsEnumerable())
                    dt.Rows[(int)VARIABLE.Field<Int64>("answer_id") - 1][VARIABLE.Field<Int64>("Item_id").ToString()] =
                        VARIABLE.Field<string>("text");

            }
            return dt;

        }
        public void Add_Answer(Form_Question_Instance input)
        {
            if (_answers == null)
                _answers = new List<Form_Question_Instance>();

            _answers.Add(input);
        }

        public void Save()
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "set transaction isolation level SERIALIZABLE " +
                "Begin transaction answertran " +
                "INSERT INTO [Form_Instance] ([filldate],[User_name],[Form_ID]) " +
                "VALUES (" + Fill_Date + ",N'" + User_Name + "'," + Form_ID + ") " +
                "if @@Error<>0 begin rollback transaction return end " +
                "DECLARE @local int " +
                "Set @local = (SELECT IDENT_CURRENT('Form_Instance')) " +
                "if @@Error<>0 begin rollback transaction return end ";

            foreach (object obj in _answers)
            {
                ORM.Form_Question_Instance question_instance = (ORM.Form_Question_Instance)obj;

                Sql_query += "INSERT INTO [Form_Question_Instance]([Form_Instance_ID],[Question_ID],[Text],[Date],[Number],answer_id,item_id) Values(@local , " +
                    question_instance.Question_ID + " , " + this.get_string_value(question_instance.Text_Field) + " , " +
                    this.get_date_value(question_instance.Date_Field) + " , " +
                    this.get_nonstring_value(question_instance.Number_filed) + " , " +
                    this.get_nonstring_value(question_instance.Answer_ID) + " , " +
                    this.get_nonstring_value(question_instance.Item_ID) +
                    ") " +
                    "if @@Error<>0 begin rollback transaction return end ";
                var qtype = Question.get_type(question_instance.Question_ID);
                var ttype = Question.get_template(question_instance.Question_ID);
                String sql_string_local = "";
                switch (ttype)
                {
                    case Template_Type.State:
                        foreach (object local_obj in question_instance.State_Choice)
                        {
                            String selected_state = (String)local_obj;
                            if (selected_state == "") break;
                            sql_string_local += "INSERT INTO[State_Choice]([Form_Instance_Id],[Question_ID],[State_Item])VALUES " +
                                "(@local , " + question_instance.Question_ID + "," + selected_state + ") " +
                                "if @@Error<>0 begin rollback transaction return end ";
                        }
                        break;
                    case Template_Type.Branch:
                        foreach (object local_obj in question_instance.Branch_Choice)
                        {
                            String selected_branch = (String)local_obj;
                            if (selected_branch == "") break;
                            sql_string_local += "INSERT INTO [Branch_Choice]([Form_Instance_Id],[Question_ID],[Branch_Item])VALUES " +
                                "(@local , " + question_instance.Question_ID + "," + selected_branch + ") " +
                                "if @@Error<>0 begin rollback transaction return end ";
                        }
                        break;
                    case Template_Type.Department:
                        foreach (object local_obj in question_instance.Branch_Choice)
                        {
                            String selected_dep = (String)local_obj;
                            if (selected_dep == "") break;
                            sql_string_local += "INSERT INTO [Dep_Choice]([Form_Instance_Id],[Question_ID],[Dep_Item])VALUES " +
                                "(@local , " + question_instance.Question_ID + "," + selected_dep + ") " +
                                "if @@Error<>0 begin rollback transaction return end ";
                        }
                        break;
                    case Template_Type.Manual:
                        foreach (object local_obj in question_instance.List_Choice)
                        {
                            String selected_item = (String)local_obj;
                            if (selected_item == "") break;
                            sql_string_local += "INSERT INTO [Item_Choice]([Form_Instance_Id],[Question_ID],[Selected_Item])VALUES " +
                                "(@local , " + question_instance.Question_ID + "," + selected_item + ") " +
                                "if @@Error<>0 begin rollback transaction return end ";
                        }
                        break;

                }

                Sql_query += " " + sql_string_local;
            }

            Sql_query += "Commit transaction answertran";
            connector.Execute(Sql_query);
        }

        public void Update(String instance_id)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "set transaction isolation level SERIALIZABLE " +
                "Begin transaction answertran ";

            foreach (object obj in _answers)
            {
                ORM.Form_Question_Instance question_instance = (ORM.Form_Question_Instance)obj;
                if (question_instance.Item_ID.Length == 0) question_instance.Item_ID = "null";
                if (question_instance.Answer_ID.Length == 0) question_instance.Answer_ID = "null";
                Sql_query += "INSERT INTO [Form_Question_Instance]([Form_Instance_ID],[Question_ID],[Text],[Date],[Number],[Item_ID],[Answer_ID]) Values(" + instance_id + " , " +
                    question_instance.Question_ID + " , " + this.get_string_value(question_instance.Text_Field) + " , " +
                    this.get_date_value(question_instance.Date_Field) + " , " +
                    this.get_nonstring_value(question_instance.Number_filed) + " , " + question_instance.Item_ID + " , " + question_instance.Answer_ID + ") " +
                    "if @@Error<>0 begin rollback transaction return end ";
                var qtype = Question.get_type(question_instance.Question_ID);
                Template_Type ttype = Question.get_template(question_instance.Question_ID);
                String sql_string_local = "";
                switch (ttype)
                {
                    case Template_Type.State:
                        foreach (object local_obj in question_instance.State_Choice)
                        {
                            String selected_state = (String)local_obj;
                            if (selected_state == "") break;
                            sql_string_local += "INSERT INTO[State_Choice]([Form_Instance_Id],[Question_ID],[State_Item])VALUES " +
                                "(" + instance_id + " , " + question_instance.Question_ID + "," + selected_state + ") " +
                                "if @@Error<>0 begin rollback transaction return end ";
                        }
                        break;
                    case Template_Type.Branch:
                        foreach (object local_obj in question_instance.Branch_Choice)
                        {
                            String selected_branch = (String)local_obj;
                            if (selected_branch == "") break;
                            sql_string_local += "INSERT INTO [Branch_Choice]([Form_Instance_Id],[Question_ID],[Branch_Item])VALUES " +
                                "(" + instance_id + " , " + question_instance.Question_ID + "," + selected_branch + ") " +
                                "if @@Error<>0 begin rollback transaction return end ";
                        }
                        break;
                    case Template_Type.Department:
                        foreach (object local_obj in question_instance.Branch_Choice)
                        {
                            String selected_dep = (String)local_obj;
                            if (selected_dep == "") break;
                            sql_string_local += "INSERT INTO [Dep_Choice]([Form_Instance_Id],[Question_ID],[Dep_Item])VALUES " +
                                "(" + instance_id + " , " + question_instance.Question_ID + "," + selected_dep + ") " +
                                "if @@Error<>0 begin rollback transaction return end ";
                        }
                        break;
                    case Template_Type.Manual:
                        foreach (object local_obj in question_instance.List_Choice)
                        {
                            String selected_item = (String)local_obj;
                            if (selected_item == "") break;
                            sql_string_local += "INSERT INTO [Item_Choice]([Form_Instance_Id],[Question_ID],[Selected_Item])VALUES " +
                                "(" + instance_id + " , " + question_instance.Question_ID + "," + selected_item + ") " +
                                "if @@Error<>0 begin rollback transaction return end ";
                        }
                        break;

                }

                Sql_query += " " + sql_string_local;
            }

            Sql_query += "Commit transaction answertran";
            connector.Execute(Sql_query);
        }

        private String get_string_value(String input)
        {
            if (input == "" || input == null)
                return "null";
            else
                return "N'" + input + "'";
        }

        private String get_nonstring_value(String input)
        {
            if (input == "" || input == null)
                return "null";
            else
                return input;
        }

        private String get_date_value(String input)
        {
            if (input == "" || input == null)
                return "null";
            else
                return "'" + input + "'";
        }

        public static void Delete(String instance_id)
        {
            String sql_query = "DELETE FROM [Form_Instance] WHERE instance_id =" + instance_id;
            SQL_Connector connector = new SQL_Connector();
            connector.Execute(sql_query);
        }

        public static void form_delete(String form_id)
        {
            String sql_query = "DELETE FROM [Form_Instance] WHERE form_id =" + form_id;
            SQL_Connector connector = new SQL_Connector();
            connector.Execute(sql_query);
        }
        

        static public DataTable get_dt_answers(String fid, String QID, String Query)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_Query = "";
            if (QID == "")
                Sql_Query = "Select [Instance_ID] , filldate , User_name, Reported from Form_Instance where Form_ID = " + fid
                + Query;
            else
                Sql_Query = "Select Distinct [Instance_ID] , filldate , User_name, Reported from V_Answers where Form_ID = " + fid +
                " And Question_ID = " + QID + Query;


            return connector.Select(Sql_Query);

        }

        static public DataTable get_dt_answers_ordered(String fid, String QID, String Query)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_Query = "";
            if (QID == "")
                Sql_Query = "Select [Instance_ID] , filldate , User_name, Reported from Form_Instance where Form_ID = "
                    + fid + Query + " order by filldate desc";
            else
                Sql_Query = "Select Distinct [Instance_ID] , filldate , User_name, Reported from V_Answers where Form_ID = " + fid +
                " And Question_ID = " + QID + Query + " order by filldate desc";


            return connector.Select(Sql_Query);

        }

        static public DataTable get_dt_allanswersForExcel(String fid, String Query)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_Query = "Select distinct [Instance_ID],[filldate],[User_name],[Question_ID],[Question_Type],[Template_Type]" +
                               ",[Form_ID],[Text],[Date],[Number],[Dep_Item],[Branch_Item],[State_Item],[Answer_ID]" +
                               ",[Item_ID],[Item_Text],[Question_Index] from V_Answers where Reported != 'True' and Form_ID = " + fid +
                " " + Query;

            return connector.Select(Sql_Query);

        }

        public static DataTable get_dt_answersBetweenDates(String fid, String QID, String Query, DateTime FromDate, DateTime ToDate)
        {
            SQL_Connector connector = new SQL_Connector();

            string format = "yyyy-MM-dd HH:mm:ss";    // modify the format depending upon input required in the column in database 
            var strToDate = ToDate.ToString(format, CultureInfo.InvariantCulture);
            var strFromDate = FromDate.ToString(format, CultureInfo.InvariantCulture);

            var dt = new DataTable();
            String Sql_Query = "";
            if (QID == "")
            {
               
                Sql_Query = "Select [Instance_ID] , filldate , User_name, Reported from Form_Instance where Form_ID = " + fid +
                    " " + Query
                + " and filldate <= '" + strToDate + 
                "'  and filldate > '" + strFromDate + "' order by filldate desc";
            }
            else
            {
               
                Sql_Query = "Select [Instance_ID] , filldate , User_name, Reported from V_Answers where Form_ID = " + fid
                + " and filldate <= '" + strToDate +
                "'  and filldate > '" + strFromDate + 
                "' And Question_ID = " + QID + " " +
                Query + " order by filldate desc";
            }

            return connector.Select(Sql_Query);
        }

        static public DataTable get_dt_answersForExcelBetweenDates(String fid, string Query, DateTime FromDate, DateTime ToDate)
        {
            SQL_Connector connector = new SQL_Connector();

            string format = "yyyy-MM-dd HH:mm:ss";    // modify the format depending upon input required in the column in database 
            var strToDate = ToDate.ToString(format, CultureInfo.InvariantCulture);
            var strFromDate = FromDate.ToString(format, CultureInfo.InvariantCulture);

            String Sql_Query = "Select distinct [USER_NAME],[CodeMahalKhedmat],[filldate] ,[Instance_ID] ,[Form_Instance_User_name] "

                + " from V_Instance_Branch_Answers where Form_ID = " + fid +

                " and filldate <= '" + strToDate + "'  and filldate > '" + strFromDate + "' " + Query;

            return connector.Select(Sql_Query);
        }

        static public DataTable get_dt_answersForExcel(String fid, String Query)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_Query = "Select distinct [Instance_ID] ,User_name,filldate from V_Answers where Form_ID = " + fid +
                " " + Query;
            return connector.Select(Sql_Query);
        }

        static public DataTable GetDtAnswersCodeKhedmatTop(String fid, String Query, string count)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_Query = "Select distinct top " + count +
                " [USER_NAME],[CodeMahalKhedmat],[filldate] ,[Instance_ID] ,[Form_Instance_User_name] "+
                " from V_Instance_Branch_Answers where Form_ID = " + fid +
                " " + Query + " order by filldate desc";
            return connector.Select(Sql_Query);
        }

        public string ReturnString(String QID, Question_Type qtype)
        {
            foreach (var ANSR in _answers)
            {
                if (ANSR.Question_ID == QID && qtype == Question_Type.DrpDnLstTxt)
                    return ANSR.Text_Field;
                if (ANSR.Question_ID == QID && qtype == Question_Type.RdoBtnLstTxt)
                    return ANSR.Text_Field;
                if (ANSR.Question_ID == QID && qtype == Question_Type.ChckBxLstTxt)
                    return ANSR.Text_Field;
                if (ANSR.Question_ID == QID && qtype == Question_Type.Text)
                    return ANSR.Text_Field;
                if (ANSR.Question_ID == QID &&
                    qtype == Question_Type.Date)
                    return ANSR.Date_Field;
                if (ANSR.Question_ID == QID &&
                    qtype == Question_Type.Number)
                    return ANSR.Number_filed;

            }
            return null;
        }
        public List<string> ReturnLString(String QID, Template_Type ttype)
        {
            foreach (var local in _answers)
            {
                if (local.Question_ID == QID &&
                    ttype == Template_Type.State)
                    return local.State_Choice;
                if (local.Question_ID == QID &&
                    ttype == Template_Type.Branch)
                    return local.Branch_Choice;
                if (local.Question_ID == QID &&
                    ttype == Template_Type.Department)
                    return local.Dep_Choice;
                if (local.Question_ID == QID &&
                    ttype == Template_Type.Manual)
                    return local.List_Choice;
            }
            return null;
        }

    }// Form_Instance class

}