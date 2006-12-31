using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Net.Mail;
using System.Text;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;


/// <summary>
/// Summary description for DataAccess
/// </summary>
public class DataAccess
{
    SqlConnection PrconObj = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);

    public DataAccess()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public SqlConnection conObj
    {
        get
        {
            if (PrconObj == null)
            {
                PrconObj = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            }
            return PrconObj;
        }
    }

    //Query to get data set .
    public DataSet getDataSetQuery(string sqlQuery)
    {
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sqlQuery;
            SqlDataAdapter dA = new SqlDataAdapter(cmd);
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            dA.Fill(ds);
        }
        catch (Exception)
        {
            ds = null;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
        }
        return ds;
    }

    //Parameterized Query to get data set .
    public DataSet getDataSetQuery(string sqlQuery, SqlParameter[] sqlParms, CommandType cmTyp = CommandType.Text)
    {
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = cmTyp;
            cmd.CommandText = sqlQuery;
            if (sqlParms != null)
                cmd.Parameters.AddRange(sqlParms.ToArray());
            SqlDataAdapter dA = new SqlDataAdapter(cmd);
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            dA.Fill(ds);
        }
        catch (Exception)
        {
            ds = null;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
        }
        return ds;
    }

    //Execute Stored procedure with output parameter.
    public string ExecSPWithOutPutPara(string sqlQuery, SqlParameter[] sqlParms, int OPParam, CommandType cmTyp = CommandType.Text)
    {
        int chkflag = 0;
        string OpParam = "";
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = cmTyp;
            cmd.CommandText = sqlQuery;
            cmd.Parameters.AddRange(sqlParms.ToArray());
            cmd.Parameters[OPParam].Direction = ParameterDirection.Output;
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            chkflag = cmd.ExecuteNonQuery();

            //if (chkflag > 0)
            OpParam = sqlParms[OPParam].Value.ToString();
        }
        catch (Exception)
        {
            chkflag = 0;
            OpParam = "";
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
        }
        return OpParam;
    }

    //Execute Stored procedure with output parameter.
    public DataSet ExecSPWithOutPutPara(string sqlQuery, SqlParameter[] sqlParms, ref Dictionary<String, String> OparDic, CommandType cmTyp = CommandType.Text)
    {
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = cmTyp;
            cmd.CommandText = sqlQuery;
            cmd.Parameters.AddRange(sqlParms.ToArray());

            foreach (var item in OparDic)
            {
                cmd.Parameters[item.Key].Direction = ParameterDirection.Output;
            }
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            SqlDataAdapter dA = new SqlDataAdapter(cmd);
            dA.Fill(ds);
            List<String> keyColl = new List<string>(OparDic.Keys);
            foreach (var item in keyColl)
            {
                OparDic[item] = cmd.Parameters[item].Value.ToString();
            }

        }
        catch (Exception)
        {
            ds = null;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
        }
        return ds;
    }

    //Execute non query with in transaction.
    public int DaExecNonQueryStrTrn(string SqlQuery, SqlParameter[] sqlParms, SqlTransaction trnSql, SqlConnection sqlCon)
    {
        int retNo = 0;
        try
        {
            //SqlTransaction trnabc = conObj.BeginTransaction();
            SqlCommand cmd = sqlCon.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = SqlQuery;
            cmd.Parameters.AddRange(sqlParms.ToArray());
            cmd.Transaction = trnSql;
            //if (conObj.State == ConnectionState.Closed)
            //    conObj.Open();
            retNo = cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            retNo = 0;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        return retNo;

    }

    //Execute non query with parameter list 
    public int DaExecNonQueryStr(string SqlQuery, SqlParameter[] sqlParms, CommandType cmdTyp = CommandType.Text)
    {
        int retNo = 0;
        try
        {
            SqlCommand cmd = PrconObj.CreateCommand();
            cmd.CommandType = cmdTyp;
            cmd.CommandText = SqlQuery;
            cmd.Parameters.AddRange(sqlParms.ToArray());
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            retNo = cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            //String paraString = sqlParms.Aggregate("", (a, b) => a + b.ParameterName + " - " + b.SqlValue + ", ");
            String paraString = "";
            if (sqlParms != null && sqlParms.Length > 0)
            {
                paraString = String.Join(", ", sqlParms.Select(x => x.ParameterName + " - " + x.SqlValue));
            }
            errorHandel.errorCatch.LogErrorDetails("DaExecNonQueryStr", ex.Message, " Sql Query " + SqlQuery + " Sql Parameter " + paraString);
            retNo = 0;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
                conObj.Close();
        }
        return retNo;
    }

    public Int16 SelectScalar(string sqlQuery, SqlParameter[] sqlParms = null)
    {
        Int16 chkint = 0;
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sqlQuery;
            if (sqlParms != null)
                cmd.Parameters.AddRange(sqlParms.ToArray());
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            chkint = Convert.ToInt16(cmd.ExecuteScalar());
        }
        catch (Exception)
        {
            chkint = 0;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
                conObj.Close();
        }
        return chkint;
    }


    public object SelectScalarRetObj(string sqlQuery, SqlParameter[] sqlParms = null)
    {
        object chkint = null;
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sqlQuery;
            if (sqlParms != null)
                cmd.Parameters.AddRange(sqlParms.ToArray());
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            chkint = cmd.ExecuteScalar();
        }
        catch (Exception)
        {
            chkint = null;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
                conObj.Close();
        }
        return chkint;
    }


    public object SelectScalarRetObj(string sqlQuery, SqlParameter[] sqlParms = null, CommandType cmdTyp = CommandType.Text)
    {
        object chkint = null;
        try
        {
            SqlCommand cmd = conObj.CreateCommand();
            cmd.CommandType = cmdTyp;
            cmd.CommandText = sqlQuery;
            if (sqlParms != null)
                cmd.Parameters.AddRange(sqlParms.ToArray());
            if (conObj.State == ConnectionState.Closed)
                conObj.Open();
            chkint = cmd.ExecuteScalar();
        }
        catch (Exception)
        {
            chkint = null;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        finally
        {
            if (conObj.State == ConnectionState.Open)
                conObj.Close();
        }
        return chkint;
    }

    public static string CreateUser(SqlParameter[] Param)
    {
        string ResStr = "", chkstring = "";
        try
        {
            DataAccess objDataAccess = new DataAccess();
            chkstring = objDataAccess.ExecSPWithOutPutPara("UserDetail_I", Param, 15, System.Data.CommandType.StoredProcedure);

            if ((chkstring != "Duplicate email Id") && (chkstring != "Error Inserting data") & (chkstring != ""))
                ResStr = "Thanks for registering with Pills in Cart\n";
            else
            {
                if (chkstring == "Duplicate email Id")
                {
                    ResStr = "User with this email Id already exists. Please provide other email Id.";
                }
                if ((chkstring == "Error Inserting data") || (chkstring != ""))
                {
                    ResStr = "Error Creating User";
                }
            }
        }
        catch (Exception)
        {
            throw;
        }
        return ResStr;
    }

    public static int UpdateUser(SqlParameter[] Param)
    {
        int res = 0;
        try
        {
            DataAccess objDataAccess = new DataAccess();
            res = Convert.ToInt32(objDataAccess.DaExecNonQueryStr("UserDetail_U", Param, System.Data.CommandType.StoredProcedure));
        }
        catch (Exception)
        {
            res = 0;
            throw;
        }
        return res;
    }

    public bool LoginUser(string EmailID, string Pasword, bool ClearSess = true)
    {

        bool chkFlag = false;
        try
        {
            SqlParameter[] parm = new SqlParameter[]{
                new SqlParameter("@EmailId",EmailID),
                new SqlParameter("@password",Pasword),
                new SqlParameter("@OrdId",(HttpContext.Current.Session["OrdId"] != null)?HttpContext.Current.Session["OrdId"].ToString():"0")
            };
            DataSet ds = new DataSet();
            ds = getDataSetQuery("UserLogIn", parm, CommandType.StoredProcedure);
            //ds = objDataAccess.getDataSetQuery("select userId,fName,lName,Gender,Dob,EmailID,password,Address1,Address2,Country,StateorProvince,City,Zipcode,phone,createdon,verificationFlag,ActiveFlag from userdetail where EmailID=@EmailId and password = @password and ActiveFlag = 1", parm);
            if ((ds != null) && (ds.Tables.Count > 0))
            {
                HttpContext.Current.Session["UserInfo"] = "";
                UserInfo objUserInfo = new UserInfo()
                {
                    userId = Convert.ToInt64(ds.Tables[0].Rows[0]["userId"].ToString()),
                    fName = ds.Tables[0].Rows[0]["fName"].ToString(),
                    lName = ds.Tables[0].Rows[0]["lName"].ToString(),

                };
                chkFlag = true;
            }
        }
        catch (Exception)
        {
            chkFlag = false;
            if (conObj.State == ConnectionState.Open)
            {
                conObj.Close();
            }
            throw;
        }
        return chkFlag;
    }
}


namespace errorHandel
{

    public class errorCatch
    {
        public static void LogErrorDetails(String FunctionName, String ErrorMessage, String Description)
        {
            SqlConnection PrconObj = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);

            try
            {
                SqlCommand cmd = PrconObj.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = @"insert into ErrorLog(FunctionName,ErrorMessage,ErrDes,ErrDt)
                                values(@FunctionName,@ErrorMessage,@ErrDes,@ErrDt);";
                SqlParameter[] para = new SqlParameter[]{
            new SqlParameter("@FunctionName",FunctionName),
            new SqlParameter("@ErrorMessage",ErrorMessage),
            new SqlParameter("@ErrDes",Description),
            new SqlParameter("@ErrDt",DateTime.Now)
            };
                cmd.Parameters.AddRange(para.ToArray());
                if (PrconObj.State == ConnectionState.Closed)
                    PrconObj.Open();
                cmd.ExecuteNonQuery();
                if (PrconObj.State == ConnectionState.Open)
                    PrconObj.Close();
            }
            catch (Exception)
            {

            }
            finally
            {
                if (PrconObj.State == ConnectionState.Open)
                    PrconObj.Close();
            }
        }
    }


}


public class UserInfo
{
    public Int64 userId;
    public string fName;
    public string lName;

    public static UserInfo GetUserInfo()
    {
        UserInfo objUserInfo = new UserInfo();
        if ((HttpContext.Current.Session != null) && (HttpContext.Current.Session["UserInfo"] != null))
        {
            objUserInfo = HttpContext.Current.Session["UserInfo"] as UserInfo;
        }
        else
        {
            objUserInfo = null;
        }
        return objUserInfo;
    }

    public static void setUserInfo(UserInfo ObjUserInfo, bool ClearSess = true)
    {
        try
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.RemoveAll();
            //HttpContext.Current.Session.Abandon();
            HttpContext.Current.Session["UserInfo"] = ObjUserInfo;
        }
        catch (Exception)
        {
            throw;
        }
    }

    public static string LogOutUser()
    {
        string chkString = "";
        try
        {
            HttpContext.Current.Session.Remove("UserInfo");
            HttpContext.Current.Session.RemoveAll();
            HttpContext.Current.Session.Abandon();
            chkString = "Success";
        }
        catch (Exception)
        {
            chkString = "";
            throw;
        }
        return chkString;
    }

    public bool IsAdmin()
    {
        bool chkflag = false;
        int chkInt = 0;
        try
        {
            chkflag = true;
        }
        catch (Exception)
        {
            chkflag = false;
        }
        return chkflag;
    }

}

public class ValidateImage
{
    public enum ImageType
    {
        AddImage,
        LogoImage,
        BigImage
    }

    public int LogImgWidth = Convert.ToInt16(ConfigurationManager.AppSettings["HigthWidthLogoImg"].ToString().Split('|')[1]);
    public int LogImgHeight = Convert.ToInt16(ConfigurationManager.AppSettings["HigthWidthLogoImg"].ToString().Split('|')[0]);

    public string valTypestr = ConfigurationManager.AppSettings["ValidImageType"].ToString();

    public string CheckImage(FileUpload filUp, ImageType imgType)
    {
        string errMsg = "";
        try
        {
            if ((filUp.HasFile) && (filUp.PostedFile.ContentLength > 0))
            {

                string filext = Path.GetExtension(filUp.PostedFile.FileName).ToString();
                string[] valType = valTypestr.Split('|');
                bool chkType = true;

                //Bitmap img = new Bitmap(filUp.PostedFile.FileName);
                Bitmap img = new Bitmap(filUp.PostedFile.InputStream, false);
                //System.Drawing.Image img = System.Drawing.Image.FromFile(filUp.PostedFile.FileName);
                int ImgHeight = img.Height;
                int ImgWidth = img.Width;
                if (imgType == ImageType.LogoImage)
                {
                    for (int i = 0; i < valType.Length; i++)
                    {
                        if (filext.Equals("." + valType[i], StringComparison.InvariantCultureIgnoreCase))
                        {
                            chkType = false;
                            break;
                        }
                    }
                    if (chkType)
                    {

                        errMsg = errMsg + "Logo Image of Invalid type\n";
                        chkType = true;
                    }

                    if ((LogImgWidth > ImgWidth) || (LogImgHeight > ImgHeight))
                    {
                        errMsg = errMsg + "Logo Image should have min height " + LogImgHeight + " and min Width " + LogImgWidth + " \n";
                        chkType = false;
                    }
                }
            }
        }
        catch (Exception)
        {
            errMsg = errMsg + "Error Inserting data\n";
            throw;
        }
        return errMsg;
    }


    public void saveimage(FileUpload fileupload, out string SaveAsName, out string SaveAsSmallImg, String ProductName)
    {
        string fileNa = "";
        try
        {
            fileNa = ProductName.Trim() + "_" + Path.GetFileName(fileupload.PostedFile.FileName);
            string filExt = Path.GetExtension(fileupload.PostedFile.FileName);
            string folderPath = ConfigurationManager.AppSettings["ImageFolder"].ToString();
            while (File.Exists(HttpContext.Current.Server.MapPath(folderPath + fileNa))) {
                fileNa = ProductName.Trim() + "_" + DateTime.Now.TimeOfDay.Ticks.ToString() + filExt;
            }
            //do
            //{
            //    fileNa = DateTime.Now.TimeOfDay.Ticks.ToString() + filExt;

            //} while (File.Exists(HttpContext.Current.Server.MapPath(folderPath + fileNa)));
            //while (File.Exists(HttpContext.Current.Server.MapPath(folderPath + fileNa)))
            //{
            //    fileNa = Guid.NewGuid().ToString() + filExt;
            //}
            fileupload.SaveAs(HttpContext.Current.Server.MapPath(folderPath + fileNa));
            SaveAsName = folderPath + fileNa;

            System.Drawing.Image oriImg = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath(folderPath + fileNa));

            SaveAsSmallImg = saveSmallImg(oriImg, new Size(LogImgWidth, LogImgHeight), SaveAsName, true);
        }
        catch (Exception)
        {
            SaveAsName = "";
            SaveAsSmallImg = "";
            throw;
        }
    }

    public String saveSmallImg(System.Drawing.Image image, Size size, String OriImgPath, bool preserveAspectRatio = true)
    {
        try
        {
            int newWidth;
            int newHeight;

            if (/*preserveAspectRatio &&*/ image.Width > LogImgWidth && image.Height > LogImgHeight)
            {
                int originalWidth = image.Width;
                int originalHeight = image.Height;
                float percentWidth = (float)size.Width / (float)originalWidth;
                float percentHeight = (float)size.Height / (float)originalHeight;
                float percent = percentHeight < percentWidth ? percentHeight : percentWidth;
                newWidth = (int)(originalWidth * percent);
                newHeight = (int)(originalHeight * percent);
            }
            else
            {
                newWidth = image.Width;
                newHeight = image.Height;
            }
            System.Drawing.Image newImage = new Bitmap(newWidth, newHeight);
            using (Graphics graphicsHandle = Graphics.FromImage(newImage))
            {
                graphicsHandle.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphicsHandle.DrawImage(image, 0, 0, newWidth, newHeight);
            }


            string folderPath = ConfigurationManager.AppSettings["ImageFolder"].ToString();
            String FilName = Path.GetFileName(HttpContext.Current.Server.MapPath(OriImgPath));
            String filExt = Path.GetExtension(HttpContext.Current.Server.MapPath(OriImgPath));
            while (File.Exists(HttpContext.Current.Server.MapPath(folderPath + "SmallImg/" + FilName)))
            {
                FilName = DateTime.Now.TimeOfDay.Ticks.ToString() + filExt;
            };

            //newImage.Save(HttpContext.Current.Server.MapPath(folderPath + "SmallImg/" + FilName));
            SaveJpeg(HttpContext.Current.Server.MapPath(folderPath + "SmallImg/" + FilName), newImage, 80);

            return folderPath + "SmallImg/" + FilName;
        }
        catch (Exception)
        {
            return "";
            throw;
        }
    }

    public static void SaveJpeg(string path, System.Drawing.Image img, int quality)
    {
        // Encoder parameter for image quality
        EncoderParameter qualityParam =
            new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, quality);
        // Jpeg image codec
        ImageCodecInfo jpegCodec = GetEncoderInfo("image/jpeg");

        EncoderParameters encoderParams = new EncoderParameters(1);
        encoderParams.Param[0] = qualityParam;

        img.Save(path, jpegCodec, encoderParams);
    }

    /// <summary>
    /// Returns the image codec with the given mime type
    /// </summary>
    private static ImageCodecInfo GetEncoderInfo(string mimeType)
    {
        // Get image codecs for all image formats
        ImageCodecInfo[] codecs = ImageCodecInfo.GetImageEncoders();

        // Find the correct image codec
        for (int i = 0; i < codecs.Length; i++)
            if (codecs[i].MimeType == mimeType)
                return codecs[i];
        return null;
    }

}

public class SendMail
{
    public String From;
    public String To;
    public String Bcc;
    public String MailSub;
    public String MailBody;
    public String ProdImgPath;
    public String NetCreUname;
    public String NetCrePass;

    public void OrderPlacedMailToUser()
    {

        MailMessage m = new MailMessage();
        SmtpClient sc = new SmtpClient();
        if ((!String.IsNullOrEmpty(From)) && (!String.IsNullOrEmpty(NetCreUname)) && (!String.IsNullOrEmpty(NetCrePass)) && (!String.IsNullOrEmpty(To)))
        {
            try
            {
                m.From = new MailAddress(From, "Kalatmak Support");
                m.To.Add(new MailAddress(To, "Dear Kalatmak user"));
                m.Bcc.Add("yagneshdxt@gmail.com");
                m.Bcc.Add(From);
                m.Subject = MailSub;
                m.Body = MailBody;

                //Logic to add image
                //Create two views, one text, one HTML.
                System.Net.Mail.AlternateView plainTextView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(MailBody, null, "text/plain");
                System.Net.Mail.AlternateView htmlView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(MailBody, null, "text/html");
                //Add image to HTML version
                System.Net.Mail.LinkedResource imageResource = new System.Net.Mail.LinkedResource(HttpContext.Current.Server.MapPath(ProdImgPath), "image/jpg");
                imageResource.ContentId = "HDIImage";
                htmlView.LinkedResources.Add(imageResource);
                //Add two views to message.
                m.AlternateViews.Add(plainTextView);
                m.AlternateViews.Add(htmlView);
                m.IsBodyHtml = true;

                //Send Mail
                sc.Host = "smtp.gmail.com";
                sc.Port = 587;
                sc.Credentials = new
                System.Net.NetworkCredential(NetCreUname, NetCrePass);
                sc.EnableSsl = true;
                sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                sc.Send(m);
                m.Dispose();
                sc.Dispose();
            }
            catch (Exception ex)
            {
                errorHandel.errorCatch.LogErrorDetails("OrderPlacedMailToUser", ex.Message, " Inner exeception -- " + ex.InnerException + " Exception source -- " + ex.Source + " Stack Trace -- " + ex.StackTrace);
            }
        }
    }

    public void sendForgotPasswordMail(String UPass)
    {

        MailMessage m = new MailMessage();
        SmtpClient sc = new SmtpClient();
        if ((!String.IsNullOrEmpty(From)) && (!String.IsNullOrEmpty(NetCreUname)) && (!String.IsNullOrEmpty(NetCrePass)))
        {
            try
            {
                m.From = new MailAddress(From, "Kalatmak Support");
                m.To.Add(new MailAddress(From, "Dear user"));
                // m.CC.Add(new MailAddress("CC@yahoo.com", "Display name CC"));
                //similarly BCC


                m.Subject = "Password for Kalatmak Admin Login";
                m.IsBodyHtml = true;
                m.Body = "Your Password is - " + UPass;

                sc.Host = "smtp.gmail.com";
                sc.Port = 587;
                sc.Credentials = new
                System.Net.NetworkCredential(NetCreUname, NetCrePass);
                sc.EnableSsl = true;
                sc.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                sc.Send(m);
                m.Dispose();
                sc.Dispose();
            }
            catch (Exception ex)
            {
                errorHandel.errorCatch.LogErrorDetails("OrderPlacedMailToUser", ex.Message, " Inner exeception -- " + ex.InnerException + " Exception source -- " + ex.Source + " Stack Trace -- " + ex.StackTrace);
            }
        }

    }
}

public class ProductColor
{
    public Int64 ProductId { get; set; }
    public String ColorCode { get; set; }
    public String tempId { get; set; }
}