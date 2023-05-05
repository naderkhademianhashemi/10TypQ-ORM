﻿<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup

    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        Logger.Error(Server.GetLastError().Message);
    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started
    }
    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
    }
    public string NormalizePersianCharacters(string text)
    {
        if (text == null)
            return null;

        text = text.Replace("\u0660", "\u06F0"); // ۰
        text = text.Replace("\u0661", "\u06F1"); // ۱
        text = text.Replace("\u0662", "\u06F2"); // ۲
        text = text.Replace("\u0663", "\u06F3"); // ۳
        text = text.Replace("\u0664", "\u06F4"); // ۴
        text = text.Replace("\u0665", "\u06F5"); // ۵
        text = text.Replace("\u0666", "\u06F6"); // ۶
        text = text.Replace("\u0667", "\u06F7"); // ۷
        text = text.Replace("\u0668", "\u06F8"); // ۸
        text = text.Replace("\u0669", "\u06F9"); // ۹
        text = text.Replace("\u0643", "\u06A9"); // ک
        text = text.Replace("\u0649", "\u06CC"); // ی
        text = text.Replace("\u064A", "\u06CC"); // ی
        text = text.Replace("\u06C0", "\u0647\u0654"); // هٔ

        return text;
    }
</script>
