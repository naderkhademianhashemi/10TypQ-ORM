<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="GroupAdminSetting.aspx.cs" 
    Inherits="Admin_GroupAdminSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <h3>تعیین کابران ارشد در گروه
        <asp:Label ID="lblGruop" runat="server" Font-Names="Tahoma" Font-Size="12pt"
            ForeColor="#0099FF"></asp:Label>
    </h3>
    <hr />


    <table>

        <tr>
            <td style="width: 150px;">نام کاربر 

            </td>

            <td>
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>

            </td>

            <td align="left">
                <asp:Button ID="btnSearch" OnClick="btnSearch_Click" 
                   OnClientClick="return check_txtUser();"  runat="server" Text="جستجو" />

            </td>
        </tr>
        <tr>
            <td style="width: 150px;">شماره پرسنلی
            </td>
            <td>
                <asp:TextBox ID="txtCodePerson" runat="server"></asp:TextBox>

            </td>
            <td align="left">

                <asp:Button ID="btnSearchCodePerson" OnClick="btnSearchCodePerson_Click"
                    OnClientClick="return check_CodePersonel();"
                    runat="server" Text="جستجو" />
            </td>

        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="btnUserSetting" OnClick="btnUserSetting_Click"
                    runat="server">
                    <asp:Label ID="lblUserSetting" runat="server">

                    </asp:Label>
                </asp:LinkButton></td>
            <td>
                <asp:LinkButton ID="btnFormSetting" OnClick="btnFormSetting_Click"
                    runat="server">
                    <asp:Label ID="lblFormSetting" runat="server">

                    </asp:Label>
                </asp:LinkButton></td>
            <td align="left"><a href="AddGroup.aspx">کلیه عملیات گروه</a></td>
        </tr>
    </table>


    <h3>لیست کاربران گروه
    <asp:Label ID="lblGroup2" runat="server" Font-Names="Tahoma" Font-Size="12pt"
        ForeColor="#0099FF"></asp:Label>
    </h3>

    <asp:GridView ID="GridView1" runat="server"
        BackColor="White" BorderColor="#999999"
        BorderStyle="Solid" BorderWidth="1px" CellPadding="3"
        AutoGenerateColumns="False"
        OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit"
        OnRowUpdating="GridView1_RowUpdating"
        EmptyDataText="اطلاعاتی یافت نشد"
        AllowPaging="true"
        OnPageIndexChanging="GridView1_PageIndexChanging">

        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
        <Columns>
            <%-- cell 0 --%>
            <asp:TemplateField HeaderText="#">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <%-- cell 1  --%>
            <asp:TemplateField HeaderText="شماره پرسنلی">
                <ItemTemplate>
                    <asp:Label ID="lblShomarehPersenely" runat="server"
                        Text='<%# Bind("ShomarehPersenely") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%-- cell 2 --%>
            <asp:TemplateField HeaderText="نام کاربر">
                <ItemTemplate>
                    <asp:Label ID="lblUserName" runat="server"
                        Text='<%# Bind("User_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%-- cell 3 --%>
            <asp:TemplateField HeaderText="نام و نام خانوادگی">
                <ItemTemplate>
                    <asp:Label ID="lblFullName" runat="server"
                        Text='<%# Bind("FullName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%--cell 4--%>
            <asp:TemplateField HeaderText="سمت">
                <ItemTemplate>
                    <asp:Label ID="lblSemat" runat="server"
                        Text='<%# Bind("Semat") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%--cell 5--%>
            <asp:TemplateField HeaderText="کاربر ارشد">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="ویرایش" />
                    <asp:CheckBox ID="cbSelect" runat="server" Enabled="false"
                        Checked='<%# Bind("IsAdmin") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="لغو" />
                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="تایید" />
                    <asp:CheckBox ID="cbSelect" runat="server" Checked='<%# Bind("IsAdmin") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>

        
    </asp:GridView>



    <script type="text/javascript">
        UsersInGroups();
        function UsersInGroups() {
            var grd = document.getElementById('<%=this.GridView1.ClientID%>');
            var Inputs = grd.getElementsByTagName('input');
            for (var i = 0; i < Inputs.length; i++) {
                if (Inputs[i].type == 'checkbox' && Inputs[i].checked == true)
                    Inputs[i].parentNode.parentNode.parentNode.style.backgroundColor = "gold";
            }
        }

        function check_CodePersonel() {
            var id = '<%=this.txtCodePerson.ClientID%>';
            var CodePersonel = document.getElementById(id);

            if (isNaN(CodePersonel.value) || CodePersonel.value.length < 4 ||
                CodePersonel.value.length > 8) {
                alert(' برای جستجو براساس شماره پرسنلی ، لطفا یک عدد حداقل 4 رقمی وارد کنید ');
                CodePersonel.value = "";
                return false;
            }
            else 
                return true;
         
        }
        function check_txtUser() {
            var tmpId = '<%=this.txtUserName.ClientID%>';
           
            var tmpTxtUser = document.getElementById(tmpId);

            if (tmpTxtUser.value.length < 1) {
                alert('نام کاربری نامعتبر است.');
                return false;
            }
            else 
                return true;
            
        }

    </script>

</asp:Content>

