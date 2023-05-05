//using System;
//using System.Data;
//using System.Configuration;
//using System.Data.SqlClient;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;


///// <summary>
///// Summary description for Credit_Bound
///// </summary>
//public class Credit_Bound : Object
//{


//    //public enum bound_type { Target, Alarm, Danger };
//    //private int bound_id = 0;
//    //private int credit_index_id =0 ;
//    //private bound_type bound;
//    //private bool negative_infinity = false;
//    //private bool lower_bound_isclose = false;
//    //private double lower_bound = 0.00;
//    //private bool upper_bound_isclose = false;
//    //private bool positive_infinity = false; 
//    //private double upper_bound = 0.00;
//    //public Credit_Bound(int bound_id, int credit_index_id, bound_type bound, bool lower_bound_isclose, bool negative_infinity,
//    //    double lower_bound, bool upper_bound_isclose, bool positive_infinity, double upper_bound)
//    //{
//    //    //
//    //    // TODO: Add constructor logic here
//    //    //

//    //    this.bound_id = bound_id;
//    //    this.credit_index_id = credit_index_id;
//    //    this.bound = bound;
//    //    this.negative_infinity = negative_infinity;
//    //    this.lower_bound_isclose = lower_bound_isclose;
//    //    this.lower_bound = lower_bound;
//    //    this.upper_bound_isclose = upper_bound_isclose;
//    //    this.positive_infinity = positive_infinity;
//    //    this.upper_bound = upper_bound;

//    //}

//    //public Credit_Bound(int credit_index_id, bound_type bound, bool lower_bound_isclose, bool negative_infinity, double lower_bound,
//    //    bool upper_bound_isclose, bool positive_infinity, double upper_bound)
//    //{
//    //    this.credit_index_id = credit_index_id;
//    //    this.bound = bound;
//    //    this.negative_infinity = negative_infinity;
//    //    this.lower_bound_isclose = lower_bound_isclose;
//    //    this.lower_bound = lower_bound;
//    //    this.upper_bound_isclose = upper_bound_isclose;
//    //    this.positive_infinity = positive_infinity; 
//    //    this.upper_bound = upper_bound;

//    //}

//    //public Credit_Bound(bound_type bound, bool lower_bound_isclose, bool negative_infinity, double lower_bound,
//    //    bool upper_bound_isclose, bool positive_infinity, double upper_bound)
//    //{
//    //    this.credit_index_id = 0;
//    //    this.bound = bound;
//    //    this.lower_bound_isclose = lower_bound_isclose;
//    //    this.negative_infinity = negative_infinity;
//    //    this.lower_bound = lower_bound;
//    //    this.upper_bound_isclose = upper_bound_isclose;
//    //    this.positive_infinity = positive_infinity ;
//    //    this.upper_bound = upper_bound;
        
        

//    //}

//    //public void Save_bound()
//    //{
//    //    SQL_Connector connector = new SQL_Connector();
//    //    String SQL_Query = "INSERT INTO [Credit_Bound]([Index_ID],[Bound_Type],[Lower_Bound_isclose],[negative_infinity]"+
//    //        ",[Lower_Bound],[Upper_bound_isclose] , [positive_infinity],[Upper_Bound])"+
//    //        "VALUES (" + credit_index_id + ",'" + bound + "'," + Convert.ToByte(lower_bound_isclose) + "," 
//    //        + Convert.ToByte(negative_infinity) +"," + lower_bound +
//    //        "," + Convert.ToByte(upper_bound_isclose) + "," + Convert.ToByte(positive_infinity) + "," + upper_bound + ")";
//    //    connector.Execute(SQL_Query);
//    //}

//    //public String ToString()
//    //{
//    //    String output = "";

//    //    switch (Bound)
//    //    {
//    //        case bound_type.Target :
//    //            output += "هدف -  ";
//    //            break;
//    //        case bound_type.Alarm :
//    //            output += "هشدار - ";
//    //            break;
//    //        case bound_type.Danger :
//    //            output += "خطر - ";
//    //            break; 
//    //    }
//    //    if (negative_infinity)
//    //        output += "(منهاي بينهايت";
//    //    else
//    //    {
//    //        if (lower_bound_isclose)
//    //            output += "[";
//    //        else
//    //            output += "(";
//    //        output += lower_bound;

//    //    }

//    //    output+=",";

//    //    if (positive_infinity)
//    //        output += "(مثبت بينهايت";
//    //    else
//    //    {
//    //        output += upper_bound;
//    //        if (lower_bound_isclose)
//    //            output += "]";
//    //        else
//    //            output += ")";
//    //    }

//    //    return output;

//    //}
   
//    //public bound_type Bound
//    //{
//    //    get { return bound ; }
//    //    set { bound = value; }
//    //}

//    //public bool Negative_Infinity
//    //{
//    //    get { return negative_infinity; }
//    //    set { negative_infinity = value; }
//    //}

//    //public bool Lower_Bound_Isclose
//    //{
//    //    get { return lower_bound_isclose; }
//    //    set { lower_bound_isclose = value; }
//    //}

//    //public double Lower_Bound
//    //{
//    //    get { return lower_bound; }
//    //    set { lower_bound = value; }
//    //}

//    //public bool Upper_Bound_Isclose
//    //{
//    //    get { return upper_bound_isclose; }
//    //    set { upper_bound_isclose = value; }
//    //}

//    //public bool Positive_Infinity
//    //{
//    //    get { return positive_infinity; }
//    //    set { positive_infinity = value; }
//    //}

//    //public double Upper_Bound
//    //{
//    //    get { return upper_bound ; }
//    //    set { upper_bound = value; }
//    //}

//    //public int Credit_ID_Index
//    //{
//    //    get { return credit_index_id ; }
//    //    set { credit_index_id = value; }
//    //}

//    //public int Bound_ID
//    //{
//    //    get { return bound_id ; }
//    //    set { bound_id = value; }
//    //}


//}
