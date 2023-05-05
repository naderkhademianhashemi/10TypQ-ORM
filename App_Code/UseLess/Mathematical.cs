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
//using System.Data.SqlClient;

///// <summary>
///// Summary description for Mathematical
///// </summary>
///// 
//namespace ORM
//{
//    public class Mathematical
//    {
//        public Mathematical()
//        {
//            //
//            // TODO: Add constructor logic here
//            //
//        }

//        public static bool isvalidinfix(String str)
//        {
//            Stack stack = new Stack();
//            Stack revstack = new Stack();
//            revstack.Clear();
//            stack.Clear();
//            String ramy = str;
//            bool cansigndigit = true;
//            for (int i = 0; i < ramy.Length; i++)
//            {
//                char c = ramy[i];
//                if (char.IsDigit(c))
//                {
//                    int k = i;
//                    while ((char.IsDigit(ramy[i])) && ++i < ramy.Length) ;
//                    if (ramy[i] == '.' && ramy.Length > i)
//                    {
//                        i++;
//                        while ((char.IsDigit(ramy[i])) && ++i < ramy.Length) ;
//                    }

//                    stack.Push(ramy.Substring(k, i - k + 1));

//                }
//                else if (cansigndigit && (c == '-' || c == '+')
//                    && i < ramy.Length - 1 && char.IsDigit(ramy[i + 1]))
//                {
//                    int k = i;
//                    i++;
//                    while ((char.IsDigit(ramy[i])) && ++i < ramy.Length) ;
//                    if (ramy[i] == '.' && ramy.Length > i)
//                    {
//                        i++;
//                        while ((char.IsDigit(ramy[i])) && ++i < ramy.Length) ;
//                    }
//                    stack.Push(ramy.Substring(k, i - k + 1));
//                    cansigndigit = false;

//                }
//                else
//                {
//                    switch (c)
//                    {

//                        case '(':
//                            cansigndigit = true;
//                            revstack.Push(c);
//                            break;
//                        case ')':
//                            cansigndigit = false;
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/" ||
//                            revstack.Peek().ToString() == "+" || revstack.Peek().ToString() == "-"))
//                            {
//                                if (!compute1(revstack.Pop(), stack))
//                                {
//                                    return false;
//                                }
//                            }
//                            if (revstack.Count == 0)
//                                return false;
//                            else if (revstack.Peek().ToString() == "(")
//                                revstack.Pop();
//                            break;
//                        case '+':
//                            cansigndigit = true;
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/" ||
//                            revstack.Peek().ToString() == "+" || revstack.Peek().ToString() == "-"))
//                            {
//                                if (!compute1(revstack.Pop(), stack))
//                                {
//                                    return false;
//                                }
//                            }

//                            revstack.Push(c);

//                            break;
//                        case '-':
//                            cansigndigit = true;
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/" ||
//                            revstack.Peek().ToString() == "+" || revstack.Peek().ToString() == "-"))
//                            {
//                                if (!compute1(revstack.Pop(), stack))
//                                {
//                                    return false;
//                                }
//                            }

//                            revstack.Push(c);
//                            break;
//                        case '*':
//                            cansigndigit = true;
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/"))
//                            {
//                                if (!compute1(revstack.Pop(), stack))
//                                {
//                                    return false;
//                                }
//                            }

//                            revstack.Push(c);
//                            break;
//                        case '/':
//                            cansigndigit = true;
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/"))
//                            {
//                                if (!compute1(revstack.Pop(), stack))
//                                {
//                                    return false;
//                                }
//                            }

//                            revstack.Push(c);
//                            break;
//                    }
//                    i++;

//                }
//            }

//            while (revstack.Count > 0)

//                if (!compute1(revstack.Pop(), stack))
//                {
//                    return false;
//                }
//            if (stack.Count > 1)
//                return false;
//            return true;
//        }
//        //yek tabe private baray mohasebeye isvalidinfix estefade mishavad.
//        private static bool compute1(object obj, Stack stack)
//        {
//            char c = (char.Parse(obj.ToString()));

//            double x = 0;
//            if (stack.Count > 1)
//            {
//                String op1 = stack.Pop().ToString();
//                stack.Pop().ToString();
//                stack.Push("1P");
//                if (op1.Contains("V") && c == '/')
//                {
//                    x = 1;
//                    if (double.TryParse(op1.Substring(0, op1.Length - 1), out x) && x != 0)
//                    {
//                        return true;
//                    }
//                    else
//                        return false;
//                }

//                return true;
//            }
//            else
//            {
//                return false;
//            }
//        }

//        //meghdar ebarate mohasebati yek shakhes ra dar yek mahdoode zamani moshakhas
//        // baray yek makan khas (hasas be makan) be dast miavarad
//        public static Result_Objects makePresfix(String str, String firstdate, String lastdate)
//        {
//            if (firstdate == "") firstdate = System.Data.SqlTypes.SqlDateTime.MinValue.ToString();
//            if (lastdate == "") lastdate = System.Data.SqlTypes.SqlDateTime.MaxValue.ToString();

//            Result_Objects comp;
//            Stack stack = new Stack();
//            Stack revstack = new Stack();
//            String fdate = firstdate;
//            String ldate = lastdate;
//            revstack.Clear();
//            stack.Clear();
//            String ramy = str;
//            for (int i = 0; i < ramy.Length; i++)
//            {
//                char c = ramy[i];
//                if (char.IsDigit(c))
//                {
//                    int k = i;
//                    while ((char.IsDigit(ramy[i])) && ++i < ramy.Length) ;
//                    if (ramy[i] == '.' && ramy.Length > i)
//                    {
//                        i++;
//                        while ((char.IsDigit(ramy[i])) && ++i < ramy.Length) ;
//                    }
//                    Result_Objects obj = new Result_Objects(ramy.Substring(k, i - k + 1),fdate , ldate);
//                    stack.Push(obj);
//                }
//                else
//                {
//                    switch (c)
//                    {
//                        case '(':
//                            revstack.Push(c);
//                            break;
//                        case ')':
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/" ||
//                            revstack.Peek().ToString() == "+" || revstack.Peek().ToString() == "-"))
//                            {
//                                comp = compute(revstack.Pop(), stack, fdate, ldate);
//                                if (comp.Result != "true")
//                                {
//                                    return comp;
//                                }
//                            }
//                            if (revstack.Count == 0)
//                            {
//                                Result_Objects r = new Result_Objects();
//                                r.Result = "پرانترها با هم متچ نشده اند.";
//                                return r;
//                            }
                                
//                            else if (revstack.Peek().ToString() == "(")
//                                revstack.Pop();
//                            break;
//                        case '+':

//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/" ||
//                            revstack.Peek().ToString() == "+" || revstack.Peek().ToString() == "-"))
//                            {
//                                comp = compute(revstack.Pop(), stack, fdate, ldate);
//                                if (comp.Result != "true")
//                                {
//                                    return comp;
//                                }
//                            }

//                            revstack.Push(c);

//                            break;
//                        case '-':
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/" ||
//                            revstack.Peek().ToString() == "+" || revstack.Peek().ToString() == "-"))
//                            {
//                                comp = compute(revstack.Pop(), stack, fdate, ldate);
//                                if (comp.Result != "true")
//                                {
//                                    return comp;
//                                }
//                            }

//                            revstack.Push(c);
//                            break;
//                        case '*':
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/"))
//                            {
//                                comp = compute(revstack.Pop(), stack, fdate, ldate);
//                                if (comp.Result != "true")
//                                {
//                                    return comp;
//                                }
//                            }

//                            revstack.Push(c);
//                            break;
//                        case '/':
//                            while (revstack.Count > 0 && (revstack.Peek().ToString() == "*" || revstack.Peek().ToString() == "/"))
//                            {
//                                comp = compute(revstack.Pop(), stack, fdate, ldate);
//                                if (comp.Result != "true")
//                                {
//                                    return comp;
//                                }
//                            }

//                            revstack.Push(c);
//                            break;
//                    }

//                }
//            }

//            while (revstack.Count > 0)
//            {
//                comp = compute(revstack.Pop(), stack, fdate, ldate);
//                if (comp.Result  != "true")
//                {

//                    Result_Objects r = new Result_Objects();
//                    r.Result = "عبارت محاسباتی غلط می باشد.";
//                    return r;
//                }
//            }
//            if (stack.Count > 1)
//            {

//                Result_Objects r = new Result_Objects();
//                r.Result = "عبارت محاسباتی غلط می باشد.";
//                return r;
//            }
//            if (((Result_Objects)stack.Peek()).Is_Parameter)
//            {
//                Result_Objects param = (Result_Objects)stack.Pop();
//                return param;
//            }
//            else
//            {
//                Result_Objects result = (Result_Objects)stack.Pop();
//                return result;
//            }

//        }


//        //meghdar yek parameter ra dar yek bazeye zamani mohsakhas baraye yek
//        // makan ( hasasiat be makan ) bar migardanad.
//        private static Result_Objects GetParameterValueof(String pid, String fdate, String ldate)
//        {
//            try
//            {
//                Result_Objects answer = new Result_Objects(pid+"P",fdate , ldate);
//                return answer;
               
//            }
//            catch (Exception err)
//            {
//                Result_Objects answer = new Result_Objects();
//                answer.Result = "چنین شاخصی وجود ندارد.";
//                return answer;
//            }
//        }


//        // baraye mohasebeye tabeh makePrefix estefade mishavad.
//        private static Result_Objects compute(object obj, Stack stack, String fdate, String ldate )
//        {
//            char c = (char.Parse(obj.ToString()));
//            Result_Objects op1, op2;
//            Result_Objects output = new Result_Objects();
          

//            double x = 0;
//            if (stack.Count > 1)
//            {
//                if (!((Result_Objects)stack.Peek()).Is_Parameter )
//                {
//                    op1 = (Result_Objects)stack.Pop();
//                }
//                else
//                {
//                    op1 = (Result_Objects)stack.Pop();
//                    if (op1.Result!= "")
//                    {
//                        return op1;
//                    }
//                }
//                if (!((Result_Objects)stack.Peek()).Is_Parameter)
//                {
//                    op2 = (Result_Objects)stack.Pop();
//                }
//                else
//                {
//                    op2 = (Result_Objects)stack.Pop();
//                    if (op2.Result!= "")
//                    {
//                        return op2;
//                    }
//                }
//            }
//            else
//            {
//                output.Result = "عبارت محاسباتی اشتباه است.";
//                return output;
//            }           
//            try
//            {
//                output = Calculator(c, op1, op2);
//                output.Result = "true";
//                stack.Push(output);
                
//                //switch (c)
//                //{
//                //    case '+':
//                //        x = double.Parse(op2) + double.Parse(op1);
//                //        break;
//                //    case '-':
//                //        x = double.Parse(op2) - double.Parse(op1);
//                //        break;
//                //    case '*':
//                //        x = double.Parse(op2) * double.Parse(op1);
//                //        break;
//                //    case '/':
//                //        if (double.Parse(op1) != 0)
//                //            x = double.Parse(op2) / double.Parse(op1);
//                //        else
//                //        {
//                //            stack.Push(x.ToString() + "V");
//                //            return "خطای تقسیم بر صفر.";
//                //        }
//                //        break;
//                //}
//            }
//            catch (Exception err)
//            {
//                output.Result = "خطا در انجام محاسبات بوجود آمد.";
//                return output;
//            }
//            return output;
//        }

//        public static Result_Objects Calculator(Char opr , Result_Objects op1 , Result_Objects op2 )
//        {
//            Double tempop1 = 0.0;
//            Double tempop2 = 0.0;
//            double localresult =0.0;
//            String[] result = new String[40];
//            for (int i = 0; i < 40; i++)
//                result[i] = Double.NaN.ToString() ;

//            switch (opr)
//            {
//                case '+':
                    
//                    for (int i = 0; i < 40; i++)
//                    {
//                        if (double.Parse(op2.Values[i].ToString()).Equals(double.NaN)) 
//                            tempop2 = 0.0;
//                        else
//                            tempop2 = double.Parse(op2.Values[i].ToString());
//                        if (double.Parse(op1.Values[i].ToString()).Equals(double.NaN)) 
//                            tempop1 = 0.0;
//                        else
//                            tempop1 = double.Parse(op1.Values[i].ToString());

//                        localresult = tempop2 +tempop1;
//                        if (double.Parse(op2.Values[i].ToString()).Equals(double.NaN) && double.Parse(op1.Values[i].ToString()).Equals(double.NaN))
//                            localresult = Double.NaN ;
//                        result[i] = localresult.ToString();
//                    }
//                    break;
//                case '-':
//                    for (int i = 0; i < 40; i++)
//                    {
//                        if (double.Parse(op2.Values[i].ToString()).Equals(double.NaN))
//                            tempop2 = 0.0;
//                        else
//                            tempop2 = double.Parse(op2.Values[i].ToString());
//                        if (double.Parse(op1.Values[i].ToString()).Equals(double.NaN))
//                            tempop1 = 0.0;
//                        else
//                            tempop1 = double.Parse(op1.Values[i].ToString());

//                        localresult = tempop2 - tempop1;
//                        if (double.Parse(op2.Values[i].ToString()).Equals(double.NaN) && double.Parse(op1.Values[i].ToString()).Equals(double.NaN))
//                            localresult = Double.NaN;
////                        localresult = double.Parse(op2.Values[i].ToString()) - double.Parse(op1.Values[i].ToString());
//                        result[i] = localresult.ToString();
//                    }
//                    break;
//                case '*':
//                    for (int i = 0; i < 40; i++)
//                    {
//                        if (double.Parse(op2.Values[i].ToString()).Equals(double.NaN))
//                            tempop2 = 0.0;
//                        else
//                            tempop2 = double.Parse(op2.Values[i].ToString());
//                        if (double.Parse(op1.Values[i].ToString()).Equals(double.NaN))
//                            tempop1 = 0.0;
//                        else
//                            tempop1 = double.Parse(op1.Values[i].ToString());

//                        localresult = tempop2 * tempop1;
//                        if (double.Parse(op2.Values[i].ToString()).Equals(double.NaN) && double.Parse(op1.Values[i].ToString()).Equals(double.NaN))
//                            localresult = Double.NaN;
//                        //localresult = double.Parse(op2.Values[i].ToString()) * double.Parse(op1.Values[i].ToString());
//                        result[i] = localresult.ToString();
//                    }
//                    break;
//                case '/':
//                    for (int i = 0; i < 40; i++)
//                    {
//                        if (double.Parse(op1.Values[i].ToString()) != 0)
//                        {
//                            if (double.Parse(op2.Values[i].ToString()).Equals(double.NaN))
//                                tempop2 = 0.0;
//                            else
//                                tempop2 = double.Parse(op2.Values[i].ToString());
//                            if (double.Parse(op1.Values[i].ToString()).Equals(double.NaN))
//                                tempop1 = 0.0;
//                            else
//                                tempop1 = double.Parse(op1.Values[i].ToString());
//                            if(tempop1 != 0.0)
//                                localresult = tempop2 / tempop1;
//                            if (double.Parse(op2.Values[i].ToString()).Equals(double.NaN) && double.Parse(op1.Values[i].ToString()).Equals(double.NaN))
//                                localresult = Double.NaN;
//                            //localresult = double.Parse(op2.Values[i].ToString()) / double.Parse(op1.Values[i].ToString());
//                            result[i] = localresult.ToString();
//                        }
//                        else
//                        {
//                            result[0] = localresult.ToString();
//                            Result_Objects result1 = new Result_Objects(result,true);
//                            result1.Result = "خطای تقسیم بر صفر.";
//                            return result1;
//                        }
//                    }
//                    break;
//            }

//            Result_Objects output = new Result_Objects();
//            output.Is_Parameter = false;
//            output.Values = result;
//            return output;
            
//        }
//        public static String MIN(String[] input)
//        {
//            double Min = double.Parse(input[0].ToString());
//            if (Min.Equals(double.NaN)) Min = double.MaxValue;
//            for (int i = 1; i < 40; i++)
//            {
//                double temp = double.Parse(input[i].ToString());
//                if (!temp.Equals(double.NaN))
//                {
//                    if (temp < Min)
//                        Min = temp;
//                }
//            }
//            return Min.ToString();
//        }

//        public static String MAX(String[] input)
//        {
//            double MAX = double.Parse(input[0].ToString());
//            if (MAX.Equals(double.NaN)) MAX = double.MaxValue ;
//            for (int i = 1; i < 40; i++)
//            {
//                double temp = double.Parse(input[i].ToString());
//                if (!temp.Equals(double.NaN))
//                {
//                    if (temp > MAX)
//                        MAX = temp;
//                }
//            }
//            return MAX.ToString();
//        }

//        public static String SUM(String[] input)
//        {
//            double Sum = double.Parse(input[0].ToString());
//            if (Sum.Equals(double.NaN)) Sum = 0;
//            for (int i = 1; i < 40; i++)
//            {
//                double temp = double.Parse(input[i].ToString());
//                if (!temp.Equals(double.NaN))
//                    Sum += temp;
//            }
//            return Sum.ToString();
//        }

//        public static String AVG(String[] input)
//        {
//            double AVG = double.Parse(input[0].ToString());
//            if (AVG.Equals(double.NaN)) AVG = 0;
//            int counter = 0;
//            for (int i = 1; i < 40; i++)
//            {
//                double temp = double.Parse(input[i].ToString());
//                if (!temp.Equals(double.NaN))
//                {
//                    counter++;
//                    AVG += temp;
//                }
                
//            }
//            if (counter > 0)
//                return (AVG /counter).ToString();
//            else
//                return "0";
//        }
//    }


//}