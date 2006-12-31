using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Product_MoreImages : System.Web.UI.Page
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
            Ds = objDataAccess.getDataSetQuery(@"select a.ProductName,a.Price,b.ImagePath,a.ProductID,a.CategoryId,b.ImageId
                                                from Product_Mst a
                                                join ProductImage_mst b on a.ProductID = b.ProductId and b.ProductId = @ProductId and b.isActive = 1 and b.isDeleted = 0
                                                order by b.SeqNo asc", para);

            if (Ds != null && Ds.Tables.Count > 0)
            {
                repBigImg.DataSource = Ds.Tables[0];
                repBigImg.DataBind();
                repSmallImg.DataSource = Ds.Tables[0];
                repSmallImg.DataBind();
            }


        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public String GetShareUrl(String ProductName, String CategroyId, String ImagePath, String ImageId)
    {
        String shareUrl = "",DomainAdd = "";

        DomainAdd = ConfigurationManager.AppSettings["domainAdd"].ToString();

        shareUrl = "return windowpop(\"http://www.facebook.com/sharer.php?s=100&amp;p[title]=" + HttpUtility.UrlEncode(ProductName) + "&amp;p[summary]=Perfrect Gift for all occasion&amp;p[url]=" + HttpUtility.UrlEncode(DomainAdd + "Product/DisplayProduct.aspx?catID=" + CategroyId + "&ImId=" + ImageId) + "&amp;p[images][0]=" + HttpUtility.UrlEncode(DomainAdd + ImagePath.Replace("~/", "") + "&ImId=" + ImageId) + "\");";
        //shareUrl = "return windowpop(\"http://www.facebook.com/sharer.php?u=" + HttpUtility.UrlEncode(DomainAdd + "ShareProduct.aspx?PrName=" + ProductName + "&CatId=" + CategroyId + "&ImgPath=" + ImagePath.Replace("~/", "") + "&ImId=" + ImageId) + "\")";

        return shareUrl;
    }
}