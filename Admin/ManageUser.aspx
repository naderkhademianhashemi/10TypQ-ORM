<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageUser.aspx.cs" 
    Inherits="ManageUser" Title="پرسشنامه" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h3>مدیریت کاربران سایت</h3>

    <hr />
    <br />
    <table>
        <tr>
            <td style="width: 150px;">
                <asp:Label ID="lblSearch" runat="server" Text="نام کاربری یا سمت کاربر :"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" Text="" Width="200px"></asp:TextBox>

            </td>
            <td align="left">
                <asp:ImageButton ImageUrl="~/images/search.jpg" ID="btnSearch" runat="server"
                    Font-Names="Tahoma" Font-Size="8pt" Text="جستجو"
                    OnClick="btnSearch_Click"
                    AccessKey="S"
                    ToolTip="Alt + S" />
            </td>
        </tr>
        <tr>
            <td style="width: 150px;">
                <asp:Label ID="lblCodePerson" runat="server" Text=" شماره پرسنلی :"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtCodePerson" runat="server" Text="" MaxLength="10" Width="200px"></asp:TextBox>

            </td>
            <td align="left">
                <asp:ImageButton ImageUrl="~/images/search.jpg" ID="btnCodePerson" runat="server"
                    Font-Names="Tahoma" Font-Size="8pt" Text="جستجو"
                    OnClick="btnCodePerson_Click"
                    OnClientClick="return check_CodePersonel()"
                    AccessKey="C"
                    ToolTip="Alt + C" />
            </td>

        </tr>
    </table>
    <br />
    <h3>لیست کاربران</h3>
    <table width="600px" align="center">

        <tr>
            <td align="center" style="width: 698px">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                    CellPadding="3"
                    BackColor="White" BorderColor="#999999"
                    BorderStyle="Solid" BorderWidth="1px" AllowPaging="True" Width="720px"
                    OnPageIndexChanging="GridView2_PageIndexChanging"
                    OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    

<Columns>
                        <%-- cell 0 --%>
                        <asp:CommandField ShowSelectButton="True" HeaderText="انتخاب سطر"
                            SelectText="انتخاب" ButtonType="Button" />
                        <%-- cell 1 --%>
                        <asp:TemplateField HeaderText="شماره پرسنلی">
                            <ItemTemplate>
                                <asp:Label ID="lblShomarehPersenely" runat="server"
                                    Text='<%# Bind("ShomarehPersenely") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- cell 2 --%>
                        <asp:TemplateField HeaderText="نام کاربری">
                            <ItemTemplate>
                                <asp:Label ID="lblUserName" runat="server"
                                    Text='<%#Bind("UserName") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- cell  3--%>
                        <asp:TemplateField HeaderText="نام و نام خانوادگی">
                            <ItemTemplate>
                                <asp:Label ID="lblFullName" runat="server"
                                    Text='<%# Bind("FullName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- cell  4--%>
                        <asp:TemplateField HeaderText="سمت">
                            <ItemTemplate>
                                <asp:Label ID="lblSemat" runat="server"
                                    Text='<%# Bind("Semat") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--cell 5--%>
                        <asp:TemplateField HeaderText="کد محل خدمت">
                            <ItemTemplate>
                                <asp:Label ID="lblCodeMahalKhedmat" runat="server"
                                    Text='<%# Bind("CodeMahalKhedmat") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--cell 6--%>
                        <asp:TemplateField HeaderText=" محل خدمت">
                            <ItemTemplate>
                                <asp:Label ID="lblMahalKhedmat" runat="server"
                                    Text='<%# Bind("MahalKhedmat") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <br />
                <br />
                <br />
            </td>
        </tr>


    </table>
    <h3>اعطا و منع دسترسی مدیریت ارشد</h3>
    <hr />
    <table>
        <tr>
            <td style="width: 60px;">نام کاربری : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtUser" />
            </td>
            <td style="padding-right: 15px;">
                <asp:Button ID="btnAddUserToRole" Text="اعطای دسترسی" runat="server" OnClick="btnAddUserToRole_Click" OnClientClick="return confirm_Admin_Grant()" />
            </td>
        </tr>
    </table>
    <p>
        به منظور اعطای سطح دسترسی مدیریت ارشد ، ردیف مورد نظر را از لیست کاربران انتخاب نموده و سپس بر روی دکمه - اعطای دسترسی - کلیک کنید . 
    </p>
    <table>
        <tr>
            <td colspan="3">
                <h3>کاربران ارشد</h3>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:GridView ID="grdAdminRoles" runat="server"
                    CellPadding="3" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px"
                    AutoGenerateColumns="False"
                    AllowPaging="true"
                    OnPageIndexChanging="grdAdminRoles_PageIndexChanging"
                    OnSelectedIndexChanged="grdAdminRoles_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="انتخاب" ButtonType="Button" />
                        <asp:TemplateField HeaderText="نام کاربر">
                            <ItemTemplate>
                                <asp:Label ID="lblUserName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="میزان دسترسی">
                            <ItemTemplate>
                                <asp:Label ID="lblRoleName" runat="server" Text='<%# Bind("RoleName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <br />
    <table>
        <tr>
            <td style="width: 60px;">نام کاربر : 
            </td>
            <td>
                <asp:TextBox ID="txt_UserToFillFormer" runat="server"></asp:TextBox>
            </td>
            <td style="padding-right: 15px;">
                <asp:Button ID="btnAddUserToFillFormer" runat="server" Text="منع دسترسی" OnClientClick="return  confirm_Admin_Revoke()" OnClick="btnAddUserToFillFormer_Click" />
            </td>
        </tr>

    </table>
    <p>
        به منظور منع سطح دسترسی مدیریت ارشد ، ردیف مورد نظر را از-لیست کاربران ارشد- انتخاب نموده و سپس بر روی دکمه - منع دسترسی - کلیک کنید . 
                
         
    </p>
    <hr />

    <script type="text/javascript">
        function confirm_delete1() {
            alert("شما نمیتوانید کاربر مدیر سایت را حذف کنید");
            return false;

        }
        function confirm_delete() {
            if (confirm("آیا برای حذف این کاربر اطمینان دارید؟ ") == true)
                return true;
            else
                return false;
        }
        function confirm_Admin_Grant() {
            var txtUserClientID = '<%=this.txtUser.ClientID%>';
            var txtUser = document.getElementById(txtUserClientID);
            if (txtUser.value.length < 1) {
                alert('وارد کردن نام کاربری  یا انتخاب سطر از لیست  کاربران الزامی است.');
                return false;
            }
            if (confirm("آیا از اختصاص دسترسی ارشداطمینان دارید؟ ") == true)
                return true;
            else {

                txtUser.value = "";
                return false;
            }
        }
        function confirm_Admin_Revoke() {
            var txt_UserToFillFormerClientID = '<%=this.txt_UserToFillFormer.ClientID%>';
            var txt_UserToFill = document.getElementById(txt_UserToFillFormerClientID);
            if (txt_UserToFill.value.length < 1) {
                alert('وارد کردن نام کاربری یا انتخاب سطر از لیست کاربران ارشد الزامی است.');
                return false;
            }
            if (confirm("آیا از منع دسترسی ارشد اطمینان دارید؟ ") == true)
                return true;
            else {
                txt_UserToFill.value = "";
                return false;
            }
        }
        function check_CodePersonel() {
            var id = '<%=this.txtCodePerson.ClientID%>';
            var CodePersonel = document.getElementById(id);

            if (isNaN(CodePersonel.value) || CodePersonel.value.length < 4) {
                alert(' برای جستجو براساس شماره پرسنلی ، لطفا یک عدد حداقل 4 رقمی وارد کنید ');
                CodePersonel.value = "";
                return false;
            }
            else {
                return true;
            }
        }
    </script>
</asp:Content>

