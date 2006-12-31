<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    CodeFile="AddProduct.aspx.cs" Inherits="Admin_Product_AddProduct" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../JScripts/KnockOut.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        var ie = (function () {
            var undef,
            v = 3,
            div = document.createElement('div'),
            all = div.getElementsByTagName('i');
            while (
                div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->',
                all[0]
            );

            return v > 4 ? v : undef;
        } ());


        $(function () {
            $("#<%= fileImage.ClientID %>").change(function () {
                $("#dvPreview").html("");
                //var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;

                var regex = /^.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$/;

                if (regex.test($(this).val().toLowerCase())) {
                    if (ie && parseFloat(ie) <= 9.0) {
                        //if ($.browser.msie && parseFloat(jQuery.browser.version) <= 9.0) {
                        $("#dvPreview").show();
                        $("#dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();
                    }
                    else {
                        if (typeof (FileReader) != "undefined") {
                            $("#dvPreview").show();
                            $("#dvPreview").prepend("<img />");
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                $("#dvPreview img").attr("src", e.target.result);
                            }
                            reader.readAsDataURL($(this)[0].files[0]);
                        } else {
                            alert("This browser does not support FileReader.");
                        }
                    }
                } else {
                    alert("Please upload a valid image file.");
                }
            });
        });


        function colorSelected(sender) {
            //alert(sender.get_selectedColor());

            var hdnImageColor = $("#<%= hdnImageColor.ClientID %>");
            hdnImageColor.val("#" + sender.get_selectedColor());
            var divStr = "<div style='background-color:#" + sender.get_selectedColor() + "'></div>";
            $("#DivPreviewLst").html(divStr);

        }

        $(document).ready(function () {
            var hdnImageColor = $("#<%= hdnImageColor.ClientID %>");
            if (hdnImageColor && hdnImageColor.val() != '')
                $("#DivPreviewLst").html("<div style='background-color:" + hdnImageColor.val() + "'></div>");
        });
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        <span class="PageName">Add/Edit Product</span>
    </p>
    <fieldset>
        <legend>Add </legend>
        <table border="0" cellpadding="5" cellspacing="5">
            <tr>
                <td>
                    Product Name
                </td>
                <td>
                    <asp:TextBox ID="txtProductname" runat="server" MaxLength="98"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtProductname"
                        Display="Dynamic" ErrorMessage="Please enter Product Name" ForeColor="Red" ValidationGroup="btnadd">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Category
                </td>
                <td>
                    <asp:DropDownList ID="ddlcategory" runat="server">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ErrorMessage="Please select Category" ControlToValidate="ddlcategory"
                        ID="rfvMainCate" Text="*" InitialValue="0" ForeColor="Red" runat="server" Display="Dynamic"
                        ValidationGroup="btnadd" />
                </td>
            </tr>
            <tr>
                <td>
                    Price
                </td>
                <td>
                    Rs.<asp:TextBox ID="txtprice" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ErrorMessage="Please enter Price"
                        ControlToValidate="txtprice" Display="Dynamic" ValidationGroup="btnadd" runat="server"
                        Text="*" ForeColor="Red" />
                </td>
            </tr>
            <tr>
                <td>
                    Size
                </td>
                <td>
                    <asp:TextBox ID="txtSize" runat="server" Width="200px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Product Image
                    <br />
                    <asp:HyperLink runat="server" ID="lnkRiot" NavigateUrl="~/Admin/Riot-setup.7z" Target="_blank"> Riot Set up </asp:HyperLink>
                    or
                    <asp:HyperLink runat="server" ID="HyperLink1" NavigateUrl="http://bluefive.pair.com/"
                        Target="_blank"> PIXresizer </asp:HyperLink>
                </td>
                <td>
                    <asp:FileUpload ID="fileImage" runat="server" Width="200px" />
                    *
                    <asp:RequiredFieldValidator ErrorMessage="Please select Product Image" ControlToValidate="fileImage"
                        ID="RfVImageFile" Text="*" ForeColor="Red" runat="server" Display="Dynamic" ValidationGroup="btnadd" />
                    <asp:RegularExpressionValidator ID="rExImgTypeValidator" runat="server" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)"
                        ControlToValidate="fileImage" Display="Dynamic" ValidationGroup="btnadd" ErrorMessage="Product Image must be a jpg, bmp. or gif file">*</asp:RegularExpressionValidator>
                    <br />
                    <asp:Label ID="lblLogoImagVali" ForeColor="Red" runat="server"></asp:Label>
                    <%--
                http://www.aspsnippets.com/Articles/Preview-image-before-upload-using-FileUpload-control-and-jQuery-in-ASPNet.aspx
                    --%>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="clsPreviImgContainer">
                        <div id="divOldImg">
                            Old Image<br />
                            <div id="DivEditImg" class="DivEditImg" runat="server" visible="false">
                                <asp:Image ID="ImgEdit" ImageUrl="" runat="server" />
                            </div>
                        </div>
                        <div id="divCurrImg">
                            Selected Image<br />
                            <div id="dvPreview">
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    Product Color
                </td>
                <td>
                    <asp:HiddenField ID="hdnImageColor" runat="server" />
                    <asp:TextBox ID="txtProdColor" runat="server" />
                    <act:ColorPickerExtender ID="ajcolorPicker" runat="server" TargetControlID="txtProdColor"
                        OnClientColorSelectionChanged="colorSelected">
                    </act:ColorPickerExtender>
                    <div id="DivPreviewLst">
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    Sequence No
                </td>
                <td>
                    <asp:TextBox ID="txtSeqNo" runat="server"></asp:TextBox>(Keep blank for auto increament.)
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
                        DisplayMode="List" HeaderText="Add/Edit Product Error" ShowSummary="false" />
                </td>
            </tr>
        </table>
    </fieldset>
    <p>
    </p>
    <fieldset>
        <legend>Edit </legend>
        <table width="100%">
            <tr>
                <td>
                    Product Name:
                    <asp:TextBox ID="txtVwProduct" runat="server" />
                </td>
                <td>
                    Category Name
                    <asp:TextBox ID="txtVwCatName" runat="server" />
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
            </tr>
        </table>
        <asp:GridView ID="grdRootcat" runat="server" AutoGenerateColumns="false" PageSize="10"
            AllowPaging="true" Width="100%" OnPageIndexChanging="grdRootcat_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Featured Image" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <div class="ImgContainer">
                            <asp:Image ImageUrl='<%#Eval("ImagePath") %>' ID="ImgProdImg" runat="server" AlternateText='<%#Eval("ProductName") %>' />
                            <asp:HiddenField ID="hdnImageColorGr" Value='<%# Eval("imgColorCode") %>' runat="server" />
                            <asp:HiddenField ID="hdnImageId" Value='<%# Eval("ImageId") %>' runat="server" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <asp:Label ID="lblProductname" runat="server" Text='<%#Eval("ProductName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category Name">
                    <ItemTemplate>
                        <asp:Label ID="lblcatname" runat="server" Text='<%#Eval("CategoryName") %>'></asp:Label>
                        <asp:HiddenField ID="hdncatID" Value='<%# Eval("CategoryId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate>
                        <asp:Label ID="lblPrice" runat="server" Text='<%#Eval("Price") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Size">
                    <ItemTemplate>
                        <asp:Label ID="lblSize" runat="server" Text='<%#Eval("Size") %>'></asp:Label>
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
                        <asp:HiddenField ID="hdnProdID" Value='<%# Eval("ProductID") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </fieldset>
    <asp:HiddenField ID="hdProdid" runat="server" />
    <asp:HiddenField ID="hdnImageId" runat="server" />
</asp:Content>
