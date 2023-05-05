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

///// <summary>
///// Summary description for Stack_Objects
///// </summary>
//public class Result_Objects
//{
//    private String[]  _values;
//    private Boolean _is_parameter;
//    private String _result = "";
//    private String _id = "";
//    public Result_Objects(String str, String fdate , String tdate )
//    {
//        _values = new String[40];
//        if (str.Contains("P"))
//        {
//            String pid = str.Substring(0, str.Length - 1);
//            ORM.Parameter newparameter = new ORM.Parameter(pid);
//            _values = newparameter.get_values(fdate , tdate);
//            _is_parameter = true;
//        }
//        else
//        {
//            String val = str.Substring(0, str.Length - 1);
//            _is_parameter = false;

//            for (int i = 0; i < 40;i++ )
//                _values[i] = val;
//        }
//    }

//    public Result_Objects(String[] list, Boolean is_value)
//    {
//        _is_parameter = !is_value;
//        _values = list;

//    }

//    public Result_Objects()
//    {
//    }

//    public String [] Values
//    {
//        set { _values = value; }
//        get { return _values; }
//    }

//    public Boolean Is_Parameter
//    {
//        set { _is_parameter = value; }
//        get { return _is_parameter; }
//    }

//    public String Result
//    {
//        set { _result = value; }
//        get { return _result; }
//    }

//    public String ID
//    {
//        set { _id = value; }
//        get { return _id; }
//    }

//}
