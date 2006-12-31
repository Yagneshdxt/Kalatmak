<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testDetails.aspx.cs" Inherits="Product_testDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="Scripts/jquery-2.1.3.min.js"></script>

    <style type="text/css">
        .mainCont
        {
            border: 1px solid black;
            overflow: hidden;
            margin: 2px;
        }

        .lftDiv
        {
            float: left;
            margin: 2px;
            border: 1px solid black;
            width: 40%;
            overflow: hidden;
        }

        .rghtDiv
        {
            float: left;
            margin: 2px;
            border: 1px solid black;
            width: 40%;
        }

        .prodImg
        {
            margin: 2px;
            border: 1px solid black;
            height: 300px;
        }

            .prodImg img
            {
                height: 100%;
                width: 100%;
            }

        .moreImg
        {
            margin: 2px;
            /*border: 1px solid black;*/
            height: 87px;
            overflow: hidden;
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        .moreImgGallary
        {
            overflow: hidden;
            padding: 0px 0px 0px 0px;
            width: 89%;
            height: 90%;
        }

        .ImgContainer
        {
            overflow: hidden;
            position: relative;
        }

            .ImgContainer > div
            {
                width: 100px;
                height: 70px;
                float: left;
                margin: 5px;
            }

                .ImgContainer > div > img
                {
                    height: 69px;
                    width: 100px;
                }


        .prebtndiv
        {
            float: left;
            display: block;
            position: relative;
            top: 27px;
            background: url("Image/leftrightArrow.jpg") no-repeat top -35px left -3px;
            width: 27px;
            height: 23px;
        }

        .nxtbtndiv
        {
            float: right;
            display: block;
            position: relative;
            top: -50px;
            background: url("Image/leftrightArrow.jpg") no-repeat top -6px left 3px;
            width: 27px;
            height: 23px;
        }

        .hidDiv
        {
            background-color: white;
            opacity: 0.4;
        }

        .zoomImgDisp
        {
            position: absolute;
            display: none;
            z-index: 100;
            /*Multiple box shadows to achieve the glass effect*/
            box-shadow: 0 0 0 7px rgba(255, 255, 255, 0.85), 0 0 7px 7px rgba(0, 0, 0, 0.25), inset 0 0 40px 2px rgba(0, 0, 0, 0.25);
            background-color: white;
        }

        .imgOverlay
        {
            height: 100%;
            width: 100%;
            position: absolute;
            background-color: white;
            opacity: 0.4;
        }

        .clearBoth
        {
            clear: both;
        }
    </style>
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
            var maxScrollPosition = totalWidth - $(".moreImgGallary").outerWidth(false);

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


            //***********************Zoom functionality start***********************
            //Code reference http://thecodeplayer.com/walkthrough/magnifying-glass-for-images-using-jquery-and-css3
            $(".prodImg").mousemove(function (e) {

                var image_object = new Image();
                var native_width = 0;
                var native_height = 0;
                var maxImgXposition = 0;
                var maxImgYposition = 0;

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

                    var magnify_offset = $(this).offset();
                    //We will deduct the positions of .magnify from the mouse positions with
                    //respect to the document to get the mouse positions with respect to the 
                    //container(.magnify)
                    var mx = e.pageX - magnify_offset.left;
                    var my = e.pageY - magnify_offset.top;

                    if (mx < $("#imgProddis").width() && my < $("#imgProddis").height() && mx > 0 && my > 0) {
                        $(".zoomImgDisp").css({ height: $(this).height(), width: $(this).width(), left: (magnify_offset.left + $(this).width() + 14), top: ($("#imgProddis").offset().top) });
                        $(".zoomImgDisp").fadeIn(100);
                    } else {
                        $(".zoomImgDisp").fadeOut(100);
                    }

                    maxImgXposition = Math.round(native_width - $(".zoomImgDisp").width());
                    maxImgYposition = Math.round(native_height - $(".zoomImgDisp").height());

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
            });

            //$("#imgProddis").mouseout(function () {
            //    $(".zoomSelector").fadeOut(100);
            //    console.log(3);
            //});

            //.mouseout(function () {
            //    $(".zoomSelector").hide();
            //    console.log("2");
            //});

            //***********************Zoom functionality Ends8***********************

        }); //end of document ready function

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="mainCont">
            <div class="lftDiv">
                <div class="clearBoth"></div>
                <div class="prodImg">
                    <asp:Image ImageUrl="#" ID="imgProddis" ClientIDMode="Static" runat="server" />
                    <div class="zoomImgDisp"></div>
                </div>
                <div class="moreImg">
                    <div class="prebtndiv hidDiv"></div>
                    <div class="moreImgGallary">
                        <div class="ImgContainer">
                            <div data-zoomimgurl="Image/Jellyfish-compressed.jpg">
                                <asp:Image ID="Image1" ImageUrl="~/Image/Jellyfish-compressed.jpg" runat="server" AlternateText="1" />
                            </div>
                            <div>
                                <asp:Image ID="Image2" ImageUrl="~/Image/JellyfishA.jpg" runat="server" AlternateText="2" />
                            </div>
                            <div>
                                <asp:Image ID="Image3" ImageUrl="~/Image/JellyfishB.jpg" runat="server" AlternateText="3" />
                            </div>
                            <div>
                                <asp:Image ID="Image4" ImageUrl="~/Image/JellyfishC.jpg" runat="server" AlternateText="4" />
                            </div>
                            <div>
                                <asp:Image ID="Image5" ImageUrl="~/Image/JellyfishD.jpg" runat="server" AlternateText="5" />
                            </div>
                            <div>
                                <asp:Image ID="Image6" ImageUrl="~/Image/JellyfishE.jpg" runat="server" AlternateText="3" />
                            </div>
                            <div>
                                <asp:Image ID="Image7" ImageUrl="~/Image/JellyfishF.jpg" runat="server" AlternateText="4" />
                            </div>
                            <div>
                                <asp:Image ID="Image8" ImageUrl="~/Image/JellyfishG.jpg" runat="server" AlternateText="5" />
                            </div>
                            <div>
                                <asp:Image ID="Image9" ImageUrl="~/Image/JellyfishH.jpg" runat="server" AlternateText="6" />
                            </div>
                        </div>
                    </div>
                    <div class="nxtbtndiv"></div>
                </div>
            </div>
            <div class="rghtDiv">
                Right Div

            </div>
        </div>
    </form>
</body>
</html>
