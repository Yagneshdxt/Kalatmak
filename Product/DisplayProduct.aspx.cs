using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;

public partial class Product_DisplayProduct : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();

    public Int64 CatId { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["catID"] != null)
            CatId = Convert.ToInt64(Request.QueryString["catID"]);
        else
            Response.Redirect("~/Default.aspx");

        if (!IsPostBack)
        {
            FillControl();
        }
    }

    public void FillControl()
    {
        try
        {
            StringBuilder sqlQuer = new StringBuilder();
            sqlQuer.Append(@"select a.ProductID,a.ProductName,a.Price,a.Size,b.ImagePath,c.CategoryName,a.CategoryId,b.ImageId,b.thumNailImgPath  
                            from Product_Mst a
                            join ProductImage_mst b on a.ProductID = b.ProductId and b.isFeatured = 1 and b.isDeleted = 0 and b.isActive = 1
                            join Category_Mst c on a.CategoryId = c.CategoryID and c.IsActive = 1 and c.IsDeleted = 0
                            where a.CategoryId = @CategoryId 
                            and a.isActive = 1 and a.IsDeleted = 0
                            order by a.SeqNo");
            DataSet Ds = new DataSet();
            SqlParameter[] para = new SqlParameter[]{
                new SqlParameter("@CategoryId", Convert.ToInt64(CatId))
            };
            Ds = objDataAccess.getDataSetQuery(sqlQuer.ToString(), para);
            repProDp.DataSource = Ds;
            repProDp.DataBind();
            lblCatName.Text = "";
            if (Ds != null && Ds.Tables.Count > 0 && Ds.Tables[0].Rows.Count > 0)
            {
                lblCatName.Text = Convert.ToString(Ds.Tables[0].Rows[0]["CategoryName"]);
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        //(repProDp.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        dtPager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        this.FillControl();
    }

    public String GetShareUrl(String ProductName, String ProductID)
    {
        String shareUrl = "", DomainAdd = "";

        DomainAdd = ConfigurationManager.AppSettings["domainAdd"].ToString();

        //shareUrl = "return windowpop(\"http://www.facebook.com/sharer.php?s=100&amp;p[title]=" + HttpUtility.UrlEncode(ProductName) + "&amp;p[summary]=Perfrect Gift for all occasion&amp;p[url]=" + HttpUtility.UrlEncode(DomainAdd + "Product/DisplayProduct.aspx?catID=" + CategroyId + "&ImId=" + ImageId) + "&amp;p[images][0]=" + HttpUtility.UrlEncode(DomainAdd + ImagePath.Replace("~/", "") + "&ImId=" + ImageId) + "\");";
        shareUrl = "return windowpop(\"http://www.facebook.com/sharer.php?u=" + HttpUtility.UrlEncode(DomainAdd + "Product/ProductDetail/" + ProductName + "_" + ProductID) + "\");";

        //shareUrl = "return windowpop(\"http://www.facebook.com/sharer.php?u=" + HttpUtility.UrlEncode(DomainAdd + "ShareProduct.aspx?PrName=" + ProductName + "&CatId=" + CategroyId + "&ImgPath=" + ImagePath.Replace("~/", "") + "&ImId=" + ImageId) + "\")";

        return shareUrl;
    }
    
}