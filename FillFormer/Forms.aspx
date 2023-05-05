<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Forms.aspx.cs" Inherits="_FillFormer_Forms" Title="پرسشنامه" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblMess" runat="server" Text="فرمی برای نمایش وجود ندارد." Visible="false"></asp:Label>
    <table style="width: 100%;">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>

                <%-- GridView_Forms --%>
                <%-- GridView_Forms.DataSource = ORM.Forms.get_Forms_By_Permission(Profile.UserName); --%>
                <asp:GridView ID="GridView_Forms" runat="server"
                    AutoGenerateColumns="False"
                    Font-Names="Tahoma" Font-Size="9pt"
                    Width="100%" OnRowCommand="GridView_Forms_RowCommand" CellPadding="3"
                    BackColor="White" BorderColor="#999999"
                    BorderStyle="Solid" BorderWidth="1px" AllowPaging="True" PageSize="20"
                    EmptyDataText="هيچ فرمي براي نمايش وجود ندارد ">
                    <Columns>
                        <asp:BoundField DataField="FormID" HeaderText="FormID" InsertVisible="False" ReadOnly="True"
                            SortExpression="FormID" Visible="False">
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
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                            </ItemTemplate>


                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>


                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="مشاهده پاسخها"
                            ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-VerticalAlign="Middle">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" Visible='<%# Bind("readable") %>'
                                    NavigateUrl='<%# GetFid(Eval("Formid")) %>' Text="نمایش"
                                    ImageUrl="~/images/search.jpg"></asp:HyperLink>
                            </ItemTemplate>

                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>

                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="پاسخ به فرم پرسشنامه">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="View" Visible='<%# Bind("writeable") %>'
                                    CommandArgument='<%# Bind("FormID") %>'>پاسخ به فرم 
                                    پرسشنامه</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="طراحی سوال">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonAddQuestion" runat="server" 
                                    CommandName="NewQuestion"
                                     Visible='<%# Bind("AddQuestion") %>'
                                    CommandArgument='<%# ConcatArgs(Eval("FormID"),Eval("FormName")) %>'> طراحی سوال
                                    </asp:LinkButton>

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
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
    </table>
    <asp:Label ID="lblID" runat="server" Text=""></asp:Label>
</asp:Content>
