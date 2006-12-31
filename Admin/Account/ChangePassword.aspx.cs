using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_Account_ChangePassword : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }
    }

    protected void btnChangePass_Click(object sender, EventArgs e)
    {
        String Chkflag = "";
        try
        {
            lblMsg.Text = "";
            UserInfo objUserInfo = UserInfo.GetUserInfo();
            SqlParameter[] param = new SqlParameter[]{
            new SqlParameter("@OldPassword",txtOldPassword.Text),
            new SqlParameter("@NewPassword",txtNewPassword.Text)
            };
            Chkflag = Convert.ToString(objDataAccess.SelectScalarRetObj("ChangePasswords", param, CommandType.StoredProcedure));

            if (Chkflag == "success")
            {
                lblMsg.Text = "Password changed successfuly";
            }
            else
            {
                lblMsg.Text = "Old password Incorrect. Please try again.";
            }
        }
        catch (Exception)
        {
            throw;
        }
    }
}