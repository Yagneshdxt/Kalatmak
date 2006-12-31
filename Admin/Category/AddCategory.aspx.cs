using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;

public partial class Admin_Category_AddCategory : System.Web.UI.Page
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

    protected void ClearControl()
    {
        try
        {
            txtcategoryname.Text = "";
            txtSeqNo.Text = "";
            radioactive.Checked = true;
            BindGrid("");
        }
        catch (Exception)
        {
            throw;
        }
    }
    protected void ResetContorl()
    {
        try
        {
            ClearControl();
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
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
            sqlQuer.Append(@"SELECT CategoryID,CategoryName,SeqNo,IsActive, 
                            case when IsActive= 1 then 'Active' else 'Inactive' end as actInac 
                            from Category_Mst WHERE IsDeleted = 0");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            sqlQuer.Append(" order by SeqNo");
            grdRootcat.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            grdRootcat.DataBind();
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected string ValidateInsertCategory()
    {
        string errMsg = "";
        try
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@CatName",txtcategoryname.Text.Trim())
            };
            Int32 IfExistsChk = Convert.ToInt32(objDataAccess.SelectScalarRetObj("SELECT COUNT(1) FROM Category_Mst WHERE CategoryName = @CatName AND IsDeleted = 0", param));
            if (IfExistsChk > 0)
            {
                errMsg = "Category With this name already exists \n";
            }
        }
        catch (Exception)
        {
            errMsg = "Error Inserting the record \n";
        }
        return errMsg;
    }

    protected string ValidateUpdateCategory(Int64 catID)
    {
        string errMsg = "";
        try
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@CatName",txtcategoryname.Text.Trim()),
                new SqlParameter("@CatId",catID)
            };
            Int32 IfExistsChk = Convert.ToInt32(objDataAccess.SelectScalarRetObj("SELECT COUNT(1) FROM Category_Mst WHERE CategoryName = @CatName AND IsDeleted = 0 AND CategoryID != @CatId", param));
            if (IfExistsChk > 0)
            {
                errMsg = "Category With this name already exists \n";
            }
        }
        catch (Exception)
        {
            errMsg = "Error Updating Category \n";
        }
        return errMsg;
    }

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnRootCategorID = grRow.FindControl("hdnRootCategorID") as HiddenField;
            Label lblrootcatnmae = grRow.FindControl("lblrootcatnmae") as Label;
            Label lblSeqNo = grRow.FindControl("lblSeqNo") as Label;
            HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;

            txtcategoryname.Text = lblrootcatnmae.Text.Trim();
            txtSeqNo.Text = lblSeqNo.Text.Trim();
            radioactive.Checked = false;
            radiodeactive.Checked = false;
            if (hdnactiveflag.Value == "True")
            {
                radioactive.Checked = true;
            }
            else
            {
                radiodeactive.Checked = true;
            }
            hdrootid.Value = hdnRootCategorID.Value;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
            btnCancel.Visible = true;
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
            HiddenField hdnRootCategorID = grRow.FindControl("hdnRootCategorID") as HiddenField;
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@DeleteFlage", '1'),
                new SqlParameter("@ActiveFlage", Convert.ToInt32(0)),
                new SqlParameter("@Rootcatid", Convert.ToInt64(hdnRootCategorID.Value)),
                };
            string SqlQuery = @"UPDATE Category_Mst SET 
                                IsDeleted=@DeleteFlage, 
                                IsActive=@ActiveFlage
                                WHERE CategoryID=@Rootcatid";
            objDataAccess.DaExecNonQueryStr(SqlQuery, paras);
            BindGrid("");
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            string errMsg = "";
            errMsg = ValidateUpdateCategory(Convert.ToInt64(hdrootid.Value));
            if (!String.IsNullOrEmpty(errMsg))
            {
                //lblErrMsg.Text = errMsg.Replace("\n", "<br/>");
                AlertMsg(errMsg.Replace("\n", "\\n"));
                //Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "errMsg", "alert('hi')",true);
                return;
            }

            //Data insert logic
            int chkflag = 1;
            int i;
            if (radioactive.Checked == true)
            {
                i = 1;
            }
            else
            {
                i = 0;
            }
            SqlParameter[] paras = new SqlParameter[]{
               new SqlParameter("@CatName", txtcategoryname.Text.Trim()),
               new SqlParameter("@SeqNo", Convert.ToInt64(String.IsNullOrWhiteSpace(txtSeqNo.Text)?"0":txtSeqNo.Text)),
                new SqlParameter("@ActiveFlage", i),
                new SqlParameter("@Rootcatid", Convert.ToInt64(hdrootid.Value)),
                };

            SqlConnection conObj = objDataAccess.conObj;
            //open connnection
            if (conObj.State == System.Data.ConnectionState.Closed)
                conObj.Open();
            SqlTransaction sqlTrn = conObj.BeginTransaction();
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append(@"UPDATE Category_Mst SET CategoryName=@CatName,
                            IsActive=@ActiveFlage,SeqNo = @SeqNo
                            WHERE CategoryID=@Rootcatid");
            chkflag = objDataAccess.DaExecNonQueryStrTrn(sqlQuer.ToString(), paras, sqlTrn, conObj);

            if (chkflag > 0)
            {
                if (chkflag == 0)
                {
                    sqlTrn.Rollback();
                    AlertMsg("Error updating the records");
                }
                else
                {
                    sqlTrn.Commit();
                    ResetContorl();
                    AlertMsg("Records updated successfuly");
                }
            }
            //close connnection
            if (conObj.State == System.Data.ConnectionState.Open)
                conObj.Close();
            BindGrid("");
        }
        catch (Exception)
        {
            throw;
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            ResetContorl();
        }
        catch (Exception)
        {
            throw;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string errMsg = "";
            errMsg = ValidateInsertCategory();
            if (!String.IsNullOrEmpty(errMsg))
            {
                //lblErrMsg.Text = errMsg.Replace("\n", "<br/>");
                AlertMsg(errMsg.Replace("\n", "\\n"));
                //Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "errMsg", "alert('hi')",true);
                return;
            }

            //Data insert logic
            int chkflag = 1;
            int i;
            if (radioactive.Checked == true)
            {
                i = 1;
            }
            else
            {
                i = 0;
            }
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@CatName", txtcategoryname.Text.Trim()),
                new SqlParameter("@ActiveFlage", i),
                new SqlParameter("@SeqNo", Convert.ToInt64(String.IsNullOrWhiteSpace(txtSeqNo.Text)?"0":txtSeqNo.Text)),
                new SqlParameter("@IsDeleted","0")
                };

            SqlConnection conObj = objDataAccess.conObj;
            //open connnection
            if (conObj.State == System.Data.ConnectionState.Closed)
                conObj.Open();
            SqlTransaction sqlTrn = conObj.BeginTransaction();
            chkflag = objDataAccess.DaExecNonQueryStrTrn(@"insert 
                                                            into Category_Mst(CategoryName,SeqNo,IsActive,IsDeleted) 
                                                            values(@CatName,@SeqNo,@ActiveFlage,@IsDeleted)", paras, sqlTrn, conObj);

            //Folder creation logic
            if (chkflag > 0)
            {
                if (chkflag == 0)
                {
                    sqlTrn.Rollback();
                }
                else
                {
                    sqlTrn.Commit();
                    ClearControl();
                    AlertMsg("Root Category saved successfuly");
                }
            }
            //close connnection
            if (conObj.State == System.Data.ConnectionState.Open)
                conObj.Close();
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
            if (!String.IsNullOrEmpty(txtProductID.Text))
            {
                sqlWher.Append(" AND CategoryName LIKE '%")
                    .Append(txtProductID.Text + "%'");
            }

            if (!String.IsNullOrWhiteSpace(txtViewSeq.Text))
            {
                sqlWher.Append(" AND SeqNo = '")
                     .Append(txtViewSeq.Text + "'");
            }

            if (ddlStatusFil.SelectedValue != "--Select--")
            {
                sqlWher.Append(" AND IsActive ='")
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