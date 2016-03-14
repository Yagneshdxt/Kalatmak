using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;

public partial class Admin_Enquiry_PendingEnquiry : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }

        try
        {
            if (!IsPostBack)
            {
                BindGrid("");
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void BindGrid(string sqlWhere)
    {
        try
        {
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append(@"select a.EnquiryId, a.Uname,a.UemailId,a.UContactNo,
                            CONVERT(varchar, a.enquiryDt,106) as enquiryDt,b.ProductName,c.ImagePath,
                            case when a.isAnswered = 1 then 'Answered' else 'UnAnswered' end as actInac,
                            a.isAnswered 
                            from EnqiryDetails a
                            join Product_Mst b on a.productID = b.ProductID 
                            join ProductImage_mst c on a.productId = c.ProductId and c.isActive = 1 and c.isFeatured = 1 and c.isDeleted = 0
                            where 1 = 1");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            sqlQuer.Append(" order by a.EnquiryId desc");
            grdRootcat.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdRootcat.DataBind();
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void lnkAnswered_Click(object sender, EventArgs e)
    {
        try
        {
            bool isAnswered = false;

            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            Label lblEnquiryId = grRow.FindControl("lblEnquiryId") as Label;
            HiddenField hdnisAnswered = grRow.FindControl("hdnisAnswered") as HiddenField;
            if (hdnisAnswered.Value == "True")
            {
                isAnswered = false;
            }
            else
            {
                isAnswered = true;
            }

            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@isAnswered", isAnswered),
                new SqlParameter("@EnquiryId", Convert.ToInt64(lblEnquiryId.Text)),
                };
            string SqlQuery = @"update EnqiryDetails set isAnswered = @isAnswered where EnquiryId = @EnquiryId";
            objDataAccess.DaExecNonQueryStr(SqlQuery, paras);
            BindGrid("");
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void btnview_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder sqlWher = new StringBuilder();
            //sqlWher.Append(" WHERE 1=1 ");
            if (!String.IsNullOrEmpty(txtOrderId.Text.Trim()))
            {
                sqlWher.Append(" AND a.EnquiryId = '")
                    .Append(txtOrderId.Text.Trim() + "'");
            }

            if (!String.IsNullOrWhiteSpace(txtProductName.Text.Trim()))
            {
                sqlWher.Append(" AND b.ProductName Like '%")
                     .Append(txtProductName.Text.Trim() + "%'");
            }

            if (!String.IsNullOrWhiteSpace(txtUserName.Text.Trim()))
            {
                sqlWher.Append(" AND a.Uname Like '%")
                     .Append(txtUserName.Text.Trim() + "%'");
            }

            if (!String.IsNullOrWhiteSpace(txtEmailId.Text.Trim()))
            {
                sqlWher.Append(" AND a.UemailId Like '%")
                     .Append(txtEmailId.Text.Trim() + "%'");
            }

            if (!String.IsNullOrWhiteSpace(txtUserPhone.Text.Trim()))
            {
                sqlWher.Append(" AND a.UContactNo Like '%")
                     .Append(txtUserPhone.Text.Trim() + "%'");
            }
            if (ddlStatusFil.SelectedValue != "--Select--")
            {
                sqlWher.Append(" AND a.isAnswered ='")
                    .Append(ddlStatusFil.SelectedValue + "'");
            }

            BindGrid(sqlWher.ToString());
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void grdRootcat_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdRootcat.PageIndex = e.NewPageIndex;
        BindGrid("");
    }
}