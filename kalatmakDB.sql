USE [master]
GO
/****** Object:  Database [KalatmakDb]    Script Date: 03/14/2016 22:52:35 ******/
ALTER DATABASE [KalatmakDb] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KalatmakDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KalatmakDb] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [KalatmakDb] SET ANSI_NULLS OFF
GO
ALTER DATABASE [KalatmakDb] SET ANSI_PADDING OFF
GO
ALTER DATABASE [KalatmakDb] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [KalatmakDb] SET ARITHABORT OFF
GO
ALTER DATABASE [KalatmakDb] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [KalatmakDb] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [KalatmakDb] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [KalatmakDb] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [KalatmakDb] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [KalatmakDb] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [KalatmakDb] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [KalatmakDb] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [KalatmakDb] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [KalatmakDb] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [KalatmakDb] SET  DISABLE_BROKER
GO
ALTER DATABASE [KalatmakDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [KalatmakDb] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [KalatmakDb] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [KalatmakDb] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [KalatmakDb] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [KalatmakDb] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [KalatmakDb] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [KalatmakDb] SET  READ_WRITE
GO
ALTER DATABASE [KalatmakDb] SET RECOVERY SIMPLE
GO
ALTER DATABASE [KalatmakDb] SET  MULTI_USER
GO
ALTER DATABASE [KalatmakDb] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [KalatmakDb] SET DB_CHAINING OFF
GO
USE [KalatmakDb]
GO
/****** Object:  Table [dbo].[State_Mst]    Script Date: 03/14/2016 22:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State_Mst](
	[StateId] [bigint] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](5000) NOT NULL,
 CONSTRAINT [PK_State_Mst] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[State_Mst] ON
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (1, N'Andaman and Nicobar Islands')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (2, N'Andhra Pradesh')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (3, N'Arunachal Pradesh')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (4, N'Assam')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (5, N'Bihar')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (6, N'Chandigarh')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (7, N'Chhattisgarh')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (8, N'Dadra and Nagar Haveli')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (9, N'Daman and Diu')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (10, N'Delhi')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (11, N'Goa')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (12, N'Gujarat')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (13, N'Haryana')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (14, N'Himachal Pradesh')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (15, N'Jammu and Kashmir')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (16, N'Jharkhand')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (17, N'Karnataka')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (18, N'Kerala')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (19, N'Lakshadweep')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (20, N'Madhya Pradesh')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (21, N'Maharashtra')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (22, N'Manipur')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (23, N'Meghalaya')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (24, N'Mizoram')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (25, N'Nagaland')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (26, N'Orissa')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (27, N'Pondicherry')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (28, N'Punjab')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (29, N'Rajasthan')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (30, N'Sikkim')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (31, N'Tamil Nadu')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (32, N'Tripura')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (33, N'Uttaranchal')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (34, N'Uttar Pradesh')
INSERT [dbo].[State_Mst] ([StateId], [StateName]) VALUES (35, N'West Bengal')
SET IDENTITY_INSERT [dbo].[State_Mst] OFF
/****** Object:  Table [dbo].[ProductImage_mst]    Script Date: 03/14/2016 22:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductImage_mst](
	[ImageId] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[ImageName] [varchar](1000) NULL,
	[ImagePath] [varchar](5000) NOT NULL,
	[thumNailImgPath] [varchar](5000) NULL,
	[imgColorCode] [varchar](50) NULL,
	[SeqNo] [bigint] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isFeatured] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProductImage_mst] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImage_mst] ON
INSERT [dbo].[ProductImage_mst] ([ImageId], [ProductId], [ImageName], [ImagePath], [thumNailImgPath], [imgColorCode], [SeqNo], [isActive], [isFeatured], [isDeleted]) VALUES (1, 1, NULL, N'~/images/products/Peacock Diya_FloatingCandle.jpg', N'~/images/products/SmallImg/Peacock Diya_FloatingCandle.jpg', N'#996633', 0, 1, 1, 0)
INSERT [dbo].[ProductImage_mst] ([ImageId], [ProductId], [ImageName], [ImagePath], [thumNailImgPath], [imgColorCode], [SeqNo], [isActive], [isFeatured], [isDeleted]) VALUES (2, 1, NULL, N'~/images/products/Peacock Diya_FloatingCandlewithKundan.jpg', N'~/images/products/SmallImg/Peacock Diya_FloatingCandlewithKundan.jpg', N'#FF9999', 1, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[ProductImage_mst] OFF
/****** Object:  Table [dbo].[Product_Mst]    Script Date: 03/14/2016 22:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product_Mst](
	[ProductID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryId] [bigint] NOT NULL,
	[ProductName] [varchar](max) NOT NULL,
	[Price] [varchar](max) NOT NULL,
	[Size] [varchar](max) NULL,
	[SeqNo] [bigint] NOT NULL,
	[isActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Product_Mst] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Mst] ON
INSERT [dbo].[Product_Mst] ([ProductID], [CategoryId], [ProductName], [Price], [Size], [SeqNo], [isActive], [IsDeleted]) VALUES (1, 1, N'Peacock Diya', N'15545', N'Width 123 * height 123', 1, 1, 0)
SET IDENTITY_INSERT [dbo].[Product_Mst] OFF
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 03/14/2016 22:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[orderID] [bigint] IDENTITY(1,1) NOT NULL,
	[productID] [bigint] NOT NULL,
	[prodPrice] [varchar](5000) NULL,
	[prodImg] [varchar](5000) NULL,
	[productColor] [varchar](50) NULL,
	[Uname] [varchar](5000) NOT NULL,
	[UemailId] [varchar](5000) NOT NULL,
	[UContactNo] [varchar](100) NOT NULL,
	[UAddress] [varchar](5000) NOT NULL,
	[UState] [bigint] NOT NULL,
	[UPinNo] [varchar](5000) NULL,
	[UOrderQty] [bigint] NOT NULL,
	[AComments] [varchar](5000) NULL,
	[APrice] [varchar](5000) NULL,
	[ApromisedQty] [bigint] NULL,
	[AdeliveryDt] [datetime] NULL,
	[isAnswered] [bit] NOT NULL,
	[isDelivered] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[UordDt] [datetime] NOT NULL,
	[AanswredDt] [datetime] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Category_Mst]    Script Date: 03/14/2016 22:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category_Mst](
	[CategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](max) NOT NULL,
	[SeqNo] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Category_Mst] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category_Mst] ON
INSERT [dbo].[Category_Mst] ([CategoryID], [CategoryName], [SeqNo], [IsActive], [IsDeleted]) VALUES (1, N'Accessory', 1, 1, 0)
INSERT [dbo].[Category_Mst] ([CategoryID], [CategoryName], [SeqNo], [IsActive], [IsDeleted]) VALUES (2, N'Candles', 2, 1, 0)
INSERT [dbo].[Category_Mst] ([CategoryID], [CategoryName], [SeqNo], [IsActive], [IsDeleted]) VALUES (3, N'Diyas & Rangolies', 3, 1, 0)
INSERT [dbo].[Category_Mst] ([CategoryID], [CategoryName], [SeqNo], [IsActive], [IsDeleted]) VALUES (4, N'Wall Hanging', 4, 1, 0)
SET IDENTITY_INSERT [dbo].[Category_Mst] OFF
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 03/14/2016 22:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ErrorLog](
	[FunctionName] [varchar](5000) NULL,
	[ErrorMessage] [varchar](5000) NULL,
	[ErrDes] [varchar](5000) NULL,
	[ErrDt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'There is no row at position 0.', N' Error In -- http://localhost:1661/Kalatmak/Product/DisplayProduct.aspx?catID=2 Exception source --  Stack Trace --    at System.Data.RBTree`1.GetNodeByIndex(Int32 userIndex)
   at System.Data.DataRowCollection.get_Item(Int32 index)
   at Product_DisplayProduct.FillControl() in e:\Kalatmak\Product\DisplayProduct.aspx.cs:line 59
   at Product_DisplayProduct.Page_Load(Object sender, EventArgs e) in e:\Kalatmak\Product\DisplayProduct.aspx.cs:line 28
   at System.Web.Util.CalliHelper.EventArgFunctionCaller(IntPtr fp, Object o, Object t, EventArgs e)
   at System.Web.Util.CalliEventHandlerDelegateProxy.Callback(Object sender, EventArgs e)
   at System.Web.UI.Control.OnLoad(EventArgs e)
   at System.Web.UI.Control.LoadRecursive()
   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)', CAST(0x0000A4FD010104A8 AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'There is no row at position 0.', N' Error In -- http://localhost:1661/Kalatmak/Product/DisplayProduct.aspx?catID=2 Exception source --  Stack Trace --    at System.Data.RBTree`1.GetNodeByIndex(Int32 userIndex)
   at System.Data.DataRowCollection.get_Item(Int32 index)
   at Product_DisplayProduct.FillControl() in e:\Kalatmak\Product\DisplayProduct.aspx.cs:line 59
   at Product_DisplayProduct.Page_Load(Object sender, EventArgs e) in e:\Kalatmak\Product\DisplayProduct.aspx.cs:line 28
   at System.Web.Util.CalliHelper.EventArgFunctionCaller(IntPtr fp, Object o, Object t, EventArgs e)
   at System.Web.Util.CalliEventHandlerDelegateProxy.Callback(Object sender, EventArgs e)
   at System.Web.UI.Control.OnLoad(EventArgs e)
   at System.Web.UI.Control.LoadRecursive()
   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)', CAST(0x0000A4FD010255ED AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD0181C103 AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD01820A12 AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD01820F93 AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD0182109C AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD01821527 AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD018215CB AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD01821653 AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD01821879 AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD01821D1B AS DateTime))
INSERT [dbo].[ErrorLog] ([FunctionName], [ErrorMessage], [ErrDes], [ErrDt]) VALUES (N'Application_Error', N'File does not exist.', N' Error In -- http://localhost:1661/Kalatmak/images/loader.giv Exception source --  Stack Trace --    at System.Web.StaticFileHandler.GetFileInfo(String virtualPathWithPathInfo, String physicalPath, HttpResponse response)
   at System.Web.StaticFileHandler.ProcessRequestInternal(HttpContext context, String overrideVirtualPath)
   at System.Web.DefaultHttpHandler.BeginProcessRequest(HttpContext context, AsyncCallback callback, Object state)
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)', CAST(0x0000A4FD01821DB7 AS DateTime))
/****** Object:  Table [dbo].[EnqiryDetails]    Script Date: 03/14/2016 22:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EnqiryDetails](
	[EnquiryId] [bigint] IDENTITY(1,1) NOT NULL,
	[productId] [bigint] NOT NULL,
	[Uname] [varchar](5000) NOT NULL,
	[UemailId] [varchar](5000) NOT NULL,
	[UContactNo] [varchar](100) NOT NULL,
	[UComments] [varchar](5000) NOT NULL,
	[isAnswered] [bit] NOT NULL,
	[enquiryDt] [datetime] NOT NULL,
 CONSTRAINT [PK_EnqiryDetails] PRIMARY KEY CLUSTERED 
(
	[EnquiryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GeneralConstant]    Script Date: 03/14/2016 22:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GeneralConstant](
	[genConstId] [bigint] IDENTITY(1,1) NOT NULL,
	[genConstKey] [varchar](5000) NOT NULL,
	[genConstValue] [varchar](5000) NOT NULL,
 CONSTRAINT [PK_GeneralConstant] PRIMARY KEY CLUSTERED 
(
	[genConstId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GeneralConstant] ON
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (1, N'AdminEmailId', N'yagneshdxt@gmail.com')
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (2, N'AdminEmailPass', N'sadfasf')
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (3, N'AdminLoginPass', N'a')
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (4, N'OrderPlacedMSub', N'Kalatmak -  Thanks for placing order')
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (6, N'OrderPlacedMBody', N'~/MailBody/PlaceOrder.htm')
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (7, N'EnqiryMSub', N'Kalatmak - We have received and Enqiry from you.')
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (8, N'EnqiryMBody', N'~/MailBody/EnqiryMail.htm')
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (9, N'ForgotPassMSub', N'Kalatmak - Forgot Password')
INSERT [dbo].[GeneralConstant] ([genConstId], [genConstKey], [genConstValue]) VALUES (10, N'ForgotPassMBody', N'  ')
SET IDENTITY_INSERT [dbo].[GeneralConstant] OFF
/****** Object:  StoredProcedure [dbo].[forgotPassword]    Script Date: 03/14/2016 22:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yagnesh
-- Create date: 03 October 2014
-- Description:	get forgot password
--exec forgotPassword
-- =============================================
CREATE PROCEDURE [dbo].[forgotPassword] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SET NOCOUNT ON;

-- order Id
    declare @table table(
     KeyName varchar(5000),
	 genConstKey varchar(5000),
	 genConstValue varchar(5000)
    )
    
	-- Select Mail details
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'FromEmail',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'AdminEmailId'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'AdminPass',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'AdminLoginPass'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'NetPass',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'AdminEmailPass'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'MailSub',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'ForgotPassMSub'
	
	select * from @table

END
GO
/****** Object:  StoredProcedure [dbo].[Fill_PlaceOrder]    Script Date: 03/14/2016 22:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yagnesh Dixit
-- Create date: 03 Oct 2014
-- Description:	Select Details for Place order
-- =============================================
CREATE PROCEDURE [dbo].[Fill_PlaceOrder] 
	-- Add the parameters for the stored procedure here
@ProductID bigint
AS
BEGIN
	SET NOCOUNT ON;

	select a.ProductID, a.ProductName, a.Price,b.ImagePath 
	from Product_Mst a 
	join ProductImage_mst b on a.ProductID = b.ProductId and b.isActive = 1 and b.isFeatured = 1 and b.isDeleted = 0
	where a.ProductID = @ProductID
	
	select StateId,StateName from State_Mst
END
GO
/****** Object:  StoredProcedure [dbo].[ChangePasswords]    Script Date: 03/14/2016 22:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yagnesh Dixit
-- Create date: 03 Oct 2014
-- Description:	Change Password
-- =============================================
CREATE PROCEDURE [dbo].[ChangePasswords]
	-- Add the parameters for the stored procedure here
@OldPassword varchar(5000),
@NewPassword varchar(5000)

AS
BEGIN
	SET NOCOUNT ON;
	
	declare @chkMsg varchar(50)
	set @chkMsg = ''
	
    if exists (select 1 from GeneralConstant where genConstKey = 'AdminLoginPass' and genConstValue = @OldPassword)
    begin		
		update GeneralConstant set genConstValue = @NewPassword where genConstKey = 'AdminLoginPass' and genConstValue = @OldPassword
		set @chkMsg = 'success'
    end
   
   select @chkMsg
    
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_OrderPlaced]    Script Date: 03/14/2016 22:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yagnesh Dixit
-- Create date: 03 Oct 2014
-- Description:	OrderPlaced
--exec Insert_OrderPlaced 1,'sadf','','','',2,'',5
-- =============================================
CREATE PROCEDURE [dbo].[Insert_OrderPlaced] 
	-- Add the parameters for the stored procedure here
	 @productID bigint
	,@Uname varchar(5000)
	,@UemailId  varchar(5000)
	,@UContactNo  varchar(100)
	,@UAddress  varchar(5000)
	,@UState bigint
	,@UPinNo  varchar(5000)
	,@UOrderQty bigint
	,@productColor varchar
AS
BEGIN
	SET NOCOUNT ON;
	
	
	insert into OrderDetails(productID,Uname,UemailId,UContactNo,UAddress,UState,
	UPinNo,UOrderQty,UordDt,isAnswered,isDelivered,isDeleted,AanswredDt)
	values(@productID, @Uname,@UemailId,@UContactNo,@UAddress,@UState,
	@UPinNo,@UOrderQty,GETDATE(),0,0,0,null)
	
	Declare @OrId bigint
	set @OrId = CAST(SCOPE_IDENTITY() as bigint)
	
	update OrderDetails 
	set prodPrice = c.Price, prodImg = d.ImagePath, productColor = @productColor
	from OrderDetails b
	join Product_Mst c on b.productID = c.ProductID	and b.orderID = @OrId
	join ProductImage_mst d on c.ProductID = d.ProductId and d.isActive = 1 and d.isFeatured = 1 and d.isDeleted = 0
	where b.orderID = @OrId
	
	-- order Id
    declare @table table(
     KeyName varchar(5000),
	 genConstKey varchar(5000),
	 genConstValue varchar(5000)
    )
    
	-- Select Mail details
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'OrderId','OrderId',CAST(@OrId as varchar) from dbo.GeneralConstant where genConstKey = 'AdminEmailId'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'FromEmail',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'AdminEmailId'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'NetPass',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'AdminEmailPass'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'MailSub',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'OrderPlacedMSub'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'MailBody',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'OrderPlacedMBody'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'ProImgPath','ProImgPath',ImagePath from ProductImage_mst where ProductId = @productID and isActive = 1 and isFeatured = 1 and isDeleted = 0
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'ProName','ProName',ProductName from Product_Mst where ProductId = @productID
	
	select * from @table
	
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_Enqiry]    Script Date: 03/14/2016 22:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yagnesh Dixit
-- Create date: 03 Oct 2014
-- Description:	To get User Enqiry
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Enqiry]
	-- Add the parameters for the stored procedure here
	 @productID bigint
	,@Uname varchar(5000)
	,@UemailId  varchar(5000)
	,@UContactNo  varchar(100)
	,@UComments  varchar(5000)

AS
BEGIN
	SET NOCOUNT ON;

	insert into EnqiryDetails(productId,Uname,UemailId,UContactNo,UComments,isAnswered)
	values(@productID,@Uname,@UemailId,@UContactNo,@UComments,0)
    
	declare @table table(
     KeyName varchar(5000),
	 genConstKey varchar(5000),
	 genConstValue varchar(5000)
    )
    
	-- Select Mail details
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'EnquiryId','EnquiryId',CAST(SCOPE_IDENTITY() as varchar) from dbo.GeneralConstant where genConstKey = 'AdminEmailId'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'FromEmail',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'AdminEmailId'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'NetPass',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'AdminEmailPass'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'MailSub',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'EnqiryMSub'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'MailBody',genConstKey,genConstValue from dbo.GeneralConstant where genConstKey = 'EnqiryMBody'
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'ProImgPath','ProImgPath',ImagePath from ProductImage_mst where ProductId = @productID and isActive = 1 and isFeatured = 1 and isDeleted = 0
	insert into @table(KeyName,genConstKey,genConstValue)
	select 'ProName','ProName',ProductName from Product_Mst where ProductId = @productID
	
	select * from @table
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_Edit_Product]    Script Date: 03/14/2016 22:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yagnesh Dixit
-- Create date: 2 Oct 2014
-- Description:	<Description,,>
-- =============================================
/*[Insert_Edit_Product]  @ProductName = 'tes one',@CategoryId = 1,
@Price = '1233',
@Size = '12 * 12 * 15',
@SeqNo = 1,
@ActiveFlage = 1,
@ProductID = 1,
@imgColorCode = '#996600',
@ImagePath  = '~/images/products/860289830000.jpg',
@ImageId  = 1,
@smallImgPath  = '~/images/products/SmallImg/860289830000.jpg'

select * from errorlog order by errdt desc
select * from product_mst
select * from productImage_mst

truncate table productImage_mst

*/
CREATE PROCEDURE [dbo].[Insert_Edit_Product] 
	-- Add the parameters for the stored procedure here
@ProductName varchar(max),
@CategoryId bigint,
@Price varchar(max),
@Size varchar(max),
@SeqNo bigint = null,
@ActiveFlage bit = 1,
@ProductID bigint = null,
@imgColorCode varchar(50),
@ImagePath varchar(5000) = '',
@ImageId bigint = null,
@smallImgPath varchar(5000) = ''

AS
BEGIN
	
	begin transaction trnProdInsert
	begin try
	if(@SeqNo is null)
	begin
		set @SeqNo = (select isnull(MAX(SeqNo),1) + 1 from Product_Mst where CategoryId=@CategoryId)
	end
	
	if(@ProductID is null)
	begin -- insert logic
		
		declare @PId bigint
		
		insert into Product_Mst(CategoryId,ProductName,Price,Size,SeqNo,isActive,IsDeleted)
		values(@CategoryId,@ProductName,@Price,@Size,@SeqNo,@ActiveFlage,0)
		
		set @PId = CAST(SCOPE_IDENTITY() as bigint)
		
		insert into ProductImage_mst(ProductId,ImagePath,thumNailImgPath,imgColorCode,isActive,isFeatured,isDeleted)
		values(@PId,@ImagePath,@smallImgPath,@imgColorCode,1,1,0)
		
	end
	else
	begin -- update logic
		update Product_Mst
				set 
				CategoryId = @CategoryId,
				ProductName = @ProductName,
				Price = @Price,
				Size = @Size,
				SeqNo = @SeqNo,
				isActive = @ActiveFlage
				where ProductID = @ProductID
				

	   IF(@ImagePath != '' and @ImageId is not null)
	   BEGIN
		  update ProductImage_mst set isActive = 0, isFeatured = 0, isDeleted = 1
		  where  ImageId = @ImageId
		  
		  insert into ProductImage_mst(ProductId,ImagePath,thumNailImgPath,imgColorCode,isActive,isFeatured,isDeleted)
		  values(@ProductID,@ImagePath,@smallImgPath,@imgColorCode,1,1,0)

	   END
	   update ProductImage_mst
	   set imgColorCode = @imgColorCode
	   where ProductId = @ProductID and ImageId = @ImageId	
		
	end
	commit transaction trnProdInsert 
	end try
	begin catch
		rollback transaction trnProdInsert
		declare @paraStr varchar(max)
		set @paraStr =	'@ProductName ' + @ProductName + '@CategoryId ' + Convert(varchar, ISNULL(@CategoryId,'null')) + '@Price ' +  @Price 
	+ '@Size' + @Size + '@SeqNo ' + convert(varchar(500), isnull(@SeqNo,'null')) + '@ActiveFlage ' + Convert(varchar, isnull(@ActiveFlage,'')) 
	+ '@ProductID ' +  Convert(varchar, isnull(@ProductID,'')) + '@imgColorCode ' + @imgColorCode + '@ImagePath' + @ImagePath
	+ '@ImageId ' + Convert(varchar, isnull(@ImageId,'')) + '@smallImgPath ' + @smallImgPath
	insert into  ErrorLog(FunctionName,ErrorMessage,ErrDes,ErrDt) 
	values('[Insert_Edit_Product]',ERROR_MESSAGE(),@paraStr,GETDATE())
	end catch

END
GO
/****** Object:  StoredProcedure [dbo].[get_ProductDetails]    Script Date: 03/14/2016 22:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yagnesh Dixit
-- Create date: 9/Aug/2015
-- Description:	procedure to get product detail
-- =============================================
CREATE PROCEDURE [dbo].[get_ProductDetails]

@ProductID bigint = 0,
@ProductName varchar(5000) = ''

AS
BEGIN

if(@ProductID = 0 and @ProductName != '')
begin
	set @ProductID = (select top 1 ProductID from Product_Mst where ProductName like '%'+ @ProductName +'%')
end

select distinct a.ProductID,a.ProductName,a.Price,a.Size,a.CategoryId, b.thumNailImgPath
 ,case 
	when a.isActive = 0 and a.IsDeleted = 1 then '0'
	when a.isActive = 1 and a.IsDeleted = 0 then '1'
	else '0'
  end as ProStatus	 
from Product_Mst a
join ProductImage_mst b on a.ProductID = b.ProductId and b.isActive = 1 and b.isDeleted = 0 and b.isFeatured = 1
where a.ProductID = @ProductID

select * from(
select ImageId,imgColorCode,ProductId, 
RANK() over(Partition by imgColorCode order by SeqNo asc) as rnk,SeqNo 
from ProductImage_mst
where isActive = 1 and isDeleted = 0 and ISNULL(imgColorCode,'') != ''  and ProductId = @ProductID
) ds where ds.rnk = 1

select a.ImageId, a.ProductId,a.ImagePath,a.thumNailImgPath,b.ProductName 
from ProductImage_mst a
join Product_Mst b on a.ProductId = b.ProductID and a.isActive = 1 and a.isDeleted = 0 and a.ProductId = @ProductID
order by case when isnull(a.imgColorCode,'') = '' then 'ZZZZZ' else a.imgColorCode end, a.ImageId

select StateId,StateName from State_Mst order by StateName

END
GO
/****** Object:  StoredProcedure [dbo].[get_homePageData]    Script Date: 03/14/2016 22:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Yagnesh Dixit
-- Create date: 9/Aug/2015
-- Description:	procedure to get home data
-- =============================================
CREATE PROCEDURE [dbo].[get_homePageData]

AS
BEGIN
	select b.CategoryID,b.CategoryName from Category_Mst b
	where exists(select 1 from Product_Mst a where a.CategoryId = b.CategoryID and a.isActive = 1 and a.IsDeleted = 0 )
	and b.IsActive = 1 and b.IsDeleted = 0
	
	select * from(
			select a.ProductID, a.ProductName, a.Price, b.thumNailImgPath, a.CategoryId, 
			RANK() over(Partition by a.CategoryId order by a.SeqNo asc) as rnk,a.SeqNo 
			from Product_Mst a
			inner join ProductImage_mst b on a.ProductID = b.ProductId 
			and b.isActive = 1 and b.isFeatured = 1 and b.IsDeleted = 0 and a.isActive = 1 and a.IsDeleted = 0
	) ds
	where ds.rnk < 5
END
GO
/****** Object:  Default [DF_ProductImage_mst_SeqNo]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[ProductImage_mst] ADD  CONSTRAINT [DF_ProductImage_mst_SeqNo]  DEFAULT ((0)) FOR [SeqNo]
GO
/****** Object:  Default [DF_ProductImage_mst_isActive]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[ProductImage_mst] ADD  CONSTRAINT [DF_ProductImage_mst_isActive]  DEFAULT ((1)) FOR [isActive]
GO
/****** Object:  Default [DF_ProductImage_mst_isFeatured]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[ProductImage_mst] ADD  CONSTRAINT [DF_ProductImage_mst_isFeatured]  DEFAULT ((0)) FOR [isFeatured]
GO
/****** Object:  Default [DF_ProductImage_mst_isDeleted]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[ProductImage_mst] ADD  CONSTRAINT [DF_ProductImage_mst_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
/****** Object:  Default [DF_Product_Mst_SeqNo]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[Product_Mst] ADD  CONSTRAINT [DF_Product_Mst_SeqNo]  DEFAULT ((0)) FOR [SeqNo]
GO
/****** Object:  Default [DF_Product_Mst_isActive]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[Product_Mst] ADD  CONSTRAINT [DF_Product_Mst_isActive]  DEFAULT ((1)) FOR [isActive]
GO
/****** Object:  Default [DF_Product_Mst_IsDeleted]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[Product_Mst] ADD  CONSTRAINT [DF_Product_Mst_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_OrderDetails_UOrderQty]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_UOrderQty]  DEFAULT ((0)) FOR [UOrderQty]
GO
/****** Object:  Default [DF_OrderDetails_isAnswered]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_isAnswered]  DEFAULT ((0)) FOR [isAnswered]
GO
/****** Object:  Default [DF_OrderDetails_isDelivered]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_isDelivered]  DEFAULT ((0)) FOR [isDelivered]
GO
/****** Object:  Default [DF_OrderDetails_isDeleted]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
/****** Object:  Default [DF_OrderDetails_UordDt]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_UordDt]  DEFAULT (getdate()) FOR [UordDt]
GO
/****** Object:  Default [DF_Category_Mst_OrderNo]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[Category_Mst] ADD  CONSTRAINT [DF_Category_Mst_OrderNo]  DEFAULT ((0)) FOR [SeqNo]
GO
/****** Object:  Default [DF_Category_Mst_IsActive]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[Category_Mst] ADD  CONSTRAINT [DF_Category_Mst_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_Category_Mst_IsDeleted]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[Category_Mst] ADD  CONSTRAINT [DF_Category_Mst_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_ErrorLog_ErrDt]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[ErrorLog] ADD  CONSTRAINT [DF_ErrorLog_ErrDt]  DEFAULT (getdate()) FOR [ErrDt]
GO
/****** Object:  Default [DF_EnqiryDetails_enquiryDt]    Script Date: 03/14/2016 22:52:37 ******/
ALTER TABLE [dbo].[EnqiryDetails] ADD  CONSTRAINT [DF_EnqiryDetails_enquiryDt]  DEFAULT (getdate()) FOR [enquiryDt]
GO
