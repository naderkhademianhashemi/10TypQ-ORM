﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" Title="پرسشنامه" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ورود </title>
    <link type="text/css" href="Assets/Css/Style.css" rel="stylesheet" />
    <style type="text/css">
        #form1 {
            text-align: center;
            height: 490px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server" dir="rtl">
        <div style="text-align: center">
            <table style="width: 100%;" align="center">

                <tr>
                    <td>

                        <img alt="" src="/images/jadid/header.png" style="width: 1000px; height: 140px" /></td>
                </tr>
                <tr>
                    <td style="background-color: #FFFFFF; text-align: center;">
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <table align="center" style="width: 100%;">
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>
                                                <table align="center">
                                                    <tr style="text-align: center">
                                                        <td>
                                                            <asp:Login ID="Login1" runat="server" BackColor="#F7F7DE"
                                                                BorderColor="#CCCC99" BorderStyle="Solid" BorderWidth="1px"
                                                                Font-Names="tahoma" Font-Size="10pt"
                                                                LoginButtonText="ورود" PasswordLabelText="کلمه عبور"
                                                                RememberMeText="نگهداری اطلاعات ورودی" TitleText="ورود"
                                                                UserNameLabelText="نام کاربری"
                                                                FailureText="دسترسی شما امکان پذیر نیست. دوباره امتحان کنید."
                                                                PasswordRequiredErrorMessage="کلمه عبور الزامی است."
                                                                UserNameRequiredErrorMessage="نام کاربری الزامی است." Height="137px" Width="229px"
                                                                FailureAction="RedirectToLoginPage"
                                                                OnAuthenticate="Login1_Authenticate"
                                                                OnLoggedIn="Login1_LoggedIn"
                                                                >

                                                                <LayoutTemplate>
                                                                    <table border="0" cellpadding="4" cellspacing="0"
                                                                        style="border-collapse: collapse;">
                                                                        <tr>
                                                                            <td>
                                                                                <table border="0" cellpadding="0" style="height: 137px; width: 229px;">
                                                                                    <tr>
                                                                                        <td align="center" colspan="2"
                                                                                            style="color: White; background-color: #DBC694; font-size: 0.9em; font-weight: bold;">ورود</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="right">
                                                                                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">نام 
                                        کاربری</asp:Label>
                                                                                        </td>
                                                                                        <td style="text-align: right">
                                                                                            <asp:TextBox ID="UserName" runat="server" Font-Size="0.8em" Width="126px"></asp:TextBox>
                                                                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server"
                                                                                                ControlToValidate="UserName" ErrorMessage="نام کاربری الزامی است."
                                                                                                ToolTip="نام کاربری الزامی است." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="right">
                                                                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">کلمه 
                                        عبور</asp:Label>
                                                                                        </td>
                                                                                        <td style="text-align: right">
                                                                                            <asp:TextBox ID="Password" runat="server" Font-Size="0.8em" TextMode="Password"
                                                                                                Width="126px"></asp:TextBox>
                                                                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server"
                                                                                                ControlToValidate="Password" ErrorMessage="کلمه عبور الزامی است."
                                                                                                ToolTip="کلمه عبور الزامی است." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td colspan="2">
                                                                                            <asp:CheckBox ID="RememberMe" runat="server" Text="نگهداری اطلاعات ورودی" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="2" style="color: Red;">
                                                                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="right" colspan="2">
                                                                                            <asp:Button ID="LoginButton" runat="server" BackColor="#FFFBFF"
                                                                                                BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CommandName="Login"
                                                                                                Font-Names="tahoma" Font-Size="0.8em" ForeColor="#284775" Text="ورود"
                                                                                                ValidationGroup="Login1" OnClick="LoginButton_Click" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </LayoutTemplate>
                                                                <TitleTextStyle BackColor="#6B696B" Font-Bold="True" ForeColor="#FFFFFF" />
                                                            </asp:Login>



                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>
                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/login_bottom_banner.png" />
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>



                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>


    </form>

</body>
</html>

