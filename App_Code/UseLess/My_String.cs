//using System;
//using System.Data;
//using System.Configuration;
//using System.IO;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Xml.Serialization;


///// <summary>
///// Summary description for My_String
///// </summary>
///// 
//[Serializable]
//[XmlRoot("String_Array")]
//public class My_String
//{
//    [XmlArray("value")]
//    public String[] Input;
//    public My_String(String[] Str )
//    {
//        //
//        // TODO: Add constructor logic here
//        //
//        Input = Str;
//    }

//    public My_String()
//    {

//    }

//    public ListItem [] Get_Item_Array()
//    {
//        ListItem [] list = new ListItem [Input.GetLength(0)] ;
//        for (int i= 0 ; i< Input.GetLength(0); i++)
//        {
//            list[i] = new ListItem(Input[i]);
//        }

//        return list;
//    }
//}
