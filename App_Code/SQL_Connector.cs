using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections;
using System.Collections.Generic;

/// <summary>
/// Summary description for SQL_DB
/// </summary>
public class SQL_Connector
{
    private SqlConnection Sqlconnection_credit_index = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ORM_ConnectionString"].ConnectionString);
    

    public SQL_Connector()
	{
        //Sqlconnection_credit_index.ConnectionTimeout=
        int x = Sqlconnection_credit_index.ConnectionTimeout;

		//
		// TODO: Add constructor logic here
		//
	}

    public bool Execute(String SQL_Query)
    {
        try
        {
            SqlCommand com = new SqlCommand(SQL_Query,Sqlconnection_credit_index);
            Sqlconnection_credit_index.Open();
            com.ExecuteNonQuery();
            Sqlconnection_credit_index.Close();
            return true;           
        }
        catch (Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);
            Sqlconnection_credit_index.Close();
            return false;
        }

    }

    public bool Check_Query(String sql_query)
    {
        try
        {
            SqlCommand com = new SqlCommand(sql_query, Sqlconnection_credit_index);
            Sqlconnection_credit_index.Open();
            com.ExecuteNonQuery();
            Sqlconnection_credit_index.Close();
        }
        catch (Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);
            return false;
        }
        return true;

    }

    public bool Check_Query(SqlCommand command)
    {
        try
        {
            command.Connection = Sqlconnection_credit_index;
            Sqlconnection_credit_index.Open();
            command.ExecuteScalar();
            Sqlconnection_credit_index.Close();
        }
        catch (Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);

            return false;
        }
        return true;

    }


    public String execute_scalar(SqlCommand command)
    {
        try
        {
            command.Connection = Sqlconnection_credit_index; 
            Sqlconnection_credit_index.Open();
            String output = command.ExecuteScalar().ToString();
            Sqlconnection_credit_index.Close();
            return output; 
        }
        catch (Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);

            return "0";
        }
    }
    public String execute_scalar(String sql_query)
    {
        try
        {
            SqlCommand com = new SqlCommand(sql_query, Sqlconnection_credit_index);
            Sqlconnection_credit_index.Open();
            String output = com.ExecuteScalar().ToString();
            Sqlconnection_credit_index.Close();
            return output;
        }
        catch (Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);

            Sqlconnection_credit_index.Close();
            return "0";
           
        }
    }
    public DataTable Select(String SQL_Query)
    {
        try
        {
            SqlDataAdapter da = new SqlDataAdapter(SQL_Query, Sqlconnection_credit_index);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
        catch(Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);

            return null;
        }
    }

    public DataTable Select(SqlCommand command)
    {
        try
        {
            Sqlconnection_credit_index.Close();
            command.Connection = Sqlconnection_credit_index;
            Sqlconnection_credit_index.Open();
            IDataReader dr =command.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            dr.Close();
            Sqlconnection_credit_index.Close();
            return dt;
        }
        catch(Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);

            Sqlconnection_credit_index.Close();
            return null;
        }
    }

    public Boolean Transaction(String sqlcommand)
    {
        SqlTransaction transaction = null;
        SqlCommand command = new SqlCommand();
        command.Connection = Sqlconnection_credit_index;
        try
        {
            Sqlconnection_credit_index.Open();
            transaction = Sqlconnection_credit_index.BeginTransaction();
            command.Transaction = transaction;
            command.CommandText = sqlcommand ;
            command.ExecuteNonQuery();
            transaction.Commit();
            Sqlconnection_credit_index.Close();

        }
        catch(Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);

            transaction.Rollback();
            Sqlconnection_credit_index.Close();
            return false;
        }

        return true;
    }

    public Boolean Transaction(String strSql, SqlCommand cmd)
    {
        SqlTransaction transaction = null;
        SqlCommand command = new SqlCommand();
        command.Connection = Sqlconnection_credit_index;
        try
        {
            Sqlconnection_credit_index.Open();
            transaction = Sqlconnection_credit_index.BeginTransaction();
            command.Transaction = transaction;
            command.CommandText = strSql;
            command.Parameters.Add(cmd.Parameters[0]);//
            command.ExecuteNonQuery();
            transaction.Commit();
            Sqlconnection_credit_index.Close();

        }
        catch (Exception er)
        {
            System.Diagnostics.Debug.WriteLine(
                string.Format("ERROR PLACE TIME: {0}-{1}",
                System.Reflection.MethodInfo.GetCurrentMethod().Name
                , DateTime.Now.ToString("yyyy/MM/dd-hh:mm",
                new System.Globalization.CultureInfo("fa-IR"))
                ));
            Logger.Error(er.Message);

            transaction.Rollback();
            Sqlconnection_credit_index.Close();
            return false;
        }

        return true;
    }
}