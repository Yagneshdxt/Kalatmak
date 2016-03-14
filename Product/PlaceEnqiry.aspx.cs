using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Product_PlaceEnqiry : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();

    public Int64 PrdId { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["PrId"] != null)
            PrdId = Convert.ToInt64(Request.QueryString["PrId"]);
        else
        {
            Response.Redirect("~/PopUpErrorPage.aspx", true);
        }
        if (!IsPostBack)
        {
            FillControl();
        }
    }

    public void FillControl()
    {
        try
        {
            DataSet Ds = new DataSet();
            SqlParameter[] para = new SqlParameter[]{
                new SqlParameter("@ProductID", PrdId)
            };
            Ds = objDataAccess.getDataSetQuery("Fill_PlaceOrder", para, CommandType.StoredProcedure);

            if (Ds != null && Ds.Tables.Count > 0)
            {

                lblProdName.Text = Convert.ToString(Ds.Tables[0].Rows[0]["ProductName"]);
                ProdImg.ImageUrl = Convert.ToString(Ds.Tables[0].Rows[0]["ImagePath"]);
                lblPrdPrice.Text = "Rs." + Convert.ToString(Ds.Tables[0].Rows[0]["Price"]);

            }

            divOrdDetail.Visible = true;
            divOrdMsg.Visible = false;
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    protected void clearControl()
    {
        txtUserName.Text = "";
        txtEmailId.Text = "";
        txtContactNo.Text = "";
        lblMsg.Text = "";
    }

    protected void btnSubOrder_Click(object sender, EventArgs e)
    {
        try
        {
            if (!String.IsNullOrWhiteSpace(txtUserName.Text) && !String.IsNullOrWhiteSpace(txtEmailId.Text) && !String.IsNullOrWhiteSpace(txtContactNo.Text))
            {
                String SqlQuery = "Insert_Enqiry";
                SqlParameter[] para = new SqlParameter[]{
                        new SqlParameter("@productID",PrdId),    
                        new SqlParameter("@Uname",txtUserName.Text.Trim()),
                        new SqlParameter("@UemailId",txtEmailId.Text.Trim()),
                        new SqlParameter("@UContactNo",txtContactNo.Text.Trim()),
                        new SqlParameter("@UComments",txtComments.Text.Trim())
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
                mBody = mBody.Replace("[xxxUserNamexxx]", txtUserName.Text.Trim()).Replace("[xxxProductNamexxx]", ProName).Replace("[xxxEnquiryIdxxx]",EnquiryId);
                objSendMail.MailBody = mBody;
                objSendMail.MailSub = objSendMail.MailSub + "- Enquiry Id -" + EnquiryId;
                objSendMail.To = txtEmailId.Text.Trim();
                objSendMail.OrderPlacedMailToUser();

                clearControl();

                lblMsg.Text = @"Thanks for enquiring. We have send you a mail for the same. 
                                <br/> 
                                In case of any difficulty you can get in touch with our executives. 
                                <br/>
                                For contact details please check our contact us page.";

                divOrdMsg.Visible = true;
                divOrdDetail.Visible = false;
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }
}