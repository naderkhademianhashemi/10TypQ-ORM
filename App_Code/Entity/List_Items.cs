using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;


/// <summary>
/// Summary description for List_Items
/// </summary>
/// 
namespace ORM
{
    public class List_Items:BaseLstItm
    {
        

        public List_Items()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List_Items(String itemid, String itemtext, String listid)
        {
            _item_id = itemid;
            _item_text = itemtext;
            _list_id = listid;
        }

        public List_Items(String itemtext, String listid, Boolean item_option, Int16 item_type, Boolean item_filled, Int32 item_table)
        {
            _item_id = "";
            _item_text = itemtext;
            _list_id = listid;
            _item_option = item_option;
            _item_type = item_type;
            _item_filled = item_filled;
            _item_table = item_table;
        }

        public List_Items(String Itemid)
        {
            String sql_query = "select [Item_ID],[Item_Text],[List_ID],[Optional],[Item_Type],[Filled],[Table_ID]"+
                " from [List_Items] where Item_ID=" + Itemid;
            SQL_Connector connector = new SQL_Connector();
            DataTable dt = connector.Select(sql_query);
            _item_id = dt.Rows[0]["Item_ID"].ToString();
            _item_text = dt.Rows[0]["Item_Text"].ToString();
            _list_id = dt.Rows[0]["List_ID"].ToString();
            if  (dt.Rows[0]["Optional"] != DBNull.Value)
                _item_option = Convert.ToBoolean(dt.Rows[0]["Optional"]);
            if (dt.Rows[0]["Item_Type"] != DBNull.Value)
                _item_type = Convert.ToInt16(dt.Rows[0]["Item_Type"]);
            if (dt.Rows[0]["Filled"] != DBNull.Value)
                _item_filled = Convert.ToBoolean(dt.Rows[0]["Filled"]);
            if (dt.Rows[0]["Table_ID"] != DBNull.Value)
                _item_table = Convert.ToInt32(dt.Rows[0]["Table_ID"]);
        }

        public void Update()
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "Update [List_Items] Set [Item_Text]=N'" + this.Item_Text + "' ,[List_ID] =" + this.List_ID +
                " where [Item_ID]="+Item_ID ;
            connector.Execute(Sql_query);
        }
        public void UpdateItems()
        {
            SQL_Connector connector = new SQL_Connector();
            string sTableId = "null";
            if (this.Item_Filled) sTableId = this.Item_Table.ToString();
            String Sql_query = "Update [List_Items] Set [Item_Text]=N'" + this.Item_Text + "' ,[Optional] ='" + this.Item_Option +
                "' ,[Item_Type] =" + this.Item_Type + " ,[Filled] ='" + this.Item_Filled + "' ,[Table_ID] =" + sTableId + " where [Item_ID]=" + Item_ID;
            connector.Execute(Sql_query);
        }
        public void Delete()
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "Delete From [List_Items] where [Item_ID]="+Item_ID ;
            connector.Execute(Sql_query);
        }
        public void Delete(string ItemID)
        {
            SQL_Connector connector = new SQL_Connector();
            String Sql_query = "Delete From [List_Items] where [Item_ID]=" + ItemID;
            connector.Execute(Sql_query);
        }
        public void Add()
        {
            SQL_Connector connector = new SQL_Connector();
            string stableid = "null";
            if (Item_Filled) stableid = Item_Table.ToString();
            String sql_query = "INSERT INTO [List_Items] ([Item_Text],[List_ID],[Optional],[Item_Type],[Filled],[Table_Id]) VALUES(N'" +
                Item_Text + "' , " + List_ID;
            if (Item_Type == 0)
                sql_query += ",null,null,null,null)";
            else
                sql_query += ",'" + Item_Option + "'," + Item_Type + ",'" + Item_Filled + "'," + stableid + ")";
            connector.Execute(sql_query);
        }

        public static DataTable get_Dt_Items(String listid)
        {
            SQL_Connector connector = new SQL_Connector();
            String sql_query = "SELECT [Item_ID],[Item_Text],[List_ID],(ROW_NUMBER() OVER (ORDER BY [Item_ID])) as [ItemNum] " +
                " FROM [List_Items] where [List_ID]=" + listid;
            return connector.Select(sql_query);
        }
        public DataTable get_Dt_All_Items(String questionid)
        {
            SQL_Connector connector = new SQL_Connector();
            String sql_query = "SELECT [Item_ID],[Item_Text],[Optional],[Type],[Filled],[Table_Name]" +
                              ",[Description],[List_ID],[Question_ID],[Table_ID],[TypeId],[Form_ID],BOptional,BFilled " +
                              " FROM [FG_DB].[dbo].[V_Items] WHERE [Question_ID] = " + questionid;
            return connector.Select(sql_query);
        }
        
    }
}