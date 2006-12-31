using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;

public partial class Admin_order_AnsweredOrder : System.Web.UI.Page
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
            sqlQuer.Append(@"select a.orderID, a.Uname,a.UemailId,a.UContactNo,a.UAddress,sm.StateName,a.UPinNo,a.UOrderQty
                            ,CONVERT(varchar, a.UordDt,106) as orDt,b.ProductName,a.prodPrice,a.prodImg,
                            case when a.isDelivered= 1 then 'Delivered' else 'UnDelivered' end as actInac,
                            a.isDelivered
                            from OrderDetails a
                            join Product_Mst b on a.productID = b.ProductID 
                            join State_Mst sm on a.UState = sm.StateId
                            where a.isAnswered = 1 and a.isDeleted = 0");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            sqlQuer.Append(" order by a.orderID desc");
            grdRootcat.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdRootcat.DataBind();
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            Label lblOrdId = grRow.FindControl("lblOrdId") as Label;
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@isDeleted", '1'),
                new SqlParameter("@orderID", Convert.ToInt64(lblOrdId.Text)),
                };
            string SqlQuery = @"update OrderDetails set isDeleted = @isDeleted where orderID = @orderID";
            objDataAccess.DaExecNonQueryStr(SqlQuery, paras);
            BindGrid("");
        }
        catch (Exception)
        {
            throw;
        }
    }


    protected void lnkDelivered_Click(object sender, EventArgs e)
    {
        try
        {
            bool isDelivered = false;

            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            Label lblOrdId = grRow.FindControl("lblOrdId") as Label;
            HiddenField hdnIsdelevered = grRow.FindControl("hdnIsdelevered") as HiddenField;
            if (hdnIsdelevered.Value == "True")
            {
                isDelivered = false;
            }
            else {
                isDelivered = true;
            }

            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@isDelivered", isDelivered),
                new SqlParameter("@orderID", Convert.ToInt64(lblOrdId.Text)),
                };
            string SqlQuery = @"update OrderDetails set isDelivered = @isDelivered where orderID = @orderID";
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
                sqlWher.Append(" AND a.orderID = '")
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