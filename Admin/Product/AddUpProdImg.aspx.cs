using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.IO;

public partial class Admin_Product_AddUpProdImg : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserInfo objUserInfo = UserInfo.GetUserInfo();
        if (objUserInfo == null)
        {
            Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }
        else
        {
            if (!objUserInfo.IsAdmin())
                Response.Redirect("~/Admin/Account/AdminLogin.aspx");
        }

        try
        {
            if (!IsPostBack)
            {
                fillControl();
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void fillControl()
    {
        try
        {
            ddlcategory.DataSource = objDataAccess.getDataSetQuery("select CategoryID,CategoryName from Category_Mst where IsDeleted = 0");
            ddlcategory.DataValueField = "CategoryID";
            ddlcategory.DataTextField = "CategoryName";
            ddlcategory.DataBind();
            ddlcategory.Items.Insert(0, new ListItem("--Select--", "0"));

            ValidateImage objValidateImage = new ValidateImage();
            lblLogoImagVali.Text = "* for best result keep min Height :" + objValidateImage.LogImgHeight + " min Width :" + objValidateImage.LogImgWidth;

            //BindGrid("");
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void ddlcategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bindddlProducts();

            grdCategory.DataSource = null;
            grdCategory.DataBind();
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void bindddlProducts()
    {
        try
        {
            ddlProduct.ClearSelection();
            ddlProduct.Items.Clear();

            ddlProduct.DataSource = objDataAccess.getDataSetQuery("select ProductID,ProductName from dbo.Product_Mst where IsDeleted = 0 and CategoryId = " + Convert.ToInt32(ddlcategory.SelectedValue));
            ddlProduct.DataValueField = "ProductID";
            ddlProduct.DataTextField = "ProductName";
            ddlProduct.DataBind();
            ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BindGrid("");
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
            /*ddlcategory.ClearSelection();
            ddlcategory.SelectedValue = "0";
            ddlProduct.ClearSelection();
            ddlProduct.SelectedValue = "0";
            grdCategory.DataSource = String.Empty;
            grdCategory.DataBind();*/
            hdnImageId.Value = "";
            txtSeqNo.Text = "";
            radioactive.Checked = true;
            hdnImageColor.Value = "";
            ImgEdit.ImageUrl = "";
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
            DivEditImg.Visible = false;
            RfVImageFile.Enabled = true;
            ddlcategory.Enabled = true;
            ddlProduct.Enabled = true;
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
            sqlQuer.Append(@"select a.ImageId,a.ImagePath,  
                            a.isActive,
                            case when a.IsActive= 1 then 'Active' else 'Inactive' end as actInac
                            ,a.SeqNo
                            ,a.isFeatured
                            ,b.ProductID,b.ProductName
                            ,c.CategoryID,c.CategoryName
                            ,a.imgColorCode
                            from dbo.ProductImage_mst a
                            join Product_Mst b on a.ProductId = b.ProductID and b.IsDeleted = 0 and b.ProductID = @ProductID
                            join Category_Mst c on b.CategoryId = c.CategoryID and c.IsDeleted = 0
                            where a.isDeleted = 0");
            if (!String.IsNullOrEmpty(sqlWhere))
                sqlQuer.Append(sqlWhere);
            sqlQuer.Append(" order by a.SeqNo");

            SqlParameter[] para = new SqlParameter[]{
                new SqlParameter("@ProductID",Convert.ToInt64(ddlProduct.SelectedValue))
            };

            grdCategory.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString(), para);
            grdCategory.DataBind();
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
            //errMsg = ValidateInsertCategory();

            string ImgfileName = "", SmallImgFile = "";
            ValidateImage objImg = new ValidateImage();
            objImg.saveimage(fileImage, out ImgfileName, out SmallImgFile, ddlProduct.SelectedItem.Text.Trim());

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
               new SqlParameter("@ProductID", Convert.ToInt64(ddlProduct.SelectedValue)),
               String.IsNullOrWhiteSpace(txtSeqNo.Text)? new SqlParameter("@SeqNo", DBNull.Value): new SqlParameter("@SeqNo", Convert.ToInt64(txtSeqNo.Text)),
               new SqlParameter("@ActiveFlage", i),
               new SqlParameter("@imgColorCode", hdnImageColor.Value),
               new SqlParameter("@ImagePath", ImgfileName),
               new SqlParameter("@smallImgPath",SmallImgFile)
            };

            chkflag = objDataAccess.DaExecNonQueryStr(@"
                                            IF @SeqNo is null BEGIN
                                                select @SeqNo = (MAX(SeqNo) + 1) from ProductImage_mst where isActive = 1 and isDeleted = 0 and ProductId = @ProductID
                                            END
                                            insert into ProductImage_mst(ProductId,ImagePath,thumNailImgPath,imgColorCode,SeqNo,isActive,isFeatured,isDeleted)
		                                    values(@ProductID,@ImagePath,@smallImgPath,@imgColorCode,@SeqNo,@ActiveFlage,0,0)", paras);

            //Folder creation logic
            if (chkflag > 0)
            {
                ClearControl();
                AlertMsg("Image Added successfuly");
            }
            //close connnection
            BindGrid("");
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnProdIDGr = grRow.FindControl("hdnProdID") as HiddenField;
            HiddenField hdncatID = grRow.FindControl("hdncatID") as HiddenField;
            Label lblSeqNo = grRow.FindControl("lblSeqNo") as Label;
            HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;
            Image ImgProdImgGr = grRow.FindControl("ImgProdImg") as Image;
            HiddenField hdnImageIdGr = grRow.FindControl("hdnImageId") as HiddenField;
            HiddenField hdnImageColorGr = grRow.FindControl("hdnImageColorGr") as HiddenField;

            DivEditImg.Visible = true;
            RfVImageFile.Enabled = false;

            ddlcategory.ClearSelection();
            ddlcategory.SelectedValue = hdncatID.Value;
            bindddlProducts();
            ddlProduct.SelectedValue = hdnProdIDGr.Value;

            ddlcategory.Enabled = false;
            ddlProduct.Enabled = false;

            ImgEdit.ImageUrl = ImgProdImgGr.ImageUrl;
            txtSeqNo.Text = lblSeqNo.Text;
            hdnImageId.Value = hdnImageIdGr.Value;
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
            hdnImageColor.Value = hdnImageColorGr.Value;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
            btnCancel.Visible = true;
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
            Int32 chkflag;

            string ImgfileName = "", SmallImgFile = "";
            if ((fileImage.HasFile) && (fileImage.PostedFile.ContentLength > 0))
            {
                ValidateImage objImg = new ValidateImage();
                objImg.saveimage(fileImage, out ImgfileName, out SmallImgFile, ddlProduct.SelectedItem.Text.Trim());
            }

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
                    new SqlParameter("@ImageId",Convert.ToInt32(hdnImageId.Value)),
                    new SqlParameter("@isActive", i),
                    new SqlParameter("@SeqNo", txtSeqNo.Text),
                    String.IsNullOrWhiteSpace(ImgfileName)?new SqlParameter("@ImagePath", DBNull.Value): new SqlParameter("@ImagePath", ImgfileName),
                    new SqlParameter("@imgColorCode", hdnImageColor.Value),
                    String.IsNullOrWhiteSpace(SmallImgFile)?new SqlParameter("@smallImgPath", DBNull.Value): new SqlParameter("@smallImgPath", SmallImgFile),
                };
            chkflag = objDataAccess.DaExecNonQueryStr(@"
                      update ProductImage_mst set SeqNo = @SeqNo, imgColorCode = @imgColorCode, 
                      ImagePath = isnull(@ImagePath,ImagePath),
                      thumNailImgPath = isnull(@smallImgPath,thumNailImgPath),
                      isActive = @isActive where ImageId = @ImageId", paras);
            if (chkflag > 0)
            {
                ResetContorl();
                BindGrid("");
                AlertMsg("Image Updated successfuly");
            }
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

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow gr = (sender as LinkButton).NamingContainer as GridViewRow;
            HiddenField ImageId = gr.FindControl("hdnImageId") as HiddenField;
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@ImageId",Convert.ToInt32(ImageId.Value)),
                };
            Int32 chkflag = objDataAccess.DaExecNonQueryStr("update ProductImage_mst set isDeleted = 1,isActive = 0, isFeatured = 0 where ImageId = @ImageId", paras);
            if (chkflag > 0)
            {
                BindGrid("");
                AlertMsg("Record Deleted Successfuly");
            }
            if (chkflag <= 0)
            {
                AlertMsg("Error while Deleting record.");
            }
        }
        catch (Exception)
        {
            AlertMsg("Error while Deleting record.");
        }
    }

    /*
    protected void grdCategory_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            GridViewRow gvr = grdCategory.Rows[e.RowIndex] as GridViewRow;
            HiddenField hdnImageId = gvr.FindControl("hdnImageId") as HiddenField;
            TextBox txtSeqNo = gvr.FindControl("txtSeqNo") as TextBox;
            RadioButtonList rdbStatus = gvr.FindControl("rdbStatus") as RadioButtonList;
            Int32 chkflag;
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@ImageId",Convert.ToInt32(hdnImageId.Value)),
                    new SqlParameter("@isActive", rdbStatus.SelectedValue),
                    new SqlParameter("@SeqNo", txtSeqNo.Text),
                };
            chkflag = objDataAccess.DaExecNonQueryStr(@"update ProductImage_mst set SeqNo = @SeqNo, isActive = @isActive where ImageId = @ImageId", paras);
            grdCategory.EditIndex = -1;
            BindGrid("");
        }
        catch (Exception)
        {

        }
    }

    protected void grdCategory_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            grdCategory.EditIndex = e.NewEditIndex;
            BindGrid("");
        }
        catch (Exception)
        {

        }
    }

    protected void grdCategory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            grdCategory.EditIndex = -1;
            BindGrid("");
        }
        catch (Exception)
        {

        }
    }

    protected void grdCategory_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridViewRow gvr = grdCategory.Rows[e.RowIndex] as GridViewRow;
            HiddenField hdnImageId = gvr.FindControl("hdnImageId") as HiddenField;
            SqlParameter[] paras = new SqlParameter[]{
                    new SqlParameter("@ImageId",Convert.ToInt32(hdnImageId.Value)),
                };
            Int32 chkflag = 0;// = objDataAccess.DaExecNonQueryStr("update ProductImage_mst set isDeleted = 1,isActive = 0, isFeatured = 0 where ImageId = @ImageId", paras);
            if (chkflag > 0)
            {
                AlertMsg("Record Deleted Successfuly");
                BindGrid("");
            }
            if (chkflag <= 0)
            {
                AlertMsg("Error while Deleting record.");
            }
        }
        catch (Exception)
        {
            AlertMsg("Error while Deleting record.");
        }
    }*/

    protected void grdCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdCategory.PageIndex = e.NewPageIndex;
        BindGrid("");
    }
    protected void grdCategory_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hdnIsFeatured = e.Row.FindControl("hdnIsFeatured") as HiddenField;
                if (hdnIsFeatured.Value == "True")
                {
                    e.Row.Cells[e.Row.Cells.Count - 1].Visible = false;
                }
                else
                {
                    e.Row.Cells[e.Row.Cells.Count - 1].Visible = true;
                    LinkButton lnkBtn = ((LinkButton)e.Row.Cells[e.Row.Cells.Count - 1].Controls[1]);
                    if (lnkBtn.CommandName == "Delete")
                        lnkBtn.OnClientClick = "return confirm('Do you really want to delete?');";
                }
            }
        }
        catch (Exception)
        {
            throw;
        }
    }
}