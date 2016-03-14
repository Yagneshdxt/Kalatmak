<%@ Page Title="" Language="C#" MasterPageFile="~/PopupPage.master" AutoEventWireup="true"
    CodeFile="PlaceEnqiry.aspx.cs" Inherits="Product_PlaceEnqiry" %>

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
                $(this).next('div').html("Characters entered <b>" + $(this).val().length + "</b> out of <b>" + maxlen + "</b>")
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
                <asp:Image ID="ProdImg" ImageUrl="~/images/IMG_20140908_173929 (315 x 281).jpg" runat="server" />
            </div>
            <div class="OrProdPrice">
                <asp:Label Text="Rs 450.00*" ID="lblPrdPrice" runat="server" />
            </div>
            <div class="PriceTermCond">
                * Price is Approx amount and is subject to change.
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
                    Comments. <span class="clsMandAstrk">*</span>
                </div>
                <div class="clstxtControl">
                    <asp:TextBox ID="txtComments" runat="server" max-length="500" TextMode="MultiLine" />
                    <div></div>
                </div>
                <div class="clsErrMsg">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtComments"
                        ErrorMessage="Please enter your comments" ForeColor="Red" Display="Dynamic"
                        ValidationGroup="btnadd"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="orButDiv">
                <div>
                    <asp:Button ID="btnSubOrder" Text="Submit Enquiry" CausesValidation="true" ValidationGroup="btnadd"
                        runat="server" OnClick="btnSubOrder_Click" />
                    <asp:ValidationSummary ID="vsum" runat="server" ValidationGroup="btnadd" ShowMessageBox="true"
                        DisplayMode="List" HeaderText="------Error------" ShowSummary="false" />
                </div>
                <div>
                    <asp:Button ID="btnBck" OnClientClick="return closeFancyBox()" Text="Back to Shopping"
                        runat="server" />
                </div>
            </div>
        </div>
        <div id="divOrdMsg" visible="false" runat="server" class="OrUserDetail">
            <asp:Literal Text="" ID="lblMsg" runat="server" />
        </div>
    </div>
</asp:Content>
