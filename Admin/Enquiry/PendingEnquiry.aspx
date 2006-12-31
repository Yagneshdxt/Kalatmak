<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    CodeFile="PendingEnquiry.aspx.cs" Inherits="Admin_Enquiry_PendingEnquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        <span class="PageName">Enquiry List</span>
    </p>
    <table width="100%">
        <tr>
            <td>
                Enquiry ID:
                <asp:TextBox ID="txtOrderId" runat="server" />
            </td>
            <td>
                Product Name
                <asp:TextBox ID="txtProductName" runat="server" />
            </td>
            <td>
                User Name
                <asp:TextBox ID="txtUserName" runat="server" />
            </td>
            <td>
                User Email Id
                <asp:TextBox ID="txtEmailId" runat="server" />
            </td>
            <td>
                User Phone No
                <asp:TextBox ID="txtUserPhone" runat="server" />
            </td>
            <td>
                Status:
                <asp:DropDownList runat="server" ID="ddlStatusFil">
                    <asp:ListItem Text="--Select--" Value="--Select--" />
                    <asp:ListItem Text="Answered" Value="1" />
                    <asp:ListItem Text="UnAnswered" Value="0" />
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button Text="view" ID="btnview" OnClick="btnview_Click" runat="server" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdRootcat" runat="server" AutoGenerateColumns="false" PageSize="10"
        AllowPaging="true" Width="100%" OnPageIndexChanging="grdRootcat_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Enquiry Id">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("EnquiryId")%>' ID="lblEnquiryId" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Featured Image" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <div class="ImgContainer">
                        <asp:Image ImageUrl='<%#Eval("ImagePath") %>' ID="ImgProdImg" runat="server" AlternateText='<%#Eval("ProductName") %>' />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product Name">
                <ItemTemplate>
                    <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("ProductName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="User Name">
                <ItemTemplate>
                    <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("Uname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="User Contact">
                <ItemTemplate>
                    <asp:Label ID="lblEmailID" runat="server" Text='<%#Eval("UemailId")%>'></asp:Label><br />
                    <asp:Label ID="lblContactNo" runat="server" Text='<%#Eval("UContactNo")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Enquiry Date">
                <ItemTemplate>
                    <asp:Label ID="lblenquiryDt" Text='<%# Eval("enquiryDt") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblisAnswered" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                    <asp:HiddenField ID="hdnisAnswered" Value='<%# Eval("isAnswered") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkAnswered" runat="server" Text='<%# Eval("isAnswered").ToString() == "True"? "UnAnswered" : "Answered" %>'
                        OnClick="lnkAnswered_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
