using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Web.UI.HtmlControls;

public partial class Product_ProductDetail : System.Web.UI.Page
{
    public Int64 proId;
    public String ProductName { get; set; }
    public String ActionName { get; set; }
    String DomainAdd = "";
    DataAccess objDataAccess = new DataAccess();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Uri objUri = Request.Url;
            String ProName_Id = Convert.ToString(this.Page.RouteData.Values["productName_Id"]);
            DomainAdd = ConfigurationManager.AppSettings["domainAdd"].ToString();
            if (String.IsNullOrWhiteSpace(ProName_Id))
            {
                Response.Redirect("~/PopUpErrorPage.aspx", true);
            }
            else
            {
                String[] proNameArr = ProName_Id.Split('_');
                Int64.TryParse(Convert.ToString(proNameArr[proNameArr.Length - 1]), out proId);
                Array.Resize(ref proNameArr, (proNameArr.Length - 1));
                ProductName = String.Join("_", proNameArr);
                ActionName = Convert.ToString(objUri.Segments[objUri.Segments.Length - 2]);

                FillControls();
            }
        }

        //lblurlRoutingDetails.Text += " Product Id " + proId.ToString() + "<br/>" + " Product Name " + ProductName + " <br/> " + " Action Name " + ActionName;
    }

    private void FillControls()
    {
        try
        {
            
            divPlaceOrder.Visible = true;
            divUnAvaiProd.Visible = false;
            DataSet Ds = new DataSet();
            SqlParameter[] para = new SqlParameter[]{
                new SqlParameter("@ProductID", proId),
                new SqlParameter("@ProductName", ProductName)
            };
            Ds = objDataAccess.getDataSetQuery("get_ProductDetails", para, CommandType.StoredProcedure);

            if (Ds != null && Ds.Tables.Count > 0)
            {
                lblProdName.Text = Convert.ToString(Ds.Tables[0].Rows[0]["ProductName"]);
                imgProddis.ImageUrl = Convert.ToString(Ds.Tables[0].Rows[0]["thumNailImgPath"]);
                imgProddis.AlternateText = Convert.ToString(Ds.Tables[0].Rows[0]["ProductName"]);
                lblPrdPrice.Text = "*Rs." + Convert.ToString(Ds.Tables[0].Rows[0]["Price"]);
                lblProdSize.Text = Convert.ToString(Ds.Tables[0].Rows[0]["Size"]);
                lblProdStatus.Text = Convert.ToString(Ds.Tables[0].Rows[0]["ProStatus"]) == "1" ? "Available" : "Unavailable";
                hdnProdId.Value = Convert.ToString(Ds.Tables[0].Rows[0]["ProductID"]);
                lnkBackToShopping.NavigateUrl = DomainAdd + "Product/DisplayProduct.aspx?catID=" + Convert.ToString(Ds.Tables[0].Rows[0]["CategoryId"]);

                if (lblProdStatus.Text.Trim() == "Available") {
                    divPlaceOrder.Visible = true;
                    divUnAvaiProd.Visible = false;
                }
                if (lblProdStatus.Text.Trim() == "Unavailable")
                {
                    divPlaceOrder.Visible = false;
                    divUnAvaiProd.Visible = true;                
                }

                if (Ds.Tables.Contains("Table3"))
                {
                    ddlState.DataSource = Ds.Tables[3];
                    ddlState.DataValueField = "StateId";
                    ddlState.DataTextField = "StateName";
                    ddlState.DataBind();
                    ddlState.Items.Insert(0, new ListItem("-- Select --", "0"));
                }

                if (Ds.Tables.Contains("Table1"))
                {
                    rptColor.DataSource = Ds.Tables[1];
                    rptColor.DataBind();

                    if (Ds.Tables[1].Rows.Count >= 2)
                    {
                        divProductColor.Visible = true;
                    }
                    else
                    {
                        divProductColor.Visible = false;
                    }
                }
                else
                {
                    divProductColor.Visible = false;
                }

                if (Ds.Tables.Contains("Table2"))
                {
                    rptMoreImge.DataSource = Ds.Tables[2];
                    rptMoreImge.DataBind();
                }
            }

            SetHeadContent();

            lnkFbShare.Attributes.Add("onclick", "return windowpop(\"http://www.facebook.com/sharer.php?u=" + HttpUtility.UrlEncode(DomainAdd + "Product/ProductDetail/" + lblProdName.Text.Trim() + "_" + Convert.ToString(proId))+ "\")");

            hdnActionName.Value = ActionName;
            lblmsg.Text = "";
        }
        catch (Exception)
        {
            throw;
        }
    }

    private void SetHeadContent()
    {
        // <link rel="image_src" href="http://www.websiteurlpicutre.com" / >
        HtmlLink link = new HtmlLink();
        //link.Attributes.Add("type", "application/rss+xml");
        link.Attributes.Add("rel", "image_src");
        if (!String.IsNullOrWhiteSpace(imgProddis.ImageUrl))
        {
            link.Attributes.Add("href", DomainAdd + imgProddis.ImageUrl.Replace("~/", ""));
        }
        else
        {
            link.Attributes.Add("href", DomainAdd + "images/LogoImg.png");
        }
        this.Header.Controls.Add(link);


        HtmlMeta keywords = new HtmlMeta();
        HtmlMeta MetTag;
        MetTag = new HtmlMeta();
        MetTag.Attributes.Add("property", "og:title");
        if (!String.IsNullOrWhiteSpace(lblProdName.Text))
        {   //Title
            MetTag.Content = lblProdName.Text;
        }
        else
        {
            MetTag.Content = "Traditional Artifacts with modern touch of art.";
        }
        Page.Header.Controls.Add(MetTag);

        //Description
        MetTag.Dispose();
        MetTag = new HtmlMeta();
        MetTag.Attributes.Add("property", "og:description");
        MetTag.Content = "Perfrect Gift for all occasion.";
        Page.Header.Controls.Add(MetTag);


        if (!String.IsNullOrWhiteSpace(lblProdName.Text))
        {
            //Url
            MetTag.Dispose();
            MetTag = new HtmlMeta();
            MetTag.Attributes.Add("property", "og:url");
            MetTag.Content = DomainAdd + "Product/ProductDetail/" + lblProdName.Text + "_" + Convert.ToString(proId);
            Page.Header.Controls.Add(MetTag);
        }
        else
        {
            //Url
            MetTag.Dispose();
            MetTag = new HtmlMeta();
            MetTag.Attributes.Add("property", "og:url");
            MetTag.Content = DomainAdd;
            Page.Header.Controls.Add(MetTag);
        }

        if (!String.IsNullOrWhiteSpace(imgProddis.ImageUrl))
        {
            //Image
            MetTag.Dispose();
            MetTag = new HtmlMeta();
            MetTag.Attributes.Add("property", "og:image");
            MetTag.Content = DomainAdd + imgProddis.ImageUrl.Replace("~/", ""); //"http://www.kalatmak.net/images/Accessory/handbagsflowerpiece.jpg"; 
            Page.Header.Controls.Add(MetTag);
        }
        else
        {
            //Image
            MetTag.Dispose();
            MetTag = new HtmlMeta();
            MetTag.Attributes.Add("property", "og:image");
            MetTag.Content = DomainAdd + "images/LogoImg.png";
            Page.Header.Controls.Add(MetTag);
        }
    }

    protected void clearControl()
    {
        txtUserName.Text = "";
        txtEmailId.Text = "";
        txtContactNo.Text = "";
        txtShipAdd.Text = "";
        ddlState.ClearSelection();
        ddlState.SelectedValue = "0";
        txtPin.Text = "";
        txtQty.Text = "";
        hdnchoosenColor.Value = "";
        txtEnqComments.Text = "";
        txtEnqContNo.Text = "";
        txtEnqEmailId.Text = "";
        txtEnqName.Text = "";
        lblmsg.Text = "";
    }

    protected void btnSubOrder_Click(object sender, EventArgs e)
    {
        try
        {

            //Response.Write(Request.Form["colorGroup"].ToString() + "Yagnesh");
            //return;
            if (!String.IsNullOrWhiteSpace(txtUserName.Text) && !String.IsNullOrWhiteSpace(txtEmailId.Text) && !String.IsNullOrWhiteSpace(txtContactNo.Text) && !String.IsNullOrWhiteSpace(txtQty.Text) && !String.IsNullOrWhiteSpace(hdnProdId.Value))
            {
                String SqlQuery = "Insert_OrderPlaced";
                SqlParameter[] para = new SqlParameter[]{
                        new SqlParameter("@productID",hdnProdId.Value.Trim()),    
                        new SqlParameter("@Uname",txtUserName.Text.Trim()),
                        new SqlParameter("@UemailId",txtEmailId.Text.Trim()),
                        new SqlParameter("@UContactNo",txtContactNo.Text.Trim()),
                        new SqlParameter("@UAddress",txtShipAdd.Text.Trim()),
                        new SqlParameter("@UState",Convert.ToInt64(ddlState.SelectedValue)),
                        String.IsNullOrWhiteSpace(txtPin.Text.Trim())?new SqlParameter("@UPinNo", DBNull.Value)  :new SqlParameter("@UPinNo", txtPin.Text.Trim()),
                        new SqlParameter("@UOrderQty", txtQty.Text.Trim()),
                        new SqlParameter("@productColor", hdnchoosenColor.Value.Trim()),
                        };
                DataSet ds = new DataSet();
                ds = objDataAccess.getDataSetQuery(SqlQuery, para, CommandType.StoredProcedure);

                SendMail objSendMail = new SendMail();
                String mBody = "", ProName = "", OrderId = "";
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (Convert.ToString(dr["KeyName"]).Trim() == "FromEmail")
                    {
                        objSendMail.From = Convert.ToString(dr["genConstValue"]);
                        objSendMail.NetCreUname = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "NetPass")
                    {
                        objSendMail.NetCrePass = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "MailSub")
                    {
                        objSendMail.MailSub = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "MailBody")
                    {
                        mBody = Convert.ToString(dr["genConstValue"]);
                        mBody = File.ReadAllText(Server.MapPath(mBody));
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "ProImgPath")
                    {
                        objSendMail.ProdImgPath = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "ProName")
                    {
                        ProName = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "OrderId")
                    {
                        OrderId = Convert.ToString(dr["genConstValue"]);
                    }
                }//end of foreach
                mBody = mBody.Replace("[xxxUserNamexxx]", txtUserName.Text.Trim()).Replace("[xxxProductNamexxx]", ProName)
                    .Replace("[xxxProductQtyxxx]", txtQty.Text.Trim()).Replace("[xxxOrderIdxxx]", OrderId);
                objSendMail.MailBody = mBody;
                objSendMail.MailSub = objSendMail.MailSub + "- Order ID - " + OrderId;
                objSendMail.To = txtEmailId.Text.Trim();
                objSendMail.OrderPlacedMailToUser();

                clearControl();

                lblmsg.Text = @"Order Placed Successfuly. We have send you a mail regarding the same. 
                                <br/> 
                                In case of any difficulty, please get in touch. 
                                <br/>
                                For contact details please check our contact us page.<br/>
                                <a href='javascript:backToShoppingclick();' onclick='javascript:backToShoppingclick();' > Back to shopping?? </a>";

            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }


    protected void btnSubEnqiry_Click(object sender, EventArgs e)
    {
        try
        {
            if (!String.IsNullOrWhiteSpace(txtEnqName.Text) && !String.IsNullOrWhiteSpace(txtEnqEmailId.Text) && !String.IsNullOrWhiteSpace(txtEnqContNo.Text) && !String.IsNullOrWhiteSpace(hdnProdId.Value))
            {
                String SqlQuery = "Insert_Enqiry";
                SqlParameter[] para = new SqlParameter[]{
                        new SqlParameter("@productID",hdnProdId.Value),    
                        new SqlParameter("@Uname",txtEnqName.Text.Trim()),
                        new SqlParameter("@UemailId",txtEnqEmailId.Text.Trim()),
                        new SqlParameter("@UContactNo",txtEnqContNo.Text.Trim()),
                        new SqlParameter("@UComments",txtEnqComments.Text.Trim())
                        };
                DataSet ds = new DataSet();
                ds = objDataAccess.getDataSetQuery(SqlQuery, para, CommandType.StoredProcedure);

                SendMail objSendMail = new SendMail();
                String mBody = "", ProName = "", EnquiryId = "";
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (Convert.ToString(dr["KeyName"]).Trim() == "FromEmail")
                    {
                        objSendMail.From = Convert.ToString(dr["genConstValue"]);
                        objSendMail.NetCreUname = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "NetPass")
                    {
                        objSendMail.NetCrePass = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "MailSub")
                    {
                        objSendMail.MailSub = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "MailBody")
                    {
                        mBody = Convert.ToString(dr["genConstValue"]);
                        mBody = File.ReadAllText(Server.MapPath(mBody));
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "ProImgPath")
                    {
                        objSendMail.ProdImgPath = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "ProName")
                    {
                        ProName = Convert.ToString(dr["genConstValue"]);
                    }
                    if (Convert.ToString(dr["KeyName"]).Trim() == "EnquiryId")
                    {
                        EnquiryId = Convert.ToString(dr["genConstValue"]);
                    }
                }//end of foreach
                mBody = mBody.Replace("[xxxUserNamexxx]", txtUserName.Text.Trim()).Replace("[xxxProductNamexxx]", ProName).Replace("[xxxEnquiryIdxxx]", EnquiryId);
                objSendMail.MailBody = mBody;
                objSendMail.MailSub = objSendMail.MailSub + "- Enquiry Id -" + EnquiryId;
                objSendMail.To = txtEmailId.Text.Trim();
                objSendMail.OrderPlacedMailToUser();

                clearControl();

                lblmsg.Text = @"Enquiry submited successfuly. We will get back to you shortly. 
                                <br/> 
                                In case of any difficulty, please get in touch. 
                                <br/>
                                For contact details, please check our contact us page.
                                <br/>
                                <a href='javascript:backToShoppingclick();' onclick='javascript:backToShoppingclick();' > Back to shopping?? </a>";

                /*divOrdMsg.Visible = true;
                divOrdDetail.Visible = false;*/
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }

}