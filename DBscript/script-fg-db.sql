USE [master]
GO
/****** Object:  Database [FG_DB]    Script Date: 2/6/2023 10:42:32 AM ******/
CREATE DATABASE [FG_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ORM_DB', FILENAME = N'E:\DB-Data\FG_DB\FG_DB.mdf' , SIZE = 1682432KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ORM_DB_log', FILENAME = N'D:\DB-Log\FG_DB\FG_DB_1.ldf' , SIZE = 1623488KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FG_DB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FG_DB].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [FG_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FG_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FG_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FG_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FG_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FG_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FG_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FG_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FG_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FG_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FG_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FG_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FG_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FG_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FG_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FG_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FG_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FG_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FG_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FG_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FG_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FG_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FG_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FG_DB] SET  MULTI_USER 
GO
ALTER DATABASE [FG_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FG_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FG_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FG_DB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [FG_DB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'FG_DB', N'ON'
GO
USE [FG_DB]
GO
/****** Object:  User [TB\sipand2]    Script Date: 2/6/2023 10:42:32 AM ******/
CREATE USER [TB\sipand2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [swart]    Script Date: 2/6/2023 10:42:32 AM ******/
CREATE USER [swart] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ORM_Users]    Script Date: 2/6/2023 10:42:32 AM ******/
CREATE USER [ORM_Users] FOR LOGIN [ORM_Users] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [m_siami]    Script Date: 2/6/2023 10:42:32 AM ******/
CREATE USER [m_siami] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [TB\sipand2]
GO
ALTER ROLE [db_owner] ADD MEMBER [swart]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [swart]
GO
ALTER ROLE [db_datareader] ADD MEMBER [ORM_Users]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [ORM_Users]
GO
ALTER ROLE [db_owner] ADD MEMBER [m_siami]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [m_siami]
GO
/****** Object:  UserDefinedFunction [dbo].[Get_SQL_Query]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Get_SQL_Query]
(
	-- Add the parameters for the function here
	@Param_ID as bigint
)
RETURNS nvarchar(max)
AS
BEGIN
	
	Declare @sqlquery nvarchar(max)
	set @sqlquery = (select sql_query from parameter where Parameter_ID = @Param_ID)
	-- Return the result of the function
	RETURN @sqlquery

END

GO
/****** Object:  Table [dbo].[Actions]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Act_Name] [nvarchar](50) NULL,
	[Act_Type] [smallint] NULL,
	[Code] [nchar](10) NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BaseData]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaseData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Fname] [nvarchar](50) NOT NULL,
	[Code] [nchar](10) NOT NULL,
	[Desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_BaseData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Branch]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[Branch] [bigint] NOT NULL,
	[BranchName] [nvarchar](100) NULL,
	[State_Of_Branch] [bigint] NULL,
	[Branch_Rank] [smallint] NULL,
	[Limit] [numeric](38, 4) NULL,
	[Description] [nvarchar](100) NULL,
	[BID] [bigint] NOT NULL,
 CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
(
	[BID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Branch_Choice]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch_Choice](
	[Form_Instance_ID] [bigint] NOT NULL,
	[Question_ID] [bigint] NOT NULL,
	[Branch_Item] [bigint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BRANCHHH]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BRANCHHH](
	[کد جدید] [float] NULL,
	[نام جدید شعبه] [nvarchar](255) NULL,
	[آدرس] [nvarchar](255) NULL,
	[تلفن] [nvarchar](255) NULL,
	[نام بانک/ موسسه] [nvarchar](255) NULL,
	[F6] [nvarchar](255) NULL,
	[F7] [nvarchar](255) NULL,
	[F8] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chart]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chart](
	[Chart_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Chart_Name] [nvarchar](100) NULL,
	[Chart_Description] [nvarchar](500) NULL,
	[Question_ID] [bigint] NULL,
	[Chart_Type] [nvarchar](20) NULL,
	[X_Label] [nvarchar](100) NULL,
	[Y_Label] [nvarchar](100) NULL,
	[Select_Command] [nvarchar](max) NULL,
 CONSTRAINT [PK_Chart] PRIMARY KEY CLUSTERED 
(
	[Chart_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contract_type_groups]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contract_type_groups](
	[Contract_type_group_id] [int] NOT NULL,
	[Contract_type_group_Desc] [nvarchar](50) NULL,
	[Contract_MType_id] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dep_Choice]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_Choice](
	[Form_Instance_ID] [bigint] NOT NULL,
	[Question_ID] [bigint] NOT NULL,
	[Dep_Item] [int] NOT NULL,
 CONSTRAINT [PK_Dep_Choice] PRIMARY KEY CLUSTERED 
(
	[Form_Instance_ID] ASC,
	[Question_ID] ASC,
	[Dep_Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dep_Index]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_Index](
	[Index_ID] [bigint] NOT NULL,
	[Dep_ID] [int] NOT NULL,
 CONSTRAINT [PK_Dep_Index] PRIMARY KEY CLUSTERED 
(
	[Dep_ID] ASC,
	[Index_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Department]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepID] [int] NOT NULL,
	[DepName] [nvarchar](500) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Form_Dep_State]    Script Date: 2/6/2023 10:42:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Form_Dep_State](
	[Form_ID] [bigint] NOT NULL,
	[Dep_ID] [int] NOT NULL,
	[State_ID] [bigint] NOT NULL,
 CONSTRAINT [PK_Form_DEp_State] PRIMARY KEY CLUSTERED 
(
	[Form_ID] ASC,
	[Dep_ID] ASC,
	[State_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Form_Instance]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Form_Instance](
	[Instance_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[filldate] [datetime] NOT NULL,
	[User_name] [nvarchar](40) NOT NULL,
	[Form_ID] [bigint] NOT NULL,
	[Reported] [bit] NULL,
 CONSTRAINT [PK_Form_Instance] PRIMARY KEY CLUSTERED 
(
	[Instance_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Form_Question_Instance]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Form_Question_Instance](
	[Form_Instance_ID] [bigint] NOT NULL,
	[Question_ID] [bigint] NOT NULL,
	[Text] [nvarchar](500) NULL,
	[Date] [datetime] NULL,
	[Number] [decimal](38, 4) NULL,
	[Other_Description] [nvarchar](500) NULL,
	[Item_ID] [bigint] NULL,
	[Answer_ID] [bigint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forms]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forms](
	[Form_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Form_Name] [nvarchar](50) NOT NULL,
	[Form_Description] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_ORM_Forms] PRIMARY KEY CLUSTERED 
(
	[Form_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Group_Permissions]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Permissions](
	[Form_ID] [bigint] NOT NULL,
	[Group_ID] [int] NOT NULL,
	[Readable] [bit] NULL,
	[Writeable] [bit] NULL,
	[Updateable] [bit] NULL,
	[Deleteable] [bit] NULL CONSTRAINT [DF_Group_Permissions_Deleteable]  DEFAULT ((1)),
	[AddQuestion] [bit] NULL CONSTRAINT [D_Group_Permissions_AddQuestion]  DEFAULT ((0)),
	[ReadOtherAnswers] [bit] NULL CONSTRAINT [D_Group_Permissions_ReadOtherAnswers]  DEFAULT ((0)),
 CONSTRAINT [PK_Group_Permissions] PRIMARY KEY CLUSTERED 
(
	[Form_ID] ASC,
	[Group_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Group_PermissionsLog]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_PermissionsLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_Name] [nvarchar](20) NULL,
	[dateEn] [datetime] NULL,
	[formName] [nvarchar](200) NULL,
	[groupName] [nvarchar](100) NULL,
	[cbr] [bit] NOT NULL CONSTRAINT [DF_read]  DEFAULT ((0)),
	[cbw] [bit] NOT NULL CONSTRAINT [DF_write]  DEFAULT ((0)),
	[cbu] [bit] NOT NULL CONSTRAINT [DF_update]  DEFAULT ((0)),
	[cbd] [bit] NOT NULL CONSTRAINT [DF_delete]  DEFAULT ((0)),
	[cbReadOtherAnswers] [bit] NULL CONSTRAINT [D_Group_PermissionsLog_ReadOtherAnswers]  DEFAULT ((0)),
	[cbAddQuestion] [bit] NULL CONSTRAINT [D_Group_PermissionsLog_AddQuestion]  DEFAULT ((0))
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Group_Users]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Users](
	[Group_ID] [int] NOT NULL,
	[User_Name] [nvarchar](100) NOT NULL,
	[IsAdmin] [bit] NOT NULL CONSTRAINT [D_Group_Users_IsAdmin]  DEFAULT ((0)),
 CONSTRAINT [PK_Group_Users] PRIMARY KEY CLUSTERED 
(
	[Group_ID] ASC,
	[User_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Groups]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Group_ID] [int] IDENTITY(1,1) NOT NULL,
	[Group_Name] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Group_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Item_Choice]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item_Choice](
	[Selected_Item] [bigint] NOT NULL,
	[Form_Instance_ID] [bigint] NOT NULL,
	[Question_ID] [bigint] NOT NULL,
 CONSTRAINT [PK_Item_Choice] PRIMARY KEY CLUSTERED 
(
	[Selected_Item] ASC,
	[Question_ID] ASC,
	[Form_Instance_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ledgers]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ledgers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Acc_Name] [nvarchar](50) NULL,
	[Acc_Type] [smallint] NULL,
	[Code] [nchar](10) NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_Ledgers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[List]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[List](
	[List_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Question_ID] [bigint] NOT NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_List] PRIMARY KEY CLUSTERED 
(
	[List_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[List_Items]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[List_Items](
	[Item_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Item_Text] [nvarchar](100) NOT NULL,
	[List_ID] [bigint] NOT NULL,
	[Optional] [bit] NULL,
	[Item_Type] [int] NULL,
	[Filled] [bit] NULL,
	[Table_ID] [int] NULL,
 CONSTRAINT [PK_ORM_List_Items] PRIMARY KEY CLUSTERED 
(
	[Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[List_Items_choice]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[List_Items_choice](
	[Item_ID] [bigint] NOT NULL,
	[Item_Text] [nvarchar](50) NULL,
	[List_ID] [bigint] NULL,
 CONSTRAINT [PK_Items_Repository] PRIMARY KEY CLUSTERED 
(
	[Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[List_Type]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[List_Type](
	[List_type_ID] [smallint] NOT NULL,
	[Description] [varchar](10) NOT NULL,
 CONSTRAINT [PK_List_Type] PRIMARY KEY CLUSTERED 
(
	[List_type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[Branch] [int] NOT NULL,
	[Branch_Description] [nvarchar](50) NULL,
	[State_Of_Branch] [int] NULL,
	[Branch_Rank] [nchar](2) NULL,
	[Limit] [numeric](38, 2) NULL,
	[City_Of_Branch] [int] NULL,
	[Bank_Of_Branch] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Organization_1]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization_1](
	[Branch] [int] NOT NULL,
	[Branch_Description] [nvarchar](50) NULL,
	[State_Of_Branch] [int] NULL,
	[Branch_Rank] [nchar](2) NULL,
	[Limit] [numeric](38, 2) NULL,
	[City_Of_Branch] [int] NULL,
	[Bank_Of_Branch] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parameter]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parameter](
	[Parameter_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Prameter_Name] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
	[Is_Time_Sensitive] [bit] NULL,
	[Is_Loc_Sensitive] [bit] NULL,
	[Sql_Query] [nvarchar](max) NULL,
	[Parameter_Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_Parameter] PRIMARY KEY CLUSTERED 
(
	[Parameter_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parameter_Dep]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parameter_Dep](
	[Parameter_ID] [bigint] NOT NULL,
	[Department_ID] [int] NOT NULL,
 CONSTRAINT [PK_Parameter_Dep] PRIMARY KEY CLUSTERED 
(
	[Parameter_ID] ASC,
	[Department_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parameter_State]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parameter_State](
	[Parameter_ID] [bigint] NOT NULL,
	[State_ID] [bigint] NOT NULL,
 CONSTRAINT [PK_Parameter_State] PRIMARY KEY CLUSTERED 
(
	[Parameter_ID] ASC,
	[State_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonelInfo]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonelInfo](
	[ShomarehPersenely] [int] NOT NULL,
	[CodeMeli] [nvarchar](10) NULL,
	[FName] [nvarchar](20) NULL,
	[LName] [nvarchar](25) NULL,
	[Genseiat] [smallint] NULL,
	[MahaleSodooreShenasnameh] [nvarchar](15) NULL,
	[TarykhTavalod] [nvarchar](8) NULL,
	[TarikhEstekhdam] [nvarchar](8) NULL,
	[Neshany] [nvarchar](max) NULL,
	[TelefonTamas] [nvarchar](17) NULL,
	[NamePedar] [nvarchar](20) NULL,
	[VazeeyateTaahol] [smallint] NULL,
	[SabeghehBymeh] [int] NULL,
	[TedadOladBarayeHoghoghDastMozd] [smallint] NULL,
	[TarikhShorooBekar] [nvarchar](8) NULL,
	[TedadSalKhedmat] [smallint] NULL,
	[TedadMahKhedmat] [int] NULL,
	[TedadRouzKhedmat] [int] NULL,
	[Estekhdam] [nvarchar](30) NULL,
	[HisDate] [nvarchar](10) NULL,
	[HashCode] [bigint] NULL,
	[ShomarehShenasnameh] [nvarchar](15) NULL,
	[MahalKhedmat] [nvarchar](60) NULL,
	[CodeMahalKhedmat] [nvarchar](50) NULL,
	[SematID] [int] NULL,
	[Semat] [nvarchar](50) NULL,
	[MobileNO] [nvarchar](64) NULL,
	[MadrakTahsyly] [smallint] NULL,
	[WorkSectionTitle] [nvarchar](1024) NULL,
	[WorkSectionID] [int] NULL,
	[StaffPureTitle] [nvarchar](512) NULL,
	[StaffID] [int] NULL,
	[EmploymentStatusTitle] [nvarchar](1024) NULL,
	[JobCategoryTitle] [nvarchar](512) NULL,
	[JobCategoryCode] [int] NULL,
	[EmploymentStatusID] [smallint] NULL,
	[EducationTitle] [nvarchar](70) NULL,
	[BranchCode] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonelInfo_AB_User]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonelInfo_AB_User](
	[USER_NAME] [nvarchar](50) NOT NULL,
	[PERSONEL_ID] [nvarchar](50) NOT NULL,
	[CodeMahalKhedmat] [nvarchar](50) NULL,
	[MahalKhedmat] [nvarchar](60) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Question_Relation]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_Relation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Question1] [bigint] NULL,
	[Question2] [bigint] NULL,
	[Type] [int] NULL,
	[Seq] [int] NULL,
	[Condition] [nvarchar](250) NULL,
 CONSTRAINT [PK_Question_Relation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Question_Type]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_Type](
	[Question_Type] [smallint] NOT NULL,
	[Description] [nchar](30) NULL,
 CONSTRAINT [PK_Question_Type] PRIMARY KEY CLUSTERED 
(
	[Question_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Questions]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Question_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Form_ID] [bigint] NOT NULL,
	[Question_Optional] [bit] NOT NULL,
	[Question_Type] [smallint] NOT NULL,
	[Template_Type] [smallint] NOT NULL,
	[Question_Index] [int] NOT NULL,
 CONSTRAINT [PK_ORM_Questions] PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[result]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[result](
	[field] [decimal](18, 0) NULL,
	[value] [bigint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Risk_Indicator]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Risk_Indicator](
	[Index_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
	[Index_Type] [smallint] NULL,
	[Goal] [decimal](18, 2) NULL,
	[Desirable] [decimal](18, 2) NULL,
	[Is_Loc_Sensitive] [bit] NULL,
	[IS_Time_Sensitive] [bit] NULL,
	[Math_Statement] [nvarchar](500) NULL,
 CONSTRAINT [PK_Index] PRIMARY KEY CLUSTERED 
(
	[Index_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Risk_Indicator_Bound]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Risk_Indicator_Bound](
	[Bound_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Index_ID] [bigint] NOT NULL,
	[Bound_Type] [smallint] NULL,
	[negative_infinity] [bit] NULL,
	[Lower_Bound_isclose] [bit] NULL,
	[Lower_Bound] [decimal](18, 2) NULL,
	[Upper_Bound_isclose] [bit] NULL,
	[positive_infinity] [bit] NULL,
	[Upper_Bound] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Risk_Indicator_Bound] PRIMARY KEY CLUSTERED 
(
	[Bound_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[State]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State](
	[locid] [bigint] NOT NULL,
	[LocName] [nvarchar](255) NULL,
	[flashcode] [smallint] NULL,
	[description] [nvarchar](50) NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[locid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[State_Choice]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State_Choice](
	[Form_Instance_Id] [bigint] NOT NULL,
	[Question_ID] [bigint] NOT NULL,
	[State_Item] [bigint] NOT NULL,
 CONSTRAINT [PK_State_Choice] PRIMARY KEY CLUSTERED 
(
	[Form_Instance_Id] ASC,
	[Question_ID] ASC,
	[State_Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[State_Index]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State_Index](
	[State_ID] [bigint] NOT NULL,
	[Index_ID] [bigint] NOT NULL,
 CONSTRAINT [PK_State_Index] PRIMARY KEY CLUSTERED 
(
	[State_ID] ASC,
	[Index_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tables]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](600) NULL,
	[Fname] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Template]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Template](
	[Template_Type] [smallint] NOT NULL,
	[Description] [nchar](10) NULL,
 CONSTRAINT [PK_ORM_Template] PRIMARY KEY CLUSTERED 
(
	[Template_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Answers]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Answers]
WITH SCHEMABINDING 
AS
SELECT     TOP (100) PERCENT dbo.Form_Instance.Instance_ID, dbo.Form_Instance.filldate, dbo.Form_Instance.User_name, 
                      dbo.Form_Question_Instance.Form_Instance_ID, dbo.Form_Question_Instance.Question_ID, dbo.Questions.Question_Type, 
                      dbo.Questions.Template_Type, dbo.Form_Instance.Form_ID, dbo.Form_Question_Instance.Text, dbo.Form_Question_Instance.Date, 
                      dbo.Form_Question_Instance.Number, dbo.Item_Choice.Selected_Item, dbo.Dep_Choice.Dep_Item, dbo.Branch_Choice.Branch_Item, 
                      dbo.State_Choice.State_Item, dbo.Form_Question_Instance.Answer_ID, dbo.Form_Question_Instance.Item_ID, dbo.List_Items.Item_Text, 
                      dbo.Questions.Question_Index, dbo.Form_Dep_State.Dep_ID, dbo.Form_Instance.Reported
FROM         dbo.Form_Question_Instance INNER JOIN
                      dbo.Form_Instance ON dbo.Form_Question_Instance.Form_Instance_ID = dbo.Form_Instance.Instance_ID INNER JOIN
                      dbo.Questions ON dbo.Form_Question_Instance.Question_ID = dbo.Questions.Question_ID INNER JOIN
                      dbo.Form_Dep_State ON dbo.Form_Instance.Form_ID = dbo.Form_Dep_State.Form_ID LEFT OUTER JOIN
                      dbo.List_Items ON dbo.Form_Question_Instance.Item_ID = dbo.List_Items.Item_ID LEFT OUTER JOIN
                      dbo.State_Choice ON dbo.Form_Question_Instance.Form_Instance_ID = dbo.State_Choice.Form_Instance_Id AND 
                      dbo.Form_Question_Instance.Question_ID = dbo.State_Choice.Question_ID LEFT OUTER JOIN
                      dbo.Item_Choice ON dbo.Form_Question_Instance.Form_Instance_ID = dbo.Item_Choice.Form_Instance_ID AND 
                      dbo.Form_Question_Instance.Question_ID = dbo.Item_Choice.Question_ID LEFT OUTER JOIN
                      dbo.Dep_Choice ON dbo.Form_Question_Instance.Form_Instance_ID = dbo.Dep_Choice.Form_Instance_ID AND 
                      dbo.Form_Question_Instance.Question_ID = dbo.Dep_Choice.Question_ID LEFT OUTER JOIN
                      dbo.Branch_Choice ON dbo.Form_Question_Instance.Form_Instance_ID = dbo.Branch_Choice.Form_Instance_ID AND 
                      dbo.Form_Question_Instance.Question_ID = dbo.Branch_Choice.Question_ID
ORDER BY dbo.Form_Instance.User_name, dbo.Form_Instance.Instance_ID, dbo.Questions.Question_Index, dbo.Form_Question_Instance.Answer_ID, 
                      dbo.Form_Question_Instance.Item_ID

GO
/****** Object:  UserDefinedFunction [dbo].[get_answer_by_date]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[get_answer_by_date]
(	
	-- Add the parameters for the function here
	@from_date datetime , @to_date datetime
)
RETURNS TABLE 
AS
RETURN 
(
	select * from answers where datediff(d,filldate,@from_date)<= 0 AND datediff(d,filldate,@to_date)>=0
)

GO
/****** Object:  View [dbo].[V_Field_Type]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Field_Type]
AS
SELECT     ID, Name, Fname, Code
FROM         dbo.BaseData
WHERE     (Code LIKE 'qt_%')

GO
/****** Object:  View [dbo].[V_Items]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Items]
AS
SELECT     dbo.List_Items.Item_ID, dbo.List_Items.Item_Text, CASE WHEN dbo.List_Items.Optional = 'False' THEN 'اختیاری' ELSE 'اجباری' END AS Optional, 
                      dbo.V_Field_Type.Fname AS Type, CASE WHEN dbo.List_Items.Filled = 'True' THEN 'مقداردار' ELSE 'خالی' END AS Filled, dbo.Tables.Fname AS Table_Name, 
                      dbo.Questions.Description, dbo.List.List_ID, dbo.Questions.Question_ID, dbo.Tables.ID AS Table_ID, dbo.V_Field_Type.ID AS TypeId, dbo.Questions.Form_ID, 
                      CAST(dbo.List_Items.Optional AS int) AS BOptional, CAST(dbo.List_Items.Filled AS int) AS BFilled
FROM         dbo.List_Items LEFT OUTER JOIN
                      dbo.Tables ON dbo.List_Items.Table_ID = dbo.Tables.ID INNER JOIN
                      dbo.List ON dbo.List_Items.List_ID = dbo.List.List_ID INNER JOIN
                      dbo.Questions ON dbo.List.Question_ID = dbo.Questions.Question_ID INNER JOIN
                      dbo.V_Field_Type ON dbo.List_Items.Item_Type = dbo.V_Field_Type.ID

GO
/****** Object:  UserDefinedFunction [dbo].[Get_Column_Text]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Get_Column_Text] (@qid int , @instancid int )
RETURNS TABLE AS
RETURN (SELECT     Text_Value, Question_ID, Instance_ID
	FROM         Text_value
	WHERE     (Question_ID = @qid) AND (Instance_ID = @instancid) )
GO
/****** Object:  UserDefinedFunction [dbo].[get_Value]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[get_Value] 
(	
	-- Add the parameters for the function here
	@Param_ID as bigint
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select sql_query from parameter where Parameter_ID = @Param_ID
)

GO
/****** Object:  View [dbo].[Orm_Personnel_Info]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Orm_Personnel_Info]
AS
SELECT        dbo.View_PersonelInfo_AB_User.USER_NAME AS U_Name, CASE WHEN dbo.View_PersonelInfo_AB_User.USER_NAME = 'g.bakhtiaryfar' OR
                         dbo.View_PersonelInfo_AB_User.USER_NAME = 'j.rasoulof' THEN 'Admin' ELSE 'User' END AS Admins, dbo.View_PersonelInfo.ShomarehPersenely, dbo.View_PersonelInfo.Semat, 
                         CASE WHEN SematID = '117' OR
                         SematID = '119' OR
                         SematID = '121' OR
                         SematID = '126' OR
                         SematID = '112' THEN 1 WHEN SematID = '120' OR
                         SematID = '122' OR
                         SematID = '125' OR
                         SematID = '140' OR
                         SematID = '131' THEN 2 WHEN SematID = '1068' OR
                         SematID = '1072' OR
                         SematID = '1072' OR
                         SematID = '1077' OR
                         SematID = '1078' OR
                         SematID = '1098' OR
                         SematID = '1104' OR
                         SematID = '1379' OR
                         SematID = '1381' OR
                         SematID = '1406' OR
                         SematID = '1408' OR
                         SematID = '1401' OR
                         SematID = '1416' OR
                         SematID = '1417' OR
                         SematID = '1412' OR
                         SematID = '1413' OR
                         SematID = '301' OR
                         SematID = '1351' OR
                         SematID = '1344' OR
                         SematID = '1085' OR
                         SematID = '1062' OR
                         SematID = '1352' OR
                         SematID = '1396' OR
                         SematID = '1397' OR
                         SematID = '1410' OR
                         SematID = '1411' OR
                         SematID = '1340' OR
                         SematID = '1089' OR
                         SematID = '1065' OR
                         SematID = '1074' OR
                         SematID = '1076' OR
                         SematID = '1093' OR
                         SematID = '1342' OR
                         SematID = '303' OR
                         SematID = '1071' OR
                         SematID = '1080' OR
                         SematID = '1347' OR
                         SematID = '1345' OR
                         SematID = '1350' OR
                         SematID = '1075' OR
                         SematID = '1059' OR
                         SematID = '1088' OR
                         SematID = '1096' OR
                         SematID = '1097' OR
                         SematID = '1106' OR
                         SematID = '1107' OR
                         SematID = '1341' OR
                         SematID = '1339' OR
                         SematID = '1083' OR
                         SematID = '1327' OR
                         SematID = '1357' OR
                         SematID = '1403' OR
                         SematID = '1343' OR
                         SematID = '305' OR
                         SematID = '1095' OR
                         SematID = '1061' OR
                         SematID = '1400' OR
                         SematID = '1346' OR
                         SematID = '1057' OR
                         SematID = '310' OR
                         SematID = '1066' OR
                         SematID = '1067' OR
                         SematID = '1082' OR
                         SematID = '1324' OR
                         SematID = '307' OR
                         SematID = '1069' OR
                         SematID = '1084' OR
                         SematID = '1317' OR
                         SematID = '1070' OR
                         SematID = '1058' THEN 3 ELSE - 1 END AS Role, dbo.View_PersonelInfo.Semat + ' : ' + dbo.View_PersonelInfo.MahalKhedmat AS s_mkh, dbo.View_PersonelInfo.SematID, dbo.View_PersonelInfo.MahalKhedmat, 
                         dbo.View_PersonelInfo.CodeMahalKhedmat
FROM            dbo.View_PersonelInfo INNER JOIN
                         dbo.View_PersonelInfo_AB_User ON dbo.View_PersonelInfo.ShomarehPersenely = dbo.View_PersonelInfo_AB_User.PERSONEL_ID
WHERE        (dbo.View_PersonelInfo.Semat IS NOT NULL)

GO
/****** Object:  View [dbo].[V_Accounts]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Accounts]
AS
SELECT     TOP (100) PERCENT ID, Acc_Name, Acc_Type, Code, Description
FROM         dbo.Ledgers
WHERE     (Code LIKE 'Ans_5_%')
ORDER BY SUBSTRING(Code, 7, 1)

GO
/****** Object:  View [dbo].[V_Branch]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Branch]
AS
SELECT     Branch, Branch_Description + N'---------' + CAST(Branch AS nvarchar) AS BranchName
FROM         dbo.Organization

GO
/****** Object:  View [dbo].[V_Branch_Code]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Branch_Code]
AS
SELECT     Branch, Branch AS BranchCode, BranchName
FROM         dbo.Branch

GO
/****** Object:  View [dbo].[V_Contract_Type]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Contract_Type]
AS
SELECT     TOP (100) PERCENT ID, Acc_Name, Acc_Type, Code, Description
FROM         dbo.Ledgers
WHERE     (Code LIKE 'Ans_7_%')
ORDER BY SUBSTRING(Code, 7, 1)

GO
/****** Object:  View [dbo].[V_GRP_USR_FRM]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_GRP_USR_FRM]
AS

with A as(
	SELECT        dbo.Groups.Group_Name, dbo.Group_Users.Group_ID, dbo.Group_Users.User_Name 
	FROM            dbo.Group_Users INNER JOIN dbo.Groups 
	ON dbo.Group_Users.Group_ID = dbo.Groups.Group_ID
),B as (
	SELECT A.*
			,dbo.Group_Permissions.Form_ID
	FROM   A INNER JOIN dbo.Group_Permissions 
	ON A.Group_ID = dbo.Group_Permissions.Group_ID
),C as(
	SELECT B.*
			,Forms.Form_Name
	FROM B INNER JOIN Forms
	ON B.Form_ID=Forms.Form_ID
)
SELECT * FROM C




GO
/****** Object:  View [dbo].[V_Ledger1]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Ledger1]
AS
SELECT     TOP (100) PERCENT ID, Acc_Name, Acc_Type, Code, Description
FROM         dbo.Ledgers
WHERE     (Code LIKE 'Ctr_9_%')
ORDER BY SUBSTRING(Code, 7, 1)

GO
/****** Object:  View [dbo].[V_Ledger2]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Ledger2]
AS
SELECT     TOP (100) PERCENT ID, Acc_Name, Acc_Type, Code, Description
FROM         dbo.Ledgers
WHERE     (Code LIKE 'Ctr_15_%')
ORDER BY SUBSTRING(Code, 8, 1)

GO
/****** Object:  View [dbo].[V_OLTP_PRSNL]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[V_OLTP_PRSNL]
AS
select 	A.PERSONEL_ID  as ShomarehPersenely
	,A.PERSONEL_ID  
  ,A.User_Name AS UserName
  ,A.User_Name 
	,A.CodeMeli
  ,A.CodeMahalKhedmat
  ,A.Semat
  ,A.MahalKhedmat
  ,B.displayName AS FullName
  ,B.displayName 
	FROM    [Risk_Mng_Tat_OLTP].[dbo].View_PersonelInfo_Swart A 
	left join
  [Risk_Mng_Tat_OLTP].[dbo].[View_PersonelInfo] B on 
  A.PERSONEL_ID=B.employeeID
  WHERE        A.isActive=1 
  and A.USER_NAME not like '$%'
  




GO
/****** Object:  View [dbo].[V_OLTP_PRSNL_FG_DB_GRP]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[V_OLTP_PRSNL_FG_DB_GRP]
AS

with AB as(
SELECT    B.displayName AS FullName 
	,B.displayName 
   ,A.Semat
  ,A.PERSONEL_ID as ShomarehPersenely
  ,A.PERSONEL_ID 
  ,A.CodeMeli
  ,A.User_Name  AS UserName
  ,A.User_Name 
  ,A.CodeMahalKhedmat
  ,A.MahalKhedmat
  ,A.branch as BranchCode 
  ,A.isActive 
FROM         
 [Risk_Mng_Tat_OLTP].[dbo].View_PersonelInfo_Swart A left join
  [Risk_Mng_Tat_OLTP].[dbo].[View_PersonelInfo] B on 
  A.PERSONEL_ID=B.employeeID
), ABC as(
select 	
	    AB.*
		,C.IsAdmin
		,C.Group_ID
		
		 from AB
inner join 
Group_Users C on 
 C.User_Name collate SQL_Latin1_General_CP1_CI_AS=AB.User_Name
WHERE        AB.isActive=1 
and C.USER_NAME not like '$%')

select ABC.*
	   ,Groups.Group_Name 
from ABC
inner join Groups
on ABC.Group_ID=Groups.Group_ID





GO
/****** Object:  View [dbo].[V_Question_16]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Question_16]
AS
SELECT     TOP (100) PERCENT ID, Acc_Name, Acc_Type, Code, Description
FROM         dbo.Ledgers
WHERE     (Code LIKE 'Ctr_16_%')
ORDER BY SUBSTRING(Code, 7, 1)

GO
/****** Object:  View [dbo].[V_Question_Relation]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Question_Relation]
AS
SELECT     dbo.Questions.Question_ID AS QID1, dbo.Questions.Form_ID, dbo.Questions.Question_Type, dbo.Questions.Question_Index AS Index1, 
                      dbo.Question_Relation.Question2 AS QID2, dbo.Question_Relation.Condition, dbo.Questions.Description AS Desc1, Questions_2.Description AS Desc2, 
                      Questions_2.Question_Index AS Index2
FROM         dbo.Question_Relation INNER JOIN
                      dbo.Questions ON dbo.Question_Relation.Question1 = dbo.Questions.Question_ID INNER JOIN
                      dbo.Questions AS Questions_2 ON dbo.Question_Relation.Question2 = Questions_2.Question_ID

GO
/****** Object:  View [dbo].[V_Questions]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Questions]
AS
SELECT     dbo.Questions.Question_ID AS QID, dbo.Questions.Question_Index AS QueNum, dbo.Questions.Description AS Que, dbo.Questions.Question_Optional AS Status, 
                      dbo.Questions.Question_Type AS Type, dbo.Questions.Form_ID, dbo.Questions.Template_Type, dbo.Question_Relation.Question1 AS QID1, 
                      dbo.Question_Relation.Condition, Questions_1.Description AS Que1, Questions_1.Question_Index AS QueNum1, dbo.Question_Type.Description AS Type_Desc, 
                      dbo.Question_Relation.ID AS QRelationID
FROM         dbo.Questions INNER JOIN
                      dbo.Question_Type ON dbo.Questions.Question_Type = dbo.Question_Type.Question_Type LEFT OUTER JOIN
                      dbo.Question_Relation ON dbo.Questions.Question_ID = dbo.Question_Relation.Question2 LEFT OUTER JOIN
                      dbo.Questions AS Questions_1 ON dbo.Question_Relation.Question1 = Questions_1.Question_ID

GO
/****** Object:  View [dbo].[View_Form]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Form]
AS
SELECT DISTINCT dbo.Forms.Form_ID, dbo.Forms.Form_Name
FROM         dbo.Forms INNER JOIN
                      dbo.Questions ON dbo.Forms.Form_ID = dbo.Questions.Form_ID
WHERE     (dbo.Questions.Question_Type = 2) OR
                      (dbo.Questions.Question_Type = 3) OR
                      (dbo.Questions.Question_Type = 4)

GO
/****** Object:  View [dbo].[View_Instance_Branch_Answers]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[View_Instance_Branch_Answers]
AS
SELECT          PersonelInfo_AB_User.USER_NAME, 
				PersonelInfo_AB_User.CodeMahalKhedmat, 
				Form_Instance.filldate, 
				Form_Instance.Instance_ID,
				Form_Instance.Form_ID,
				Form_Instance.User_name AS Form_Instance_User_name
FROM            Form_Instance LEFT OUTER JOIN
                         PersonelInfo_AB_User ON PersonelInfo_AB_User.USER_NAME=Form_Instance.User_name
						-- where filldate >'2018-09-10 12:51:00.000'



GO
/****** Object:  View [dbo].[View_Parameter]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Parameter]
AS
SELECT DISTINCT 
                      dbo.Parameter.Parameter_ID, dbo.Parameter.Prameter_Name AS parameter_Name, dbo.Parameter.Description, dbo.Parameter.Is_Time_Sensitive, 
                      dbo.Parameter.Is_Loc_Sensitive, dbo.Parameter.Sql_Query, dbo.Department.DepID, dbo.Department.DepName, dbo.State.locid, 
                      dbo.State.LocName
FROM         dbo.Parameter LEFT OUTER JOIN
                      dbo.Department INNER JOIN
                      dbo.Parameter_Dep ON dbo.Department.DepID = dbo.Parameter_Dep.Department_ID ON 
                      dbo.Parameter.Parameter_ID = dbo.Parameter_Dep.Parameter_ID LEFT OUTER JOIN
                      dbo.State INNER JOIN
                      dbo.Parameter_State ON dbo.State.locid = dbo.Parameter_State.State_ID ON dbo.Parameter.Parameter_ID = dbo.Parameter_State.Parameter_ID

GO
/****** Object:  View [dbo].[View_Personel]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[View_Personel]
AS

SELECT        
[displayName] AS FullName
	  ,A.[EmploymentStatusTitle]
	  ,A.[EmploymentStatusID]
	 ,A.[Semat]      
	  ,A.employeeID as ShomarehPersenely
  ,A.[CodeMeli]
  ,[UserName]  AS User_Name,
      A.[CodeMahalKhedmat]
	  ,department as [MahalKhedmat],			 		
			null as BranchCode  ,
							Group_Users.IsAdmin,
							Group_Users.Group_ID
FROM [Risk_Mng_Tat_OLTP].[dbo].[View_PersonelInfo] A  left JOIN          
 Group_Users
  on Group_Users.User_Name collate SQL_Latin1_General_CP1_CI_AS=A.[UserName]
						 
WHERE        (A.EmploymentStatusID IN (1, 9, 10, 11))



GO
/****** Object:  View [dbo].[View_Personel_Hot]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[View_Personel_Hot]
AS

select [displayName] AS FullName
	  ,[EmploymentStatusTitle]
	  ,[EmploymentStatusID]
	 ,A.[Semat]      
	  ,A.employeeID as ShomarehPersenely
  ,[CodeMeli]
  ,[UserName]
      ,[CodeMahalKhedmat]
	  ,department as [MahalKhedmat],			 		
			null as BranchCode 
  FROM    [Risk_Mng_Tat_OLTP].[dbo].[View_PersonelInfo] A
  
  WHERE        (EmploymentStatusID IN (1, 9, 10, 11))


GO
/****** Object:  View [dbo].[View_Risk_Indicator]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Risk_Indicator]
AS
SELECT DISTINCT 
                      dbo.Risk_Indicator.Index_ID, dbo.Risk_Indicator.Name, dbo.Risk_Indicator.Description, dbo.Risk_Indicator.Index_Type, dbo.Risk_Indicator.Goal, 
                      dbo.Risk_Indicator.Desirable, dbo.Risk_Indicator.Is_Loc_Sensitive, dbo.Risk_Indicator.Math_Statement, dbo.State.LocName, 
                      dbo.Department.DepName, dbo.Dep_Index.Dep_ID, dbo.State_Index.State_ID, dbo.Risk_Indicator_Bound.Bound_ID
FROM         dbo.State INNER JOIN
                      dbo.State_Index ON dbo.State.locid = dbo.State_Index.State_ID RIGHT OUTER JOIN
                      dbo.Department INNER JOIN
                      dbo.Dep_Index ON dbo.Department.DepID = dbo.Dep_Index.Dep_ID RIGHT OUTER JOIN
                      dbo.Risk_Indicator LEFT OUTER JOIN
                      dbo.Risk_Indicator_Bound ON dbo.Risk_Indicator.Index_ID = dbo.Risk_Indicator_Bound.Index_ID ON 
                      dbo.Dep_Index.Index_ID = dbo.Risk_Indicator.Index_ID ON dbo.State_Index.Index_ID = dbo.Risk_Indicator.Index_ID

GO
/****** Object:  Index [IX_Form_Dep_State]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_Form_Dep_State] ON [dbo].[Form_Dep_State]
(
	[Form_ID] ASC,
	[Dep_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_Form_Instance_9_670625432__K4_K1_2_3]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Form_Instance_9_670625432__K4_K1_2_3] ON [dbo].[Form_Instance]
(
	[Form_ID] ASC,
	[Instance_ID] ASC
)
INCLUDE ( 	[filldate],
	[User_name]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Form_Instance]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_Form_Instance] ON [dbo].[Form_Instance]
(
	[filldate] ASC,
	[Form_ID] ASC,
	[Instance_ID] ASC,
	[User_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [NonClusteredIndex-20161129-140316]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20161129-140316] ON [dbo].[Form_Instance]
(
	[filldate] ASC,
	[User_name] ASC,
	[Form_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_Form_Question_Instance_9_718625603__K1_K2_K7_3_4_5_8]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Form_Question_Instance_9_718625603__K1_K2_K7_3_4_5_8] ON [dbo].[Form_Question_Instance]
(
	[Form_Instance_ID] ASC,
	[Question_ID] ASC,
	[Item_ID] ASC
)
INCLUDE ( 	[Text],
	[Date],
	[Number],
	[Answer_ID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Form_Question_Instance]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_Form_Question_Instance] ON [dbo].[Form_Question_Instance]
(
	[Form_Instance_ID] ASC,
	[Question_ID] ASC,
	[Answer_ID] ASC,
	[Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_Item_Choice_9_782625831__K3_K2_1]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Item_Choice_9_782625831__K3_K2_1] ON [dbo].[Item_Choice]
(
	[Question_ID] ASC,
	[Form_Instance_ID] ASC
)
INCLUDE ( 	[Selected_Item]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_List]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_List] ON [dbo].[List]
(
	[List_ID] ASC,
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_List_Items]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_List_Items] ON [dbo].[List_Items]
(
	[Item_ID] ASC,
	[List_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Question_Relation]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_Question_Relation] ON [dbo].[Question_Relation]
(
	[Question1] ASC,
	[Question2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Questions_Form]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_Questions_Form] ON [dbo].[Questions]
(
	[Question_ID] ASC,
	[Form_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Questions_Index]    Script Date: 2/6/2023 10:42:33 AM ******/
CREATE NONCLUSTERED INDEX [IX_Questions_Index] ON [dbo].[Questions]
(
	[Form_ID] ASC,
	[Question_ID] ASC,
	[Question_Index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Branch]  WITH CHECK ADD  CONSTRAINT [FK_Branch_State] FOREIGN KEY([State_Of_Branch])
REFERENCES [dbo].[State] ([locid])
GO
ALTER TABLE [dbo].[Branch] CHECK CONSTRAINT [FK_Branch_State]
GO
ALTER TABLE [dbo].[Chart]  WITH CHECK ADD  CONSTRAINT [FK_Chart_Questions] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Questions] ([Question_ID])
GO
ALTER TABLE [dbo].[Chart] CHECK CONSTRAINT [FK_Chart_Questions]
GO
ALTER TABLE [dbo].[Dep_Choice]  WITH CHECK ADD  CONSTRAINT [FK_Dep_Choice_Department] FOREIGN KEY([Dep_Item])
REFERENCES [dbo].[Department] ([DepID])
GO
ALTER TABLE [dbo].[Dep_Choice] CHECK CONSTRAINT [FK_Dep_Choice_Department]
GO
ALTER TABLE [dbo].[Dep_Index]  WITH CHECK ADD  CONSTRAINT [FK_Dep_Index_Department] FOREIGN KEY([Dep_ID])
REFERENCES [dbo].[Department] ([DepID])
GO
ALTER TABLE [dbo].[Dep_Index] CHECK CONSTRAINT [FK_Dep_Index_Department]
GO
ALTER TABLE [dbo].[Dep_Index]  WITH CHECK ADD  CONSTRAINT [FK_Dep_Index_Index] FOREIGN KEY([Index_ID])
REFERENCES [dbo].[Risk_Indicator] ([Index_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Dep_Index] CHECK CONSTRAINT [FK_Dep_Index_Index]
GO
ALTER TABLE [dbo].[Form_Dep_State]  WITH CHECK ADD  CONSTRAINT [FK_Form_Dep_State_Department] FOREIGN KEY([Dep_ID])
REFERENCES [dbo].[Department] ([DepID])
GO
ALTER TABLE [dbo].[Form_Dep_State] CHECK CONSTRAINT [FK_Form_Dep_State_Department]
GO
ALTER TABLE [dbo].[Form_Dep_State]  WITH CHECK ADD  CONSTRAINT [FK_Form_DEp_State_ORM_Forms] FOREIGN KEY([Form_ID])
REFERENCES [dbo].[Forms] ([Form_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Form_Dep_State] CHECK CONSTRAINT [FK_Form_DEp_State_ORM_Forms]
GO
ALTER TABLE [dbo].[Form_Dep_State]  WITH CHECK ADD  CONSTRAINT [FK_Form_DEp_State_State] FOREIGN KEY([State_ID])
REFERENCES [dbo].[State] ([locid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Form_Dep_State] CHECK CONSTRAINT [FK_Form_DEp_State_State]
GO
ALTER TABLE [dbo].[Form_Instance]  WITH CHECK ADD  CONSTRAINT [FK_Form_Instance] FOREIGN KEY([Form_ID])
REFERENCES [dbo].[Forms] ([Form_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Form_Instance] CHECK CONSTRAINT [FK_Form_Instance]
GO
ALTER TABLE [dbo].[Form_Question_Instance]  WITH CHECK ADD  CONSTRAINT [FK_Instance_Question] FOREIGN KEY([Form_Instance_ID])
REFERENCES [dbo].[Form_Instance] ([Instance_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Form_Question_Instance] CHECK CONSTRAINT [FK_Instance_Question]
GO
ALTER TABLE [dbo].[Form_Question_Instance]  WITH CHECK ADD  CONSTRAINT [FK_Item_Instance] FOREIGN KEY([Item_ID])
REFERENCES [dbo].[List_Items] ([Item_ID])
GO
ALTER TABLE [dbo].[Form_Question_Instance] CHECK CONSTRAINT [FK_Item_Instance]
GO
ALTER TABLE [dbo].[Form_Question_Instance]  WITH CHECK ADD  CONSTRAINT [FK_Question_Instance] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Questions] ([Question_ID])
GO
ALTER TABLE [dbo].[Form_Question_Instance] CHECK CONSTRAINT [FK_Question_Instance]
GO
ALTER TABLE [dbo].[Group_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Group_Permissions_Forms] FOREIGN KEY([Form_ID])
REFERENCES [dbo].[Forms] ([Form_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Group_Permissions] CHECK CONSTRAINT [FK_Group_Permissions_Forms]
GO
ALTER TABLE [dbo].[Group_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Group_Permissions_Groups] FOREIGN KEY([Group_ID])
REFERENCES [dbo].[Groups] ([Group_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Group_Permissions] CHECK CONSTRAINT [FK_Group_Permissions_Groups]
GO
ALTER TABLE [dbo].[Group_Users]  WITH CHECK ADD  CONSTRAINT [FK_Group_Users_Groups] FOREIGN KEY([Group_ID])
REFERENCES [dbo].[Groups] ([Group_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Group_Users] CHECK CONSTRAINT [FK_Group_Users_Groups]
GO
ALTER TABLE [dbo].[Item_Choice]  WITH NOCHECK ADD  CONSTRAINT [FK_Item_Choice_List_Items1] FOREIGN KEY([Selected_Item])
REFERENCES [dbo].[List_Items] ([Item_ID])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Item_Choice] CHECK CONSTRAINT [FK_Item_Choice_List_Items1]
GO
ALTER TABLE [dbo].[List]  WITH CHECK ADD  CONSTRAINT [FK_List_Questions1] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Questions] ([Question_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[List] CHECK CONSTRAINT [FK_List_Questions1]
GO
ALTER TABLE [dbo].[List_Items]  WITH CHECK ADD  CONSTRAINT [FK_item_table] FOREIGN KEY([Table_ID])
REFERENCES [dbo].[Tables] ([ID])
GO
ALTER TABLE [dbo].[List_Items] CHECK CONSTRAINT [FK_item_table]
GO
ALTER TABLE [dbo].[List_Items]  WITH CHECK ADD  CONSTRAINT [FK_item_type] FOREIGN KEY([Item_Type])
REFERENCES [dbo].[BaseData] ([ID])
GO
ALTER TABLE [dbo].[List_Items] CHECK CONSTRAINT [FK_item_type]
GO
ALTER TABLE [dbo].[List_Items]  WITH CHECK ADD  CONSTRAINT [FK_List_Items_List] FOREIGN KEY([List_ID])
REFERENCES [dbo].[List] ([List_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[List_Items] CHECK CONSTRAINT [FK_List_Items_List]
GO
ALTER TABLE [dbo].[Parameter_Dep]  WITH CHECK ADD  CONSTRAINT [FK_Parameter_Dep_Department] FOREIGN KEY([Department_ID])
REFERENCES [dbo].[Department] ([DepID])
GO
ALTER TABLE [dbo].[Parameter_Dep] CHECK CONSTRAINT [FK_Parameter_Dep_Department]
GO
ALTER TABLE [dbo].[Parameter_Dep]  WITH CHECK ADD  CONSTRAINT [FK_Parameter_Dep_Parameter] FOREIGN KEY([Parameter_ID])
REFERENCES [dbo].[Parameter] ([Parameter_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Parameter_Dep] CHECK CONSTRAINT [FK_Parameter_Dep_Parameter]
GO
ALTER TABLE [dbo].[Parameter_State]  WITH CHECK ADD  CONSTRAINT [FK_Parameter_State_Parameter] FOREIGN KEY([Parameter_ID])
REFERENCES [dbo].[Parameter] ([Parameter_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Parameter_State] CHECK CONSTRAINT [FK_Parameter_State_Parameter]
GO
ALTER TABLE [dbo].[Parameter_State]  WITH CHECK ADD  CONSTRAINT [FK_Parameter_State_State] FOREIGN KEY([State_ID])
REFERENCES [dbo].[State] ([locid])
GO
ALTER TABLE [dbo].[Parameter_State] CHECK CONSTRAINT [FK_Parameter_State_State]
GO
ALTER TABLE [dbo].[Question_Relation]  WITH CHECK ADD  CONSTRAINT [FK_Ques_Rel_Ques1] FOREIGN KEY([Question1])
REFERENCES [dbo].[Questions] ([Question_ID])
GO
ALTER TABLE [dbo].[Question_Relation] CHECK CONSTRAINT [FK_Ques_Rel_Ques1]
GO
ALTER TABLE [dbo].[Question_Relation]  WITH CHECK ADD  CONSTRAINT [FK_Ques_Rel_Ques2] FOREIGN KEY([Question2])
REFERENCES [dbo].[Questions] ([Question_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Question_Relation] CHECK CONSTRAINT [FK_Ques_Rel_Ques2]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_ORM_Questions_ORM_Forms] FOREIGN KEY([Form_ID])
REFERENCES [dbo].[Forms] ([Form_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_ORM_Questions_ORM_Forms]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_ORM_Questions_Question_Type] FOREIGN KEY([Question_Type])
REFERENCES [dbo].[Question_Type] ([Question_Type])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_ORM_Questions_Question_Type]
GO
ALTER TABLE [dbo].[Risk_Indicator_Bound]  WITH CHECK ADD  CONSTRAINT [FK_Index_Bound_Index] FOREIGN KEY([Index_ID])
REFERENCES [dbo].[Risk_Indicator] ([Index_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Risk_Indicator_Bound] CHECK CONSTRAINT [FK_Index_Bound_Index]
GO
ALTER TABLE [dbo].[State_Choice]  WITH CHECK ADD  CONSTRAINT [FK_State_Choice_State1] FOREIGN KEY([State_Item])
REFERENCES [dbo].[State] ([locid])
GO
ALTER TABLE [dbo].[State_Choice] CHECK CONSTRAINT [FK_State_Choice_State1]
GO
ALTER TABLE [dbo].[State_Index]  WITH CHECK ADD  CONSTRAINT [FK_State_Index_Index] FOREIGN KEY([Index_ID])
REFERENCES [dbo].[Risk_Indicator] ([Index_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[State_Index] CHECK CONSTRAINT [FK_State_Index_Index]
GO
ALTER TABLE [dbo].[State_Index]  WITH CHECK ADD  CONSTRAINT [FK_State_Index_State] FOREIGN KEY([State_ID])
REFERENCES [dbo].[State] ([locid])
GO
ALTER TABLE [dbo].[State_Index] CHECK CONSTRAINT [FK_State_Index_State]
GO
/****** Object:  StoredProcedure [dbo].[Get_Form_Answers]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[Get_Form_Answers] (@from_id bigint)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
sELECT     Text_value.Instance_ID, Questions.Description AS Question, Text_value.Text_Value AS Answer  , Questions.Question_Type as Question_Type , Questions.Template_Type as Template_Type
FROM         dbo.Text_value INNER JOIN
                      dbo.Questions ON dbo.Text_value.Question_ID = dbo.Questions.Question_ID
WHERE     (dbo.Questions.Question_Type = 1 AND Text_value.Instance_ID in(Select Instance_id from Form_Instance where form_id = @from_id))


UNION

SELECT     dbo.Date_Value.Instance_ID, Questions_1.Description AS Question, convert(varchar , dbo.Date_Value.Date_value) AS Answer , Questions_1.Question_Type as Question_Type ,  Questions_1.Template_Type as Template_Type
FROM         dbo.Date_Value INNER JOIN
                      dbo.Questions AS Questions_1 ON dbo.Date_Value.Question_ID = Questions_1.Question_ID
WHERE     (Questions_1.Question_Type = 6 AND Instance_ID in(Select Instance_id from Form_Instance where form_id = @from_id))


union 
SELECT     dbo.Number_Value.Instance_ID, Questions_2.Description AS Question, convert(varchar ,dbo.Number_Value.Number_Value) AS Answer ,Questions_2.Question_Type as Question_Type , Questions_2.Template_Type as Template_Type
FROM         dbo.Questions AS Questions_2 INNER JOIN
                      dbo.Number_Value ON Questions_2.Question_ID = dbo.Number_Value.Question_ID
WHERE     (Questions_2.Question_Type = 5 and Instance_ID in(Select Instance_id from Form_Instance where form_id = @from_id))

union 

SELECT     dbo.Item_Choice.Form_Instance_ID AS Instance_ID, dbo.Questions.Description AS Question, dbo.List_Items.Item_Text AS Answer,Questions.Question_Type as Question_Type , Questions.Template_Type as Template_Type
FROM         dbo.Questions INNER JOIN
                      dbo.Item_Choice ON dbo.Questions.Question_ID = dbo.Item_Choice.Question_ID INNER JOIN
                      dbo.List_Items ON dbo.Item_Choice.Selected_Item = dbo.List_Items.Item_ID
WHERE     (dbo.Questions.Template_Type = 4 and Item_Choice.Form_Instance_ID in(Select Instance_id from Form_Instance where form_id = @from_id) )


union

SELECT     dbo.Item_Choice.Form_Instance_ID AS Instance_ID, dbo.Questions.Description AS Question, dbo.Department.DepName AS Answer ,Questions.Question_Type as Question_Type , Questions.Template_Type as Template_Type
FROM         dbo.Questions INNER JOIN
                      dbo.Item_Choice ON dbo.Questions.Question_ID = dbo.Item_Choice.Question_ID INNER JOIN
                      dbo.Dep_Choice AS Dep_Choice_1 ON dbo.Item_Choice.Form_Instance_ID = Dep_Choice_1.Form_Instance_ID INNER JOIN
                      dbo.Department ON Dep_Choice_1.Dep_Item = dbo.Department.DepID
WHERE     (dbo.Questions.Template_Type = 3 and Item_Choice.Form_Instance_ID in(Select Instance_id from Form_Instance where form_id = @from_id))

union 

SELECT     dbo.Item_Choice.Form_Instance_ID AS Instance_ID, dbo.Questions.Description AS Question, dbo.Branch.BranchName AS Answer ,Questions.Question_Type as Question_Type, Questions.Template_Type as Template_Type
FROM         dbo.Questions INNER JOIN
                      dbo.Item_Choice ON dbo.Questions.Question_ID = dbo.Item_Choice.Question_ID INNER JOIN
                      dbo.Branch_Choice ON dbo.Item_Choice.Form_Instance_ID = dbo.Branch_Choice.Form_Instance_ID INNER JOIN
                      dbo.Branch ON dbo.Branch_Choice.Branch_Item = dbo.Branch.BID
WHERE     (dbo.Questions.Template_Type = 2and Item_Choice.Form_Instance_ID in(Select Instance_id from Form_Instance where form_id = @from_id))
union 

SELECT     dbo.Item_Choice.Form_Instance_ID AS Instance_ID, dbo.Questions.Description AS Question, dbo.State.LocName AS Answer,Questions.Question_Type as Question_Type, Questions.Template_Type as Template_Type
FROM         dbo.Questions INNER JOIN
                      dbo.Item_Choice ON dbo.Questions.Question_ID = dbo.Item_Choice.Question_ID INNER JOIN
                      dbo.State_Choice ON dbo.Questions.Question_ID = dbo.State_Choice.Question_ID INNER JOIN
                      dbo.State ON dbo.State_Choice.State_Item = dbo.State.locid
WHERE     (dbo.Questions.Template_Type = 1and Item_Choice.Form_Instance_ID in(Select Instance_id from Form_Instance where form_id = @from_id))
END

GO
/****** Object:  StoredProcedure [dbo].[Get_Text]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Text]
	-- Add the parameters for the stored procedure here
	@Instance_ID int , 
	@Question_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     Text_Value, Question_ID, Instance_ID
	FROM         Text_value
	WHERE     (Question_ID = 14) AND (Instance_ID = @Instance_ID) 
END

GO
/****** Object:  StoredProcedure [dbo].[insert_parameter]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insert_parameter]
	@parameter_name nvarchar , 
	@parameter_des nvarchar ,
	@time_sensitive bit , 
	@loc_sentive bit , 
	@sql_query nvarchar
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

set transaction isolation level SERIALIZABLE
begin transaction parameter_tran
	INSERT INTO [Parameter]
           ([Prameter_Name]
           ,[Description]
           ,[Is_Time_Sensitive]
           ,[Is_Loc_Sensitive]
           ,[Sql_Query])
     VALUES
           (@parameter_name , @parameter_des , @time_sensitive , @loc_sentive ,@sql_query)
if @@Error<>0 begin rollback transaction return end 
DECLARE @local int
Set @local = (SELECT IDENT_CURRENT('Parameter')) 
if @@Error<>0 begin rollback transaction return end 

INSERT INTO [Parameter_State] ([Parameter_ID],[State_ID]) VALUES  (1,2)
if @@Error<>0 begin rollback transaction return end 
INSERT INTO [Parameter_Dep] ([Parameter_ID],[Department_ID]) VALUES (1,1)
if @@Error<>0 begin rollback transaction return end 

commit transaction parameter_tran

END

GO
/****** Object:  StoredProcedure [dbo].[SP_PRSNL]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_PRSNL]

AS
BEGIN	
	SET NOCOUNT ON;

	SELECT     *
	FROM         V_OLTP_PRSNL
END


GO
/****** Object:  StoredProcedure [dbo].[SP_PRSNL_ByCodPrsn]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_PRSNL_ByCodPrsn]
@ShomarehPersenely nchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT     *
	FROM         V_OLTP_PRSNL
	Where @ShomarehPersenely is null 
	OR ShomarehPersenely = @ShomarehPersenely  
END



GO
/****** Object:  StoredProcedure [dbo].[SP_PRSNL_BySemat]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PRSNL_BySemat]
@Semat varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT     *
	FROM         V_OLTP_PRSNL
	Where Semat is null 
	OR Semat like N'%'+@Semat+'%'
END

GO
/****** Object:  StoredProcedure [dbo].[SP_PRSNL_ByUser]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_PRSNL_ByUser]
@User_Name nchar(100)
AS
BEGIN
	
	SELECT     *
	FROM         V_OLTP_PRSNL
	Where @User_Name is null 
	OR User_Name like '%'+@User_Name+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PRSNL_GRP]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PRSNL_GRP]
@Group_ID int
AS
BEGIN	
	SET NOCOUNT ON;

	SELECT     *
	FROM         V_OLTP_PRSNL_FG_DB_GRP
	WHERE @Group_ID is null 
	OR Group_ID=@Group_ID

END

GO
/****** Object:  StoredProcedure [dbo].[SP_PRSNL_GRP_ByCodPrsn]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PRSNL_GRP_ByCodPrsn] 
	@ShomarehPersenely nchar(100)
	,@Group_ID int
AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT * FROM V_OLTP_PRSNL_FG_DB_GRP
	WHERE ShomarehPersenely =  @ShomarehPersenely  
	AND Group_ID=@Group_ID


END



GO
/****** Object:  StoredProcedure [dbo].[SP_PRSNL_GRP_ByUser]    Script Date: 2/6/2023 10:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_PRSNL_GRP_ByUser]
@Group_ID int
,@User_Name nchar(100)
AS
BEGIN	
	SET NOCOUNT ON;

	SELECT     *
	FROM         V_OLTP_PRSNL_FG_DB_GRP
	WHERE User_Name like '%'+@User_Name+'%'
	AND (@Group_ID is null 
	OR Group_ID=@Group_ID)

END
  


GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[8] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[56] 2[20] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Form_Question_Instance"
            Begin Extent = 
               Top = 15
               Left = 321
               Bottom = 177
               Right = 561
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Form_Instance"
            Begin Extent = 
               Top = 18
               Left = 37
               Bottom = 195
               Right = 188
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Questions"
            Begin Extent = 
               Top = 215
               Left = 30
               Bottom = 386
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Form_Dep_State"
            Begin Extent = 
               Top = 6
               Left = 599
               Bottom = 99
               Right = 750
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "List_Items"
            Begin Extent = 
               Top = 215
               Left = 282
               Bottom = 305
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "State_Choice"
            Begin Extent = 
               Top = 238
               Left = 554
               Bottom = 331
               Right = 722
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Item_Choice"
            Begin Extent = 
               Top = 7
               Left = 796
               Bottom = 122
               Right = 972
          ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Answers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dep_Choice"
            Begin Extent = 
               Top = 210
               Left = 788
               Bottom = 303
               Right = 957
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Branch_Choice"
            Begin Extent = 
               Top = 114
               Left = 811
               Bottom = 207
               Right = 980
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 20
         Width = 284
         Width = 1650
         Width = 2895
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1830
         Width = 2130
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 2565
         Alias = 1800
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Answers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Answers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4[60] 2) )"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 14
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "View_PersonelInfo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 246
               Right = 327
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_PersonelInfo_AB_User"
            Begin Extent = 
               Top = 6
               Left = 362
               Bottom = 244
               Right = 560
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Orm_Personnel_Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Orm_Personnel_Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ledgers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Accounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Accounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[12] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Organization"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 3450
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Branch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Branch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Branch"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Branch_Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Branch_Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ledgers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Contract_Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Contract_Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "BaseData"
            Begin Extent = 
               Top = 31
               Left = 75
               Bottom = 139
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Field_Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Field_Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[17] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "List_Items"
            Begin Extent = 
               Top = 6
               Left = 294
               Bottom = 114
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Tables"
            Begin Extent = 
               Top = 15
               Left = 530
               Bottom = 123
               Right = 681
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "List"
            Begin Extent = 
               Top = 190
               Left = 71
               Bottom = 283
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Questions"
            Begin Extent = 
               Top = 163
               Left = 452
               Bottom = 271
               Right = 621
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "V_Field_Type"
            Begin Extent = 
               Top = 13
               Left = 27
               Bottom = 121
               Right = 178
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Items'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Items'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Items'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ledgers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Ledger1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Ledger1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ledgers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Ledger2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Ledger2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ledgers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Question_16'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Question_16'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Question_Relation"
            Begin Extent = 
               Top = 11
               Left = 331
               Bottom = 119
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Questions"
            Begin Extent = 
               Top = 33
               Left = 47
               Bottom = 201
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Questions_2"
            Begin Extent = 
               Top = 27
               Left = 613
               Bottom = 135
               Right = 782
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Question_Relation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Question_Relation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Question_Relation"
            Begin Extent = 
               Top = 12
               Left = 20
               Bottom = 194
               Right = 171
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Question_Type"
            Begin Extent = 
               Top = 165
               Left = 606
               Bottom = 243
               Right = 759
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Questions"
            Begin Extent = 
               Top = 149
               Left = 304
               Bottom = 282
               Right = 473
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Questions_1"
            Begin Extent = 
               Top = 13
               Left = 355
               Bottom = 121
               Right = 524
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1440
         Width = 2190
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Questions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Questions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Questions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Forms"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Questions"
            Begin Extent = 
               Top = 6
               Left = 239
               Bottom = 114
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4380
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Form'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Form'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Parameter"
            Begin Extent = 
               Top = 32
               Left = 534
               Bottom = 140
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "State"
            Begin Extent = 
               Top = 161
               Left = 30
               Bottom = 269
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Parameter_Dep"
            Begin Extent = 
               Top = 127
               Left = 799
               Bottom = 205
               Right = 953
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Parameter_State"
            Begin Extent = 
               Top = 123
               Left = 212
               Bottom = 201
               Right = 363
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Department"
            Begin Extent = 
               Top = 112
               Left = 1068
               Bottom = 205
               Right = 1219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1635
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2985
      End
   End
   Begin CriteriaPane = 
      Begin Col' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Parameter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'umnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Parameter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Parameter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Risk_Indicator"
            Begin Extent = 
               Top = 126
               Left = 453
               Bottom = 234
               Right = 613
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Risk_Indicator_Bound"
            Begin Extent = 
               Top = 167
               Left = 690
               Bottom = 275
               Right = 872
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "State_Index"
            Begin Extent = 
               Top = 17
               Left = 234
               Bottom = 95
               Right = 385
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dep_Index"
            Begin Extent = 
               Top = 6
               Left = 645
               Bottom = 84
               Right = 796
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Department"
            Begin Extent = 
               Top = 6
               Left = 834
               Bottom = 99
               Right = 985
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "State"
            Begin Extent = 
               Top = 172
               Left = 43
               Bottom = 280
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Risk_Indicator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2385
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Risk_Indicator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Risk_Indicator'
GO
USE [master]
GO
ALTER DATABASE [FG_DB] SET  READ_WRITE 
GO
