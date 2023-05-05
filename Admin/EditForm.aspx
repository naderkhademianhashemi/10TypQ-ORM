<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EditForm.aspx.cs" Inherits="EditForm" Title="پرسشنامه" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>
    
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td></td>
            <td>
                <span style="color: Blue; font-size: 9pt">ويرايش فرم خصوصيات پرسشنامه</span>
                &nbsp;            
                <asp:Label ID="lblForm" runat="server" Font-Names="Tahoma" Font-Size="9pt"
                    ForeColor="Blue"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:Image ID="Image2" runat="server" Width="20px" ImageUrl="~/Pictures/A_Attachments_Sm_N.png"
                    Height="20px"></asp:Image>
                <asp:Label ID="Label7" runat="server" Text="تخصیص فرم به دپارتمان و استانها" Font-Size="9pt"
                    Font-Names="Tahoma" Height="20px" Font-Bold="True"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <table style="width: 60%">
                    <tr>
                        <td>
                            <asp:Label ID="Label8" runat="server" Font-Underline="True" Text="حوزه عملیاتی  :"
                                Font-Size="9pt" Font-Names="Tahoma"
                                Height="20px" Width="100%"></asp:Label>
                            <asp:CheckBox ID="Dep_selectall"
                                runat="server" __designer:wfdid="w6"
                                AutoPostBack="True" OnCheckedChanged="selectall_CheckedChanged"
                                Text="انتخاب تمامي دپارتمان ها"
                                Width="100%" />
                        </td>
                        <td>
                            <div style="overflow: auto; width: 230px; height: 100px; background-color: White; border: solid 1px #dddddd;">
                                <asp:CheckBoxList ID="CheckBoxList_Department" runat="server"
                                    DataSourceID="SqlDataSource_department" DataTextField="DepName"
                                    DataValueField="DepID">
                                </asp:CheckBoxList>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label9" runat="server" Font-Underline="True" Text="نام استان ها :"
                                Font-Size="9pt" Font-Names="Tahoma"
                                Height="20px" Width="100%" Visible="False"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 40%">
                            <br>
                                <asp:CheckBox ID="selectall" runat="server" Text="انتخاب همه استان ها" OnCheckedChanged="selectall_CheckedChanged"
                                    __designer:wfdid="w6"
                                    AutoPostBack="True" Width="100%" Checked="True" Visible="False"></asp:CheckBox>
                            </br>
                            <br />
                        </td>
                        <td>
                            <div style="overflow: auto; width: 150px; height: 100px; background-color: White; border: solid 1px #dddddd; visibility: hidden;">
                                <asp:CheckBoxList ID="chkloc" runat="server" ForeColor="Black" Font-Size="8pt" Font-Names="Tahoma"
                                    DataSourceID="SqlDataSource_state" DataValueField="LocID"
                                    DataTextField="LocName">
                                </asp:CheckBoxList>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2" valign="top">
                            <asp:Label ID="ValidityTest" runat="server" Font-Names="Tahoma"
                                ForeColor="#FF3300"></asp:Label>
                            <br />
                            <asp:Button ID="btnAddForm" OnClick="btnAddForm_Click" runat="server" Text="تایید تخصیص"
                                Width="150px" Font-Size="8pt"
                                Font-Names="Tahoma"></asp:Button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:SqlDataSource ID="SqlDataSource_department" runat="server"
                                ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                                SelectCommand="SELECT [DepID], [DepName] FROM [Department] where [DepID]&lt;&gt;0"></asp:SqlDataSource>
                        </td>
                        <td>
                            <asp:SqlDataSource ID="SqlDataSource_state" runat="server"
                                ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                                SelectCommand="SELECT [locid], [LocName] FROM [State] where  [locid]&lt;&gt;0"></asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="بازگشت به صفحه قبل "></asp:Label>
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/back.jpg" OnClick="ImageButton1_Click" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>

                </table>

            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>


    </table>

</asp:Content>

