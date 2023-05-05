using System;
using System.Text;
using System.Data;
using System.Collections;
using System.Configuration;
using System.Web;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Diagnostics;

/// <summary> 
/// A JavaScript alert 
/// </summary> 
public static class Alert
{
    /// <summary> 
    /// Shows a client-side JavaScript alert in the browser. 
    /// </summary> 
    /// <param name="message">The message to appear in the alert.</param> 
    public static void Show(string message)
    {
        string cleanMessage = message.Replace("'", "\\'");
        string script = "<script type=\"text/javascript\">alert('" + cleanMessage + "');</script>";

        Page page = HttpContext.Current.CurrentHandler as Page;

        if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
        {
            page.ClientScript.RegisterClientScriptBlock(typeof(Alert), "alert", script);
        }
    }
    static StackTrace _stackTrace = new StackTrace();
    public static void Show()
    {
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(
            HttpContext.Current.CurrentHandler as Page,
            typeof(Alert), "Alert",
            "alert('" + _stackTrace.GetFrame(1).GetMethod().Name + "');",
            true);
    }


}



