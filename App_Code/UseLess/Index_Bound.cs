//using System;
//using System.Data;
//using System.Configuration;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;

///// <summary>
///// Summary description for Index_Bound
///// </summary>
///// 
//namespace ORM
//{
//    public class Index_Bound
//    {
//        private String _bound_id;
//        private String _index_id;
//        private ORM_Types.Bound_Type _bound;
//        private Boolean _negative_infinity;
//        private Boolean _lower_bound_isclose;
//        private String _lower_bound;
//        private Boolean _upper_bound_isclose;
//        private Boolean _positive_infinity;
//        private String _upper_bound;

//        public Index_Bound()
//        {
//            //
//            // TODO: Add constructor logic here
//            //
//        }

//        public Index_Bound(String index_id, String bound_id, ORM_Types.Bound_Type bound, Boolean lower_bound_isclose, Boolean negative_infinity, String lower_bound,
//        Boolean upper_bound_isclose, Boolean positive_infinity, String upper_bound)
//        {
//            this._index_id = index_id;
//            this._bound_id = bound_id;
//            this._bound = bound;
//            this._lower_bound_isclose = lower_bound_isclose;
//            this._negative_infinity = negative_infinity;
//            this._lower_bound = lower_bound;
//            this._upper_bound_isclose = upper_bound_isclose;
//            this._positive_infinity = positive_infinity;
//            this._upper_bound = upper_bound;
//        }

//        public Index_Bound(ORM_Types.Bound_Type bound, Boolean lower_bound_isclose, Boolean negative_infinity, String lower_bound,
//        Boolean upper_bound_isclose, Boolean positive_infinity, String upper_bound)
//        {
//            this._index_id = "";
//            this._bound = bound;
//            this._lower_bound_isclose = lower_bound_isclose;
//            this._negative_infinity = negative_infinity;
//            this._lower_bound = lower_bound;
//            this._upper_bound_isclose = upper_bound_isclose;
//            this._positive_infinity = positive_infinity;
//            this._upper_bound = upper_bound;
//        }

//        public Boolean is_in_bound(double value)
//        {
//            double low_bound=0.0;
//            double up_bound=0.0;
//            ORM.Index_Bound temp_bound = this;
//            if (temp_bound.Negative_Infinity)
//                low_bound = double.MinValue;
//            if (temp_bound.Positive_Infinity)
//                up_bound = double.MaxValue;
//            if (!temp_bound.Negative_Infinity && !temp_bound.Positive_Infinity)
//            {
//                low_bound = double.Parse(temp_bound.Lower_Bound);
//                up_bound = double.Parse(temp_bound.Upper_Bound);
//            }
//            if (temp_bound.Lower_Bound_Isclose)
//            {
//                if (temp_bound.Upper_Bound_Isclose)
//                {
//                    if (value >= low_bound && value <= up_bound)
//                        return true;
//                }
//                else
//                    if (value >= low_bound && value < up_bound)
//                        return true;
//            }
//            else
//            {
//                if (temp_bound.Upper_Bound_Isclose)
//                {
//                    if (value > low_bound && value <= up_bound)
//                        return true;
//                }
//                else
//                    if (value > low_bound && value < up_bound)
//                        return true;
//            }
//            return false;
//        }

//        public Boolean have_intersection_with(Index_Bound new_bound)
//        {
//            Double new_low = 0.0; 
//            Double.TryParse(new_bound.Lower_Bound, out new_low);
//            Double new_high = 0.0;
//            Double.TryParse(new_bound.Upper_Bound,out new_high);
//            Double low = 0.0;
//            Double.TryParse(this.Lower_Bound,out low);
//            Double high = 0.0;
//            Double.TryParse(this.Upper_Bound,out high);

//            if ((this.Negative_Infinity && this.Positive_Infinity) || (new_bound.Negative_Infinity && new_bound.Positive_Infinity) ||
//                (new_bound.Negative_Infinity && this.Negative_Infinity) || (new_bound.Positive_Infinity && this.Positive_Infinity))
//                return true;
//            if (this.Positive_Infinity)
//            {

//                if ((new_high > low) || (new_bound.Upper_Bound_Isclose && new_bound.Lower_Bound_Isclose && low == new_low))
//                    return true;
//                else
//                    return false;
//            }
//            if (this.Negative_Infinity)
//            {

//                if ((new_low < high) || (new_bound.Lower_Bound_Isclose && new_bound.Upper_Bound_Isclose && high == new_high))
//                    return true;
//                else
//                    return false;
//            }
//            if (new_bound.Positive_Infinity)
//            {

//                if ((high > new_low) || (this.Upper_Bound_Isclose && new_bound.Lower_Bound_Isclose && new_low == high))
//                    return true;
//                else
//                    return false;
//            }
//            if (new_bound.Negative_Infinity)
//            {
//                if ((low < new_high) || (this.Lower_Bound_Isclose && new_bound.Upper_Bound_Isclose && low == new_high))
//                    return true;
//                else
//                    return false;
//            }
//            if ((this.Upper_Bound_Isclose && new_bound.Lower_Bound_Isclose && new_low == high) ||
//                (this.Upper_Bound_Isclose && new_bound.Upper_Bound_Isclose && new_high == high) ||
//                (this.Lower_Bound_Isclose && new_bound.Lower_Bound_Isclose && new_low == low) ||
//                (this.Lower_Bound_Isclose && new_bound.Upper_Bound_Isclose && new_high == low) ||
//                (new_low > low && new_low < high) || (new_high < high && new_high > low)
//                || (low > new_low && low < new_high) || (high < new_high && high > new_low))
//                return true;
//            return false;
//        }

//        public String ToString()
//        {
//            String output = "";

//            switch (Bound)
//            {
//                case ORM_Types.Bound_Type.Goal:
//                    output += "هدف -  ";
//                    break;
//                case ORM_Types.Bound_Type.Alarm:
//                    output += "هشدار - ";
//                    break;
//                case ORM_Types.Bound_Type.Danger:
//                    output += "خطر - ";
//                    break;
//            }
//            if (_negative_infinity)
//                output += "(منهاي بينهايت";
//            else
//            {
//                if (_lower_bound_isclose)
//                    output += "[";
//                else
//                    output += "(";
//                output += _lower_bound;

//            }

//            output += ",";

//            if (_positive_infinity)
//                output += "مثبت بينهايت)";
//            else
//            {
//                output += _upper_bound;
//                if (_upper_bound_isclose)
//                    output += "]";
//                else
//                    output += ")";
//            }
            
//            return output;

//        }

//        public void Save()
//        {
//            String Sql_query = "INSERT INTO [Risk_Indicator_Bound] ([Index_ID],[Bound_Type],[negative_infinity],[Lower_Bound_isclose]"+
//                ",[Lower_Bound],[Upper_Bound_isclose],[positive_infinity],[Upper_Bound]) "+
//                "VALUES ("+this.Index_ID +","+ORM_Types.Get_Bound_Type(this.Bound)+","+Convert.ToByte(this.Negative_Infinity) + ","+
//                +Convert.ToByte(this.Lower_Bound_Isclose) + "," + this.Lower_Bound + "," + Convert.ToByte(this.Upper_Bound_Isclose ) + ","+
//                Convert.ToByte(this.Positive_Infinity) + "," +this.Upper_Bound +")";
//            SQL_Connector conector = new SQL_Connector();
//            conector.Execute(Sql_query);

//        }

//        public ORM_Types.Bound_Type Bound
//        {
//            get { return _bound; }
//            set { _bound = value; }
//        }

//        public Boolean Negative_Infinity
//        {
//            get { return _negative_infinity; }
//            set { _negative_infinity = value; }
//        }

//        public Boolean Lower_Bound_Isclose
//        {
//            get { return _lower_bound_isclose; }
//            set { _lower_bound_isclose = value; }
//        }

//        public String Lower_Bound
//        {
//            get { return _lower_bound; }
//            set { _lower_bound = value; }
//        }

//        public Boolean Upper_Bound_Isclose
//        {
//            get { return _upper_bound_isclose; }
//            set { _upper_bound_isclose = value; }
//        }

//        public Boolean Positive_Infinity
//        {
//            get { return _positive_infinity; }
//            set { _positive_infinity = value; }
//        }

//        public String Upper_Bound
//        {
//            get { return _upper_bound; }
//            set { _upper_bound = value; }
//        }

//        public String Index_ID
//        {
//            get { return _index_id; }
//            set { _index_id = value; }
//        }

//        public String Bound_ID
//        {
//            get { return _bound_id; }
//            set { _bound_id = value; }
//        }
//    }
//}
