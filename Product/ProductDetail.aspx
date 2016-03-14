<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ProductDetail.aspx.cs" Inherits="Product_ProductDetail" EnableViewState="true"
    ViewStateMode="Enabled" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src='<%= ResolveUrl("~/JScripts/jquery-ui.min.js") %>' type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            var totalWidth = 0;

            // Total width is calculated by looping through each gallery item and
            // adding up each width and storing that in `totalWidth`
            $(".ImgContainer > div").each(function () {
                totalWidth = totalWidth + $(this).outerWidth(true);
            });

            // The maxScrollPosition is the furthest point the items should
            // ever scroll to. We always want the viewport to be full of images.
            var maxScrollPosition = totalWidth - $(".moreImgGallary").outerWidth(true);
            maxScrollPosition = maxScrollPosition < 0 ? 0 : maxScrollPosition;
            console.log('maxScrollPosition ' + maxScrollPosition);
            // This is the core function that animates to the target item
            // ====================================================================
            function toGalleryItem($targetItem) {
                // Make sure the target item exists, otherwise do nothing
                if ($targetItem.length) {

                    // The new position is just to the left of the targetItem
                    var newPosition = $targetItem.position().left;

                    // If the new position isn't greater than the maximum width
                    if (newPosition <= maxScrollPosition) {

                        // Add active class to the target item
                        $targetItem.addClass("gallery__item--active");

                        // Remove the Active class from all other items
                        $targetItem.siblings().removeClass("gallery__item--active");

                        // Animate .gallery element to the correct left position.
                        $(".ImgContainer").animate({
                            left: -newPosition
                        });
                    } else {
                        // Animate .gallery element to the correct left position.
                        $(".ImgContainer").animate({
                            left: -maxScrollPosition
                        });
                    };

                    $(".nxtbtndiv").removeClass("hidDiv");
                    $(".prebtndiv").removeClass("hidDiv");
                    if ($targetItem.position().left >= maxScrollPosition) {
                        $(".nxtbtndiv").addClass("hidDiv");
                        $(".prebtndiv").removeClass("hidDiv");
                    }
                    if ($targetItem.position().left <= 0) {
                        $(".nxtbtndiv").removeClass("hidDiv");
                        $(".prebtndiv").addClass("hidDiv");
                    }
                };
            };


            $(".ImgContainer").width(totalWidth);

            // Add active class to the first gallery item
            $(".ImgContainer > div:first").addClass("gallery__item--active");

            // When the prev button is clicked
            // ====================================================================
            $(".prebtndiv").click(function () {
                // Set target item to the item before the active item
                var $targetItem = $(".gallery__item--active").prev();
                toGalleryItem($targetItem);
                return false;
            });

            // When the next button is clicked
            // ====================================================================
            $(".nxtbtndiv").click(function () {
                // Set target item to the item after the active item
                var $targetItem = $(".gallery__item--active").next();
                toGalleryItem($targetItem);
                return false;
            });

            var bigImgSrc = '';
            //change main Image container hover
            $(".ImgContainer img").mouseover(function () {
                $("#imgProddis").attr('src', $(this).attr("src"));
                bigImgSrc = $(this).closest('div').attr("data-ZoomImgurl");
                if (typeof bigImgSrc == "undefined") {
                    bigImgSrc = $(this).attr("src");
                }
                $(".zoomImgDisp").css({ 'background': ('url(' + bigImgSrc + ') no-repeat') });
            });

            //Document.ready fist load setting of zoom div and background image
            bigImgSrc = $(".ImgContainer img[src='" + $("#imgProddis").attr("src") + "']").closest("div").attr("data-ZoomImgurl");
            $(".zoomImgDisp").css({ height: $("#imgProddis").closest("div").height(),
                width: $("#imgProddis").closest("div").width(),
                left: ($("#imgProddis").closest("div").offset().left + $("#imgProddis").closest("div").width() + 14),
                top: ($("#imgProddis").closest("div").offset().top)
            });
            $(".zoomImgDisp").css({ 'background': ('url(' + bigImgSrc + ') no-repeat') });

            //***********************Zoom functionality start***********************
            //Code reference http://thecodeplayer.com/walkthrough/magnifying-glass-for-images-using-jquery-and-css3
            $("#imgProddis").mousemove(function (e) {

                var image_object = new Image();
                var native_width = 0;
                var native_height = 0;
                var maxImgXposition = 0;
                var maxImgYposition = 0;

                //hide the loading image onces image is loaded.
                $(image_object).load(function () {
                    $("#divzoomLoding").fadeOut("slow");
                });

                image_object.src = bigImgSrc;
                native_width = image_object.width;
                native_height = image_object.height;

                if ((!native_width && !native_height) || (native_width == 0 || native_height == 0)) {
                    image_object.src = $("#imgProddis").attr("src")
                    native_width = image_object.width;
                    native_height = image_object.height;
                    $(".zoomImgDisp").css({ 'background': ('url(' + image_object.src + ') no-repeat') });
                }

                if (native_width && native_height && native_width > 0 && native_height > 0) {

                    var magnify_offset = $(this).closest("div").offset();
                    //We will deduct the positions of .magnify from the mouse positions with
                    //respect to the document to get the mouse positions with respect to the 
                    //container(.magnify)
                    var mx = e.pageX - magnify_offset.left;
                    var my = e.pageY - magnify_offset.top;

                    /*if (mx < $("#imgProddis").width() && my < $("#imgProddis").height() && mx > 0 && my > 0) {
                    $(".zoomImgDisp").fadeIn(100);
                    } else {
                    $(".zoomImgDisp").fadeOut(100);
                    }*/

                    maxImgXposition = Math.round(native_width - $(".zoomImgDisp").width());
                    maxImgYposition = Math.round(native_height - $(".zoomImgDisp").height());

                    maxImgXposition = maxImgXposition < 0 ? 0 : maxImgXposition;
                    maxImgYposition = maxImgYposition < 0 ? 0 : maxImgYposition;

                    //The background position of .large will be changed according to the position
                    //of the mouse over the .small image. So we will get the ratio of the pixel
                    //under the mouse pointer with respect to the image and use that to position the 
                    //large image inside the magnifying glass
                    var rx = Math.round(mx / $("#imgProddis").width() * native_width - $(".zoomImgDisp").width() / 2);
                    var ry = Math.round(my / $("#imgProddis").height() * native_height - $(".zoomImgDisp").height() / 2);

                    if (rx > 0 && rx < maxImgXposition) {
                        rx = (rx * -1);
                    } else {
                        if (rx < 0) { rx = 0 };
                        if (rx > maxImgXposition) { rx = (maxImgXposition * -1) };
                    }
                    if (ry > 0 && ry < maxImgYposition) {
                        ry = (ry * -1);
                    } else {
                        if (ry < 0) { ry = 0 };
                        if (ry > maxImgYposition) { ry = (maxImgYposition * -1) };
                    }

                    var bgp = rx + "px " + ry + "px";
                    $(".zoomImgDisp").css({ 'backgroundPosition': bgp });
                }
            }).mouseout(function () {
                $(".zoomImgDisp").fadeOut(100);
            }).mouseenter(function () {
                $(".zoomImgDisp, #divzoomLoding").fadeIn(100);
            });

            //***********************Zoom functionality Ends***********************


            //**********************Order functionality script**********************

            var hdnchoosenColor = $("#<%= hdnchoosenColor.ClientID %>");
            if (hdnchoosenColor.val('') == '') {
                $(".divSelected").removeClass("divSelected");
            }
            $(".DivcolorCodes").click(function () {
                hdnchoosenColor.val('');
                $(".divSelected").removeClass("divSelected");
                $(this).addClass("divSelected")
                hdnchoosenColor.val($(this).attr('data-colorcode'));

                //1. change display image and //2. bring corrosponding thumbnail to focus.
                var colorMapId = $(this).attr('data-colorMap')
                var thumImg = $(".ImgContainer img[data-colorMap='" + colorMapId + "']");
                //toGalleryItem(thumImg.closest('div'));

                if (thumImg.closest('div').position().left <= maxScrollPosition) {
                    // Animate .gallery element to the correct left position.
                    $(".ImgContainer").animate({
                        left: -thumImg.closest('div').position().left
                    });
                } else {
                    // Animate .gallery element to the correct left position.
                    $(".ImgContainer").animate({
                        left: -maxScrollPosition
                    });
                };

                $("#imgProddis").attr('src', $(thumImg).attr("src"));
                bigImgSrc = $(thumImg).closest('div').attr("data-ZoomImgurl");
                if (typeof bigImgSrc == "undefined") {
                    bigImgSrc = $(thumImg).attr("src");
                }
                $(".zoomImgDisp").css({ 'background': ('url(' + bigImgSrc + ') no-repeat') });
            });

            $('textarea[max-length]').keyup(function (e) {
                var txt = $(this).val();
                var maxlen = $(this).attr("max-length")
                if (parseFloat(txt.length) > parseFloat(maxlen)) {
                    $(this).val(txt.substr(0, parseFloat(maxlen)));
                }
                $(this).next('div').html("Characters entered <b>" + $(this).val().length + "</b> out of <b>" + maxlen + "</b>");
            });

            var ActionValue = $("#<%= hdnActionName.ClientID %>").val();
            if (ActionValue == "ProductDetail/") {
                ActionValue = false;
            }
            if (ActionValue == "OrderNow/") {
                ActionValue = 0;
            }
            if (ActionValue == "Enquiry/") {
                ActionValue = 1;
            }
            $("#accordion-1").accordion({ collapsible: true, heightStyle: "content", active: ActionValue }); //, disabled: true


            var lblMsg = $("#<%= lblmsg.ClientID %>");
            if (lblMsg.text() == '') {
                console.log(lblMsg.text());
                $(".msgOverlay").hide();
            } else {
                $(".msgOverlay").show();
            }
            $(".clsClosePopup").click(function () {
                lblMsg.text('');
                $(".msgOverlay").hide();
            });
            //**********************Order functionality script ends*****************


        });                             //end of document ready function

        function ValdtsubmitOrder(sender, args) {
            args.IsValid = true;
            var hdnchoosenColor = $("#<%= hdnchoosenColor.ClientID %>");
            if (hdnchoosenColor && hdnchoosenColor.val() == '') {
                sender.errormessage = "Please select Color";
                args.IsValid = false;
            }
        }

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

        function backToShoppingclick() {
            window.location.href = $("#<%= lnkBackToShopping.ClientID %>").attr("href");
            return;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="proDetContainer">
        <div class="proDetLeft">
            <div class="clearBoth">
            </div>
            <div class="prDeImgContainer">
                <div class="dummy">
                </div>
                <div class="ProDetProdImg">
                    <div class="Imgdummy">
                    </div>
                    <asp:Image ImageUrl="#" ID="imgProddis" ClientIDMode="Static" runat="server" />
                </div>
            </div>
            <div class="zoomImgDisp">
                <div id="divzoomLoding"></div>
            </div>
            <div class="moreImg">
                <div class="prebtndiv hidDiv">
                </div>
                <div class="moreImgGallary">
                    <div class="ImgContainer">
                        <asp:Repeater ID="rptMoreImge" runat="server">
                            <ItemTemplate>
                                <div data-zoomimgurl='<%# ResolveClientUrl(Convert.ToString(Eval("ImagePath"))) %>'>
                                    <asp:Image ID="Image1" ImageUrl='<%# Eval("thumNailImgPath") %>' runat="server" AlternateText='<%# Eval("ProductName") %>' data-colorMap='<%# Eval("ImageId") %>' />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="nxtbtndiv">
                </div>
            </div>
        </div>
        <div id="divOrdDetail" class="proDetRight">
            <div class="ProdName">
                <asp:Label Text="" ID="lblProdName" runat="server" />
            </div>
            <div class="ProdName">
                <asp:Label Text="" ID="lblPrdPrice" runat="server" />
            </div>
            <div>
                Size: <asp:Label Text="" ID="lblProdSize" runat="server" />
            </div>
            <div>
                Status:
                <asp:Label Text="" ID="lblProdStatus" runat="server" />
            </div>
            <div class="clsCtr" id="divProductColor" runat="server">
                <div class="clsControlName">
                    Product Colors <span class="clsMandAstrk">*</span>
                </div>
                <div class="clstxtControl">
                    <asp:Repeater ID="rptColor" runat="server">
                        <ItemTemplate>
                            <div class="DivcolorCodes" data-colorcode='<%# Eval("imgColorCode") %>'  data-colorMap='<%# Eval("ImageId") %>'>
                                <div class="divColor" style='<%# "background-color:"+  Eval("imgColorCode") %>'>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:HiddenField ID="hdnchoosenColor" runat="server" Value="" />
                    <div class="clear">
                    </div>
                </div>
                <div class="clsErrMsg">
                    <asp:CustomValidator ID="CustomValidator1" ErrorMessage="Please select Color" ControlToValidate=""
                        ValidationGroup="btnadd" Display="Dynamic" ClientValidationFunction="ValdtsubmitOrder"
                        runat="server" ForeColor="Red" />
                </div>
            </div>
            <div id="accordion-1">
                <h3>
                    Order Now</h3>
                <div id="divOrderNow">
                    <div id="divPlaceOrder" runat="server">
                        <div class="clsCtr">
                            <div class="clsControlName">
                                Name <span class="clsMandAstrk">*</span>
                            </div>
                            <div class="clstxtControl">
                                <asp:TextBox ID="txtUserName" runat="server" MaxLength="100" />
                            </div>
                            <div class="clsErrMsg">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName"
                                    ErrorMessage="Please enter Your Name" ForeColor="Red" Display="Dynamic" ValidationGroup="btnadd"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="clsCtr">
                            <div class="clsControlName">
                                Email Id <span class="clsMandAstrk">*</span>
                            </div>
                            <div class="clstxtControl">
                                <asp:TextBox ID="txtEmailId" runat="server" MaxLength="100" />
                            </div>
                            <div class="clsErrMsg">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmailId"
                                    ErrorMessage="Please enter Your Email Id" ForeColor="Red" Display="Dynamic" ValidationGroup="btnadd"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Invalid Email Address"
                                    ControlToValidate="txtEmailId" runat="server" ValidationExpression="^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$"
                                    Display="Dynamic" Text="Invalid Email Address" ValidationGroup="btnadd" ForeColor="Red"
                                    ToolTip="Invalid email Addresss" />
                            </div>
                        </div>
                        <div class="clsCtr">
                            <div class="clsControlName">
                                Contact No. <span class="clsMandAstrk">*</span>
                            </div>
                            <div class="clstxtControl">
                                <asp:TextBox ID="txtContactNo" runat="server" MaxLength="15" />
                            </div>
                            <div class="clsErrMsg">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtContactNo"
                                    ErrorMessage="Please enter Your Contact No." ForeColor="Red" Display="Dynamic"
                                    ValidationGroup="btnadd"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ErrorMessage="Only Numbers Please"
                                    ControlToValidate="txtContactNo" runat="server" ValidationExpression="^\d{1,15}?$"
                                    Display="Dynamic" ValidationGroup="btnadd" ToolTip="Numeric" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="clsCtr">
                            <div class="clsControlName">
                                Shipping Address <span class="clsMandAstrk">*</span>
                            </div>
                            <div class="clstxtControl">
                                <asp:TextBox ID="txtShipAdd" runat="server" max-length="500" TextMode="MultiLine" />
                                <div>
                                </div>
                            </div>
                            <div class="clsErrMsg">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtShipAdd"
                                    ErrorMessage="Please enter Shipping Address" ForeColor="Red" Display="Dynamic"
                                    ValidationGroup="btnadd"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="clsCtr">
                            <div class="clsControlName">
                                State <span class="clsMandAstrk">*</span>
                            </div>
                            <div class="clstxtControl">
                                <asp:DropDownList ID="ddlState" runat="server" />
                            </div>
                            <div class="clsErrMsg">
                                <asp:RequiredFieldValidator ErrorMessage="Please select State" ControlToValidate="ddlState"
                                    ID="rfvMainCate" InitialValue="0" ForeColor="Red" runat="server" Display="Dynamic"
                                    ValidationGroup="btnadd" />
                            </div>
                        </div>
                        <div class="clsCtr">
                            <div class="clsControlName">
                                Pin No
                            </div>
                            <div class="clstxtControl">
                                <asp:TextBox ID="txtPin" runat="server" MaxLength="20" />
                            </div>
                            <div class="clsErrMsg">
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ErrorMessage="Only Numbers Please"
                                    ControlToValidate="txtPin" runat="server" ValidationExpression="^\d{1,20}?$"
                                    Display="Dynamic" ValidationGroup="btnadd" ToolTip="Numeric" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="clsCtr">
                            <div class="clsControlName">
                                Order Quantity <span class="clsMandAstrk">*</span>
                            </div>
                            <div class="clstxtControl">
                                <asp:TextBox ID="txtQty" runat="server" MaxLength="10" />
                            </div>
                            <div class="clsErrMsg">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtQty"
                                    ErrorMessage="Please enter Order Quantity" ForeColor="Red" Display="Dynamic"
                                    ValidationGroup="btnadd"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ErrorMessage="Only Numbers Please"
                                    ControlToValidate="txtQty" runat="server" ValidationExpression="^\d{1,10}?$"
                                    Display="Dynamic" ValidationGroup="btnadd" ToolTip="Numeric" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="orButDiv">
                            <div>
                                <asp:Button ID="btnSubOrder" Text="Place Order" CausesValidation="true" ValidationGroup="btnadd"
                                    runat="server" OnClick="btnSubOrder_Click" />
                                <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnadd" ShowMessageBox="true"
                                    DisplayMode="List" HeaderText="------Error------" ShowSummary="false" />
                            </div>
                        </div>
                    </div>
                    <div id="divUnAvaiProd" runat="server">
                        <p>
                            Sorry!!!</p>
                        <p>
                            Product Unavilable right now!</p>
                    </div>
                </div>
                <h3>
                    Enquiry
                </h3>
                <div id="divEnquiry">
                    <div class="clsCtr">
                        <div class="clsControlName">
                            Name <span class="clsMandAstrk">*</span>
                        </div>
                        <div class="clstxtControl">
                            <asp:TextBox ID="txtEnqName" runat="server" MaxLength="100" />
                        </div>
                        <div class="clsErrMsg">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEnqName"
                                ErrorMessage="Please enter Your Name" ForeColor="Red" Display="Dynamic" ValidationGroup="btnEnq"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="clsCtr">
                        <div class="clsControlName">
                            Email Id <span class="clsMandAstrk">*</span>
                        </div>
                        <div class="clstxtControl">
                            <asp:TextBox ID="txtEnqEmailId" runat="server" MaxLength="100" />
                        </div>
                        <div class="clsErrMsg">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtEnqEmailId"
                                ErrorMessage="Please enter Your Email Id" ForeColor="Red" Display="Dynamic" ValidationGroup="btnEnq"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ErrorMessage="Invalid Email Address"
                                ControlToValidate="txtEnqEmailId" runat="server" ValidationExpression="^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$"
                                Display="Dynamic" Text="Invalid Email Address" ValidationGroup="btnEnq" ForeColor="Red"
                                ToolTip="Invalid email Addresss" />
                        </div>
                    </div>
                    <div class="clsCtr">
                        <div class="clsControlName">
                            Contact No. <span class="clsMandAstrk">*</span>
                        </div>
                        <div class="clstxtControl">
                            <asp:TextBox ID="txtEnqContNo" runat="server" MaxLength="15" />
                        </div>
                        <div class="clsErrMsg">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtEnqContNo"
                                ErrorMessage="Please enter Your Contact No." ForeColor="Red" Display="Dynamic"
                                ValidationGroup="btnEnq"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ErrorMessage="Only Numbers Please"
                                ControlToValidate="txtEnqContNo" runat="server" ValidationExpression="^\d{1,15}?$"
                                Display="Dynamic" ValidationGroup="btnEnq" ToolTip="Numeric" ForeColor="Red" />
                        </div>
                    </div>
                    <div class="clsCtr">
                        <div class="clsControlName">
                            Comments. <span class="clsMandAstrk">*</span>
                        </div>
                        <div class="clstxtControl">
                            <asp:TextBox ID="txtEnqComments" runat="server" max-length="500" TextMode="MultiLine" />
                            <div>
                            </div>
                        </div>
                        <div class="clsErrMsg">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtEnqComments"
                                ErrorMessage="Please enter your comments" ForeColor="Red" Display="Dynamic" ValidationGroup="btnEnq"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="orButDiv">
                        <div>
                            <asp:Button ID="btnSubEnqiry" Text="Submit Enquiry" CausesValidation="true" ValidationGroup="btnEnq"
                                runat="server" OnClick="btnSubEnqiry_Click" />
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="btnEnq"
                                ShowMessageBox="true" DisplayMode="List" HeaderText="------Error------" ShowSummary="false" />
                        </div>
                    </div>
                </div>
            </div>
            <asp:HyperLink NavigateUrl="" ID="lnkBackToShopping" runat="server">
            <h3>
                 Back to Shopping 
            </h3>
            </asp:HyperLink>
            <asp:HyperLink NavigateUrl="javascript:return false;" ID="lnkFbShare" runat="server">
            <h3>
                Share
            </h3>
            </asp:HyperLink>
            <div class="PriceTermCond">
                (* price may vary.)
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnProdId" runat="server" />
    <asp:HiddenField ID="hdnActionName" runat="server" />
    <div id="msgDiv" class="msgOverlay">
        <div class="msgContent">
            <div class="clsClosePopup">
                X
            </div>
            <br />
            <asp:Label Text="" ID="lblmsg" runat="server" />
            <br />
            <br />
        </div>
    </div>
</asp:Content>
