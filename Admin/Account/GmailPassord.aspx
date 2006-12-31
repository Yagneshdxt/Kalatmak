<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    CodeFile="GmailPassord.aspx.cs" Inherits="Admin_Account_GmailPassord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table border="0">
        <tr>
            <td>
            </td>
            <td>
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="AdminLogin" ShowMessageBox="false"
                    DisplayMode="List" ForeColor="Red" HeaderText="" ShowSummary="true" />
                <asp:Label Text="" ID="lblMsg" ForeColor="Red" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                Gmail Id :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtEmail" MaxLength="100" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ErrorMessage="Please enter Email Id"
                    ControlToValidate="txtEmail" Display="Dynamic" ValidationGroup="AdminLogin" Text="*"
                    ForeColor="Red" runat="server" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Email Address Invalid"
                    ControlToValidate="txtEmail" runat="server" ValidationExpression="^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$"
                    Display="Dynamic" Text="*" ValidationGroup="AdminLogin" ForeColor="Red" ToolTip="Invalid email Addresss" />
            </td>
        </tr>
        <tr>
            <td>
                Update Gmail Password :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtPassword" MaxLength="100" TextMode="Password" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Please enter password"
                    ControlToValidate="txtPassword" Display="Dynamic" ValidationGroup="AdminLogin"
                    Text="*" ForeColor="Red" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnLogin" runat="server" Text="Update" OnClick="btnLogin_Click" CausesValidation="true"
                    ValidationGroup="AdminLogin" />
            </td>
        </tr>
    </table>
</asp:Content>
