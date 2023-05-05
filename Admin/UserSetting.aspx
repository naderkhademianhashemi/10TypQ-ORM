<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UserSetting.aspx.cs" Inherits="UserSetting" Title="پرسشنامه" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">



    <h3>تعیین کاربران گروه
       <asp:Label ID="Label1" runat="server" Font-Names="Tahoma" Font-Size="12pt"
           ForeColor="#0099FF"></asp:Label>
    </h3>
    <hr />

    <table>

        <tr>
            <td style="width: 150px;">
                <asp:Label ID="lblSearch" runat="server"
                    Text="نام کاربری یا سمت کاربر :"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" Text="" Width="200px"></asp:TextBox>

            </td>
            <td align="left">
                <asp:ImageButton ImageUrl="~/images/search.jpg" ID="btnSearch"
                    runat="server"
                    Font-Names="Tahoma" Font-Size="8pt" Text="جستجو"
                    OnClick="btnSearch_Click" />
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
                <asp:ImageButton ImageUrl="~/images/search.jpg"
                    ID="ImgBtnCodePerson" runat="server"
                    Font-Names="Tahoma" Font-Size="8pt" Text="جستجو"
                    OnClick="ImgBtnCodePerson_Click"
                    OnClientClick=" return check_CodePersonel()" EnableViewState="false" />
            </td>
        </tr>

        <tr>
            <td>
                <asp:LinkButton ID="btnAdminSetting" OnClick="btnAdminSetting_Click"
                    runat="server">
                    <asp:Label ID="lblAdminSetting" runat="server"> </asp:Label>
                </asp:LinkButton></td>
            <td>
                <asp:LinkButton ID="btnFormSetting" OnClick="btnFormSetting_Click"
                    runat="server">
                    <asp:Label ID="lblFormSetting" runat="server">

                    </asp:Label>
                </asp:LinkButton></td>
            <td><a href="AddGroup.aspx">کلیه عملیات گروه</a></td>
        </tr>
    </table>



    <h3>لیست کلیه کاربران 
    </h3>
    <%-- GridView1.DataSource = [FG_DB].[dbo].[V_OLTP_PRSNL_FG_DB_GRP] --%>
    <asp:GridView ID="GridView1" runat="server"
        AutoGenerateColumns="False" BackColor="White" CellPadding="3" AllowPaging="true"
        OnDataBound="GridView1_DataBound"
        OnPageIndexChanging="GridView1_PageIndexChanging"
        OnRowEditing="GridView1_RowEditing"
        OnRowCancelingEdit="GridView1_RowCancelingEdit"
        OnRowUpdating="GridView1_RowUpdating">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
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
                        Text='<%#Bind("ShomarehPersenely") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%-- cell 2 --%>
            <asp:TemplateField HeaderText="نام کاربری">
                <ItemTemplate>
                    <asp:Label ID="lblUser_Name" runat="server"
                        Text='<%#Bind("UserName") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%-- cell 3 --%>
            <asp:TemplateField HeaderText="نام و نام خانوادگی">
                <ItemTemplate>
                    <asp:Label ID="lblFullName" runat="server"
                        Text='<%#Bind("FullName") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%-- cell 4 --%>
            <asp:TemplateField HeaderText="سمت">
                <ItemTemplate>
                    <asp:Label ID="lblSemat" runat="server"
                        Text='<%#Bind("Semat") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%-- cell 5 --%>
            <asp:TemplateField HeaderText="کد محل خدمت">
                <ItemTemplate>
                    <asp:Label ID="lblCodeService" runat="server"
                        Text='<%#Bind("CodeMahalKhedmat") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%-- cell 6--%>
            <asp:TemplateField HeaderText="محل خدمت">
                <ItemTemplate>
                    <asp:Label ID="lblService" runat="server"
                        Text='<%#Bind("MahalKhedmat") %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <%-- cell edit group users --%>
            <asp:TemplateField HeaderText="عضویت" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="تغییر عضویت" />
                    <asp:CheckBox ID="cbSelect" runat="server" Enabled="false" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="لغو" />
                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="تایید" />
                    <asp:CheckBox ID="cbSelect" runat="server" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
            <pagerstyle backcolor="#E7E7FF" forecolor="#4A3C8C" horizontalalign="Right" />
            <selectedrowstyle backcolor="#738A9C" font-bold="True" forecolor="#F7F7F7" />
            <headerstyle cssclass="GridHeader" font-bold="True" forecolor="#000000" />
            <alternatingrowstyle backcolor="#F7F7F7" />
    </asp:GridView>
    <br />
    <hr />
    <h3>تعیین کاربران گروه
        <asp:Label ID="lblGroup" runat="server" Font-Names="Tahoma" Font-Size="12pt"
            ForeColor="#0099FF"></asp:Label>
        براساس سمت کاربری
    </h3>

    <table>
        <tr>
            <td>
                <h3>سمت کاربر : </h3>
            </td>
            <td>
                <span>&nbsp;&nbsp;&nbsp;</span>
                <asp:TextBox runat="server" ID="txtSemat" Text="" Width="200px" />
            </td>
        </tr>
    </table>
    <br />
    <br />

    <asp:Button ID="btnAddMembers" runat="server" Text="اضافه کردن کاربران به گروه "
        OnClick="btnAddMembers_Click"
        OnClientClick="return confirm('آیا از سمت کاربری وارد شده اطمینان دارید ؟')" />

    <asp:Button runat="server" ID="btnRemoveMembers" Text="حذف کاربران از گروه "
        OnClick="btnRemoveMembers_Click"
        OnClientClick="return confirm('آیا از سمت کاربری وارد شده اطمینان دارید ؟')" />

    <hr />


    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
        ProviderName="System.Data.SqlClient"
        SelectCommand="select [User_Name],dbo.Group_Users.[Group_ID],[Group_Name] from dbo.Group_Users,dbo.Groups where dbo.Group_Users.[Group_ID] = dbo.Groups.[Group_ID] and [Group_Name] Like N' + @GroupName + '  and [User_Name] Like N'% + @UserName  + %'">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" PropertyName="Text" Name="UserName" DefaultValue="%" />
            <asp:Parameter Name="GroupName" DefaultValue="%" />
        </SelectParameters>
    </asp:SqlDataSource>
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

            if (isNaN(CodePersonel.value) || CodePersonel.value.length < 5 ||
                CodePersonel.value.length > 8) {
                alert('لطفا یک شماره پرسنلی معتبر وارد کنید  ');
                CodePersonel.value = "";
                return false;
            }
            else
                return true;

        }
    </script>
</asp:Content>

