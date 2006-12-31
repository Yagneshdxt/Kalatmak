using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;

public partial class SiteMaster : System.Web.UI.MasterPage
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
            sqlQuer.Append(@"SELECT CategoryID,CategoryName 
                            from Category_Mst WHERE IsDeleted = 0 and IsActive= 1");
            sqlQuer.Append(" order by SeqNo");
            DataSet Ds = new DataSet();
            Ds = objDataAccess.getDataSetQuery(sqlQuer.ToString());
            repMenu.DataSource = Ds;
            repMenu.DataBind();
            /*RepLeftLnk.DataSource = Ds;
            RepLeftLnk.DataBind();*/
        }
        catch (Exception)
        {
            throw;
        }
    }
}
