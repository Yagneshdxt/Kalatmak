using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Configuration;

public partial class Version1_Default : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
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
            sqlQuer.Append("get_homePageData");
            DataSet Ds = new DataSet();
            Ds = objDataAccess.getDataSetQuery(sqlQuer.ToString(), null, CommandType.StoredProcedure);

            if (Ds != null && Ds.Tables.Count > 0)
            {
                Session["DefaultDataSet"] = Ds;
                rptCategory.DataSource = Ds.Tables[0];
                rptCategory.DataBind();
            }
            /*RepLeftLnk.DataSource = Ds;
            RepLeftLnk.DataBind();*/
        }
        catch (Exception)
        {

        }
    }
    protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            HiddenField hdnCatId = e.Item.FindControl("hdnCatId") as HiddenField;
            Repeater rptProducts = e.Item.FindControl("rptProducts") as Repeater;
            Int64 catId;
            Int64.TryParse(Convert.ToString(hdnCatId.Value), out catId);
            if (catId > 0 && Session["DefaultDataSet"] != null)
            {
                DataSet Ds = Session["DefaultDataSet"] as DataSet;
                DataTable dt = new DataTable();
                DataRow[] dr = Ds.Tables[1].Select("CategoryId = '" + catId.ToString() + "'");
                if (dr.Length > 0) { dt = dr.CopyToDataTable(); }
                rptProducts.DataSource = dt;
                rptProducts.DataBind();
            }
        }
    }

    public String GetShareUrl(String ProductName, String ProductID)
    {
        String shareUrl = "", DomainAdd = "";
        DomainAdd = ConfigurationManager.AppSettings["domainAdd"].ToString();
        shareUrl = "return windowpop(\"http://www.facebook.com/sharer.php?u=" + HttpUtility.UrlEncode(DomainAdd + "Product/ProductDetail/" + ProductName + "_" + ProductID) + "\");";
        return shareUrl;
    }
}