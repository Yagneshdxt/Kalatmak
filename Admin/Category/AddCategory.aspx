<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    CodeFile="AddCategory.aspx.cs" Inherits="Admin_Category_AddCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <p>
        <span class="PageName">Category Add/Edit</span>
    </p>
    <table border="0" cellpadding="5" cellspacing="5">
        <tr>
            <td>
                Category Name
            </td>
            <td>
                <asp:TextBox ID="txtcategoryname" runat="server" MaxLength="98"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcategoryname"
                    ErrorMessage="Please enter Category Name" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator7" ErrorMessage="Please do not enter special character for Name"
                    ControlToValidate="txtcategoryname" runat="server" ValidationExpression="^[a-zA-Z''_'\s]{1,100}$"
                    Display="Dynamic" Text="*" ValidationGroup="btnadd" ForeColor="Red" ToolTip="Numeric" />--%>
            </td>
        </tr>
        <tr>
            <td>
                Sequence No
            </td>
            <td>
                <asp:TextBox ID="txtSeqNo" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ErrorMessage="Please enter Numeric in Sequence No"
                    ControlToValidate="txtSeqNo" runat="server" ValidationExpression="^\d{1,9}?$"
                    Display="Dynamic" ValidationGroup="btnadd" ToolTip="Numeric" Text="*" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:RadioButton ID="radioactive" runat="server" Text="Active" Checked="True" GroupName="act" />
                <asp:RadioButton ID="radiodeactive" runat="server" Text="Deactive" GroupName="act" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Add" OnClick="btnSubmit_Click" CausesValidation="true"
                    ValidationGroup="btnadd" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"
                    CausesValidation="true" ValidationGroup="btnadd" Visible="false" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                    Visible="false" />
                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnadd" ShowMessageBox="true"
                    DisplayMode="List" HeaderText="Add Category Error" ShowSummary="false" />
            </td>
        </tr>
    </table>
    <p>
    </p>
    <table width="100%">
        <tr>
            <td>
                Root Category Name:
                <asp:TextBox ID="txtProductID" runat="server" />
            </td>
            <td>
                Seq No:
                <asp:TextBox ID="txtViewSeq" runat="server" />
            </td>
            <td>
                Status:
                <asp:DropDownList runat="server" ID="ddlStatusFil">
                    <asp:ListItem Text="--Select--" Value="--Select--" />
                    <asp:ListItem Text="Active" Value="1" />
                    <asp:ListItem Text="InActive" Value="0" />
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button Text="view" ID="btnview" OnClick="btnview_Click" runat="server" />
            </td>
            <td>
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdRootcat" runat="server" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
        Width="100%" OnPageIndexChanging="grdRootcat_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Category Name">
                <ItemTemplate>
                    <asp:Label ID="lblrootcatnmae" runat="server" Text='<%#Eval("CategoryName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sequence No.">
                <ItemTemplate>
                    <asp:Label ID="lblSeqNo" runat="server" Text='<%#Eval("SeqNo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblactive" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                    <asp:HiddenField ID="hdnactiveflag" Value='<%# Eval("IsActive") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Edit">
                <ItemTemplate>
                    <asp:LinkButton Text="Edit" ID="lnkEdit" runat="server" OnClick="lnkEdit_Click" />
                    <asp:LinkButton Text="Delete" ID="lnkDelete" runat="server" OnClick="lnkDelete_Click"
                        OnClientClick="Javascript:return confirm('Do you want to delete?');" />
                    <asp:HiddenField ID="hdnRootCategorID" Value='<%# Eval("CategoryID") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="hdrootid" runat="server" />
</asp:Content>
