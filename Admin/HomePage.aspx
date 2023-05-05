<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HomePage.aspx.cs" 
    Inherits="HomePage" Title="" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">

        function roll_over(img_name, img_src) {
            document[img_name].src = img_src;
        }

    </script>



    <table style="width: 96%;">
        <tr>
            <td style="height: 1px">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table style="width: 708px;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="background-position: right top; background-image: url('../images/form-top.png'); height: 37px; background-repeat: no-repeat;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; فرمهای پرسشنامه</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel_Forms" runat="server" Width="691px">
                                        <table cellpadding="0" cellspacing="0"
                                            style="border-left: 1px solid #C0C0C0; border-right: 1px solid #C0C0C0; border-top: 0px solid #C0C0C0; border-bottom: 1px solid #C0C0C0; width: 706px; background-image: url('images/theme/tile_down.gif'); background-repeat: repeat-x; margin-top: 2px;">
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="Panel1" runat="server" ToolTip="ایجاد پرسشنامه جدید">
                                                        <a href="FormDefine.aspx"
                                                            onmouseout="roll_over('but1', 'images/Disable/Documents_Add.png')"
                                                            onmouseover="roll_over('but1', 'images/Regular/Documents_Add.png')">
                                                            <img alt="" name="but1" src="../images/Disable/Documents_Add.png" />
                                                        </a>
                                                    </asp:Panel>
                                                </td>
                                                <td style="color: #000000">ایجاد فرم پرسشنامه
                                                </td>
                                                <td>
                                                    <asp:Panel ID="Panel2" runat="server" ToolTip="مشاهده فرمهای پرسشنامه">
                                                        <a href="FormView.aspx"
                                                            onmouseout="roll_over('but2', 'images/Disable/Documents_Search.png')"
                                                            onmouseover="roll_over('but2', 'images/Regular/Documents_Search.png')">
                                                            <img alt="" name="but2" src="../images/Disable/Documents_Search.png" />
                                                        </a>
                                                    </asp:Panel>
                                                </td>
                                                <td style="color: #000000">مشاهده فرمهای پرسشنامه
                                                </td>
                                                <td>
                                                    <asp:Panel ID="Panel3" runat="server"
                                                        ToolTip="مشاهده  پاسخهای داده شده به پرسشنامه">
                                                        <a href="ShowForm.aspx"
                                                            onmouseout="roll_over('but3', 'images/Disable/Documents_Idea.png')"
                                                            onmouseover="roll_over('but3', 'images/Regular/Documents_Idea.png')">
                                                            <img alt="" name="but3" src="../images/Disable/Documents_Idea.png" />
                                                        </a>
                                                    </asp:Panel>
                                                </td>
                                                <td style="color: #000000">مشاهده پاسخهای<br />
                                                    داده شده به پرسشنامه
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>









                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
    </table>

</asp:Content>

