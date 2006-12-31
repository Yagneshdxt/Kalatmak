<%@ Application Language="C#" %>

<%@ Import Namespace="errorHandel" %>

<script runat="server">

    static void RegisterRoutes(System.Web.Routing.RouteCollection routes)
    {
        routes.MapPageRoute("ProductDetail", "Product/ProductDetail/{productName_Id}", "~/Product/ProductDetail.aspx");
        routes.MapPageRoute("OrderProduct", "Product/OrderNow/{productName_Id}", "~/Product/ProductDetail.aspx");
        routes.MapPageRoute("ProductEnquiry", "Product/Enquiry/{productName_Id}", "~/Product/ProductDetail.aspx");
        routes.Ignore("images/{*pathInfo}");
        routes.Ignore("Styles/{*pathInfo}");
        routes.Ignore("JScripts/{*pathInfo}");
        routes.Ignore("MailBody/{*pathInfo}");
    }
    
    
    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        RegisterRoutes(System.Web.Routing.RouteTable.Routes);
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs
        Exception objErr = Server.GetLastError().GetBaseException();
        errorHandel.errorCatch.LogErrorDetails("Application_Error", objErr.Message,
            " Error In -- " + Request.Url.ToString() + " Exception source -- " + Convert.ToString(objErr.InnerException) + " Stack Trace -- " + Convert.ToString(objErr.StackTrace));
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
