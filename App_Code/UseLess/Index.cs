//using System;
//using System.Data;
//using System.Configuration;
//using System.Collections;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Data.SqlClient;
//using System.Drawing;
//using System.Web;
//using Dundas.Gauges.WebControl;


///// <summary>
///// Summary description for Index
///// </summary>
///// 
//namespace ORM
//{
//    public class Index
//    {
//        private int[] locs = new int[]{0,32,44,53,39,45,51,59,46,52,48,56,58,33,60,49,38,35,34
//        ,57,50,4,47,40,37,41,54,36,55,42,43};

//        private String _index_id;
//        private String _index_name;
//        private String _description;
//        private ORM_Types.Index_Type _index_type;
//        private String _goal;
//        private String _desirable;
//        private Boolean _is_loc_sensitive;
//        private String _math_statement;
//        private ArrayList _bounds;
//        private ArrayList _dep_array = new ArrayList();
//        private ArrayList _state_array = new ArrayList();

//        public Index()
//        {
//            _index_id = "";
//            _index_name = "";
//            _description= "";
//            ORM_Types.Index_Type _index_type = ORM_Types.Index_Type.ASC;
//            _goal = Double.NaN.ToString();
//            _desirable = Double.NaN.ToString();
//            _is_loc_sensitive = true;
//            _math_statement = "";
//            _bounds = new ArrayList();
//            //
//            // TODO: Add constructor logic here
//            //
//        }

//        public Index(String index_id)
//        {
//            String sql_query = "SELECT [Index_ID],[Name],[Description],[Index_Type],[Goal],[Desirable] " +
//                ",[Is_Loc_Sensitive],[Math_Statement] FROM [Risk_Indicator] where [Index_ID]=" + index_id;
//            SQL_Connector connector = new SQL_Connector();
//            DataTable dt = connector.Select(sql_query);

//            if (dt != null)
//            {
//                foreach (DataRow dr in dt.Rows)
//                {
//                    this._index_id = dr["Index_ID"].ToString();
//                    this._index_name = dr["Name"].ToString();
//                    this._description = dr["Description"].ToString();
//                    this._index_type = ORM_Types.Get_Index_Type(int.Parse(dr["Index_Type"].ToString()));
//                    this._goal = dr["Goal"].ToString();
//                    this._desirable = dr["Desirable"].ToString();
//                    this._is_loc_sensitive = Convert.ToBoolean(dr["Is_Loc_Sensitive"].ToString());
//                    this._math_statement = dr["Math_Statement"].ToString();
//                }
//            }

//            if (Index_Type == ORM_Types.Index_Type.REL)
//            {
//                this._bounds = new ArrayList();
//                String Sql_query_bound = "SELECT [Bound_ID],[Index_ID],[Bound_Type],[negative_infinity],[Lower_Bound_isclose], " +
//                    "[Lower_Bound],[Upper_Bound_isclose],[positive_infinity],[Upper_Bound] FROM [Risk_Indicator_Bound] " +
//                    "where Index_ID = " + index_id;
//                DataTable dt_bound = connector.Select(Sql_query_bound);
//                if (dt != null)
//                {
//                    foreach (DataRow dr in dt_bound.Rows)
//                    {
//                        Index_Bound newbound = new Index_Bound(
//                            index_id, dr["Bound_ID"].ToString(),
//                            ORM.ORM_Types.Get_Bound_Type(int.Parse(dr["Bound_Type"].ToString())),
//                            Convert.ToBoolean(dr["Lower_Bound_isclose"].ToString()),
//                            Convert.ToBoolean(dr["negative_infinity"].ToString()), dr["Lower_Bound"].ToString(),
//                            Convert.ToBoolean(dr["Upper_Bound_isclose"].ToString()),
//                            Convert.ToBoolean(dr["positive_infinity"].ToString()), dr["Upper_Bound"].ToString());

//                        this._bounds.Add(newbound);
//                    }
//                }
//            }

//        }

//        public String Add_Bound(Index_Bound Input_bound)
//        {
//            Input_bound.Bound_ID = Bounds.Count.ToString();
//            Bounds.Add(Input_bound);
//            return (Bounds.Count-1).ToString();
//        }

//        public void Remove_Bound(String value)
//        {
//            foreach (object obj in Bounds)
//            {
//                Index_Bound localbound = (Index_Bound) obj;
//                if (localbound.Bound_ID == value)
//                {
//                    Bounds.Remove(obj);
//                    return;
//                }
//            }
//        }

//        public Dundas.Gauges.WebControl.GaugeContainer guage_binder(Dundas.Gauges.WebControl.GaugeContainer input_guage , Label input_label)
//        {
            
//            CircularRange rcg = new CircularRange();
//            int index = 0;
//            Double max, min;
//            Color[] bound_color = new Color[] { Color.Red, Color.YellowGreen, Color.FromArgb(254, 150, 0) };
//            Color[] bound_color1 = new Color[] { Color.FromArgb(254, 150, 0), Color.YellowGreen, Color.Red };
//            try
//            {
//                if (Index_Type == ORM_Types.Index_Type.ASC)
//                {
                    
//                    max = min = Double.Parse(input_label.Text);
//                    input_guage.CircularGauges["Default"].Pointers["Default"].Value = min;
//                    if (double.Parse(Goal) > max) max = Double.Parse(Goal);
//                    if (double.Parse(Desirable) < min) min = Double.Parse(Desirable);
//                    int pc = (int)(max - min + 1) / 5;
//                    min -= pc; max += pc;
//                    rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده خطر:" + index.ToString() + "بازه");
//                    rcg.StartValue = min; rcg.EndValue = Double.Parse(Desirable);
//                    rcg.FillColor = rcg.FillGradientEndColor = bound_color[0];
//                    rcg.EndWidth = rcg.StartWidth;
//                    index++;
//                    rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده هشدار:" + index.ToString() + "بازه");
//                    rcg.StartValue = Double.Parse(Desirable); rcg.EndValue = Double.Parse(Goal);
//                    rcg.FillColor = rcg.FillGradientEndColor = bound_color[2];
//                    rcg.EndWidth = rcg.StartWidth;
//                    index++;
//                    rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده هدف:" + index.ToString() + "بازه");
//                    rcg.StartValue = Double.Parse(Goal); rcg.EndValue = max;
//                    rcg.FillColor = rcg.FillGradientEndColor = bound_color[1];
//                    rcg.EndWidth = rcg.StartWidth;
//                    index++;
//                    CircularScale scale = input_guage.CircularGauges["Default"].Scales["Default"];
//                    scale.Minimum = min;
//                    scale.Maximum = max;
//                    return input_guage;
//                }

//                else
//                    if (Index_Type == ORM_Types.Index_Type.DES)
//                    {
//                        max = min = Double.Parse(input_label.Text);
//                        input_guage.CircularGauges["Default"].Pointers["Default"].Value = min;
//                        if (double.Parse(Goal) > max) max = Double.Parse(Goal);
//                        if (double.Parse(Desirable) < min) min = Double.Parse(Desirable);
//                        int pc = (int)(max - min + 1) / 5;
//                        min -= pc; max += pc;
//                        rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده خطر:" + index.ToString() + "بازه");
//                        rcg.StartValue = min; rcg.EndValue = Double.Parse(Desirable);
//                        rcg.FillColor = rcg.FillGradientEndColor = bound_color[1];
//                        rcg.EndWidth = rcg.StartWidth;
//                        rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده هشدار:" + index.ToString() + "بازه");
//                        rcg.StartValue = Double.Parse(Desirable); rcg.EndValue = Double.Parse(Goal);
//                        rcg.FillColor = rcg.FillGradientEndColor = bound_color[2];
//                        rcg.EndWidth = rcg.StartWidth;
//                        rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده هدف:" + index.ToString() + "بازه");
//                        rcg.StartValue = Double.Parse(Goal); rcg.EndValue = max;
//                        rcg.FillColor = rcg.FillGradientEndColor = bound_color[0];
//                        rcg.EndWidth = rcg.StartWidth;
//                        CircularScale scale = input_guage.CircularGauges["Default"].Scales["Default"];
//                        scale.Minimum = min;
//                        scale.Maximum = max;
//                    }
//                    else
//                        if (Index_Type == ORM_Types.Index_Type.REL)
//                        {
//                            Index_Bound bound = new Index_Bound();
//                            bound.Lower_Bound = bound.Upper_Bound = double.Parse(input_label.Text).ToString();
//                            max = min = Double.Parse(bound.Lower_Bound);
//                            rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده هشدار:" + index.ToString() + "بازه");
//                            rcg.StartValue = Double.MinValue;
//                            rcg.EndValue = Double.MaxValue;
//                            rcg.FillColor = rcg.FillGradientEndColor = Color.White;
//                            rcg.EndWidth = rcg.StartWidth;

//                            foreach (object obj in this.Bounds)
//                            {
//                                Index_Bound local_bound = (Index_Bound)obj;
//                                if (local_bound.Bound == ORM_Types.Bound_Type.Danger)
//                                    rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده خطر:" + index.ToString() + "بازه");
//                                else
//                                    if (local_bound.Bound == ORM_Types.Bound_Type.Alarm)
//                                        rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده هشدار:" + index.ToString() + "بازه");
//                                    else
//                                        if (local_bound.Bound == ORM_Types.Bound_Type.Goal)
//                                            rcg = input_guage.CircularGauges["default"].Ranges.Add("محدوده هدف:" + index.ToString() + "بازه");
//                                index++;
//                                if (!local_bound.Negative_Infinity && Double.Parse(local_bound.Lower_Bound) < min)
//                                    min = Double.Parse(local_bound.Lower_Bound);
//                                if (!local_bound.Positive_Infinity && Double.Parse(local_bound.Upper_Bound) > max)
//                                    max = Double.Parse(local_bound.Upper_Bound);
//                                rcg.StartValue = Double.Parse(local_bound.Lower_Bound);
//                                rcg.EndValue = Double.Parse(local_bound.Upper_Bound);
//                                rcg.FillColor = rcg.FillGradientEndColor = bound_color1[ORM_Types.Get_Bound_Type(local_bound.Bound) - 1];
//                                rcg.EndWidth = rcg.StartWidth;

//                            }
//                            int pc = (int)(max - min + 1) / 5;
//                            min -= pc; max += pc;
//                            CircularScale scale = input_guage.CircularGauges["Default"].Scales["Default"];
//                            scale.Minimum = min;
//                            scale.Maximum = max;
//                            input_guage.CircularGauges["Default"].Pointers["Default"].Value = Double.Parse(bound.Lower_Bound);
//                        }
//            }
//            catch
//            {

//            }
//            return input_guage;

//        }

//        public Result_Objects get_value(String From_date , String to_date)
//        {            
//                return ORM.Mathematical.makePresfix(Math_Statement, From_date, to_date);           
//        }

//        public String Get_Html_Code(String From_date , String to_date)
//        {
//            String querystring = "";
//            Result_Objects temp = get_value(From_date, to_date);

//            for(int counter=1 ; counter<locs.Length; counter++)
//            {
//                querystring += "ID" + locs[counter].ToString() + "=" + Get_Color(Double.Parse(temp.Values[counter])) + "&";
//                querystring += "Value" + locs[counter].ToString() + "=" + Get_Double(temp.Values[counter]) + "&";
//            }
//            return querystring;
//        }

//        private String Get_Double(String in_value)
//        {
//            if (in_value.Equals(double.NaN.ToString()))
//                return "No Data";
//            else
//                return Math.Round(Double.Parse(in_value), 2).ToString();
//        }

//        private String Get_Color(Double value)
//        {
            
//            if (this.Index_Type == ORM_Types.Index_Type.ASC)
//            {
//                Double goal = double.Parse(this.Goal);
//                Double desirable = double.Parse(this.Desirable);
//                if (value < desirable)
//                    return Color.Red.ToArgb().ToString();
//                else if (value >= desirable & value <= goal)
//                    return Color.Orange.ToArgb().ToString();
//                else if (value > goal)
//                    return Color.Green.ToArgb().ToString();
//            }

//            if (this.Index_Type == ORM_Types.Index_Type.DES)
//            {
//                Double goal = double.Parse(this.Goal);
//                Double desirable = double.Parse(this.Desirable);
//                if (value > goal)
//                    return Color.Red.ToArgb().ToString();
//                else if (value <= goal & value >= desirable)
//                    return Color.Orange.ToArgb().ToString();
//                else if (value < goal)
//                    return Color.Green.ToArgb().ToString();
//            }

//            if (this.Index_Type == ORM_Types.Index_Type.REL)
//            {
//                foreach (Index_Bound temp_bound in this.Bounds)
//                {
//                    if(temp_bound.is_in_bound(value))
//                        if(temp_bound.Bound == ORM_Types.Bound_Type.Goal)
//                            return Color.Green.ToArgb().ToString();
//                        else
//                            if(temp_bound.Bound == ORM_Types.Bound_Type.Alarm)
//                                return Color.Orange.ToArgb().ToString();
//                            else
//                                if (temp_bound.Bound == ORM_Types.Bound_Type.Danger)
//                                    return Color.Red.ToArgb().ToString();
//                }
//            }
//            return Color.White.ToArgb().ToString();
//        }

//        private ArrayList Related_Parameter()
//        {
//            ArrayList output = new ArrayList();
//            String[] math_element = Math_Statement.Split(';');
//            for (int i = 0; i < math_element.Length; i++)
//                if (math_element[i].Contains("P"))
//                {
//                    String pid = math_element[i].Substring(0,math_element[i].IndexOf("P"));
//                    Parameter newparameter = new Parameter(pid);
//                    output.Add(newparameter);
//                }
//            return output;
//        }

//        public bool is_loc_sensitive()
//        {
//            ArrayList parameters = this.Related_Parameter();
//            foreach (Parameter par in parameters)
//            {
//                if (par.Is_Loc_Sensitive)
//                    return true;
//            }
//            return false;
//        }
        
//        public Boolean save()
//        {
//            try
//            {
//                this.IS_Loc_Sensitive = is_loc_sensitive();
//                String Sql_query = "INSERT INTO [Risk_Indicator] ([Name],[Description],[Index_Type],[Goal]" +
//                    ",[Desirable],[Is_Loc_Sensitive],[Math_Statement]) " +
//                    "VALUES (N'" + this.Index_Name + "' , N'" + this.Description + "'," + ORM.ORM_Types.Get_Index_Type(this.Index_Type) +
//                    "," + this.Goal + "," + this.Desirable + "," + Convert.ToByte(this.IS_Loc_Sensitive) +
//                    ",N'" + this.Math_Statement + "') " +
//                    "DECLARE @local int " +
//                    "Set @local = (SELECT IDENT_CURRENT('Risk_Indicator')) ";

//                foreach (object obj in State_Array)
//                {
//                    String stateid = (String)obj;
//                    Sql_query += "INSERT INTO [State_Index] ([State_ID],[Index_ID]) VALUES  (" + stateid + ",@local) ";
//                }

//                foreach (object obj in Dep_Array)
//                {
//                    String depid = (String)obj;
//                    Sql_query += "INSERT INTO [Dep_Index] ([Index_ID],[Dep_ID]) VALUES (@local," + depid + ") ";
//                }
//                SQL_Connector connector = new SQL_Connector();
//                connector.Execute(Sql_query);


//                if (this._index_type == ORM_Types.Index_Type.REL)
//                {
//                    Sql_query = "select Index_ID from Risk_indicator where name =N'" + this.Index_Name + "'";
//                    DataTable dt = connector.Select(Sql_query);
//                    if (dt != null & dt.Rows.Count != 0)
//                    {
//                        String LocalID = dt.Rows[0]["Index_ID"].ToString();
//                        foreach (object obj in this.Bounds)
//                        {
//                            Index_Bound local_bound = (Index_Bound)obj;
//                            local_bound.Index_ID = LocalID;
//                            local_bound.Save();
//                        }
//                    }
//                    else
//                        return false;
//                }
//                return true; 
//            }
//            catch
//            {
//                return false;
//            }
//        }

//        public static String GetStmt(String obj)
//        {
//            String str = obj.ToString();
//            SQL_Connector connector = new SQL_Connector();
//            SqlCommand com = new SqlCommand();
//            com.CommandText = "select Prameter_Name from parameter where parameter_id = @pid ";
//            com.Parameters.Add("@pid", SqlDbType.BigInt);
//            String output = "";
//            for (int i = 0; i < str.Length; i++)
//            {
//                char c = str[i];
//                if (char.IsDigit(c))
//                {
//                    int k = i;
//                    while ((char.IsDigit(str[i])) && ++i < str.Length) ;
//                    if (str[i] == '.' && str.Length > i)
//                    {
//                        i++;
//                        while ((char.IsDigit(str[i])) && ++i < str.Length) ;
//                    }
//                    if (i < str.Length && str[i] == 'V')
//                    {
//                        output += str.Substring(k, i - k);
//                        continue;
//                    }
//                    try
//                    {
//                        com.Parameters["@pid"].Value = str.Substring(k, i - k);
//                        output += connector.execute_scalar(com).ToString();
//                    }
//                    catch (Exception err)
//                    {
//                        output += "????";
//                    }

//                }
//                else if (c != ';')
//                {
//                    output += str.Substring(i, 1);
//                }
//            }
//            return output;
//        }

//        public Boolean have_intersection_with(Index_Bound new_bound)
//        {
//            foreach (Index_Bound temp_bound in this.Bounds)
//            {
//                if (temp_bound.have_intersection_with(new_bound))
//                    return true;
//            }
//            return false;
//        }
//        public static DataTable Get_DT_indicators(String name, String dep_ID, String State_ID)
//        {
//            String query = "SELECT distinct [Index_ID],[Name],[Description],[Index_Type],[Goal],[Desirable],[Is_Loc_Sensitive],[Math_Statement] "+
//                "FROM [View_Risk_Indicator] where [name] Like(N'%" + name + "%')";

//            if (dep_ID != "0") query += " AND Dep_ID =" + dep_ID;
//            if (State_ID != "0") query += "AND State_ID = " + State_ID;

//            return new SQL_Connector().Select(query);
//        }

//        public static bool Is_valid_Name(String name)
//        {
//            try
//            {
//                SQL_Connector connector = new SQL_Connector();
//                System.Data.SqlClient.SqlCommand command = new System.Data.SqlClient.SqlCommand("select count(*) from Risk_Indicator where Name = @name");
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

//        public String Index_ID
//        {
//            get { return _index_id; }
//            set { _index_id = value; }
//        }

//        public String Index_Name
//        {
//            get { return _index_name; }
//            set { _index_name = value; }
//        }

//        public String Description
//        {
//            get { return _description; }
//            set { _description = value; }
//        }

//        public ORM_Types.Index_Type Index_Type
//        {
//            get { return _index_type; }
//            set { _index_type = value; }
//        }

//        public ArrayList Bounds
//        {
//            get { return _bounds; }
//            set { _bounds = value; }
//        }

//        public String Desirable
//        {
//            get { return _desirable; }
//            set { _desirable = value; }
//        }

//        public String Goal
//        {
//            get { return _goal; }
//            set { _goal = value; }
//        }

//        public Boolean IS_Loc_Sensitive
//        {
//            get { return _is_loc_sensitive; }
//            set { _is_loc_sensitive = value; }
//        }

//        public String Math_Statement
//        {
//            get { return _math_statement; }
//            set { _math_statement = value; }
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
