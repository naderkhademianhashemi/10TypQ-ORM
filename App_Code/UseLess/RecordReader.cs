//using System;
//using System.Data;
//using System.Configuration;
//using System.Collections.Generic;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Data.SqlClient;

///// <summary>
///// Summary description for RecordReader
///// </summary>
//public class RecordReader
//{
//    SqlConnection con;
//    SqlCommand command;
//    SqlDataReader reader;
    

//    public RecordReader()
//    {
//        con = new SqlConnection(
//                ConfigurationManager.ConnectionStrings["Connectionstring"].ConnectionString);
//        command = new SqlCommand();
//        command.Connection = con;
        
//    }

//    public List<string> getLocationList()
//    {       
//        List<String> locationList = new List<String>();

//        command.CommandText = "select locName FROM oprisk_Location";
//        con.Open();
//        reader = command.ExecuteReader();       

//        while (reader.Read())
//        {
//            locationList.Add(reader["locName"].ToString());
//        }
//        con.Close();

//        return locationList;
//    }

//    public List<string> getBranchList()
//    {
//        List<String> branchList = new List<String>();

//        command.CommandText = "select BranchName FROM oprisk_Branch";
//        con.Open();
//        reader = command.ExecuteReader();

//        while (reader.Read())
//        {
//            branchList.Add(reader["BranchName"].ToString());
//        }
//        con.Close();

//        return branchList;
//    }
//}
