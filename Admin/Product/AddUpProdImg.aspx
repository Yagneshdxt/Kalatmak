<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    CodeFile="AddUpProdImg.aspx.cs" Inherits="Admin_Product_AddUpProdImg" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
        <span class="PageName">Product Images</span>
    </p>
    <table border="0" cellpadding="5" cellspacing="5">
        <tr>
            <td>
                Select Category
            </td>
            <td>
                <asp:DropDownList ID="ddlcategory" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlcategory_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ErrorMessage="Please select Category" ControlToValidate="ddlcategory"
                    ID="rfvMainCate" Text="*" InitialValue="0" ForeColor="Red" runat="server" Display="Dynamic"
                    ValidationGroup="btnadd" />
            </td>
        </tr>
        <tr>
            <td>
                Select Product
            </td>
            <td>
                <asp:DropDownList ID="ddlProduct" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ErrorMessage="Please select Product" ControlToValidate="ddlProduct"
                    ID="RequiredFieldValidator1" Text="*" InitialValue="0" ForeColor="Red" runat="server"
                    Display="Dynamic" ValidationGroup="btnadd" />
            </td>
        </tr>
        <tr>
            <td>
                Product Image
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
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:TextBox ID="txtProdColor" runat="server" />
                <asp:colorpickerextender id="ajcolorPicker" runat="server" targetcontrolid="txtProdColor"
                    onclientcolorselectionchanged="colorSelected">
                </asp:colorpickerextender>
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
                <asp:FilteredTextBoxExtender ID="flextTxtDisValid" ClientIDMode="AutoID" runat="server"
                    Enabled="True" TargetControlID="txtSeqNo" FilterType="Custom, Numbers" ValidChars="">
                </asp:FilteredTextBoxExtender>
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
                    DisplayMode="List" HeaderText="Add More Image Error ----" ShowSummary="false" />
            </td>
        </tr>
    </table>
    <p>
    </p>
    <%--    OnRowUpdating="grdCategory_RowUpdating" OnRowEditing="grdCategory_RowEditing"
        OnRowCancelingEdit="grdCategory_RowCancelingEdit" OnRowDeleting="grdCategory_RowDeleting"--%>
    <asp:GridView ID="grdCategory" runat="server" AutoGenerateColumns="False" PageSize="10"
        AllowPaging="true" Width="100%" OnPageIndexChanging="grdCategory_PageIndexChanging"
        OnRowDataBound="grdCategory_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Featured Image" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <div class="ImgContainer">
                        <asp:Image ImageUrl='<%#Eval("ImagePath") %>' ID="ImgProdImg" runat="server" AlternateText='<%#Eval("ProductName") %>' />
                        <asp:HiddenField ID="hdnImageId" Value='<%# Eval("ImageId") %>' runat="server" />
                        <asp:HiddenField ID="hdncatID" Value='<%# Eval("CategoryID") %>' runat="server" />
                        <asp:HiddenField ID="hdnImageColorGr" Value='<%# Eval("imgColorCode") %>' runat="server" />
                        <asp:HiddenField ID="hdnIsFeatured" Value='<%# Eval("isFeatured") %>' runat="server" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product Name">
                <ItemTemplate>
                    <asp:Label ID="lblProductName" runat="server" Text='<% #Eval("ProductName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category Name">
                <ItemTemplate>
                    <asp:Label ID="lblCategoryName" runat="server" Text='<%#Eval("CategoryName")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Seq No">
                <ItemTemplate>
                    <asp:Label ID="lblSeqNo" runat="server" Text='<%#Eval("SeqNo")%>'></asp:Label>
                    <asp:HiddenField ID="hdnSeqNo" Value='<%#Eval("SeqNo")%>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblactive" runat="server" Text='<%#Eval("actInac")%>'></asp:Label>
                    <asp:HiddenField ID="hdnactiveflag" Value='<%# Eval("isActive") %>' runat="server" />
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
    <asp:HiddenField ID="hdnImageId" runat="server" />
    <asp:HiddenField ID="hdnImageColor" runat="server" />
</asp:Content>
