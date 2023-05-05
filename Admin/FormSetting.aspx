<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FormSetting.aspx.cs"
    Inherits="FormSetting" Title="كاربران" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript">
        function RSelectAll(CheckBox) {
            TotalChkBx = parseInt('<%= this.GridView1.Rows.Count %>');
            var TargetBaseControl = document.getElementById('<%= this.GridView1.ClientID %>');
            var TargetChildControl = "cbR";
            var Inputs = TargetBaseControl.getElementsByTagName("input");
            for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                    Inputs[iCount].checked = CheckBox.checked;
            }
        }
        function DSelectAll(CheckBox) {
            TotalChkBx = parseInt('<%= this.GridView1.Rows.Count %>');
            var TargetBaseControl = document.getElementById('<%= this.GridView1.ClientID %>');
            var TargetChildControl = "cbD";
            var Inputs = TargetBaseControl.getElementsByTagName("input");
            for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                    Inputs[iCount].checked = CheckBox.checked;
            }
        }
        function USelectAll(CheckBox) {
            TotalChkBx = parseInt('<%= this.GridView1.Rows.Count %>');
            var TargetBaseControl = document.getElementById('<%= this.GridView1.ClientID %>');
            var TargetChildControl = "cbU";
            var Inputs = TargetBaseControl.getElementsByTagName("input");
            for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                    Inputs[iCount].checked = CheckBox.checked;
            }
        }
        function WSelectAll(CheckBox) {
            TotalChkBx = parseInt('<%= this.GridView1.Rows.Count %>');
     var TargetBaseControl = document.getElementById('<%= this.GridView1.ClientID %>');
     var TargetChildControl = "cbW";
     var Inputs = TargetBaseControl.getElementsByTagName("input");
     for (var iCount = 0; iCount < Inputs.length; ++iCount) {
         if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
             Inputs[iCount].checked = CheckBox.checked;
     }
 }
    </script>


    <h3>تعیین فرم های گروه
    <asp:Label ID="lblGroup" runat="server" Font-Names="Tahoma" Font-Size="12pt"
        ForeColor="#0099FF"></asp:Label>
    </h3>
    <hr />

    <table>
        <tr>
            <td style="width: 150px;">
                <asp:LinkButton ID="btnUserSetting" OnClick="btnUserSetting_Click"
                    runat="server">
                    <asp:Label ID="lblUserSetting" runat="server">

                    </asp:Label>
                </asp:LinkButton></td>
            <td style="width: 150px;">
                <asp:LinkButton ID="btnAdminSetting" OnClick="btnAdminSetting_Click"
                    runat="server">
                    <asp:Label ID="lblAdminSetting" runat="server"> </asp:Label>
                </asp:LinkButton></td>
            <td ><a href="AddGroup.aspx">کلیه عملیات گروه</a></td>
        </tr>
    </table>

    <h3>لیست فرم ها</h3>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
        OnDataBound="GridView1_DataBound" BackColor="White" BorderColor="#999999"
        BorderStyle="Solid" BorderWidth="1px" CellPadding="3">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <Columns>

            <asp:TemplateField>
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="False">

                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("FormID") %>'></asp:Label>
                </ItemTemplate>

            </asp:TemplateField>

            <asp:TemplateField HeaderText="نام فرم">

                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("FormName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="خواندن" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:CheckBox ID="cbR" runat="server" />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="RSelectAll" runat="server" onclick="RSelectAll(this);" Text="خواندن" />
                </HeaderTemplate>

                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="نوشتن" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:CheckBox ID="cbW" runat="server" />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="WSelectAll" runat="server" onclick="WSelectAll(this);" Text="نوشتن" />
                </HeaderTemplate>

                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="بروزرساني" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:CheckBox ID="cbU" runat="server" />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="USelectAll" runat="server" onclick="USelectAll(this);" Text="به روز رسانی" />
                </HeaderTemplate>

                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="حذف" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:CheckBox ID="cbD" runat="server" />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="DSelectAll" runat="server" onclick="DSelectAll(this);" Text="حذف" />
                </HeaderTemplate>

                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="طراحی سوال" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:CheckBox ID="cbAddQuestion" runat="server" />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="addSelectAll" runat="server" onclick="addSelectAll(this);" Text="طراحی سوال" />
                </HeaderTemplate>

                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="مشاهده پاسخ های دیگران" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:CheckBox ID="cbReadOtherAnswers" runat="server" />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="readSelectAll" runat="server" onclick="readSelectAll(this);" Text="مشاهده پاسخ های دیگران" />
                </HeaderTemplate>

                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </asp:TemplateField>
        </Columns>
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
    <br />
    <asp:Button ID="btnSave" runat="server" Font-Names="Tahoma" Font-Size="8pt" Text="ثبت تغييرات" OnClick="btnSave_Click" />
</asp:Content>

