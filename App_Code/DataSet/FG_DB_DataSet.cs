using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Globalization;

/// <summary>
/// Summary description for FG_DB_DataSet
/// </summary>
public class FG_DB_DataSet
{
    private const string _SP_PRSNL = "SP_PRSNL";
    private const string _SP_PRSNL_BySemat = "SP_PRSNL_BySemat";
    private const string _SP_PRSNL_ByCodPrsn = "SP_PRSNL_ByCodPrsn";
    private const string _SP_PRSNL_ByUser = "SP_PRSNL_ByUser";
    private const string _SP_PRSNL_GRP = "SP_PRSNL_GRP";
    private const string _SP_PRSNL_GRP_ByCodPrsn = "SP_PRSNL_GRP_ByCodPrsn";
    private const string _SP_PRSNL_GRP_ByUser = "SP_PRSNL_GRP_ByUser";

    private SqlConnection _Sqlconnection_credit_index =
       new SqlConnection(
           System.Web.Configuration.WebConfigurationManager.
           ConnectionStrings["ORM_ConnectionString"].ConnectionString);

    public FG_DB_DataSet()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataTable GetDT_PRSNL_ByCodPrsn(string CodPrsn)
    {
        var table = new DataTable();
        try
        {
            var tmpParam = new SqlParameter("@ShomarehPersenely", SqlDbType.NChar)
            { Value = CodPrsn };
            var db = new SqlCommand(_SP_PRSNL_ByCodPrsn, _Sqlconnection_credit_index)
            { CommandType = CommandType.StoredProcedure };

            db.Parameters.Add(tmpParam);
            var adapter = new SqlDataAdapter(db);
            adapter.Fill(table);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("ERROR PLACE TIME:\t{0}\t{1}\t{2}",
               MethodInfo.GetCurrentMethod().Name
               , ex.Message
               , DateTime.Now.ToString("yyyy/MM/dd-hh:mm", new CultureInfo("fa-IR"))
               );
            Logger.Error(ex.Message);
        }
        return table;
    }
    public DataTable GetDT_PRSNL_BySemat(string Semat)
    {
        var table = new DataTable();
        try
        {
            var tmpParam = new SqlParameter("@Semat", SqlDbType.VarChar)
            { Value = Semat };
            var db = new SqlCommand(_SP_PRSNL_BySemat, _Sqlconnection_credit_index)
            { CommandType = CommandType.StoredProcedure };

            db.Parameters.Add(tmpParam);
            var adapter = new SqlDataAdapter(db);
            adapter.Fill(table);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("ERROR PLACE TIME:\t{0}\t{1}\t{2}",
               MethodInfo.GetCurrentMethod().Name
               , ex.Message
               , DateTime.Now.ToString("yyyy/MM/dd-hh:mm", new CultureInfo("fa-IR"))
               );
            Logger.Error(ex.Message);
            return null;
        }
        return table;
    }

    public DataTable GetDT_PRSNL_ByUser(string User_Name)
    {
        var table = new DataTable();
        try
        {
            var tmpParam = new SqlParameter("@User_Name", SqlDbType.NVarChar)
            { Value = User_Name };
            var db = new SqlCommand(_SP_PRSNL_ByUser, _Sqlconnection_credit_index)
            { CommandType = CommandType.StoredProcedure };

            db.Parameters.Add(tmpParam);
            var adapter = new SqlDataAdapter(db);
            adapter.Fill(table);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("ERROR PLACE TIME:\t{0}\t{1}\t{2}",
               MethodInfo.GetCurrentMethod().Name
               , ex.Message
               , DateTime.Now.ToString("yyyy/MM/dd-hh:mm", new CultureInfo("fa-IR"))
               );
            Logger.Error(ex.Message);
        }
        return table;
    }
    public DataTable GetDT_PRSNL()
    {
        var table = new DataTable();
        try
        {
            var db = new SqlCommand(_SP_PRSNL, _Sqlconnection_credit_index)
            { CommandType = CommandType.StoredProcedure };

            var adapter = new SqlDataAdapter(db);
            adapter.Fill(table);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("ERROR PLACE TIME:\t{0}\t{1}\t{2}",
               MethodInfo.GetCurrentMethod().Name
               , ex.Message
               , DateTime.Now.ToString("yyyy/MM/dd-hh:mm", new CultureInfo("fa-IR"))
               );
            Logger.Error(ex.Message);
        }
        return table;
    }
    public DataTable GetDT_PRSNL_GRP()
    {
        var table = new DataTable();
        try
        {
            var db = new SqlCommand(_SP_PRSNL_GRP,
                _Sqlconnection_credit_index)
            { CommandType = CommandType.StoredProcedure };

            var adapter = new SqlDataAdapter(db);
            adapter.Fill(table);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("ERROR PLACE TIME:\t{0}\t{1}\t{2}",
               MethodInfo.GetCurrentMethod().Name
               , ex.Message
               , DateTime.Now.ToString("yyyy/MM/dd-hh:mm", new CultureInfo("fa-IR"))
               );
            Logger.Error(ex.Message);
        }
        return table;
    }

    public DataTable GetDT_PRSNL_GRP_ByGroupId(int Group_ID)
    {
        var table = new DataTable();
        try
        {
            var tmpGroup_ID = new SqlParameter("@Group_ID", SqlDbType.Int)
            { Value = Group_ID };
            
            var db = new SqlCommand(_SP_PRSNL_GRP,
                _Sqlconnection_credit_index)
            { CommandType = CommandType.StoredProcedure };

            db.Parameters.Add(tmpGroup_ID);
            var adapter = new SqlDataAdapter(db);
            adapter.Fill(table);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("ERROR PLACE TIME:\t{0}\t{1}\t{2}",
               MethodInfo.GetCurrentMethod().Name
               , ex.Message
               , DateTime.Now.ToString("yyyy/MM/dd-hh:mm", new CultureInfo("fa-IR"))
               );
            Logger.Error(ex.Message);
        }
        return table;
    }
    public DataTable GetDT_PRSNL_GRP_ByCodPrsn(int Group_ID, string CodPrsn)
    {
        var table = new DataTable();
        try
        {
            var tmpGroup_ID = new SqlParameter("@Group_ID", SqlDbType.Int)
            { Value = Group_ID };
            var tmpParam = new SqlParameter("@ShomarehPersenely", SqlDbType.NChar)
            { Value = CodPrsn };
            var db = new SqlCommand(_SP_PRSNL_GRP_ByCodPrsn, 
                _Sqlconnection_credit_index)
            { CommandType = CommandType.StoredProcedure };

            db.Parameters.Add(tmpParam);
            db.Parameters.Add(tmpGroup_ID);
            var adapter = new SqlDataAdapter(db);
            adapter.Fill(table);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("ERROR PLACE TIME:\t{0}\t{1}\t{2}",
               MethodInfo.GetCurrentMethod().Name
               , ex.Message
               , DateTime.Now.ToString("yyyy/MM/dd-hh:mm", new CultureInfo("fa-IR"))
               );
            Logger.Error(ex.Message);
        }
        return table;
    }

    public DataTable GetDT_PRSNL_GRP_ByUserName(int Group_ID, string User_Name)
    {
        var table = new DataTable();
        try
        {
            var tmpGroup_ID = new SqlParameter("@Group_ID", SqlDbType.Int)
            { Value = Group_ID };
            var tmpUser_Name = new SqlParameter("@User_Name", SqlDbType.NVarChar)
            { Value = User_Name };

            var db = new SqlCommand(_SP_PRSNL_GRP_ByUser,
                _Sqlconnection_credit_index)
            { CommandType = CommandType.StoredProcedure };

            db.Parameters.Add(tmpGroup_ID);
            db.Parameters.Add(tmpUser_Name);
            var adapter = new SqlDataAdapter(db);
            adapter.Fill(table);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("ERROR PLACE TIME:\t{0}\t{1}\t{2}",
               MethodInfo.GetCurrentMethod().Name
               , ex.Message
               , DateTime.Now.ToString("yyyy/MM/dd-hh:mm", new CultureInfo("fa-IR"))
               );
            Logger.Error(ex.Message);
        }
        return table;
    }

}