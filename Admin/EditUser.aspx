<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EditUser.aspx.cs" 
    Inherits="EditUser" Title="كاربران" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h3>ویرایش کاربر<asp:SqlDataSource ID="SqlDataSource_department" runat="server"
        ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
        SelectCommand="SELECT [DepID], [DepName] FROM [Department] where [DepID]&lt;&gt;0"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_state" runat="server"
            ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
            SelectCommand="SELECT [locid], [LocName] FROM [State] where  [locid]&lt;&gt;0"></asp:SqlDataSource>
    </h3>
    <br />
    <asp:GridView ID="GridView1" runat="server"
        AutoGenerateColumns="False" CellPadding="3" OnDataBound="GridView1_DataBound" BackColor="White"
        BorderColor="#999999" BorderStyle="None" BorderWidth="1px" AllowPaging="True">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="نام کاربری" />
            <asp:BoundField DataField="Email" HeaderText="آدرس الکترونیک" Visible="False" />
            <asp:BoundField HeaderText="نام استان" Visible="False" />
            <asp:BoundField HeaderText="نام دپارتمان" />
            <asp:BoundField HeaderText="نقش کاربر در سامانه" />
            <asp:CheckBoxField DataField="IsLockedOut" HeaderText="غیرفعال"
                InsertVisible="False" />
            <asp:BoundField HeaderText="سمت" />
            <asp:BoundField HeaderText="کد محل خدمت" />
            <asp:BoundField HeaderText="شرح محل خدمت" />
        </Columns>
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
    <br />
    <table border="0">
        <tr>
            <td align="right" style="width: 125px;">نام دپارتمان کاربر:
            </td>
            <td style="width: 179px;">
                <asp:DropDownList ID="DropDownList1" runat="server" Width="150px"
                    DataSourceID="SqlDataSource_department" DataTextField="DepName"
                    DataValueField="DepID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 125px;">
                <asp:Label ID="Label1" runat="server" Text="نام استان کاربر: " Visible="False"></asp:Label>
            </td>
            <td style="width: 179px;">
                <asp:DropDownList ID="DropDownList2" runat="server" Width="150px"
                    DataSourceID="SqlDataSource_state" DataTextField="LocName"
                    DataValueField="LocID" Visible="False">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 125px;">نحوه کاربری از سایت :
            </td>
            <td style="width: 179px">
                <asp:DropDownList ID="DropDownList3" runat="server" Width="150px">
                    <asp:ListItem Selected="True" Value="admin">کاربر مدیر سایت</asp:ListItem>
                    <asp:ListItem Value="FillFormer">کاربر پرکننده پرسشنامه ها</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 125px;">کاربر فعال بماند</td>
            <td style="width: 179px">
                <asp:CheckBox ID="chkSetActive" runat="server" Text=""
                    Width="100%" AutoPostBack="True" />
            </td>
        </tr>
        <tr>
            <td style="width: 125px" align="right">ویرایش اطلاعات 
                <asp:ImageButton ID="ImageButton1" ImageUrl="./images/edit.jpg" runat="server"
                    OnClick="ImageButton1_Click" />
            </td>
            <td style="width: 179px"></td>
        </tr>
    </table>





</asp:Content>

