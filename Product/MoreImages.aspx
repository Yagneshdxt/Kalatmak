<%@ Page Title="" Language="C#" MasterPageFile="~/PopupPage.master" AutoEventWireup="true"
    CodeFile="MoreImages.aspx.cs" Inherits="Product_MoreImages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- FlexiSlider -->
    <link rel="stylesheet" href="../flexiSlider/flexslider.css" type="text/css" />
    <link rel="stylesheet" href="../flexiSlider/demo.css" type="text/css" media="screen" />
    <%--<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>--%>
    <script type="text/javascript" src="../flexiSlider/jquery.flexslider.js"></script>
    <script defer="defer" type="text/javascript" charset="utf-8">
        $(function () {
            SyntaxHighlighter.all();
        });
        $(window).load(function () {
            $('#carousel').flexslider({
                animation: "slide",
                controlNav: false,
                animationLoop: false,
                slideshow: false,
                itemWidth: 180,
                itemMargin: 5,
                asNavFor: '#slider'
            });

            $('#slider').flexslider({
                animation: "slide",
                controlNav: false,
                animationLoop: false,
                slideshow: false,
                sync: "#carousel",
                start: function (slider) {
                    $('body').removeClass('loading');
                }
            });
        });

        function windowpop(hrefUrl) {
            var leftPosition, topPosition, width, height;
            width = 545;
            height = 433;
            //Allow for borders.
            leftPosition = (window.screen.width / 2) - ((width / 2) + 10);
            //Allow for title and status bars.
            topPosition = (window.screen.height / 2) - ((height / 2) + 50);
            //Open the window.
            window.open(hrefUrl, "Window2", "status=no,height=" + height + ",width=" + width + ",resizable=yes,left=" + leftPosition + ",top=" + topPosition + ",screenX=" + leftPosition + ",screenY=" + topPosition + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <center>
        <div class="moreImgWrapper">
            <div class="ImgSlider">
                <section class="slider">
                <div id="slider" class="flexslider">
                    <ul class="slides">
                        <asp:Repeater ID="repBigImg" runat="server">
                            <ItemTemplate>
                                <li>
                                    <img src='<%# Eval("ImagePath") %>' alt='<%# Eval("ProductName") %>' runat="server" />
                                    <span>
                                        <%# Eval("ProductName")%>
                                    </span>
                                    <span>
                                        Rs.<%# Eval("Price")%>
                                    </span>
                                    <span>
                                        <asp:LinkButton ID="lnkPlaceOrder" Text="Order Now" PostBackUrl='<%# "~/Product/PlaceOrder.aspx?PrId=" + Eval("ProductID").ToString() %>'
                                            runat="server" />
                                    </span>
                                    <span>
                                        <asp:LinkButton ID="lnkEnqiry" Text="Enqiry" PostBackUrl='<%# "~/Product/PlaceEnqiry.aspx?PrId=" + Eval("ProductID").ToString() %>'
                                            runat="server" />
                                    </span>
                                    <span class="GalaryshareFb">
                                        <a target="_blank" onclick='<%#  GetShareUrl(Eval("ProductName").ToString(), Eval("CategoryId").ToString(), Eval("ImagePath").ToString(),Eval("ImageId").ToString())  %>' > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </a>
                                    </span> 
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div id="carousel" class="flexslider">
                    <ul class="slides">
                        <asp:Repeater ID="repSmallImg" runat="server">
                            <ItemTemplate>
                                <li>
                                    <img id="Img1" src='<%# Eval("ImagePath") %>' alt='<%# Eval("ProductName") %>' runat="server" />
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                </section>
                <div class="PriceTermCond">
                    * Price is Approx amount and is subject to change.
                </div>
            </div>
        </div>
    </center>
</asp:Content>
