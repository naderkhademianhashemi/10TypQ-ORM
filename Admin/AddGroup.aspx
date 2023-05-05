<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddGroup.aspx.cs"
    Inherits="AddGroup" Title="پرسشنامه" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <h3>کلیه عملیات گروه</h3>
    
    <table>
        
        <tr>
            <td style="width: 100px;">
                <asp:Label ID="lblSearch" runat="server" Text="نام گروه:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" Text=""></asp:TextBox>

            </td>
            <td align="left">
                <asp:ImageButton ImageUrl="~/images/search.jpg" ID="btnSearch" runat="server"
                    Font-Names="Tahoma" Font-Size="8pt" Text="جستجو"
                    AccessKey="S"
                    ToolTip="Alt + S" />
            </td>
        </tr>
    </table>


    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />

    <asp:GridView ShowFooter="True" ID="GridView1" runat="server"
        DataSourceID="SqlDataSource1"
        DataKeyNames="Group_ID"
        AutoGenerateColumns="False"
        BackColor="White" BorderColor="#999999"
        BorderStyle="Solid" BorderWidth="1px" CellPadding="3" 
        AllowPaging="true">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
        <AlternatingRowStyle BackColor="#F7F7F7" />

        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="Group_ID" HeaderText="Group_ID" InsertVisible="False" ReadOnly="True"
                SortExpression="Group_ID" Visible="False" />

            <asp:TemplateField HeaderText="Group_Name" SortExpression="Group_Name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Group_Name") %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderTemplate>
                    نام گروه: 
                </HeaderTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtAddGroupName" runat="server" Text='<%# Bind("Group_Name") %>'></asp:TextBox>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Group_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="توضیحات" SortExpression="Description">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtAddDescription" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="اضافه  کردن">
                <FooterTemplate>
                    <asp:LinkButton ID="lbtnAdd" runat="server" OnClick="lbtnAdd_Click">افزودن گروه</asp:LinkButton>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField ShowHeader="False" HeaderText="ویرایش">
                <EditItemTemplate>
                    <asp:ImageButton ImageUrl="~/Pictures/Ok.png" ID="lbtnEdit" runat="server" CausesValidation="True" CommandName="Update"
                        Text="Update"></asp:ImageButton>
                    <asp:ImageButton ImageUrl="~/Pictures/nOk.png" ID="lbtnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancel"></asp:ImageButton>
                </EditItemTemplate>
                <FooterTemplate>
                    &nbsp;
                </FooterTemplate>
                <ItemTemplate>
                    <asp:ImageButton ImageUrl="~/images/edit.jpg" ID="lbtEdit" runat="server" CausesValidation="False" CommandName="Edit"
                        Text="Edit"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField ShowHeader="False" HeaderText="حذف">
                <FooterTemplate>
                    &nbsp;
                </FooterTemplate>
                <ItemTemplate>
                    <asp:ImageButton ImageUrl="~/images/delete.jpg" ID="lbtnDelete" runat="server" CausesValidation="false" CommandName="Delete"
                        Text="Delete" OnClientClick="return confirm('آیا از حذف این گروه اطمینان دارید؟');"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="تعیین کاربران گروه">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnUsers" runat="server" CommandArgument='<%# BeforSendUsers(Eval("Group_ID"),Eval("Group_Name")) %>'
                        OnClick="lbtnUsers_Click">تعیین کاربران گروه</asp:LinkButton>
                </ItemTemplate>
                <FooterTemplate>
                    &nbsp;
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="تعیین فرمهای گروه">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnForms" runat="server" OnClick="lbtnForms_Click" CommandArgument='<%# BeforSendForms(Eval("Group_ID"),Eval("Group_Name")) %>'>تعیین فرمهای گروه</asp:LinkButton>
                </ItemTemplate>
                <FooterTemplate>
                    &nbsp;
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="تعیین ارشد گروه">
                <ItemTemplate>
                    <asp:LinkButton ID="btnDefineGroupAdmin"
                        runat="server"
                        OnClick="btnDefineGroupAdmin_Click"
                        CommandArgument='<%# BeforSendForms(Eval("Group_ID"),Eval("Group_Name")) %>'>
                        <asp:Label ID="lblDefineGroupAdmin" runat="server"
                            Text="تعیین ارشد گروه">
                        </asp:Label>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

        <EmptyDataTemplate>
            <table style="width: 100%">
                <tr>
                    <td>
                        <asp:TextBox ID="txtAddGroupName" runat="server" Text='<%# Bind("Group_Name") %>'></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtAddDescription" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox></td>
                    <td>
                        <asp:LinkButton ID="lbtnAdd" runat="server" OnClick="lbtnAdd_Click">Add</asp:LinkButton></td>
                </tr>
            </table>
        </EmptyDataTemplate>
    </asp:GridView>

    <br />
    <h4>ایجاد دسترسی همگانی برای کاربران جدید اکتیو دیرکتوری </h4>
    <hr />
    <asp:Label ID="lblGroupName" Text="نام گروه برای دسترسی : " runat="server" />
    <asp:DropDownList runat="server" ID="drpListGroups" DataSourceID="SqlDataSource1" DataTextField="Group_Name" DataValueField="Group_ID">
    </asp:DropDownList>
    <br />
    <br />
    <asp:Button runat="server" ID="btnAddADUsersToGroup" Text="دسترسی کاربران به گروه انتخابی"
        OnClick="btnAddADUsersToGroup_Click" 
        OnClientClick="return confirm('آیا از دسترسی کاربران جدید اکتیو دیرکتوری به گروه انتخابی اطمینان دارید؟ ')" />
    <hr />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
        ProviderName="System.Data.SqlClient"
        SelectCommand="SELECT Group_ID, Group_Name, Description FROM Groups WHERE (Group_Name LIKE '%' + @GroupName + '%')"
        InsertCommand="Insert into Groups (Group_Name,Description) VALUES (@GroupName,@Description);"
        DeleteCommand="Delete from Groups where [Group_ID]=@Group_ID"
        UpdateCommand="UPDATE Groups SET Group_Name =@Group_Name, Description =@Description WHERE [Group_ID]=@Group_ID ;">
        <DeleteParameters>
            <asp:Parameter Name="GroupID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Group_Name" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="GroupID" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="GroupName"></asp:Parameter>
            <asp:Parameter Type="String" Name="Description"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" PropertyName="Text"
                Name="GroupName" DefaultValue="%" />
        </SelectParameters>

    </asp:SqlDataSource>
</asp:Content>

