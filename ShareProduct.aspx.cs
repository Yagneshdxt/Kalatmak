using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Configuration;

public partial class ShareProduct : System.Web.UI.Page
{
    DataAccess objDataAccess = new DataAccess();

    public String PrName { get; set; }
    public String CatID { get; set; }
    public String ImgPath { get; set; }
    public String DomainAdd { get; set; }
    public String ImId { get; set; }
    
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["PrName"] != null)
            PrName = Convert.ToString(Request.QueryString["PrName"]);

        if (Request.QueryString["CatId"] != null)
            CatID = Convert.ToString(Request.QueryString["CatId"]);

        if (Request.QueryString["ImgPath"] != null)
            ImgPath = Convert.ToString(Request.QueryString["ImgPath"]);

        if (Request.QueryString["ImId"] != null)
            ImId = Convert.ToString(Request.QueryString["ImId"]);

        DomainAdd = ConfigurationManager.AppSettings["domainAdd"].ToString();

        // <link rel="image_src" href="http://www.websiteurlpicutre.com" / >
        HtmlLink link = new HtmlLink();
        //link.Attributes.Add("type", "application/rss+xml");
        link.Attributes.Add("rel", "image_src");
        if (!String.IsNullOrWhiteSpace(ImgPath))
        {
            link.Attributes.Add("href", DomainAdd + ImgPath.Replace("~/", ""));
        }
        else {
            link.Attributes.Add("href", DomainAdd + "images/LogoImg.png");
        }
        this.Header.Controls.Add(link);


        HtmlMeta keywords = new HtmlMeta();
        HtmlMeta MetTag;
        MetTag = new HtmlMeta();
        MetTag.Attributes.Add("property", "og:title");
        if (!String.IsNullOrWhiteSpace(PrName))
        {   //Title
            MetTag.Content = PrName;
        }
        else {
            MetTag.Content = "Traditional Artifacts with modern touch of art.";
        }
        Page.Header.Controls.Add(MetTag);

        //Description
        MetTag.Dispose();
        MetTag = new HtmlMeta();
        MetTag.Attributes.Add("property", "og:description");
        MetTag.Content = "Perfrect Gift for all occasion.";
        Page.Header.Controls.Add(MetTag);


        if (!String.IsNullOrWhiteSpace(CatID))
        {
            //Url
            MetTag.Dispose();
            MetTag = new HtmlMeta();
            MetTag.Attributes.Add("property", "og:url");
            MetTag.Content = DomainAdd + "Product/DisplayProduct.aspx?catID=" + CatID + "&ImId=" + ImId;
            Page.Header.Controls.Add(MetTag);
        }
        else {
            //Url
            MetTag.Dispose();
            MetTag = new HtmlMeta();
            MetTag.Attributes.Add("property", "og:url");
            MetTag.Content = DomainAdd;
            Page.Header.Controls.Add(MetTag);
        }

        if (!String.IsNullOrWhiteSpace(ImgPath))
        {
            //Image
            MetTag.Dispose();
            MetTag = new HtmlMeta();
            MetTag.Attributes.Add("property", "og:image");
            MetTag.Content = DomainAdd + ImgPath.Replace("~/", ""); //"http://www.kalatmak.net/images/Accessory/handbagsflowerpiece.jpg"; 
            Page.Header.Controls.Add(MetTag);
        }
        else {
            //Image
            MetTag.Dispose();
            MetTag = new HtmlMeta();
            MetTag.Attributes.Add("property", "og:image");
            MetTag.Content = DomainAdd + "images/LogoImg.png"; 
            Page.Header.Controls.Add(MetTag);
        }
    }
}