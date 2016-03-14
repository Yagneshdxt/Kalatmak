using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Data;
using System.Configuration;

public partial class Admin_Account_AdminLogin : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            txtEmail.Text = Convert.ToString(objDataAccess.SelectScalarRetObj("select top 1 genConstValue from GeneralConstant where genConstKey = 'AdminEmailId'", null));
            txtEmail.ReadOnly = true;
        }
    }

    protected void AlertMsg(string msg)
    {
        try
        {
            string scripfun = "alert('" + msg + "')";
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "keya", "alert('" + msg + "')", true);
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        bool chkFlag = false;
        try
        {
            String ValidPass = Convert.ToString(objDataAccess.SelectScalarRetObj("select top 1 genConstValue from GeneralConstant where genConstKey = 'AdminLoginPass'", null));
            if (!String.IsNullOrWhiteSpace(txtPassword.Text) && txtPassword.Text.Trim().ToLower() == ValidPass)
            {
                Session["UserInfo"] = "";
                UserInfo objUserInfo = new UserInfo()
                {
                    userId = Convert.ToInt64("1"),
                    fName = "Admin",
                    lName = "",
                };
                UserInfo.setUserInfo(objUserInfo);
                chkFlag = true;
            }
        }
        catch (Exception)
        {
            chkFlag = false;
        }

        if (!chkFlag)
        {
            lblMsg.Text = "Logg failed!!! invalid user name and/or password";
        }
        else {
            Response.Redirect("~/Admin/order/PendingOrders.aspx", true);
        }
    }

    protected void lnkForgotPass_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            ds = objDataAccess.getDataSetQuery("forgotPassword", null, CommandType.StoredProcedure);
            if (ds != null && ds.Tables.Count > 0)
            {
                SendMail objSendMail = new SendMail();
                String AdminPass = "";
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
                    if (Convert.ToString(dr["KeyName"]).Trim() == "AdminPass")
                    {
                        AdminPass = Convert.ToString(dr["genConstValue"]);
                    }
                }//end of foreach

                objSendMail.sendForgotPasswordMail(AdminPass);
                AlertMsg("Your password is mailed to your registered email Id.");
            }
        }
        catch (Exception)
        {
            throw;
        }
    }
}