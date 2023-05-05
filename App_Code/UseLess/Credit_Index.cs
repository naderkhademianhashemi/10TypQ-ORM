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
///// Summary description for Credit_Index
///// </summary>
//public class Credit_Index
//{
//    //public enum type{ ASC , DES , REL};

//    //private int index_id = 0;
//    //private String index_name = "";
//    //private type index_type;
//    //private ArrayList bounds  = new ArrayList();

//    //public Credit_Index(int index_id , String index_name , type index_type , ArrayList bound)
//    //{
//    //    //
//    //    // TODO: Add constructor logic here
//    //    //
        
//    //    this.index_id = index_id;
//    //    this.index_name = index_name;
//    //    this.index_type = index_type;
//    //    this.bounds = bounds;
//    //}

//    //public Credit_Index( String index_name, type index_type, ArrayList bound)
//    //{
//    //    //
//    //    // TODO: Add constructor logic here
//    //    //
//    //    this.index_id = 0;
//    //    this.index_name = index_name;
//    //    this.index_type = index_type;
//    //    this.bounds = bounds;

//    //}

//    //public Credit_Index()
//    //{
//    //    this.index_id = 0;
//    //    this.index_name = "";


//    //}

//    //public Credit_Index(int index_id)
//    //{
//    //    Credit_Index Output = new Credit_Index();

//    //    SQL_Connector connector = new SQL_Connector();

//    //    String SQL_Query = "SELECT [Index_ID],[Index_Name],[Index_Type] FROM [Credit_Index] where Index_ID=" + index_id;
//    //    DataTable index_table = connector.Select(SQL_Query);

//    //    if (index_table.Rows.Count > 0)
//    //    {

//    //        SQL_Query = "SELECT [Bound_ID],[Index_ID],[Bound_Type],[Lower_Bound_isclose],[negative_infinity]" +
//    //        ",[Lower_Bound],[Upper_bound_isclose] , [positive_infinity],[Upper_Bound]" +
//    //            "FROM [Credit_Bound] where [Index_ID]=" + index_id;
//    //        DataTable bound_table = connector.Select(SQL_Query);

//    //        foreach (DataRow row in bound_table.Rows)
//    //        {
//    //            Credit_Bound.bound_type bound_type = Credit_Bound.bound_type.Danger;
//    //            if (row["Bound_Type"].ToString().Contains("Target")) 
//    //                bound_type = Credit_Bound.bound_type.Target;
//    //            else
//    //                if (row["Bound_Type"].ToString().Contains("Alarm")) 
//    //                    bound_type = Credit_Bound.bound_type.Alarm;

//    //            Credit_Bound temp = new Credit_Bound(int.Parse(row["Bound_ID"].ToString()), int.Parse(row["Index_ID"].ToString()),
//    //                bound_type, Convert.ToBoolean(row["Lower_Bound_isclose"].ToString()), Convert.ToBoolean(row["Negative_Infinity"].ToString()),
//    //                Convert.ToDouble(row["Lower_Bound"].ToString()), Convert.ToBoolean(row["Upper_Bound_isclose"].ToString()), 
//    //                Convert.ToBoolean(row["Positive_Infinity"].ToString()), Convert.ToDouble(row["Upper_Bound"].ToString()));

//    //            bounds.Add(temp);
//    //        }

//    //        this.index_type = Credit_Index.type.ASC;

//    //        if (index_table.Rows[0]["Index_Type"].ToString().Contains("DES"))
//    //            this.index_type = Credit_Index.type.DES;
//    //        else
//    //            if (index_table.Rows[0]["Index_Type"].ToString().Contains("REL"))
//    //                this.index_type = Credit_Index.type.REL;
            

//    //        this.index_id = index_id;
//    //        this.index_name = index_table.Rows[0]["Index_Name"].ToString();
//    //    }
//    //    else
//    //    {
//    //        this.index_name = "null"; 
//    //    }


//    //}

//    //public void add_bound(Credit_Bound bound)
//    //{
//    //    this.bounds.Add(bound);
//    //}

//    //public void remove_bound(int bound_index)
//    //{
//    //    this.bounds.RemoveAt(bound_index);
//    //}
    
//    //public void Save_index()
//    //{
//    //    SQL_Connector connector = new SQL_Connector();
//    //    String SQL_Query = "INSERT INTO [Credit_Index] ([Index_ID],[Index_Name],[Index_Type]) VALUES ("+index_id+",N'" + index_name + "','" + index_type + "')";
//    //    connector.Execute(SQL_Query);
        

//    //    foreach (Object bound in bounds)
//    //    {
//    //        Credit_Bound tempbound = (Credit_Bound) bound;
//    //        tempbound.Credit_ID_Index = this.index_id;
//    //        tempbound.Save_bound();
//    //    }

//    //}

//    //public void delete()
//    //{
//    //    SQL_Connector connector = new SQL_Connector();
//    //    String SQL_Query = "DELETE FROM [Credit_Bound] WHERE index_id=" + index_id;
//    //    connector.Execute(SQL_Query);

//    //    SQL_Query = "DELETE FROM [Credit_Index] WHERE index_id=" + index_id ;
//    //    connector.Execute(SQL_Query);


//    //}

//    //public int Index_ID
//    //{
//    //    get { return index_id; }
//    //    set { index_id = value; }
//    //}
//    //public String Index_Name
//    //{
//    //    get { return index_name; }
//    //    set { index_name = value; }
//    //}


//    //public type Index_Type
//    //{
//    //    get { return index_type; }
//    //    set { index_type = value; }
//    //}

//    //public ArrayList Bounds
//    //{
//    //    get { return bounds; }
//    //    set { bounds = value; }
//    //}
    

        
//}
