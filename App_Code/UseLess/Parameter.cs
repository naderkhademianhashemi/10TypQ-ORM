//using System;
//using System.Data;
//using System.Configuration;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Collections;
//using System.Collections.Generic;


///// <summary>
///// Summary description for Parameter
///// </summary>
///// 
//namespace ORM
//{
//    public class Parameter
//    {
//        private String _parameter_id = "";
//        private String _parameter_name = "";
//        private String _description = "";
//        private Boolean _is_time_sensitive = false;
//        private Boolean _is_loc_sensitive = false;
//        private String _sql_query = "";
//        private String _parameter_type = "";
//        private ArrayList _value = new ArrayList();
//        private ArrayList _dep_array = new ArrayList();
//        private ArrayList _state_array = new ArrayList();
//        public Parameter()
//        {
//            //
//            // TODO: Add constructor logic here
//            //
//        }

//        public Parameter(String name, String description, Boolean time_sensitive, Boolean loc_sensitive, String local_sql_query, ArrayList dep_array,
//            ArrayList state_array , String par_type)
//        {
//            _parameter_type = par_type;
//            _parameter_name = name;
//            _description = description;
//            _is_time_sensitive = time_sensitive;
//            _is_loc_sensitive = loc_sensitive;
//            _sql_query = local_sql_query.Replace("'", "''") ;
//            _dep_array = dep_array;
//            _state_array = state_array;


//            SQL_Connector connector = new SQL_Connector();
//            String sql_query = "set transaction isolation level SERIALIZABLE " +
//                "begin transaction parameter_tran " +
//                "INSERT INTO [Parameter]([Prameter_Name],[Description],[Is_Time_Sensitive],[Is_Loc_Sensitive],[Sql_Query],[Parameter_Type]) " +
//                "VALUES (N'" + name + "', N'" + description + "', " + Convert.ToByte(time_sensitive) + ", " + Convert.ToByte(loc_sensitive) +
//                ",N'" + _sql_query + "',N'" + par_type + "') " +
//                "if @@Error<>0 begin rollback transaction return end " +
//                "DECLARE @local int " +
//                "Set @local = (SELECT IDENT_CURRENT('Parameter')) " +
//                "if @@Error<>0 begin rollback transaction return end ";

//            foreach (object obj in dep_array)
//            {
//                String depid = (String)obj;
//                sql_query += "INSERT INTO [Parameter_State] ([Parameter_ID],[State_ID]) VALUES  (@local," + depid + ") " +
//                    "if @@Error<>0 begin rollback transaction return end ";
//            }

//            foreach (object obj in state_array)
//            {
//                String stateid = (String)obj;
//                sql_query += "INSERT INTO [Parameter_Dep] ([Parameter_ID],[Department_ID]) VALUES (@local," + stateid + ") " +
//                    "if @@Error<>0 begin rollback transaction return end ";
//            }

//            sql_query += "commit transaction parameter_tran ";
//            connector.Execute(sql_query);

//        }

//        public static Boolean is_loc_sensitive(String PID)
//        {
//            String sql_query = "Select [Is_Loc_Sensitive] FROM [Parameter] where parameter_ID = " + PID;
//            SQL_Connector connector = new SQL_Connector();
//            DataTable dt = connector.Select(sql_query);
//            if (dt != null && dt.Rows.Count != 0)
//                return Convert.ToBoolean(dt.Rows[0]["Is_Loc_Sensitive"]);
//            else
//                return false;
//        }

//        public Parameter(String PID)
//        {
//            SQL_Connector connector = new SQL_Connector();
//            String Sql = "Select Parameter_ID , Prameter_Name , [Description] , Is_TIme_Sensitive , Is_Loc_Sensitive , Sql_query , Parameter_Type " +
//                "From parameter where Parameter_ID=" + PID;
//            DataTable dt = connector.Select(Sql);
//            foreach (DataRow dr in dt.Rows)
//            {
//                this._parameter_id = dr["Parameter_ID"].ToString();
//                this._parameter_name = dr["Prameter_Name"].ToString();
//                this._description = dr["Description"].ToString();
//                this._is_loc_sensitive = Convert.ToBoolean(dr["Is_Loc_Sensitive"].ToString());
//                this._is_time_sensitive = Convert.ToBoolean(dr["Is_TIme_Sensitive"].ToString());
//                this._sql_query = dr["Sql_query"].ToString();
//                this._parameter_type = dr["Parameter_Type"].ToString();
//            }

//            dt = Get_DT_States_Parameter(PID, "Department");
//            _dep_array = new ArrayList();
//            _state_array = new ArrayList();
//            foreach (DataRow dr in dt.Rows)
//            {
//                _dep_array.Add(dr["شماره دپارتمان"].ToString());
//            }

//            dt = Get_DT_States_Parameter(PID, "State");
//            foreach (DataRow dr in dt.Rows)
//            {
//                _state_array.Add(dr["شماره استان"].ToString());
//            }
//        }

//        public static bool Is_valid_Name(String name)
//        {
//            try
//            {
//                SQL_Connector connector = new SQL_Connector();
//                System.Data.SqlClient.SqlCommand command = new System.Data.SqlClient.SqlCommand("select count(*) from Parameter where Prameter_Name = @name");
//                command.Parameters.Clear();
//                command.Parameters.Add("@name", SqlDbType.NVarChar).Value = name;
//                String numrow = connector.execute_scalar(command);
//                if (numrow == "0")
//                    return true;
//                else
//                    return false;
//            }
//            catch
//            {
//                return false;
//            }
//        }

//        public static DataTable Get_DT_Parameters(String name, String dep_ID, String State_ID)
//        {
//            String query = "select distinct Parameter_ID, Parameter_Name, [Description], [Is_Time_Sensitive], " +
//                      " [Is_Loc_Sensitive] , [Sql_Query] from View_parameter where Parameter_Name Like(N'%" + name + "%')";

//            if (dep_ID != "0") query += " AND DepID =" + dep_ID;
//            if (State_ID != "0") query += "AND locid = " + State_ID;

//            return new SQL_Connector().Select(query);
//        }

//        public static DataTable Get_DT_States_Parameter(String PID, String Relation_Type)
//        {
//            String Sql_Query = "";
//            if (Relation_Type == "Department")
//            {
//                Sql_Query = "select distinct DepID as [شماره دپارتمان], Depname as [نام دپارتمان]  from view_parameter where Parameter_ID =" + PID;
//            }
//            else if (Relation_Type == "State")
//            {
//                Sql_Query = "select distinct locid as [شماره استان], locname as [نام استان] from view_parameter where Parameter_ID =" + PID;
//            }

//            SQL_Connector connector = new SQL_Connector();
//            return connector.Select(Sql_Query);
            
//        }

//        public String[] get_values(String from_date, String to_date)
//        {
//            try
//            {
//                if (from_date == "") from_date = System.Data.SqlTypes.SqlDateTime.MinValue.ToString();
//                if (to_date == "") to_date = System.Data.SqlTypes.SqlDateTime.MaxValue.ToString();

//                String[] output = new String[40];
//                SQL_Connector connector = new SQL_Connector();
//                System.Data.SqlClient.SqlCommand command = new System.Data.SqlClient.SqlCommand(this.Sql_Query);
//                command.Parameters.Clear();
//                if (this.Is_Time_Sensitive)
//                {
//                    command.Parameters.Add("@from_date", SqlDbType.DateTime).Value = Convert.ToDateTime(from_date);
//                    command.Parameters.Add("@to_date", SqlDbType.DateTime).Value = Convert.ToDateTime(to_date);
//                }
//                else
//                {
//                    command.Parameters.Add("@from_date", SqlDbType.DateTime).Value = System.Data.SqlTypes.SqlDateTime.MinValue;
//                    command.Parameters.Add("@to_date", SqlDbType.DateTime).Value = System.Data.SqlTypes.SqlDateTime.MaxValue;
//                }
//                DataTable dt = connector.Select(command);

//                if (this._parameter_type == "count")
//                    for (int i = 0; i < 40; i++)
//                        output[i] = "0.0";
//                else
//                    for (int i = 0; i < 40; i++)
//                        output[i] = double.NaN.ToString();

//                if (dt == null || dt.Rows.Count == 0)
//                {
//                    output[0] = "0";
//                    return output;
//                }
//                foreach (DataRow dr in dt.Rows)
//                {
//                    if (this.Is_Loc_Sensitive)
//                    {
//                        output[int.Parse(dr[0].ToString())] = dr[1].ToString();
//                    }
//                    else
//                    {
//                        output[0] = dr[0].ToString();
//                    }
//                }

//                if (this.Is_Loc_Sensitive)
//                    switch (this._parameter_type)
//                    {
//                        case "min":
//                            output[0] = Mathematical.MIN(output);
//                            break;
//                        case "max":
//                            output[0] = Mathematical.MAX(output);
//                            break;
//                        case "sum":
//                        case "count":
//                            output[0] = Mathematical.SUM(output);
//                            break;
//                        case "avg":
//                            output[0] = Mathematical.AVG(output);
//                            break;
//                    }
//                return output;
//            }
//            catch
//            { return null; }
//        }


//        public void Update()
//        {
//            SQL_Connector connector = new SQL_Connector();
//            String sql = "set transaction isolation level SERIALIZABLE " +
//                "begin transaction parameter_update " +
//                "DELETE FROM [Parameter_Dep] WHERE Parameter_ID = " + Parameter_ID +
//                " if @@Error<>0 begin rollback transaction return end " +
//                " DELETE FROM [Parameter_state] WHERE Parameter_ID = " + Parameter_ID +
//                " if @@Error<>0 begin rollback transaction return end " +
//                " UPDATE [Parameter] SET [Prameter_Name] =N'" + Parameter_Name + "',[Description]=N'" + Description + "'" +
//                ",[Is_Time_Sensitive] =" + Convert.ToByte(Is_Time_Sensitive) + ",[Is_Loc_Sensitive] = " + Convert.ToByte(Is_Loc_Sensitive) +
//                ",[Sql_Query] =N'" + Sql_Query + "',Parameter_Type="+_parameter_type+" WHERE Parameter_ID = " + Parameter_ID +
//                " if @@Error<>0 begin rollback transaction return end ";

//            foreach (object obj in _dep_array)
//            {
//                String depid = (String)obj;
//                sql += "INSERT INTO [Parameter_State] ([Parameter_ID],[State_ID]) VALUES  ("+Parameter_ID+"," + depid + ") " +
//                    "if @@Error<>0 begin rollback transaction return end ";
//            }

//            foreach (object obj in _state_array)
//            {
//                String stateid = (String)obj;
//                sql += "INSERT INTO [Parameter_Dep] ([Parameter_ID],[Department_ID]) VALUES ("+Parameter_ID+"," + stateid  + ") " +
//                    "if @@Error<>0 begin rollback transaction return end ";
//            }

//            sql += "commit transaction parameter_update ";

//            connector.Execute(sql);


//        }

//        public void Delete()
//        {
//            String sql = "delete from [Parameter] where Parameter_ID = " + Parameter_ID;
//            SQL_Connector connector = new SQL_Connector();
//            connector.Execute(sql);
//        }

//        public String Parameter_ID
//        {
//            get { return _parameter_id; }
//            set { _parameter_id = value; }
//        }

//        public String Parameter_Name
//        {
//            get { return _parameter_name; }
//            set { _parameter_name = value; }
//        }

//        public String Description
//        {
//            get { return _description; }
//            set { _description = value; }
//        }

//        public Boolean Is_Time_Sensitive
//        {
//            get { return _is_time_sensitive; }
//            set { _is_time_sensitive = value; }
//        }

//        public Boolean Is_Loc_Sensitive
//        {
//            get { return _is_loc_sensitive; }
//            set { _is_loc_sensitive = value; }
//        }
//        public String Sql_Query
//        {
//            get { return _sql_query; }
//            set { _sql_query = value; }
//        }

//        public ArrayList Value
//        {
//            get { return _value; }
//            set { _value = value; }
//        }

//        public ArrayList State_Array
//        {
//            get { return _state_array; }
//            set { _state_array = value; }
//        }

//        public ArrayList Dep_Array
//        {
//            get { return _dep_array; }
//            set { _dep_array = value; }
//        }
//    }
//}