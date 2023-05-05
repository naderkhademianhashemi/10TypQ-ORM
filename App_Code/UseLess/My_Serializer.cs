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


///// <summary>
///// Summary description for My_Serializer
///// </summary>


//public class My_Serializer
//{
//    public My_Serializer()
//    {
//        //
//        // TODO: Add constructor logic here
//        //
//    }

//    public String String_Serializer(My_String Str_Input)
//    {
//        System.Xml.Serialization.XmlSerializer Str_Serializer;
//        try
//        {
//            Str_Serializer = new System.Xml.Serialization.XmlSerializer(typeof(My_String));
//        }
//        catch (Exception ex)
//        {
            
//        }
//        System.IO.StringWriter oStmW;
//        oStmW = new System.IO.StringWriter();
//        try {
//            Str_Serializer = new System.Xml.Serialization.XmlSerializer(typeof(My_String));
//            Str_Serializer.Serialize(oStmW, Str_Input);
//        }
//        catch (Exception ex) {     }

//        return oStmW.ToString();

//    }

//    public My_String Deserialize_String(String Serialized_String)
//    {
//        System.Xml.Serialization.XmlSerializer oXS = new System.Xml.Serialization.XmlSerializer (typeof(My_String));
//        System.IO.StringReader oStmR;
//        oStmR = new System.IO.StringReader(Serialized_String);
//        My_String Output = (My_String) oXS.Deserialize(oStmR);
//        oStmR.Close();
//        return Output;
//    }

    
//}
