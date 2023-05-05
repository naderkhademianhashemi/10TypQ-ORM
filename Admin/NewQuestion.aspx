<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="NewQuestion.aspx.cs"
    Inherits="NewQuestion" Title="پرسشنامه" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td align="center" colspan="2">&nbsp;</td>

        </tr>
        <tr>
            <td align="center" colspan="2">
                <span style="color: #000099"><font size="3">تنظيم سوالات پرسشنامه&nbsp;
                </font></span>
                <asp:Label ID="Label9" runat="server" Font-Names="Tahoma" Font-Size="12pt"
                    ForeColor="#000099" Text="Label" Font-Bold="False"></asp:Label>

                <br />

                <br />

            </td>

        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:GridView ID="GridView_Form_Questions" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="QID" BackColor="White" BorderColor="#999999" BorderStyle="Solid"
                    BorderWidth="1px" CellPadding="3" AllowPaging="True" Style="text-align: center" Width="600px"
                    OnRowCommand="GridView_Form_Questions_RowCommand"
                    OnSelectedIndexChanged="GridView_Form_Questions_SelectedIndexChanged"
                    OnRowDataBound="GridView_Form_Questions_RowDataBound"
                    OnRowDeleting="GridView_Form_Questions_RowDeleting"
                    OnRowEditing="GridView_Form_Questions_RowEditing"
                    OnRowCancelingEdit="GridView_Form_Questions_RowCancelingEdit"
                    OnRowUpdating="GridView_Form_Questions_RowUpdating"
                    OnPageIndexChanging="GridView_Form_Questions_PageIndexChanging">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="QID" HeaderText="QID" InsertVisible="False" ReadOnly="True"
                            SortExpression="QID" Visible="False" />
                        <asp:TemplateField HeaderText="شماره سوال" SortExpression="QueNum">
                            <ItemTemplate>
                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("QueNum") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" سوال" SortExpression="Que">
                            <ItemTemplate>
                                <asp:Label ID="Label11" runat="server" Text='<%# Bind("Que") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Que") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="  جواب " SortExpression="ِStatus">
                            <ItemTemplate>
                                <asp:Label ID="stlbl0" runat="server" Text='<%# GetStatus(Eval("Status")) %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server"
                                    SelectedIndex='<%# GetselectIndex(Eval("Status")) %>'>
                                    <asp:ListItem Value="0">اختياري</asp:ListItem>
                                    <asp:ListItem Value="1">اجباري</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="نوع" SortExpression="Type">
                            <ItemTemplate>
                                <asp:Label ID="Label12" runat="server" Text='<%# GetType(Eval("Type")) %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderTemplate>
                                نوع سوال
                            </HeaderTemplate>
                        </asp:TemplateField>
                        
                        
                        <asp:TemplateField HeaderText="سئوال فعال">
                            <ItemTemplate>
                                <asp:Label ID="lblQueIsActive" runat="server"
                                    Text='<%# GetActive(Eval("QueIsActive"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="drpQueIsActive" runat="server"
                                    SelectedIndex='<%# GetselectIndex(Eval("QueIsActive")) %>'>
                                    <asp:ListItem Value="1">فعال</asp:ListItem>
                                    <asp:ListItem Value="0">غیر فعال</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="FormID" HeaderText="FormID" SortExpression="FormID" Visible="False" />
                        <asp:BoundField DataField="ColNum" SortExpression="ColNum" Visible="False" />
                        <asp:TemplateField ShowHeader="False" HeaderText="حذف سوال">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton22" runat="server" CausesValidation="False" CommandName="Delete"
                                    ImageUrl="~/images/delete.jpg" Text="Delete"
                                    OnClientClick="return confirm('آیا اطمینان دارید که میخواهید این سوال را حذف کنید ؟');"
                                    CommandArgument='<%# Eval("QID") %>' />
                            </ItemTemplate>
                            <ControlStyle BackColor="#999999" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" HeaderText="ویرایش سوال">
                            <EditItemTemplate>
                                <asp:ImageButton ID="ImageButton23" runat="server" CausesValidation="True"
                                    CommandName="Update" ImageUrl="~/Pictures/Ok.png" Text="Update" />
                                &nbsp;<asp:ImageButton ID="ImageButton24" runat="server" CausesValidation="False"
                                    CommandName="Cancel" ImageUrl="~/Pictures/nOk.png" Text="Cancel" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton25" runat="server" CausesValidation="False"
                                    CommandName="Edit" ImageUrl="~/images/edit.jpg" Text="Edit" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="تخصیص گزینه">
                            <ItemTemplate>
                                <div align="center">
                                    <asp:ImageButton ID="allocate0" runat="server" Enabled='<%# linkIsEnable(Eval("Type")) %>'
                                        CausesValidation="false" CommandArgument='<%# Eval("QID") %>' ImageUrl="~/images/icon079.GIF"
                                        OnClick="ImageButton2_Click" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="جابجایی">
                            <ItemTemplate>
                                <table style="width: 100%">
                                    <tr>
                                        <td>

                                            <%--gggggggggggggggggggg--%>

                                            <asp:ImageButton ImageUrl="~/images/up.gif" ID="Button3" runat="server" CausesValidation="False"
                                                CommandArgument='<%#Eval("QID")+";"+Eval("quenum")  %>'
                                                OnClick="Button1_Click" Text="بالا" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ImageButton ImageUrl="~/images/down.gif" ID="Button4" runat="server" CausesValidation="False"
                                                CommandArgument='<%# Eval("QID")+";"+Eval("quenum") %>'
                                                OnClick="Button2_Click" Text="پايين" />
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            </td>

        </tr>
        <tr>
            <td style="width: 196px">
                <asp:Label ID="Label7" runat="server" Text="تعریف سوال جدید" Font-Size="9pt"
                    Font-Names="Tahoma" ForeColor="#0066FF"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 196px">
                <asp:Label ID="Label8" runat="server" Text="صورت سوال" Font-Size="9pt"
                    Font-Names="Tahoma"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtQue" runat="server" Width="472px" Font-Size="9pt"
                    Font-Names="Tahoma" Height="25px"></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ControlToValidate="txtQue" ErrorMessage="لطفا صورت سوال را وارد كنيد."
                    Display="Dynamic" ValidationGroup="1"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CustomValidator1" runat="server"
                    ControlToValidate="txtQue" Display="Dynamic"
                    ErrorMessage="اين نام هم اكنون وجود دارد."
                    OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="1"></asp:CustomValidator>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 196px">
                <asp:Label ID="Label4" runat="server" Width="108px" Text="نوع سوال" Font-Size="9pt" Font-Names="Tahoma"></asp:Label>
            </td>
            <td>
                <asp:RadioButtonList ID="rblTypeQue" runat="server" Font-Size="9pt"
                    Font-Names="Arial">
                    <asp:ListItem Value="1" Selected="True">متنی </asp:ListItem>
                    <asp:ListItem Value="2">چندگزینه ای چند جوابی</asp:ListItem>
                    <asp:ListItem Value="3">چند گزینه ای تک جوابی </asp:ListItem>
                    <asp:ListItem Value="4">چند گزینه ای تک جوابی نمایش به صورت آبشاری</asp:ListItem>
                    <asp:ListItem Value="5">مقدار عددی</asp:ListItem>
                    <asp:ListItem Value="6">تاریخ</asp:ListItem>
                    <asp:ListItem Value="7">جدول</asp:ListItem>
                    <asp:ListItem Value="8"> چند جوابی و متنی</asp:ListItem>
                    <asp:ListItem Value="9"> تک جوابی و متنی</asp:ListItem>
                    <asp:ListItem Value="10"> آبشاری و متنی</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 196px">
                <asp:Label ID="Label6" runat="server" Width="108px" Text="سوال اجباریست یا اختیاری" Font-Size="9pt" Font-Names="Tahoma"></asp:Label>
            </td>
            <td>
                <asp:RadioButtonList ID="rblStatus" runat="server">
                    <asp:ListItem Value="0"
                        Selected="True">اختیاری</asp:ListItem>
                    <asp:ListItem Value="1">اجباری</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td>&nbsp;</td>
        </tr>
        
        
        <tr>
            <td style="width: 196px">
                <br />
                <asp:Label ID="lblIsEnable" runat="server" Text="سوال فعال است یا غیر فعال"></asp:Label>

            </td>
            <td>
                <asp:RadioButtonList ID="rblIsEnable" runat="server">
                    <asp:ListItem Value="0"
                        Selected="True">فعال</asp:ListItem>
                    <asp:ListItem Value="1">غیر فعال</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>


        <tr>
            <td style="width: 196px">&nbsp;</td>
            <td>
                <asp:Button ID="btnAddQue" runat="server" Font-Names="Tahoma" Font-Size="9pt"
                    OnClick="btnAddQue_Click" Text="تعریف سوال" Width="150px"
                    ValidationGroup="1" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>

</asp:Content>

