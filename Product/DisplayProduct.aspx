<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="DisplayProduct.aspx.cs" Inherits="Product_DisplayProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        function windowpop(hrefUrl) {
            var leftPosition, topPosition, width, height;
            width = 545;
            height = 433;
            //Allow for borders.
            leftPosition = (window.screen.width / 2) - ((width / 2) + 10);
            //Allow for title and status bars.
            topPosition = (window.screen.height / 2) - ((height / 2) + 50);
            //Open the window.
            window.open(hrefUrl, "sharer", "status=no,height=" + height + ",width=" + width + ",resizable=yes,left=" + leftPosition + ",top=" + topPosition + ",screenX=" + leftPosition + ",screenY=" + topPosition + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="productlistBody">
        <div>
            <asp:Label Text="" ID="lblCatName" runat="server" />
        </div>
        <asp:ListView ID="repProDp" runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging">
            <ItemTemplate>
                <div class="prodContainer">
                    <a id="A1" href='<%# "~/Product/ProductDetail/"+ Eval("ProductName") + "_" + Eval("ProductID") %>'
                        runat="server">
                        <div class="prLstImgCont">
                            <div class="dummy">
                            </div>
                            <div class="prodImg">
                                <div class="Imgdummy">
                                </div>
                                <asp:Image ImageUrl='<%# Eval("thumNailImgPath") %>' AlternateText='<%# Eval("ProductName") %>'
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
                                runat="server">Enquiry</a> <a target="_blank" onclick='<%#  GetShareUrl(Convert.ToString(Eval("ProductName")), Convert.ToString(Eval("ProductID")))  %>'>
                                    Share</a>
                    </div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                No Record found.
            </EmptyDataTemplate>
        </asp:ListView>
        <div class="clear">
        </div>
        <div class="divProdPaging">
            <asp:DataPager ID="dtPager" runat="server" PagedControlID="repProDp" PageSize="8">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                        ShowNextPageButton="false" PreviousPageText="<<" />
                    <asp:NumericPagerField ButtonType="Link" ButtonCount="3" />
                    <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false"
                        ShowPreviousPageButton="false" NextPageText=">>" />
                </Fields>
            </asp:DataPager>
        </div>
        <div class="termDiv">
            (* price may vary.)</div>
    </div>
</asp:Content>
