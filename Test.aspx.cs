using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TestClass objTst = new ChileTwo();
        String abb = "";
        lblOutput.Text = objTst.getClass(ref abb);
        Label1.Text = abb;
    }
}

public class TestClass
{

    public virtual String getClass(ref String bc) {
        bc = bc + " -- Test Class -- ";
        return "Test Class";    
    }


}

public class ChileOne:TestClass
{

    public override String getClass(ref String bc)
    {
        bc = bc + " -- Child ONe override -- ";
        return "Child ONe override";
    }
}

public class ChileTwo : TestClass
{
    public new String getClass(ref String bc)
    {
        bc = bc + " -- Child ONe new -- ";
        return "Child ONe new";

    }
}