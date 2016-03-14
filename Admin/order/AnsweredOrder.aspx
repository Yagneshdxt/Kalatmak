<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="AnsweredOrder.aspx.cs" Inherits="Admin_order_AnsweredOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <span class="PageName">Delivery Status</span>
    </p>
    <table width="100%">
        <tr>
            <td>
                Order ID:
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
                <asp:Button Text="view" ID="btnview" OnClick="btnview_Click" runat="server" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdRootcat" runat="server" AutoGenerateColumns="false" PageSize="10"
        Width="100%" OnPageIndexChanging="grdRootcat_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Order Id">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("orderID")%>' ID="lblOrdId" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Featured Image" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <div class="ImgContainer">
                        <asp:Image ImageUrl='<%#Eval("prodImg") %>' ID="ImgProdImg" runat="server" AlternateText='<%#Eval("ProductName") %>' />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product Name">
                <ItemTemplate>
                    <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("ProductName") %>'></asp:Label>
                    -- Price Rs.<asp:Label ID="lblProductPrice" runat="server" Text='<%#Eval("prodPrice") %>'></asp:Label>
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
            <asp:TemplateField HeaderText="Shipping Address">
                <ItemTemplate>
                    Add:-
                    <asp:Label ID="lblAddress" Text='<%# Eval("UAddress") %>' runat="server" /><br />
                    State:-
                    <asp:Label ID="lblState" Text='<%# Eval("StateName") %>' runat="server" />
                    <br />
                    Pin :-
                    <asp:Label ID="lblPinNo" Text='<%# Eval("UPinNo") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Order Qty">
                <ItemTemplate>
                    <asp:Label ID="lblOrQty" Text='<%# Eval("UOrderQty") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Order Date">
                <ItemTemplate>
                    <asp:Label ID="lblOrDt" Text='<%# Eval("orDt") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblDelivered" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                    <asp:HiddenField ID="hdnIsdelevered" Value='<%# Eval("isDelivered") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDelivered" runat="server" OnClick="lnkDelivered_Click" Text='<%# Eval("isDelivered").ToString() == "True"? "Undeliver" : "Deliver" %>'></asp:LinkButton>
                    <asp:LinkButton ID="lnkDelete" runat="server" OnClick="lnkDelete_Click" Text="Delete" OnClientClick="return confirm('Do you want to delete?')"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

