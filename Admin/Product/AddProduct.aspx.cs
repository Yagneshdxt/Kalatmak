using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Data;

public partial class Admin_Product_AddProduct : System.Web.UI.Page
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
            //ddlmaincategory 
            ddlcategory.DataSource = objDataAccess.getDataSetQuery("select CategoryID,CategoryName from Category_Mst where IsDeleted = 0");
            ddlcategory.DataValueField = "CategoryID";
            ddlcategory.DataTextField = "CategoryName";
            ddlcategory.DataBind();
            ddlcategory.Items.Insert(0, new ListItem("--Select--", "0"));

            ValidateImage objValidateImage = new ValidateImage();
            lblLogoImagVali.Text = "* for best result keep min Height :" + objValidateImage.LogImgHeight + " min Width :" + objValidateImage.LogImgWidth;

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
            txtProductname.Text = "";
            ddlcategory.ClearSelection();
            ddlcategory.SelectedValue = "0";
            txtprice.Text = "";
            txtSize.Text = "";
            ImgEdit.ImageUrl = "";
            txtSeqNo.Text = "";
            radioactive.Checked = true;
            hdProdid.Value = "";
            hdnImageColor.Value = "";
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
            DivEditImg.Visible = false;
            RfVImageFile.Enabled = true;
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
            if (!String.IsNullOrWhiteSpace(sqlWhere))
            {
                StringBuilder sqlQuer = new StringBuilder();
                sqlQuer.Append(@"SELECT  
                            a.ProductID,
                            a.CategoryId,
                            a.ProductName,
                            a.Price,
                            ISNULL(a.Size,'') Size,
                            a.SeqNo,
                            a.isActive,
                            case when a.IsActive= 1 then 'Active' else 'Inactive' end as actInac,
                            b.CategoryName,
                            c.ImagePath,
                            c.ImageId,
                            c.imgColorCode
                            from Product_Mst a 
                            join Category_Mst b on a.CategoryId = b.CategoryID and b.IsDeleted = 0
                            join ProductImage_mst c on a.ProductID = c.ProductId and c.isFeatured = 1 and c.isDeleted = 0
                            WHERE a.IsDeleted = 0 ");
                if (!String.IsNullOrEmpty(sqlWhere))
                    sqlQuer.Append(sqlWhere);
                sqlQuer.Append(" order by a.SeqNo");
                grdRootcat.DataSource = objDataAccess.getDataSetQuery(sqlQuer.ToString());
                grdRootcat.DataBind();
            }
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
            Label lblProductname = grRow.FindControl("lblProductname") as Label;
            Label lblPrice = grRow.FindControl("lblPrice") as Label;
            Label lblSize = grRow.FindControl("lblSize") as Label;
            Label lblSeqNo = grRow.FindControl("lblSeqNo") as Label;
            HiddenField hdnactiveflag = grRow.FindControl("hdnactiveflag") as HiddenField;
            Image ImgProdImgGr = grRow.FindControl("ImgProdImg") as Image;
            HiddenField hdnImageIdGr = grRow.FindControl("hdnImageId") as HiddenField;
            HiddenField hdnImageColorGr = grRow.FindControl("hdnImageColorGr") as HiddenField;

            DivEditImg.Visible = true;
            RfVImageFile.Enabled = false;

            txtProductname.Text = lblProductname.Text.Trim();
            ddlcategory.ClearSelection();
            ddlcategory.SelectedValue = hdncatID.Value;
            txtprice.Text = lblPrice.Text;
            txtSize.Text = lblSize.Text;
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
            hdProdid.Value = hdnProdIDGr.Value;
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

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow grRow = (GridViewRow)(((LinkButton)sender).NamingContainer);
            HiddenField hdnProdID = grRow.FindControl("hdnProdID") as HiddenField;
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@DeleteFlage", '1'),
                new SqlParameter("@ActiveFlage", Convert.ToInt32(0)),
                new SqlParameter("@ProductID", Convert.ToInt64(hdnProdID.Value)),
                };
            string SqlQuery = @"UPDATE Product_Mst SET 
                                IsDeleted=@DeleteFlage, 
                                IsActive=@ActiveFlage
                                WHERE ProductID=@ProductID";
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
            //errMsg = ValidateUpdateCategory(Convert.ToInt64(hdrootid.Value));

            string ImgfileName = "", SmallImgFile = "";

            if ((fileImage.HasFile) && (fileImage.PostedFile.ContentLength > 0))
            {
                ValidateImage objImg = new ValidateImage();
                objImg.saveimage(fileImage, out ImgfileName, out SmallImgFile, txtProductname.Text.Trim());
            }


            if (!String.IsNullOrEmpty(errMsg))
            {
                AlertMsg(errMsg.Replace("\n", "\\n"));
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
               new SqlParameter("@ProductName", txtProductname.Text.Trim()),
               new SqlParameter("@CategoryId", Convert.ToInt64(ddlcategory.SelectedValue)),
               new SqlParameter("@Price", txtprice.Text.Trim()),
               new SqlParameter("@Size", txtSize.Text.Trim()),
               String.IsNullOrWhiteSpace(txtSeqNo.Text)?new SqlParameter("@SeqNo", DBNull.Value): new SqlParameter("@SeqNo", Convert.ToInt64(txtSeqNo.Text)),
               new SqlParameter("@ActiveFlage", i),
               new SqlParameter("@ProductID", Convert.ToInt64(hdProdid.Value)),
               new SqlParameter("@ImagePath", ImgfileName),
               new SqlParameter("@ImageId", Convert.ToInt64(hdnImageId.Value)),
               new SqlParameter("@imgColorCode", hdnImageColor.Value),
               new SqlParameter("@smallImgPath",SmallImgFile)
             };
            chkflag = objDataAccess.DaExecNonQueryStr("Insert_Edit_Product", paras, System.Data.CommandType.StoredProcedure);

            if (chkflag == 0)
            {
                AlertMsg("Error updating the records");
            }
            else
            {
                ResetContorl();
                AlertMsg("Records updated successfuly");
            }

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
            //errMsg = ValidateInsertCategory();

            string ImgfileName = "", SmallImgFile = "";
            ValidateImage objImg = new ValidateImage();
            objImg.saveimage(fileImage, out ImgfileName, out SmallImgFile, txtProductname.Text.Trim());

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
               new SqlParameter("@ProductName", txtProductname.Text.Trim()),
               new SqlParameter("@CategoryId", Convert.ToInt64(ddlcategory.SelectedValue)),
               new SqlParameter("@Price", txtprice.Text.Trim()),
               new SqlParameter("@Size", txtSize.Text.Trim()),
               String.IsNullOrWhiteSpace(txtSeqNo.Text)?new SqlParameter("@SeqNo", DBNull.Value): new SqlParameter("@SeqNo", Convert.ToInt64(txtSeqNo.Text)),
               new SqlParameter("@ActiveFlage", i),
               new SqlParameter("@ImagePath", ImgfileName),
               new SqlParameter("@imgColorCode",hdnImageColor.Value),
               new SqlParameter("@smallImgPath",SmallImgFile)
            };

            chkflag = objDataAccess.DaExecNonQueryStr("Insert_Edit_Product", paras, System.Data.CommandType.StoredProcedure);

            //Folder creation logic
            if (chkflag > 0)
            {
                ClearControl();
                AlertMsg("Product saved successfuly");
            }
            //close connnection
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
            if (!String.IsNullOrEmpty(txtVwProduct.Text))
            {
                sqlWher.Append(" AND a.ProductName LIKE '%")
                    .Append(txtVwProduct.Text + "%'");
            }

            if (!String.IsNullOrWhiteSpace(txtVwCatName.Text))
            {
                sqlWher.Append(" AND b.CategoryName LIKE '%")
                     .Append(txtVwCatName.Text + "%'");
            }

            if (ddlStatusFil.SelectedValue != "--Select--")
            {
                sqlWher.Append(" AND a.IsActive ='")
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
        btnview_Click(null, null);
    }

    #region ColorCRUD

    [WebMethod]
    public static String AddColor(ProductColor data)
    {
        Int32 chkValue = 0;
        if (data.ProductId == 0 && String.IsNullOrWhiteSpace(Convert.ToString(data.tempId)))
        {
            data.tempId = Guid.NewGuid().ToString();
        }
        DataAccess objda = new DataAccess();
        SqlParameter[] paras = new SqlParameter[]{
            data.ProductId == 0 ? new SqlParameter("@ProductID", DBNull.Value) :new SqlParameter("@ProductID", data.ProductId),
            new SqlParameter("@colorCode", data.ColorCode),
            String.IsNullOrWhiteSpace(Convert.ToString(data.tempId))?    new SqlParameter("@tempId", DBNull.Value):new SqlParameter("@tempId", data.tempId)
            };
        chkValue = objda.DaExecNonQueryStr("insert into productColor_Mst(ProductID,colorCode,tempId) values(@productID,@colorCode,@tempId)", paras);

        if (chkValue > 0)
        {
            return "{\"Success\":true,\"tempId\":\"" + data.tempId + "\",\"ProductId\":\"" + Convert.ToString(data.ProductId) + "\"}";
        }
        else
        {
            return "{\"Success\":false,\"tempId\":\"" + data.tempId + "\",\"ProductId\":\"" + Convert.ToString(data.ProductId) + "\"}";
        }
    }

    [WebMethod]
    public static List<ProductColor> GetColor(ProductColor data)
    {
        DataAccess objda = new DataAccess();
        SqlParameter[] paras = new SqlParameter[]{
            data.ProductId == 0 ? new SqlParameter("@ProductID", DBNull.Value) :new SqlParameter("@ProductID", data.ProductId),
            String.IsNullOrWhiteSpace(Convert.ToString(data.tempId))?    new SqlParameter("@tempId", DBNull.Value):new SqlParameter("@tempId", data.tempId)
            };
        DataSet ds = new DataSet();
        ds = objda.getDataSetQuery("Get_ProductColors", paras, CommandType.StoredProcedure);
        List<ProductColor> ProdColorLst = new List<ProductColor>();
        if (ds != null && ds.Tables.Count > 0)
        {
            ProductColor objProdColor;
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                objProdColor = new ProductColor();
                objProdColor.ProductId = Convert.ToInt64(dr["ProductID"]);
                objProdColor.ColorCode = Convert.ToString(dr["colorCode"]);
                objProdColor.tempId = Convert.ToString(dr["tempId"] == null ? "" : dr["tempId"]);
                ProdColorLst.Add(objProdColor);
            }
        }
        return ProdColorLst;
    }

    [WebMethod]
    public static Boolean DeleteColor(ProductColor data)
    {
        Int32 chkValue = 0;
        DataAccess objda = new DataAccess();
        SqlParameter[] paras = new SqlParameter[]{
            data.ProductId == 0 ? new SqlParameter("@ProductID", DBNull.Value) :new SqlParameter("@ProductID", data.ProductId),
            new SqlParameter("@colorCode", data.ColorCode),
            String.IsNullOrWhiteSpace(Convert.ToString(data.tempId))?    new SqlParameter("@tempId", DBNull.Value):new SqlParameter("@tempId", data.tempId)
            };
        chkValue = objda.DaExecNonQueryStr("DeleteProdcutColor", paras, CommandType.StoredProcedure);

        if (chkValue > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    #endregion

}