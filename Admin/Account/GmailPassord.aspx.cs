using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Admin_Account_GmailPassord : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }

        if (!IsPostBack)
        {
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
        Int32 chkInt = 0;
        try
        {
            SqlParameter[] para = new SqlParameter[]{
            new SqlParameter("@NewPassword",txtPassword.Text)
            };

            chkInt = objDataAccess.DaExecNonQueryStr("update GeneralConstant set genConstValue = @NewPassword where genConstKey = 'AdminEmailPass'", para);
            
        }
        catch (Exception)
        {
            chkInt = 0;
        }

        if (chkInt <= 0)
        {
            lblMsg.Text = "Password could not be updated due to some unknow error.";
        }
        else
        {
            lblMsg.Text = "Password Successfuly updated";
        }
    }
}