<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Editoption.aspx.cs" Inherits="Editoption" Title="پرسشنامه" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript">
        function LSelectAll(CheckBox) {
            TotalChkBx = parseInt('<%= this.GridView1.Rows.Count %>');
    var TargetBaseControl = document.getElementById('<%= this.GridView1.ClientID %>');
    var TargetChildControl = "CheckBox";
    var Inputs = TargetBaseControl.getElementsByTagName("input");
    for (var iCount = 0; iCount < Inputs.length; ++iCount) {
        if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
            Inputs[iCount].checked = CheckBox.checked;
    }
}
function BSelectAll(CheckBox) {
    TotalChkBx = parseInt('<%= this.GridView1.Rows.Count %>');
        var TargetBaseControl = document.getElementById('<%= this.GridView1.ClientID %>');
        var TargetChildControl = "CheckBox";
        var Inputs = TargetBaseControl.getElementsByTagName("input");
        for (var iCount = 0; iCount < Inputs.length; ++iCount) {
            if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                Inputs[iCount].checked = CheckBox.checked;
        }
    }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <table width="100%">
        <tr>
            <td colspan="2" style="color: #3399FF; font-size: 12pt">ويرايش گزينه هاي سوال</td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
            <td align="center">
                <%--    <FooterTemplate>
                    <img src="images/RSS.gif" />
                </FooterTemplate>--%>



                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="Branch" runat="server">
                        <asp:GridView ID="GridView1" runat="server">
                        </asp:GridView>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="BID" DataSourceID="SqlDataSource2"
                            EmptyDataText="There are no data records to display." BackColor="White"
                            BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3"
                            AllowPaging="True">
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <Columns>
                                <asp:BoundField DataField="Branch" HeaderText="كد شعبه"
                                    SortExpression="Branch" />
                                <asp:BoundField DataField="BranchName" HeaderText="نام شعبه"
                                    SortExpression="BranchName" />
                                <asp:BoundField DataField="Description" HeaderText="توضيحات"
                                    SortExpression="Description" />
                                <asp:BoundField DataField="BID" HeaderText="BID" ReadOnly="True"
                                    SortExpression="BID" Visible="False" />
                            </Columns>
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:ORM_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT [Branch], [BranchName], [State_Of_Branch], [Branch_Rank], [Limit], [Description], [BID] FROM [Branch] where BID&lt;&gt;0"></asp:SqlDataSource>
                    </asp:View>
                    <asp:View ID="location" runat="server">
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="locid" DataSourceID="SqlDataSource3"
                            EmptyDataText="There are no data records to display." BackColor="White"
                            BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3"
                            AllowPaging="True">
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <Columns>
                                <asp:BoundField DataField="locid" HeaderText="كد محل" ReadOnly="True"
                                    SortExpression="locid" />
                                <asp:BoundField DataField="LocName" HeaderText="نام محل"
                                    SortExpression="LocName" />
                            </Columns>
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:ORM_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT [locid], [LocName], [description] FROM [state] where   [locid]&lt;&gt;0"></asp:SqlDataSource>
                    </asp:View>
                    <asp:View ID="Queitem" runat="server">
                        <asp:GridView ID="GridView_options" runat="server" AllowPaging="True"
                            AllowSorting="True" AutoGenerateColumns="False" BackColor="White"
                            BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3"
                            DataKeyNames="ITID"
                            ShowFooter="True" Style="text-align: right; margin-top: 0px;"
                            OnRowEditing="GridView_options_RowEditing"
                            OnRowDataBound="GridView_options_RowDataBound"
                            OnRowCancelingEdit="GridView_options_RowCancelingEdit"
                            OnRowUpdating="GridView_options_RowUpdating"
                            OnRowCommand="GridView_options_RowCommand"
                            OnRowDeleting="GridView_options_RowDeleting">
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <Columns>
                                <asp:BoundField DataField="GroupID" HeaderText="ITID" InsertVisible="False"
                                    ReadOnly="True" SortExpression="" Visible="False" />
                                <asp:TemplateField HeaderText="شماره گزینه" SortExpression="">

                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Itemnum") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item" ItemStyle-HorizontalAlign="Right"
                                    SortExpression="Item">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Item_Text") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnAdd">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtAddItem" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="btnAdd" runat="server" ImageUrl="~/images/add.jpg"
                                                            OnClick="btnAdd_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </FooterTemplate>
                                    <HeaderTemplate>
                                        عنوان گزینه
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Item_Text") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="اضافه کردن" Visible="False"></asp:TemplateField>
                                <asp:TemplateField HeaderText="ویرایش" ShowHeader="False">
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="lbtnEdit" runat="server" CausesValidation="True"
                                            CommandName="Update" ImageUrl="~/pictures/ok.png" Text="Update" />
                                        <asp:ImageButton ID="lbtnCancel" runat="server" CausesValidation="False"
                                            CommandName="Cancel" ImageUrl="~/pictures/nok.png" Text="Cancel" />
                                    </EditItemTemplate>
                                    <%--    <FooterTemplate>
                    <img src="images/RSS.gif" />
                </FooterTemplate>--%>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="lbtEdit" runat="server" CausesValidation="False"
                                            CommandName="Edit" ImageUrl="~/images/edit.jpg" Text="ويرايش" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton2" runat="server"
                                            CommandArgument='<%# Eval("Item_ID") %>'
                                            ImageUrl="~/images/delete.jpg"
                                            CommandName="Delete" />
                                        <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender2" runat="server"
                                            DisplayModalPopupID="ModalPopupExtender1" TargetControlID="ImageButton2" />
                                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
                                            BackgroundCssClass="modalBackground" CancelControlID="ButtonCancel"
                                            OkControlID="ButtonOk" PopupControlID="PNL" TargetControlID="ImageButton2" />
                                        <asp:Panel ID="PNL" runat="server"
                                            Style="display: none; width: 200px; background-color: White; border-width: 2px; border-color: Black; border-style: solid; padding: 20px;">
                                            آیا مطمئن هستید که میخواهید این گزينه را حذف کنید.در صورت وجود اطلاعات براي اين 
                                            سوال حذف اين گزينه امكان پذير نخواهد بود. آيا اطمينان داريد؟.
                                            <br />
                                            <br />
                                            <div style="text-align: right;">
                                                <asp:Button ID="ButtonOk" runat="server" Text="بلی" Width="50px" />
                                                <asp:Button ID="ButtonCancel" runat="server" Text="خیر" Width="50px" />
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        حذف
                                    </HeaderTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <EmptyDataTemplate>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtAddItem" runat="server" Text='<%# Bind("Item_Text") %>'></asp:TextBox>
                                        </td>
                                        <%--<td>
                        <asp:TextBox ID="txtAddItemnum" runat="server" Text='<%# Bind("Itemnum") %>'></asp:TextBox></td>--%>
                                        <td>
                                            <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="false"
                                                ImageUrl="~/images/add.jpg" OnClick="btnAdd_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>
                    </asp:View>
                    <asp:View ID="Department" runat="server">
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                            SelectCommand="SELECT [DepID], [DepName] FROM [Department] WHERE ([DepID] &lt;&gt; @DepID)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="DepID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridView4" runat="server" AllowPaging="True"
                            AutoGenerateColumns="False" BackColor="White" BorderColor="#999999"
                            BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="depid"
                            DataSourceID="SqlDataSource4"
                            EmptyDataText="There are no data records to display.">
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <Columns>
                                <asp:BoundField DataField="DepID" HeaderText="كد دپارتمان" ReadOnly="True"
                                    SortExpression="depid" />
                                <asp:BoundField DataField="DepName" HeaderText="نام دپارتمان"
                                    SortExpression="depname" />
                            </Columns>
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>
                    </asp:View>
                </asp:MultiView>

            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td align="center">
                <asp:Panel ID="Panel2" runat="server" DefaultButton="button_add">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 345px">

                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbl_fieldtitle" runat="server">عنوان فیلد :  &nbsp;&nbsp;</asp:Label>
                                            <asp:TextBox ID="TextBox_Add" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>

                            </td>
                            <td align="center" style="width: 87px">
                                <asp:CheckBox ID="chkField_Optional" runat="server" Text="اجباری"
                                    TextAlign="Left" />
                            </td>
                            <td style="width: 207px">
                                <asp:Label ID="lbl_fieldtype" runat="server">نوع فیلد :  &nbsp;&nbsp;</asp:Label>
                                <asp:DropDownList ID="cmbFieldtype" runat="server" Width="146px">
                                </asp:DropDownList>

                            </td>
                            <td>
                                <asp:ImageButton ID="button_add" runat="server" ImageUrl="~/images/add.jpg"
                                    OnClick="button_add_Click" /></td>
                        </tr>
                        <tr>
                            <td style="width: 345px">&nbsp;</td>
                            <td style="width: 87px">
                                <asp:CheckBox ID="chkField_Filled" runat="server" Text="دارای مقدار"
                                    TextAlign="Left" AutoPostBack="True"
                                    OnCheckedChanged="chkField_Filled_CheckedChanged" />
                            </td>
                            <td style="width: 207px">
                                <asp:Label ID="lbl_fieldfill" runat="server" Visible="False">نام جدول :&nbsp;</asp:Label>
                                <asp:DropDownList ID="cmbFieldFilled" runat="server" Width="146px"
                                    Style="margin-right: 0px" Visible="False">
                                </asp:DropDownList>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">

                                <asp:GridView ID="GridView_ListItem" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Item_ID" BackColor="White" BorderColor="#999999" BorderStyle="Solid"
                                    BorderWidth="1px" CellPadding="3" Width="600px" AllowPaging="True" Style="text-align: center"
                                    OnRowDataBound="GridView_ListItem_RowDataBound" 
                                    OnRowCommand="GridView_ListItem_RowCommand"
                                    OnRowDeleting="GridView_ListItem_RowDeleting"
                                    OnRowEditing="GridView_ListItem_RowEditing"
                                    OnRowCancelingEdit="GridView_ListItem_RowCancelingEdit"
                                    OnRowUpdating="GridView_ListItem_RowUpdating">
                                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                    <Columns>
                                        <asp:BoundField DataField="Question_ID" HeaderText="Question_ID" InsertVisible="False" ReadOnly="True"
                                            SortExpression="" Visible="False" />
                                        <asp:TemplateField HeaderText="عنوان فیلد" SortExpression="Item_Text">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_itemtext" runat="server" Text='<%# Bind("Item_Text") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txt_ItemText" runat="server" Text='<%# Bind("Item_Text") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="اجباری" SortExpression="Optional">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_optional" runat="server" Text='<%# Bind("Optional") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="drd_optional" runat="server"
                                                    SelectedIndex='<%# Bind("BOptional") %>'>
                                                    <asp:ListItem Value="0">اختياري</asp:ListItem>
                                                    <asp:ListItem Value="1">اجباري</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="نوع فیلد" SortExpression="ِType">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_type" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="drd_type" runat="server" AppendDataBoundItems="True">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="مقداردار" SortExpression="Filled">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_filled" runat="server" Text='<%# Bind("Filled") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="drd_filled" runat="server"
                                                    SelectedIndex='<%# Bind("BFilled") %>'>
                                                    <asp:ListItem Value="0">خالی</asp:ListItem>
                                                    <asp:ListItem Value="1">مقداردار</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="جدول" SortExpression="Table_Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_table" runat="server" Text='<%# Bind("Table_Name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="drd_table" runat="server" AppendDataBoundItems="True">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="[Item_ID]" HeaderText="ItemID" SortExpression="Item_ID"
                                            Visible="False" />
                                        <asp:BoundField DataField="[Form_ID]" Visible="False" />
                                        <asp:TemplateField ShowHeader="False" HeaderText="حذف ">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="ImageButton22" runat="server" CausesValidation="False" CommandName="Delete"
                                                    ImageUrl="~/images/delete.jpg" Text="Delete"
                                                    OnClientClick="return confirm('آیا اطمینان دارید که میخواهید این سوال را حذف کنید ؟');"
                                                    CommandArgument='<%# Bind("Item_ID") %>' />
                                            </ItemTemplate>
                                            <ControlStyle BackColor="#999999" />
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False" HeaderText="ویرایش">
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

                                    </Columns>
                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                                    <AlternatingRowStyle BackColor="#F7F7F7" />
                                </asp:GridView>

                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">

                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <br />
                        <img alt="لطفا منتظر بمانید." longdesc="لطفا منتظر بمانید."
                            src="images/progress.gif" />
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>

            <td align="center">
                <asp:Button ID="Button1" runat="server" Text="تخصيص همه استان ها"
                    OnClick="Button1_Click" Visible="False" />
                <asp:Button ID="Button2" runat="server" Text="تخصيص همه شعبه ها"
                    OnClick="Button2_Click" Visible="False" />
                <asp:Button ID="Button4" runat="server" Text="تخصيص همه شعبه ها"
                    OnClick="Button4_Click" Visible="False" />
                <asp:Button ID="Button3" runat="server" Text="تنظيم دستي گزينه ها "
                    OnClick="Button3_Click" Visible="False" />
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3" align="center" valign="middle">

                <asp:Label ID="Label3" runat="server" Text="بازگشت به صفحه قبل "></asp:Label>

                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/back.jpg"
                    OnClick="ImageButton1_Click" />

            </td>

        </tr>

    </table>

</asp:Content>
