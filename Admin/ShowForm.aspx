<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ShowForm.aspx.cs" Inherits="ShowForm" Title="پرسشنامه" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        function IsNumeric(obj) {
            var sText = obj.value;
            var ValidChars = "0123456789";
            var ValidChars1 = ".";
            var IsNumber = true;
            var Char;
            var numdot = 0;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);
                if (ValidChars.indexOf(Char) == -1 && ValidChars1.indexOf(Char) == -1) {
                    IsNumber = false;
                }
                if (ValidChars1.indexOf(Char) >= 0)
                    numdot++;
            }
            if (numdot > 1)
                IsNumber = false;
            return IsNumber;
        }
        function Check_Click(objRef) {
            //Get the Row based on checkbox
            var row = objRef.parentNode.parentNode;
            if (objRef.checked) {
                //If checked change color to Aqua
                row.style.backgroundColor = "gold";
            }
            else {
                //If not checked change back to original color
                if (row.rowIndex % 2 == 0) {
                    //Alternating Row Color
                    row.style.backgroundColor = "#E7E7FF";
                }
                else {
                    row.style.backgroundColor = "#F7F7F7";
                }

            }

            //Get the reference of GridView
            var GridView = row.parentNode;

            //Get all input elements in Gridview
            var inputList = GridView.getElementsByTagName("input");

            for (var i = 0; i < inputList.length; i++) {
                //The First element is the Header Checkbox
                var headerCheckBox = inputList[0];

                //Based on all or none checkboxes
                //are checked check/uncheck Header Checkbox
                var checked = true;
                if (inputList[i].type == "checkbox" && inputList[i] != headerCheckBox) {
                    if (!inputList[i].checked) {
                        checked = false;
                        break;
                    }
                }
            }
            headerCheckBox.checked = checked;

        }
        function checkAll(objRef) {
            //chkSelectAll

            var inputList = $('input[id$=Chk01]');

            for (var i = 0; i < inputList.length; i++) {
                //Get the Cell To find out ColumnIndex
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {
                        //If the header checkbox is checked
                        //check all checkboxes
                        //and highlight all rows
                        row.style.backgroundColor = "gold";
                        inputList[i].checked = true;
                    }
                    else {
                        //If the header checkbox is checked
                        //uncheck all checkboxes
                        //and change rowcolor back to original 
                        if (row.rowIndex % 2 == 0) {
                            //Alternating Row Color
                            row.style.backgroundColor = "#E7E7FF";
                        }
                        else {
                            row.style.backgroundColor = "#F7F7F7";
                        }
                        inputList[i].checked = false;
                    }
                }
            }
        }

        function checkAll_Form_Instance(objRef) {

            var inputList = $('input[id$=chk_Form_Instance]');
            for (var i = 0; i < inputList.length; i++) {
                //Get the Cell To find out ColumnIndex
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {
                        //If the header checkbox is checked
                        //check all checkboxes
                        //and highlight all rows
                        row.style.backgroundColor = "gold";
                        inputList[i].checked = true;
                    }
                    else {
                        //If the header checkbox is checked
                        //uncheck all checkboxes
                        //and change rowcolor back to original 
                        if (row.rowIndex % 2 == 0) {
                            //Alternating Row Color
                            row.style.backgroundColor = "#E7E7FF";
                        }
                        else {
                            row.style.backgroundColor = "#F7F7F7";
                        }
                        inputList[i].checked = false;
                    }
                }
            }
        }

        function MouseEvents(objRef, evt) {
            var checkbox = objRef.getElementsByTagName("input")[0];
            if (evt.type == "mouseover") {
                objRef.style.backgroundColor = "brown";
            }
            else {
                if (checkbox.checked) {
                    objRef.style.backgroundColor = "gold";
                }
                else if (evt.type == "mouseout") {
                    if (objRef.rowIndex % 2 == 0) {
                        //Alternating Row Color
                        objRef.style.backgroundColor = "#E7E7FF";
                    }
                    else {
                        objRef.style.backgroundColor = "#F7F7F7";
                    }

                }
            }
        }
    </script>



    <asp:Label ID="Label4" runat="server" Font-Size="10.5pt" ForeColor="#3366FF" Text="مشاهده پاسخ های داده شده به پرسشنامه"></asp:Label>
    <br />
    <hr />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>


    <table style="width: 100%;" cellspacing="0px">
        <tr>
            <td style="width: 150px;">انتخاب فرم :
            </td>
            <td>
                <asp:DropDownList ID="tblname" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
                    DataTextField="Form_Name" DataValueField="Form_ID" OnDataBound="tblname_DataBound"
                    OnSelectedIndexChanged="tblname_SelectedIndexChanged" Width="277px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                    SelectCommand="SELECT [Form_ID], [Form_Name] FROM [Forms]"></asp:SqlDataSource>
                <asp:CheckBox ID="chkSearch" runat="server" __designer:wfdid="w6"
                    AutoPostBack="True"
                    Text="جستجو در سوالها" Width="100%"
                    OnCheckedChanged="Dep_selectall_CheckedChanged" />
            </td>
        </tr>
        <tr>
            <td style="width: 150px; height: 6px;">انتخاب سوال : 
            </td>
            <td align="right">
                <asp:DropDownList ID="WhereColname" runat="server" Width="276px" OnDataBound="WhereColname_DataBound"
                    OnSelectedIndexChanged="Wherecolname_SelectedIndexChanged"
                    AutoPostBack="True" Height="24px" Style="margin-top: 0px">
                </asp:DropDownList>
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:MultiView ID="WhereView" runat="server" ActiveViewIndex="0">
                    <asp:View ID="NVarChar" runat="server">
                        <table cellspacing="0px" style="width: 100%;">
                            <tr>
                                <td style="width: 150px;">شرط مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherecondopNvar" runat="server" Width="125px">
                                        <asp:ListItem Value="=">برابر با</asp:ListItem>
                                        <asp:ListItem Value="&lt;&gt;">نا مساوی </asp:ListItem>
                                        <asp:ListItem Value="Like">شباهت </asp:ListItem>
                                        <asp:ListItem Value="NOT Like">عدم شباهت</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;">مقدار براي مقايسه :
                                </td>
                                <td>
                                    <asp:TextBox ID="WherevalueNvar" runat="server" CssClass="textboxlrt" ValidationGroup="addcond"
                                        Width="125px"></asp:TextBox><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="WherevalueNvar"
                                        Display="Dynamic" ErrorMessage="این فیلد را خالی نگذارید." ValidationGroup="addcond"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="Num" runat="server">
                        <table cellspacing="0px" style="width: 100%;">
                            <tr>
                                <td style="width: 150px;">مقدار براي مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherecondopNum" runat="server" Width="125px">
                                        <asp:ListItem Value="=">برابر با</asp:ListItem>
                                        <asp:ListItem Value="&lt;&gt;">نا مساوی با</asp:ListItem>
                                        <asp:ListItem Value="&gt;">بزرگتر از</asp:ListItem>
                                        <asp:ListItem Value="&lt;">کوچکتر از</asp:ListItem>
                                        <asp:ListItem Value="&gt;=">بزرگتر مساوی با</asp:ListItem>
                                        <asp:ListItem Value="&lt;=">کوچکتر مساوی با </asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">شرط مقايسه :
                                </td>
                                <td>
                                    <asp:TextBox ID="WherevalueNum" runat="server" CausesValidation="True" CssClass="textboxlrt"
                                        ValidationGroup="addcond" Width="125px"></asp:TextBox><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="WherevalueNum"
                                        Display="Dynamic" ErrorMessage="این فیلد را خالی نگذارید." ValidationGroup="addcond"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                            ID="RegularExpressionValidator1" runat="server" ControlToValidate="WherevalueNum"
                                            Display="Dynamic" ErrorMessage="لطفاً عدد وارد کنید." ValidationExpression="^-?(\d+(.\d*)*|.\d+)$"
                                            ValidationGroup="addcond"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="Date" runat="server">
                        <table cellspacing="0px" style="width: 100%;">
                            <tr>
                                <td style="width: 150px;">شرط مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherecondopDate" runat="server" Width="125px">
                                        <asp:ListItem Value="=">برابر با</asp:ListItem>
                                        <asp:ListItem Value="&lt;&gt;">نا مساوی با</asp:ListItem>
                                        <asp:ListItem Value="&gt;">بزرگتر از</asp:ListItem>
                                        <asp:ListItem Value="&lt;">کوچکتر از</asp:ListItem>
                                        <asp:ListItem Value="&gt;=">بزرگتر مساوی با </asp:ListItem>
                                        <asp:ListItem Value="&lt;=">کوچکتر مساوی با</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">مقدار براي مقايسه :
                                </td>
                                <td>
                                    <pdc:PersianDateScriptManager ID="PersianDateScriptManager" runat="server"
                                        CalendarDayWidth="50" FooterCSS="PickerFooterCSS"
                                        ForbidenCSS="PickerForbidenCSS" ForbidenWeekDays="6" FrameCSS="PickerCSS"
                                        HeaderCSS="PickerHeaderCSS" SelectedCSS="PickerSelectedCSS"
                                        WeekDayCSS="PickerWeekDayCSS" WorkDayCSS="PickerWorkDayCSS">
                                    </pdc:PersianDateScriptManager>
                                    <pdc:PersianDateTextBox ID="WherevalueDate" runat="server" CausesValidation="True"
                                        CssClass="textboxlrt" DefaultDate="1363/10/22" IconUrl="~/images/cal.gif"
                                        SetDefaultDateOnEvent="OnClick" ValidationGroup="addcond" Width="125px"
                                        ShowPickerOnEvent="OnClick" ShowPickerOnTop="True" />
                                    <asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator3" runat="server" ControlToValidate="WherevalueDate"
                                        Display="Dynamic" ErrorMessage="این فیلد را خالی نگذارید." ValidationGroup="addcond">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator2" runat="server" ControlToValidate="WherevalueDate"
                                        Display="Dynamic" ErrorMessage="لطفاً تاریخ شمسی وارد کنید" ValidationExpression="1(3|4)\d{2}/\d{2}/\d{2}"
                                        ValidationGroup="addcond"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="List" runat="server">
                        <table cellspacing="0px" style="width: 100%;">
                            <tr>
                                <td style="width: 150px; height: 22px;">شرط مقايسه :
                                </td>
                                <td style="height: 22px">
                                    <asp:DropDownList ID="WherecondopList" runat="server" Width="125px">
                                        <asp:ListItem Value="=">برابر با </asp:ListItem>
                                        <asp:ListItem Value="&lt;&gt;">نامساوی با</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">مقدار براي مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherevalueList" runat="server" ValidationGroup="1"
                                        Width="125px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="locView1" runat="server">
                        <table cellspacing="0px" style="width: 100%;">
                            <tr>
                                <td style="width: 150px;">شرط مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherecondopLoc" runat="server" Width="125px">
                                        <asp:ListItem Value="=">برابر با</asp:ListItem>
                                        <asp:ListItem Value="&lt;&gt;">نا مساوی با</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">مقدار براي مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherevalueLoc" runat="server" DataSourceID="SqlDataSource2"
                                        DataTextField="LocName" DataValueField="locid" ValidationGroup="1" Width="125px">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                                        SelectCommand="SELECT [locid], [LocName] FROM [State] where [locid]&lt;&gt;0"></asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="branchview" runat="server">
                        <table cellspacing="0px" style="width: 100%;">
                            <tr>
                                <td style="width: 150px;">شرط مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherecondopBranch" runat="server" Width="125px">
                                        <asp:ListItem Value="=">برابر با</asp:ListItem>
                                        <asp:ListItem Value="&lt;&gt;">نا مساوی با</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">مقدار براي مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherevalueBranch" runat="server" DataSourceID="SqlDataSource6"
                                        DataTextField="BranchName" DataValueField="BID" ValidationGroup="1" Width="125px">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource6" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                                        SelectCommand="SELECT convert(nvarchar,[Branch]) +' - ' +  [BranchName] as BranchName , [BID] FROM [Branch] where BID&lt;&gt;0"></asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="DepView" runat="server">
                        <table cellspacing="0px" style="width: 100%;">
                            <tr>
                                <td style="width: 150px;">شرط مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherecondopDep" runat="server" Width="125px">
                                        <asp:ListItem Value="=">مساوی با</asp:ListItem>
                                        <asp:ListItem Value="&lt;&gt;">نا مساوی با</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px;">مقدار براي مقايسه :
                                </td>
                                <td>
                                    <asp:DropDownList ID="WherevalueDep" runat="server" DataSourceID="SqlDataSource7"
                                        DataTextField="DepName" DataValueField="DepID" ValidationGroup="1"
                                        Width="125px">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource7" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:ORM_ConnectionString %>"
                                        SelectCommand="SELECT [DepID], [DepName] FROM [Department] WHERE ([DepID] &lt;&gt; @DepID)">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="0" Name="DepID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                </asp:MultiView>
            </td>
        </tr>

        <tr>
            <td style="width: 150px">&nbsp;</td>
            <td>

                <asp:Button Text="جستجو" ID="btnSearchAnswers" runat="server"
                    OnClick="btnSearchAnswers_Click"
                    ToolTip="Alt + S"
                    AccessKey="S" />

                <asp:Button ID="btnXML_Save" Text="XML" runat="server"
                    OnClick="btnXML_Save_Click"
                    AccessKey="X"
                    ToolTip="Alt + X"
                    OnClientClick="return check_Grid()" />

            </td>
        </tr>
    </table>

    <h4>اخذ خروجی پاسخ های اخیر براساس تعداد سطر</h4>
    <hr />

    <table>

        <tr>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td>تعداد سطر خروجی 
                    
            </td>
            <td>
                <asp:TextBox ID="txtCount" runat="server" MaxLength="3" Text="10"></asp:TextBox>
                <asp:Button ID="btnXMLTop" Text="XML" runat="server"
                    OnClick="btnXMLTop_Click" />

            </td>
        </tr>
        <tr>
            <td style="width: 150px">&nbsp;</td>
            <td>به منظور اخذ خروجی با تعداد سطر بالا می بایستی منتظر بمانید  
            </td>
        </tr>
        <tr>
            <td style="width: 100px;">از تاریخ 
            </td>
            <td>
                <input type="text" id="txtFromDate" class="persianDate" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="width: 100px;">تا تاریخ
            </td>
            <td>
                <input type="text" id="txtToDate" class="persianDate" runat="server" />
                <asp:Button ID="btnSearchBetweenDates" Text="جستجو" runat="server"
                     OnClick="btnSearchBetweenDates_Click" />
                <asp:Button ID="btnXmlBetweenDates" Text="XML" runat="server"
                    OnClick="btnXmlBetweenDates_Click" />
            </td>
        </tr>
    </table>

    <br />
    <%--<p>
        به منظور اخذ خروجی اکسل از نتایج پرسشنامه ها ، ابتدا سطری را از جدول پاسخ ها انتخاب کنید و سپس بر روی دکمه - خروجی اکسل - کلیک نمایید.
    </p>--%>
    <hr />

    <asp:Label ID="lblresult" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="9pt"
        ForeColor="#000099"></asp:Label>
    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
        <table style="width: 100%;">
            <tr>
                <td style="width: 256px; margin-right: 40px; vertical-align: top;">
                    <asp:Panel ID="temp_Panel" runat="server" Visible="False">
                    </asp:Panel>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridView_Form_Instance" runat="server" AllowPaging="True"
                                AutoGenerateColumns="False" BackColor="White"
                                CellPadding="3"
                                OnPageIndexChanging="GridView_Form_Instance_PageIndexChanging"
                                OnRowCommand="GridView_Form_Instance_RowCommand"
                                OnRowDeleting="GridView_Form_Instance_RowDeleting"
                                EmptyDataText="موردي يافت نشد" Height="344px" Width="294px"
                                OnDataBound="GridView_Form_Instance_DataBound"
                                Visible="False">
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                <Columns>
                                    <%-- 0 --%>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkAll_Form_Instance" runat="server" onclick="checkAll_Form_Instance(this);" Text="انتخاب" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk_Form_Instance" runat="server" CssClass="firstColumnChk" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- 1 --%>
                                    <asp:TemplateField HeaderText="شناسه" SortExpression="Instance_ID"
                                        HeaderStyle-CssClass="displayNone" ItemStyle-CssClass="displayNone">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInstance_ID" Text='<%#Bind("Instance_ID") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- 2 --%>
                                    <asp:TemplateField HeaderText="نام كاربري" SortExpression="User_Name">
                                        <ItemTemplate>
                                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("User_name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="تاريخ ثبت" SortExpression="filldate">
                                        <ItemTemplate>
                                            <%-- <asp:Label ID="Label11" runat="server" Text='<%# Bind("filldate") %>'></asp:Label>--%>
                                            <asp:Label ID="lblFillDate" runat="server"
                                                Text='<%# OrmUtility.ConvertToShamsi(Eval("filldate").ToString()) %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="گزارش" SortExpression="Reported">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkSelectAll" runat="server" onclick="checkAll(this);" Text="گزارش" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="Chk01" runat="server" ToolTip='<%# Eval("Instance_ID")%>'
                                                Checked='<%#Eval("Reported").ToString()=="True"?true:false %>'></asp:CheckBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="نمايش جواب">
                                        <ItemTemplate>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="Button_Show_Answer" runat="server"
                                                            CausesValidation="False" CommandArgument='<%# Eval("Instance_ID") %>'
                                                            CommandName="Show_Instance" ImageUrl="~/images/down.gif" Text="پايين"
                                                            OnClick="Button_Show_Answer_Click1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="حذف">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButton_Delete" runat="server"
                                                CommandArgument='<%# Eval("Instance_ID") %>' CommandName="Delete"
                                                OnClientClick="return confirm('با حذف سطر مورد نظر كليه اطلاعات مربوط به اين فرم حذف خواهد شد.آيا مايل به ادامه كار هستيد؟')"
                                                ImageUrl="~/images/delete.jpg" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ويرايش">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButton_Edit" runat="server" CommandName="Edit"
                                                CommandArgument='<%# Eval("Instance_ID") %>'
                                                ImageUrl="~/images/edit.jpg" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                <SelectedRowStyle CssClass="RowSelected" BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <HeaderStyle CssClass="GridHeader" Font-Bold="True" ForeColor="#000000" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>
                            <asp:Button ID="Btn_Reported" runat="server" Font-Names="Tahoma"
                                Font-Size="8pt" OnClick="Btn_Reported_Click" Text="ثبت تغییرات"
                                Visible="False" />
                            <table>
                                <tr>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lblSearch" runat="server" Text="نام کاربر:" Visible="false"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSearch" runat="server" Text="" Visible="false"></asp:TextBox>
                                    </td>
                                    <td align="left">
                                        <asp:ImageButton ImageUrl="~/images/search.jpg" ID="btnSearch" runat="server"
                                            Font-Names="Tahoma" Font-Size="8pt" Text="جستجو" Visible="false" OnClick="btnSearch_Click" />
                                    </td>
                                </tr>
                            </table>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>

                    <%-- "GV" + Current_Question.Question_ID + "_" + Current_Question.Question_Index --%>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="panelHtmlForms" runat="server">
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 256px; height: 101px;">
                    <asp:GridView ID="GridView2" runat="server" Visible="False">
                    </asp:GridView>
                </td>
                <td style="height: 101px"></td>
            </tr>
            <tr>
                <td style="width: 256px">
                    <pdc:PersianDateScriptManager ID="PersianDateScriptManager0" runat="server"
                        CalendarDayWidth="50" FooterCSS="PickerFooterCSS"
                        ForbidenCSS="PickerForbidenCSS" ForbidenWeekDays="6" FrameCSS="PickerCSS"
                        HeaderCSS="PickerHeaderCSS" SelectedCSS="PickerSelectedCSS"
                        WeekDayCSS="PickerWeekDayCSS" WorkDayCSS="PickerWorkDayCSS">
                    </pdc:PersianDateScriptManager>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <br />
    </asp:Panel>

    <br />



    <script src="../jquery.min.js" type="text/javascript"></script>

    <script type="text/javascript">

        function check_Grid() {
            var chk_Form_InstanceArray = $('input[id$=chk_Form_Instance]');
            var messageAlert = 'به منظور گرفتن خروجی ، ابتدا می بایست سطری را از جدول پاسخ ها انتخاب کنید';

            var flagChecked = false;

            for (var i = 0; i < chk_Form_InstanceArray.length; i++) {
                if (chk_Form_InstanceArray[i].checked) {
                    flagChecked = true;
                }
            }

            if (flagChecked == false) {
                alert(messageAlert);
                return false;
            }
            else {
                return true;
            }
        }

        document.querySelector("input[id*='txtCount']").addEventListener("keypress", function (evt) {
            if (evt.which < 48 || evt.which > 57) {
                evt.preventDefault();
            }
        });

        $('input[type=text]').focus(function () {
            $(this).select();
        });

    </script>
</asp:Content>
