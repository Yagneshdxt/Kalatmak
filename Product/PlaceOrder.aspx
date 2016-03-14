<%@ Page Title="" Language="C#" MasterPageFile="~/PopupPage.master" AutoEventWireup="true"
    CodeFile="PlaceOrder.aspx.cs" Inherits="Product_PlaceOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function closeFancyBox() {
            parent.$.fancybox.close();
            return false;
        }

        $(function () {
            $('textarea[max-length]').keyup(function (e) {
                var txt = $(this).val();
                var maxlen = $(this).attr("max-length")
                if (parseFloat(txt.length) > parseFloat(maxlen)) {
                    $(this).val(txt.substr(0, parseFloat(maxlen)));
                }
                $(this).next('div').html("Characters entered <b>" + $(this).val().length + "</b> out of <b>" + maxlen + "</b>");
            });
        });

        function ValdtsubmitOrder(sender, args) {
            args.IsValid = true;
            var hdnchoosenColor = $("#<%= hdnchoosenColor.ClientID %>");
            if (hdnchoosenColor && hdnchoosenColor.val() == '') {
                sender.errormessage = "Please select Color";
                args.IsValid = false;
            }
        }

        $(document).ready(function () {
            var hdnchoosenColor = $("#<%= hdnchoosenColor.ClientID %>");
            $(".DivcolorCodes").click(function () {
                hdnchoosenColor.val('');
                $(".divSelected").removeClass("divSelected");
                $(this).addClass("divSelected")
                hdnchoosenColor.val($(this).attr('data-colorcode'));
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="orderWrapper">
        <div class="OrProDisplay">
            <div class="ProdName">
                <asp:Label Text="Diya Bati" ID="lblProdName" runat="server" />
            </div>
            <div class="OrProdImg">
                <asp:Image ID="ProdImg" ImageUrl="~/images/IMG_20140908_172738 (600 x 337).jpg" runat="server" />
            </div>
            <div class="OrProdPrice">
                <asp:Label Text="Rs 450.00*" ID="lblPrdPrice" runat="server" />
            </div>
            <div class="PriceTermCond">
                * Price is Approx amount and is subject to change.
            </div>
            <div>
                <asp:Button ID="btnBck" OnClientClick="return closeFancyBox()" Text="Back to Shopping"
                    runat="server" />
            </div>
        </div>
        <div id="divOrdDetail" visible="true" runat="server" class="OrUserDetail">
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
            <div class="clsCtr" id="divProductColor" runat="server">
                <div class="clsControlName">
                    Product Color <span class="clsMandAstrk">*</span>
                </div>
                <div class="clstxtControl">
                    <asp:Repeater ID="rptColor" runat="server">
                        <ItemTemplate>
                            <div class="DivcolorCodes" data-colorcode='<%# Eval("colorCode") %>'>
                                <div class="divColor" style='<%# "background-color:"+  Eval("colorCode") %>'>
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
        <div id="divOrdMsg" visible="false" runat="server" class="OrUserDetail">
            <asp:Literal Text="" ID="lblMsg" runat="server" />
        </div>
    </div>
</asp:Content>
