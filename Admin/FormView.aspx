<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FormView.aspx.cs" 
    Inherits="FormView" Title="پرسشنامه" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .class1 {
            overflow: auto;
            width: 90%;
        }

        .class2 {
            text-align: right;
        }
         .Hide  {
            display:none;
        }
    </style>


    <div class="class2">

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td style="width: 12px">&nbsp;</td>
                <td align="right" dir="rtl" style="width: 517px">
                    <asp:Label ID="Label1" runat="server" Font-Names="Tahoma" Font-Size="10pt" Font-Bold="True">مشاهده پرسشنامه های موجود :</asp:Label></td>
            </tr>
            <tr>
                <td style="width: 12px; height: 34px;"></td>
                <td align="right" dir="rtl" style="width: 517px; vertical-align: top; height: 34px;">&nbsp;
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Pictures/A_AddFiles_Md_N.png"
                                    PostBackUrl="~/Admin/FormDefine.aspx" ToolTip="ÊÚÑíÝ ÝÑã ÌÏíÏ" />
                                <asp:HyperLink ID="HyperLink1" runat="server" Font-Names="Tahoma" Font-Size="9pt"
                                    ForeColor="Black" Height="25px" NavigateUrl="~/Admin/FormDefine.aspx" Font-Underline="True">تعریف 
                                فرم پرسشنامه جدید</asp:HyperLink>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <table style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text="حوزه عملیاتی"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownList_field" runat="server"
                                                        DataSourceID="SqlDataSource_department" DataTextField="DepName" DataValueField="DepID"
                                                        Enabled="False">
                                                        <asp:ListItem Value="Select_All">همه</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text="استان" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownList_Location" runat="server"
                                                        DataSourceID="SqlDataSource_state" DataTextField="LocName" DataValueField="locid"
                                                        Enabled="False" Visible="False">
                                                        <asp:ListItem Value="Select_ALL">همه</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>
                                                    <asp:CheckBox ID="CheckBox_field_Select_All" runat="server" AutoPostBack="True"
                                                        Checked="True" OnCheckedChanged="CheckBox_field_Select_All_CheckedChanged"
                                                        Text="تمامی حوزه های عملیاتی" />
                                                </td>
                                                <td>&nbsp;</td>
                                                <td>
                                                    <asp:CheckBox ID="CheckBox_All_Location" runat="server" AutoPostBack="True"
                                                        Checked="True" OnCheckedChanged="CheckBox_All_Location_CheckedChanged"
                                                        Text="تمامی استانها" Visible="False" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td>
                                <asp:ImageButton ID="ImageButton_Search" runat="server"
                                    ImageUrl="~/images/search.jpg" OnClick="ImageButton_Search_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 12px"></td>
                <td align="right" dir="rtl">
                    <asp:SqlDataSource ID="SqlDataSource_department" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                        SelectCommand="SELECT [DepID], [DepName] FROM [Department] where [DepID]&lt;&gt;0"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_state" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                        SelectCommand="SELECT [locid], [LocName] FROM [State] where  [locid]&lt;&gt;0"></asp:SqlDataSource>
                    <br />
                </td>
            </tr>
        </table>


        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server">
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="class1">
                        <asp:GridView ID="GridView_Forms" runat="server"
                            AutoGenerateColumns="False"
                            Font-Names="Tahoma" Font-Size="9pt"
                            Width="100%" CellPadding="3"
                            BackColor="White" BorderColor="#999999"
                            BorderStyle="Solid" BorderWidth="1px" AllowPaging="True" PageSize="10"
                            OnRowCommand="GridView_Forms_RowCommand"
                            OnPageIndexChanging="GridView_Forms_PageIndexChanging"
                            OnRowCancelingEdit="GridView_Forms_RowCancelingEdit" 
                            OnRowDeleting="GridView_Forms_RowDeleting"
                            OnRowEditing="GridView_Forms_RowEditing"
                            OnRowUpdating="GridView_Forms_RowUpdating">
                            <Columns>
                                <asp:BoundField DataField="FormID" HeaderText="FormID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="FormID" ItemStyle-CssClass="Hide" HeaderStyle-CssClass="Hide">
                                    <HeaderStyle Font-Size="Small" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="نام فرم" SortExpression="FormName"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox_Edit_Name" runat="server" BackColor="#E0E0E0" Font-Names="Tahoma"
                                            Font-Size="9pt" Text='<%# Bind("FormName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("FormName") %>'></asp:Label>
                                    </ItemTemplate>


                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>


                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="توضیحات" SortExpression="Description"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox_Edit_Description" runat="server" BackColor="#E0E0E0" Font-Names="Tahoma"
                                            Font-Size="9pt" Text='<%# Bind("Description") %>' TextMode="MultiLine"
                                            Width="95%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                                    </ItemTemplate>


                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>


                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="سوالات فرم "
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_Question_Management" runat="server"
                                            ForeColor="Black" CausesValidation="false"
                                            CommandName="Question" Text="مدیریت سوالات"
                                            CommandArgument='<%# Eval("Formid") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:ButtonField CommandName="View" Text="پاسخ به فرم پرسشنامه"
                                    HeaderText="پاسخ به فرم پرسشنامه"
                                    HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-VerticalAlign="Middle">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:ButtonField>
                                <asp:ButtonField ButtonType="Image" HeaderText="ویرایش "
                                    ImageUrl="~/Pictures/Edit1.png" CommandName="EditF"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:ButtonField>
                                <asp:TemplateField HeaderText="حذف" ShowHeader="False"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle"
                                    Visible="False">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False"
                                            CommandName="Delete" CommandArgument='<%# Eval("Formid") %>' OnClientClick="return confirm('با حذف سطر مورد نظر كليه اطلاعات مربوط به اين فرم حذف خواهد شد.آيا مايل به ادامه كار هستيد؟');"
                                            ImageUrl="~/Pictures/del.jpg" Text="ÍÐÝ" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowEditButton="True" ShowHeader="True" ButtonType="Image"
                                    CancelImageUrl="~/Pictures/NOk.png" EditImageUrl="~/Pictures/Edit1.png"
                                    HeaderText="ویرایش نام و توضیحات فرم" UpdateImageUrl="~/Pictures/Ok.png"
                                    CancelText="لغو" UpdateText="تائید"
                                    HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-VerticalAlign="Middle">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CommandField>
                                <asp:TemplateField HeaderText="مشاهده پاسخها"
                                    ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-VerticalAlign="Middle">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink1" runat="server"
                                            NavigateUrl='<%# GetFid(Eval("Formid")) %>' Text="نمایش"
                                            ImageUrl="~/images/search.jpg"></asp:HyperLink>
                                    </ItemTemplate>

                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>

                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="پارامترهای وابسته" Visible="False">
                                    <ItemTemplate>
                                        <a href="<%# GetBoundlink(Eval("FormID")) %>">وابستگی ها</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="حذف">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Formid") %>'
                                            ImageUrl="~/Pictures/del.jpg"
                                            OnClientClick="return confirm('با حذف سطر مورد نظر كليه اطلاعات و پاسخهاي مربوط به اين فرم حذف خواهد شد.آيا مايل به ادامه كار هستيد؟')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <EmptyDataRowStyle Font-Names="Tahoma" Font-Size="9pt" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <EditRowStyle Font-Names="Tahoma" Font-Size="9pt" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>


</asp:Content>

