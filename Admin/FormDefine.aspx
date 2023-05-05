<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FormDefine.aspx.cs" Inherits="FormDefine" Title="پرسشنامه" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="text-align: center">
                <table style="width: 100%">
                    <tbody>
                        <tr>
                            <td style="width: 10%" dir="ltr" valign="top">
                                &nbsp;
                                </td>
                            <td style="width: 80%" dir="rtl" align="right">
                                &nbsp;<asp:Panel ID="Panel3" runat="server" Width="100%">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 15%">
                                                <asp:Image ID="Image3" runat="server" Height="20px" ImageUrl="~/Pictures/edit.gif"
                                                    Width="20px" />
                                                <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="9pt"
                                                    Height="20px" Text="تعریف فرم"></asp:Label>
                                            </td>
                                            <td style="width: 85%">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" dir="rtl" style="width: 15%">
                                                <asp:Label ID="Label1" runat="server" Font-Names="Tahoma" Font-Size="9pt" Text="نام فرم :"
                                                    Height="20px"></asp:Label>
                                            </td>
                                            <td style="width: 85%">
                                                <asp:TextBox ID="txtFName" runat="server" Font-Names="Tahoma" Font-Size="9pt" Width="200px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvForm" runat="server" 
                                                    ControlToValidate="txtFName" ErrorMessage="تکمیل نام فرم ضروری است." 
                                                    Font-Names="Tahoma" Font-Size="8pt">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" dir="rtl" style="width: 15%">
                                                <asp:Label ID="Label2" runat="server" Font-Names="Tahoma" Font-Size="9pt" Text="توضیحات :"
                                                    Height="20px"></asp:Label>
                                            </td>
                                            <td style="width: 85%">
                                                <asp:TextBox ID="txtFDesc" runat="server" Font-Names="Tahoma" Font-Size="9pt" TextMode="MultiLine"
                                                    Width="200px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                            <td style="width: 10%" dir="rtl" align="right">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 10%">
                            </td>
                            <td style="width: 80%" dir="rtl" align="right" rowspan="2">
                                &nbsp;&nbsp;<asp:Panel ID="Panel1" runat="server" Width="100%">
                                    <table style="width: 100%">
                                        <tbody>
                                            <tr>
                                                <td dir="rtl" align="right" colspan="2">
                                                    &nbsp;<asp:Image ID="Image2" runat="server" Width="20px" ImageUrl="~/Pictures/A_Attachments_Sm_N.png"
                                                        Height="20px"></asp:Image>
                                                    <asp:Label ID="Label7" runat="server" Text="تخصیص فرم به دپارتمان و استانها" Font-Size="9pt"
                                                        Font-Names="Tahoma" Height="20px" Font-Bold="True"></asp:Label>
                                                </td>
                                                <td style="width: 10%" dir="rtl" align="right" colspan="1">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%" dir="rtl" align="left">
                                                    <asp:Label ID="Label8" runat="server" Font-Underline="True" Text="حوزه عملیاتی:"
                                                        Font-Size="9pt" Font-Names="Tahoma" Height="20px"></asp:Label>
                                                    <br />
                                                    <asp:CheckBox ID="Dep_selectall" runat="server" __designer:wfdid="w6" 
                                                        AutoPostBack="True" OnCheckedChanged="selectall_CheckedChanged" 
                                                        Text="انتخاب تمامي دپارتمان ها" Width="100%" />
                                                </td>
                                                <td style="width: 60%" >
                                                    <div style="overflow: auto; width: 230px; height: 309px; background-color:White;border:solid 1px #dddddd;">
                                                        <asp:CheckBoxList ID="CheckBoxList_Department" runat="server" 
                                                            DataSourceID="SqlDataSource_department" DataTextField="DepName" 
                                                            DataValueField="DepID">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </td>
                                                <td style="width: 10%" rowspan="3">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%; height: 47px" dir="rtl" align="left">
                                                    <asp:Label ID="Label9" runat="server" Font-Underline="True" Text="نام استان ها :"
                                                        Font-Size="9pt" Font-Names="Tahoma" Height="20px" Visible="False"></asp:Label><br />
                                                    <asp:CheckBoxList ID="CheckBoxList_State" runat="server" 
                                                        DataSourceID="SqlDataSource_state" DataTextField="LocName" 
                                                        DataValueField="locid" Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" 
                                                        Visible="False">
                                                    </asp:CheckBoxList>
                                                    <br />
                                                    <br />
                                                    &nbsp;<asp:CheckBox ID="state_selectall" runat="server" __designer:wfdid="w6" 
                                                        AutoPostBack="True" OnCheckedChanged="selectall_CheckedChanged" 
                                                        Text="انتخاب همه استان ها" Width="100%" Checked="True" Visible="False" />
                                                </td>
                                            </tr>
                                            <tr>
                                            <td colspan="2">
                                                <asp:Label ID="ValidityTest" runat="server" Font-Names="Tahoma" 
                                                    ForeColor="#FF3300"></asp:Label>
                                             </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%" dir="rtl" align="left">
                                                    <asp:Button ID="btnAddDep" OnClick="btnAddDep_Click" runat="server" Text="ثبت فرم و تخصيص مجدد"
                                                        Width="150px" Font-Size="8pt" Font-Names="Tahoma"></asp:Button>
                                                </td>
                                                <td style="width: 60%">
                                                    <asp:Button ID="btnAddForm" OnClick="btnAddForm_Click" runat="server" Text="ثبت فرم  و تعریف سوال"
                                                        Width="150px" Font-Size="8pt" Font-Names="Tahoma"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                &nbsp;&nbsp;&nbsp;
                                </td>
                            <td style="width: 10%" dir="rtl" align="right">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 10%">
                            </td>
                            <td style="width: 10%" dir="rtl" align="right">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 10%">
                            </td>
                            <td style="width: 80%" dir="rtl" align="right">
                            </td>
                            <td style="width: 10%" dir="rtl" align="right">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 10%">
                            </td>
                            <td style="width: 80%" dir="rtl" align="right">
                                &nbsp;&nbsp;<asp:SqlDataSource ID="SqlDataSource_department" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>" 
                                    SelectCommand="SELECT [DepID], [DepName] FROM [Department] where [DepID]&lt;&gt;0">
                                </asp:SqlDataSource>
                                &nbsp;<asp:SqlDataSource ID="SqlDataSource_state" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>" 
                                    SelectCommand="SELECT [locid], [LocName] FROM [State] where  [locid]&lt;&gt;0">
                                </asp:SqlDataSource>
                            </td>
                            <td style="width: 10%" dir="rtl" align="right">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
