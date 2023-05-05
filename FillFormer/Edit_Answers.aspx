<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Edit_Answers.aspx.cs" Inherits="Edit_Answers" Title="پرسشنامه" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script language="javascript" type= "text/javascript">
    function moneyCommaSep(ctrl)
{
  var separator = ",";
  var int = ctrl.value.replace ( new RegExp ( separator, "g" ), "" );
  var regexp = new RegExp ( "\\B(\\d{3})(" + separator + "|$)" );
  do
  {
    int = int.replace( regexp, separator + "$1" );
  }
  while ( int.search ( regexp ) >= 0 )
  ctrl.value = int;
}

function removeComma(ctrl)
{
  var separator = ",";
  
  ctrl.value = ctrl.value.replace ( new RegExp ( separator, "g" ), "" );
}

      </script>
    <div style ="text-align:right ;">
        <br />
    <asp:Label ID="lblFname" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="12pt"
        ForeColor="Blue"></asp:Label>
        <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server" >
    </asp:ScriptManager>
    <asp:Panel ID="Panel1" runat="server" Direction="RightToLeft">
    </asp:Panel>
        <asp:Label ID="ValidityText" runat="server"></asp:Label>
    <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
    <asp:Label ID="lblType" runat="server" ForeColor="Red" Visible="False"></asp:Label>&nbsp;<asp:Label
        ID="Label2" runat="server" Text="" Visible="False"></asp:Label>
        <br />
    <asp:Button ID="Button1" runat="server" Font-Names="Tahoma" Font-Size="9pt" OnClick="Button1_Click1"
        Style="height: 26px" Text="ويرايش پاسخ"  />
        <pdc:PersianDateScriptManager ID="PersianDateScriptManager" runat="server" 
            CalendarDayWidth="50" FooterCSS="PickerFooterCSS" ForbidenCSS="PickerForbidenCSS"
             ForbidenWeekDays="6" FrameCSS="PickerCSS"
            HeaderCSS="PickerHeaderCSS" SelectedCSS="PickerSelectedCSS" WeekDayCSS="PickerWeekDayCSS"
            WorkDayCSS="PickerWorkDayCSS"></pdc:PersianDateScriptManager>

</div>
</asp:Content>

