<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Version1_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="homePgCont">
        <ul class="hpParentUl">
            <asp:Repeater runat="server" ID="rptCategory" OnItemDataBound="rptCategory_ItemDataBound">
                <ItemTemplate>
                    <li><a href='<%# "Product/DisplayProduct.aspx?catID=" + Eval("CategoryID") %>' runat="server">
                        <%# Eval("CategoryName")%>
                    </a>
                        <asp:HiddenField ID="hdnCatId" runat="server" Value='<%# Eval("CategoryID") %>' />
                        <div class="clsLstWrap">
                            <div class="HpprodList">
                                <asp:Repeater runat="server" ID="rptProducts">
                                    <ItemTemplate>
                                        <div class="hpProdContainer">
                                            <a id="A1" href='<%# ResolveUrl("~/Product/ProductDetail/"+ Eval("ProductName") + "_" + Eval("ProductID")) %>'>
                                                <div class="prLstImgCont">
                                                    <div class="dummy">
                                                    </div>
                                                    <div class="prodImg">
                                                        <div class="Imgdummy">
                                                        </div>
                                                        <asp:Image ID="Image1" ImageUrl='<%# Eval("thumNailImgPath") %>' AlternateText='<%# Eval("ProductName") %>'
                                                            runat="server" />
                                                    </div>
                                                </div>
                                            </a>
                                            <div class="prodDisDiv">
                                                <div class="ProdName">
                                                    <%# Eval("ProductName") %>
                                                </div>
                                                <div class="ProdPrice">
                                                    Rs.<%# Eval("Price").ToString().Trim() %>*</div>
                                            </div>
                                            <div class="prodAction">
                                                <a id="A2" runat="server" href='<%# "~/Product/OrderNow/"+ Eval("ProductName") + "_" + Eval("ProductID") %>'>
                                                    Order Now</a> <a id="A3" href='<%# "~/Product/Enquiry/"+ Eval("ProductName") + "_" + Eval("ProductID") %>'
                                                        runat="server">Enquiry</a> <a target="_blank" id="A4" onclick='<%#  GetShareUrl(Convert.ToString(Eval("ProductName")), Convert.ToString(Eval("ProductID")))  %>'>
                                                            Share</a>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <div class="hpMoreLink">
                            <a id="A5" href='<%# "Product/DisplayProduct.aspx?catID=" + Eval("CategoryID") %>'
                                runat="server">more</a>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
</asp:Content>
