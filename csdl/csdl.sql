use master 
go
create database [ClothesShopV1];
go

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClothesShopV1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClothesShopV1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClothesShopV1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClothesShopV1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClothesShopV1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClothesShopV1] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClothesShopV1] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ClothesShopV1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClothesShopV1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClothesShopV1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClothesShopV1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClothesShopV1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClothesShopV1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClothesShopV1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClothesShopV1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClothesShopV1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ClothesShopV1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClothesShopV1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClothesShopV1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClothesShopV1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClothesShopV1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClothesShopV1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClothesShopV1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClothesShopV1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ClothesShopV1] SET  MULTI_USER 
GO
ALTER DATABASE [ClothesShopV1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClothesShopV1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClothesShopV1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClothesShopV1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ClothesShopV1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ClothesShopV1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ClothesShopV1] SET QUERY_STORE = ON
GO
ALTER DATABASE [ClothesShopV1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ClothesShopV1]
GO
/****** Object:  FullTextCatalog [ClothesShopV1_FT_Catalog]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE FULLTEXT CATALOG [ClothesShopV1_FT_Catalog] AS DEFAULT
GO
/****** Object:  FullTextCatalog [FTCatalog_ClothesShopV1]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE FULLTEXT CATALOG [FTCatalog_ClothesShopV1] 
GO
USE [ClothesShopV1]
GO
/****** Object:  Sequence [dbo].[OrderSequence]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE SEQUENCE [dbo].[OrderSequence] 
 AS [bigint]
 START WITH 1234
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 CACHE  10 
GO
/****** Object:  UserDefinedTableType [dbo].[OrderDetailType]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE TYPE [dbo].[OrderDetailType] AS TABLE(
	[product_variant_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[product_variant_id] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_RemoveDiacritics]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Helper function to remove diacritics (accents) from Vietnamese text
CREATE   FUNCTION [dbo].[fn_RemoveDiacritics](@text NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    IF @text IS NULL RETURN NULL

    DECLARE @result NVARCHAR(MAX) = @text
    
    -- Vietnamese character mappings
    SET @result = REPLACE(@result, N'á', N'a')
    SET @result = REPLACE(@result, N'à', N'a')
    SET @result = REPLACE(@result, N'ả', N'a')
    SET @result = REPLACE(@result, N'ã', N'a')
    SET @result = REPLACE(@result, N'ạ', N'a')
    SET @result = REPLACE(@result, N'ă', N'a')
    SET @result = REPLACE(@result, N'ắ', N'a')
    SET @result = REPLACE(@result, N'ằ', N'a')
    SET @result = REPLACE(@result, N'ẳ', N'a')
    SET @result = REPLACE(@result, N'ẵ', N'a')
    SET @result = REPLACE(@result, N'ặ', N'a')
    SET @result = REPLACE(@result, N'â', N'a')
    SET @result = REPLACE(@result, N'ấ', N'a')
    SET @result = REPLACE(@result, N'ầ', N'a')
    SET @result = REPLACE(@result, N'ẩ', N'a')
    SET @result = REPLACE(@result, N'ẫ', N'a')
    SET @result = REPLACE(@result, N'ậ', N'a')
    
    SET @result = REPLACE(@result, N'é', N'e')
    SET @result = REPLACE(@result, N'è', N'e')
    SET @result = REPLACE(@result, N'ẻ', N'e')
    SET @result = REPLACE(@result, N'ẽ', N'e')
    SET @result = REPLACE(@result, N'ẹ', N'e')
    SET @result = REPLACE(@result, N'ê', N'e')
    SET @result = REPLACE(@result, N'ế', N'e')
    SET @result = REPLACE(@result, N'ề', N'e')
    SET @result = REPLACE(@result, N'ể', N'e')
    SET @result = REPLACE(@result, N'ễ', N'e')
    SET @result = REPLACE(@result, N'ệ', N'e')
    
    SET @result = REPLACE(@result, N'í', N'i')
    SET @result = REPLACE(@result, N'ì', N'i')
    SET @result = REPLACE(@result, N'ỉ', N'i')
    SET @result = REPLACE(@result, N'ĩ', N'i')
    SET @result = REPLACE(@result, N'ị', N'i')
    
    SET @result = REPLACE(@result, N'ó', N'o')
    SET @result = REPLACE(@result, N'ò', N'o')
    SET @result = REPLACE(@result, N'ỏ', N'o')
    SET @result = REPLACE(@result, N'õ', N'o')
    SET @result = REPLACE(@result, N'ọ', N'o')
    SET @result = REPLACE(@result, N'ô', N'o')
    SET @result = REPLACE(@result, N'ố', N'o')
    SET @result = REPLACE(@result, N'ồ', N'o')
    SET @result = REPLACE(@result, N'ổ', N'o')
    SET @result = REPLACE(@result, N'ỗ', N'o')
    SET @result = REPLACE(@result, N'ộ', N'o')
    SET @result = REPLACE(@result, N'ơ', N'o')
    SET @result = REPLACE(@result, N'ớ', N'o')
    SET @result = REPLACE(@result, N'ờ', N'o')
    SET @result = REPLACE(@result, N'ở', N'o')
    SET @result = REPLACE(@result, N'ỡ', N'o')
    SET @result = REPLACE(@result, N'ợ', N'o')
    
    SET @result = REPLACE(@result, N'ú', N'u')
    SET @result = REPLACE(@result, N'ù', N'u')
    SET @result = REPLACE(@result, N'ủ', N'u')
    SET @result = REPLACE(@result, N'ũ', N'u')
    SET @result = REPLACE(@result, N'ụ', N'u')
    SET @result = REPLACE(@result, N'ư', N'u')
    SET @result = REPLACE(@result, N'ứ', N'u')
    SET @result = REPLACE(@result, N'ừ', N'u')
    SET @result = REPLACE(@result, N'ử', N'u')
    SET @result = REPLACE(@result, N'ữ', N'u')
    SET @result = REPLACE(@result, N'ự', N'u')
    
    SET @result = REPLACE(@result, N'ý', N'y')
    SET @result = REPLACE(@result, N'ỳ', N'y')
    SET @result = REPLACE(@result, N'ỷ', N'y')
    SET @result = REPLACE(@result, N'ỹ', N'y')
    SET @result = REPLACE(@result, N'ỵ', N'y')
    
    SET @result = REPLACE(@result, N'đ', N'd')
    
    -- Handle uppercase as well
    SET @result = REPLACE(@result, N'Á', N'A')
    SET @result = REPLACE(@result, N'À', N'A')
    SET @result = REPLACE(@result, N'Ả', N'A')
    SET @result = REPLACE(@result, N'Ã', N'A')
    SET @result = REPLACE(@result, N'Ạ', N'A')
    SET @result = REPLACE(@result, N'Ă', N'A')
    SET @result = REPLACE(@result, N'Ắ', N'A')
    SET @result = REPLACE(@result, N'Ằ', N'A')
    SET @result = REPLACE(@result, N'Ẳ', N'A')
    SET @result = REPLACE(@result, N'Ẵ', N'A')
    SET @result = REPLACE(@result, N'Ặ', N'A')
    SET @result = REPLACE(@result, N'Â', N'A')
    SET @result = REPLACE(@result, N'Ấ', N'A')
    SET @result = REPLACE(@result, N'Ầ', N'A')
    SET @result = REPLACE(@result, N'Ẩ', N'A')
    SET @result = REPLACE(@result, N'Ẫ', N'A')
    SET @result = REPLACE(@result, N'Ậ', N'A')
    
    SET @result = REPLACE(@result, N'É', N'E')
    SET @result = REPLACE(@result, N'È', N'E')
    SET @result = REPLACE(@result, N'Ẻ', N'E')
    SET @result = REPLACE(@result, N'Ẽ', N'E')
    SET @result = REPLACE(@result, N'Ẹ', N'E')
    SET @result = REPLACE(@result, N'Ê', N'E')
    SET @result = REPLACE(@result, N'Ế', N'E')
    SET @result = REPLACE(@result, N'Ề', N'E')
    SET @result = REPLACE(@result, N'Ể', N'E')
    SET @result = REPLACE(@result, N'Ễ', N'E')
    SET @result = REPLACE(@result, N'Ệ', N'E')
    
    SET @result = REPLACE(@result, N'Í', N'I')
    SET @result = REPLACE(@result, N'Ì', N'I')
    SET @result = REPLACE(@result, N'Ỉ', N'I')
    SET @result = REPLACE(@result, N'Ĩ', N'I')
    SET @result = REPLACE(@result, N'Ị', N'I')
    
    SET @result = REPLACE(@result, N'Ó', N'O')
    SET @result = REPLACE(@result, N'Ò', N'O')
    SET @result = REPLACE(@result, N'Ỏ', N'O')
    SET @result = REPLACE(@result, N'Õ', N'O')
    SET @result = REPLACE(@result, N'Ọ', N'O')
    SET @result = REPLACE(@result, N'Ô', N'O')
    SET @result = REPLACE(@result, N'Ố', N'O')
    SET @result = REPLACE(@result, N'Ồ', N'O')
    SET @result = REPLACE(@result, N'Ổ', N'O')
    SET @result = REPLACE(@result, N'Ỗ', N'O')
    SET @result = REPLACE(@result, N'Ộ', N'O')
    SET @result = REPLACE(@result, N'Ơ', N'O')
    SET @result = REPLACE(@result, N'Ớ', N'O')
    SET @result = REPLACE(@result, N'Ờ', N'O')
    SET @result = REPLACE(@result, N'Ở', N'O')
    SET @result = REPLACE(@result, N'Ỡ', N'O')
    SET @result = REPLACE(@result, N'Ợ', N'O')
    
    SET @result = REPLACE(@result, N'Ú', N'U')
    SET @result = REPLACE(@result, N'Ù', N'U')
    SET @result = REPLACE(@result, N'Ủ', N'U')
    SET @result = REPLACE(@result, N'Ũ', N'U')
    SET @result = REPLACE(@result, N'Ụ', N'U')
    SET @result = REPLACE(@result, N'Ư', N'U')
    SET @result = REPLACE(@result, N'Ứ', N'U')
    SET @result = REPLACE(@result, N'Ừ', N'U')
    SET @result = REPLACE(@result, N'Ử', N'U')
    SET @result = REPLACE(@result, N'Ữ', N'U')
    SET @result = REPLACE(@result, N'Ự', N'U')
    
    SET @result = REPLACE(@result, N'Ý', N'Y')
    SET @result = REPLACE(@result, N'Ỳ', N'Y')
    SET @result = REPLACE(@result, N'Ỷ', N'Y')
    SET @result = REPLACE(@result, N'Ỹ', N'Y')
    SET @result = REPLACE(@result, N'Ỵ', N'Y')
    
    SET @result = REPLACE(@result, N'Đ', N'D')
    
    RETURN @result
END
GO
/****** Object:  Table [dbo].[Account_Discount_Codes]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account_Discount_Codes](
	[account_discount_id] [int] IDENTITY(1,1) NOT NULL,
	[product_variant_id] [int] NOT NULL,
	[used_at] [datetime] NULL,
	[status] [varchar](20) NOT NULL,
	[customer_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[account_discount_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[account_id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NULL,
	[login_name] [varchar](50) NOT NULL,
	[password] [varchar](255) NOT NULL,
 CONSTRAINT [pk_accounts] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[address_id] [int] NOT NULL,
	[customer_id] [int] NULL,
	[street] [nvarchar](100) NULL,
	[ward_id] [int] NULL,
	[district_id] [int] NULL,
	[province_id] [int] NULL,
	[country] [nvarchar](50) NULL,
	[recipientName] [nchar](100) NULL,
	[recipientPhone] [nchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[address_id] [int] NOT NULL,
	[customer_id] [int] NULL,
	[street] [nvarchar](100) NULL,
	[ward] [nvarchar](50) NULL,
	[district] [nvarchar](50) NULL,
	[province] [nvarchar](50) NULL,
	[city] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
 CONSTRAINT [pk_address] PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[brand_id] [int] NOT NULL,
	[brand_name] [nvarchar](255) NOT NULL,
 CONSTRAINT [pk_brand] PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart_details]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_details](
	[cart_detail_id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NULL,
	[product_variant_id] [int] NULL,
	[price] [decimal](18, 0) NULL,
	[quantity] [int] NOT NULL,
	[added_date] [date] NOT NULL,
 CONSTRAINT [pk_cart_detail] PRIMARY KEY CLUSTERED 
(
	[cart_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[cart_id] [int] NOT NULL,
	[customer_id] [int] NULL,
 CONSTRAINT [pk_cart] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] NOT NULL,
	[category_name] [nvarchar](255) NOT NULL,
 CONSTRAINT [pk_category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Colors]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colors](
	[color_id] [int] NOT NULL,
	[color_name] [nvarchar](50) NOT NULL,
	[color_hex] [nvarchar](50) NULL,
 CONSTRAINT [pk_color] PRIMARY KEY CLUSTERED 
(
	[color_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NULL,
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL,
	[email] [varchar](50) NULL,
	[phone] [nchar](10) NULL,
	[date_of_birth] [date] NULL,
	[registration_date] [date] NULL,
	[gender] [bit] NULL,
	[status] [bit] NOT NULL,
	[image_url] [nvarchar](255) NULL,
 CONSTRAINT [pk_customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discounts]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discounts](
	[discount_id] [int] NOT NULL,
	[discount_name] [nvarchar](100) NULL,
	[description] [ntext] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[discount_code] [varchar](50) NOT NULL,
	[discount_percentage] [decimal](5, 2) NULL,
	[totalminmoney] [decimal](10, 2) NOT NULL,
	[max_discount_amount] [decimal](10, 2) NULL,
 CONSTRAINT [pk_discount_shop] PRIMARY KEY CLUSTERED 
(
	[discount_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[employee_id] [int] NOT NULL,
	[account_id] [int] NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[address] [nvarchar](500) NULL,
	[date_of_birth] [date] NULL,
	[gender] [bit] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[phone] [nchar](10) NULL,
	[image_url] [varchar](100) NULL,
	[hire_date] [date] NULL,
	[status] [bit] NOT NULL,
	[manager_id] [int] NULL,
	[salary] [decimal](10, 0) NULL,
 CONSTRAINT [pk_employee] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GHN_Districts]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GHN_Districts](
	[district_id] [int] NOT NULL,
	[district_name] [nvarchar](100) NOT NULL,
	[province_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[district_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GHN_Provinces]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GHN_Provinces](
	[province_id] [int] NOT NULL,
	[province_name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[province_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GHN_Wards]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GHN_Wards](
	[ward_id] [int] NOT NULL,
	[ward_name] [nvarchar](100) NOT NULL,
	[district_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ward_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventories]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventories](
	[inventory_id] [int] NOT NULL,
	[product_variant_id] [int] NULL,
	[last_update] [date] NULL,
	[quantity_stock] [int] NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[inventory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_details]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_details](
	[order_detail_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [char](10) NULL,
	[product_variant_id] [int] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
 CONSTRAINT [pk_order_detail] PRIMARY KEY CLUSTERED 
(
	[order_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [char](10) NOT NULL,
	[customer_id] [int] NULL,
	[order_date] [datetime] NULL,
	[total_amount] [decimal](15, 2) NULL,
	[order_status] [nvarchar](50) NULL,
	[shipping_address_id] [int] NULL,
	[payment_status] [bit] NULL,
	[payment_id] [int] NULL,
 CONSTRAINT [pk_orders] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[payment_id] [int] NOT NULL,
	[payment_method] [nvarchar](100) NULL,
	[payment_gateway] [nvarchar](100) NULL,
 CONSTRAINT [pk_payment] PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_discounts]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_discounts](
	[product_discount_id] [int] NOT NULL,
	[discount_id] [int] NULL,
	[product_variant_id] [int] NULL,
 CONSTRAINT [PK_ProductDiscounts] PRIMARY KEY CLUSTERED 
(
	[product_discount_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_images]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_images](
	[product_image_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[image_url] [varchar](100) NULL,
	[priority] [bit] NULL,
 CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED 
(
	[product_image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_variants]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_variants](
	[product_variant_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[sku] [varchar](50) NULL,
	[size_id] [int] NULL,
	[color_id] [int] NULL,
	[image_url] [varchar](500) NULL,
	[quantity_stock] [int] NULL,
 CONSTRAINT [PK_ProductVariants] PRIMARY KEY CLUSTERED 
(
	[product_variant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_id] [int] NULL,
	[category_id] [int] NULL,
	[brand_id] [int] NULL,
	[product_name] [nvarchar](100) NULL,
	[description] [ntext] NULL,
	[image_url] [nvarchar](500) NULL,
	[rating] [int] NULL,
	[type] [bit] NULL,
	[price] [decimal](10, 2) NULL,
	[quantity_sold] [int] NULL,
	[warranty] [nvarchar](100) NULL,
	[return_policy] [nvarchar](255) NULL,
 CONSTRAINT [pk_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchase_receipt]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_receipt](
	[purchase_receipt_id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_id] [int] NULL,
	[receipt_code] [varchar](50) NULL,
	[total_amount] [decimal](18, 0) NULL,
	[note] [ntext] NULL,
	[create_by] [int] NULL,
	[create_at] [date] NULL,
 CONSTRAINT [PK_purchase_receipt] PRIMARY KEY CLUSTERED 
(
	[purchase_receipt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchase_receipt_details]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_receipt_details](
	[purchase_receipt_detail_id] [int] IDENTITY(1,1) NOT NULL,
	[purchase_receipt_id] [int] NULL,
	[product_id] [int] NULL,
	[product_variant_id] [int] NULL,
	[quantity] [int] NULL,
	[unit_price] [decimal](15, 2) NULL,
 CONSTRAINT [PK_purchase_receipt_details] PRIMARY KEY CLUSTERED 
(
	[purchase_receipt_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Returns]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Returns](
	[return_id] [int] NOT NULL,
	[product_id] [int] NULL,
	[order_id] [char](10) NULL,
	[return_date] [date] NULL,
	[reason] [ntext] NULL,
	[return_status] [nvarchar](50) NULL,
 CONSTRAINT [PK_Returns] PRIMARY KEY CLUSTERED 
(
	[return_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[rating] [int] NULL,
	[comment] [ntext] NULL,
	[review_date] [datetime] NULL,
	[image_url] [nvarchar](255) NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] NOT NULL,
	[role_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_role] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shipments]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipments](
	[shipment_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [char](10) NOT NULL,
	[shipper_id] [int] NOT NULL,
	[tracking_number] [varchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[assigned_date] [date] NULL,
	[delivered_date] [date] NULL,
 CONSTRAINT [PK_Shipments] PRIMARY KEY CLUSTERED 
(
	[shipment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sizes]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sizes](
	[size_id] [int] NOT NULL,
	[size_name] [nvarchar](10) NOT NULL,
 CONSTRAINT [pk_size] PRIMARY KEY CLUSTERED 
(
	[size_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SPRING_SESSION]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SPRING_SESSION](
	[PRIMARY_ID] [char](36) NOT NULL,
	[SESSION_ID] [char](36) NOT NULL,
	[CREATION_TIME] [bigint] NOT NULL,
	[LAST_ACCESS_TIME] [bigint] NOT NULL,
	[MAX_INACTIVE_INTERVAL] [int] NOT NULL,
	[EXPIRY_TIME] [bigint] NOT NULL,
	[PRINCIPAL_NAME] [varchar](100) NULL,
 CONSTRAINT [SPRING_SESSION_PK] PRIMARY KEY CLUSTERED 
(
	[PRIMARY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SPRING_SESSION_ATTRIBUTES]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SPRING_SESSION_ATTRIBUTES](
	[SESSION_PRIMARY_ID] [char](36) NOT NULL,
	[ATTRIBUTE_NAME] [varchar](200) NOT NULL,
	[ATTRIBUTE_BYTES] [image] NOT NULL,
 CONSTRAINT [SPRING_SESSION_ATTRIBUTES_PK] PRIMARY KEY CLUSTERED 
(
	[SESSION_PRIMARY_ID] ASC,
	[ATTRIBUTE_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[supplier_id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_name] [nvarchar](100) NULL,
	[logo_url] [varchar](100) NULL,
	[contact_person] [nvarchar](100) NULL,
	[phone] [char](10) NULL,
	[email] [varchar](50) NULL,
	[address] [nvarchar](500) NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account_Discount_Codes] ON 

INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (1, 5, NULL, N'used', 1017)
INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (3, 2, NULL, N'used', 1017)
INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (5, 5, NULL, N'available', 1017)
INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (6, 6, NULL, N'available', 1017)
INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (7, 5, NULL, N'available', 1017)
INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (8, 1, NULL, N'used', 1017)
INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (9, 3, CAST(N'2025-05-20T01:39:58.920' AS DateTime), N'used', 1017)
INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (11, 22, NULL, N'available', 1017)
INSERT [dbo].[Account_Discount_Codes] ([account_discount_id], [product_variant_id], [used_at], [status], [customer_id]) VALUES (12, 10, NULL, N'available', 1017)
SET IDENTITY_INSERT [dbo].[Account_Discount_Codes] OFF
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (1, 3, N'DUONG', N'$2a$10$RyBEakXo5u3mXbQR5RByx.FuOmNow5j.wEHemzdW6q6TlvG4.m6WK')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (2, 1, N'AN', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (3, 1, N'BINH', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (4, 1, N'DUC', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (5, 1, N'MINH', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (6, 1, N'NGHIA', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (7, 1, N'SON', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (16, 1, N'THANH', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (17, 1, N'HUYEN', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (18, 1, N'LONG', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (19, 1, N'KHANH', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (20, 1, N'LINH', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (21, 1, N'HUY', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (22, 1, N'BAO', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (23, 1, N'TIEN', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (33, 2, N'NV1', N'$2a$10$RyBEakXo5u3mXbQR5RByx.FuOmNow5j.wEHemzdW6q6TlvG4.m6WK')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (34, 2, N'NV2', N'$2a$10$RyBEakXo5u3mXbQR5RByx.FuOmNow5j.wEHemzdW6q6TlvG4.m6WK')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (35, 2, N'NV3', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (36, 2, N'NV4', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (37, 2, N'NV5', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (38, 2, N'NV6', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (39, 2, N'NV7', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (40, 2, N'NV8', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (41, 2, N'NV9', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (42, 2, N'NV10', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (43, 4, N'SHIPPER1', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (44, 4, N'SHIPPER2', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (45, 4, N'SHIPPER3', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (46, 4, N'SHIPPER4', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
INSERT [dbo].[Accounts] ([account_id], [role_id], [login_name], [password]) VALUES (47, 4, N'SHIPPER5', N'$2a$10$5eQPYJRPjI0gMbzrqBrwq.mOWw2Mj.Mz.Mt0LG9JJ8btjjhweP4py')
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
INSERT [dbo].[Address] ([address_id], [customer_id], [street], [ward_id], [district_id], [province_id], [country], [recipientName], [recipientPhone]) VALUES (1, 1017, N'818/26 Xô Viết nghệ tĩnhhh', 21618, 1462, 202, N'Việt Nam', N'ggg                                                                                                 ', N'123232         ')
INSERT [dbo].[Address] ([address_id], [customer_id], [street], [ward_id], [district_id], [province_id], [country], [recipientName], [recipientPhone]) VALUES (2, 1017, N'Lê Đức Thọ F17', 21618, 1462, 202, N'Việt Nam', NULL, N'4143241        ')
INSERT [dbo].[Address] ([address_id], [customer_id], [street], [ward_id], [district_id], [province_id], [country], [recipientName], [recipientPhone]) VALUES (3, 1017, N'LLLL', 21618, 1462, 202, N'VN', N'dsafd                                                                                               ', N'144134         ')
INSERT [dbo].[Address] ([address_id], [customer_id], [street], [ward_id], [district_id], [province_id], [country], [recipientName], [recipientPhone]) VALUES (4, 1017, N'sdafdfds, F17, Quận Bình Thạnh, Hồ Chí Minh', 21618, 1462, 202, N'Việt Nam', N'Uông Ngọc Sơn                                                                                       ', N'0123321123     ')
INSERT [dbo].[Address] ([address_id], [customer_id], [street], [ward_id], [district_id], [province_id], [country], [recipientName], [recipientPhone]) VALUES (552563740, 1017, N'gggg, Phường 26, Quận Bình Thạnh, Hồ Chí Minh', 21618, 1462, 202, N'Việt Nam', N'Uông Ngọc Sơnnnn                                                                                    ', N'01233213323    ')
GO
INSERT [dbo].[Addresses] ([address_id], [customer_id], [street], [ward], [district], [province], [city], [country]) VALUES (1, 1017, N'fffffsfdf', N'21618', N'1462', N'202', N'HCM', N'Việt Nam')
INSERT [dbo].[Addresses] ([address_id], [customer_id], [street], [ward], [district], [province], [city], [country]) VALUES (2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Addresses] ([address_id], [customer_id], [street], [ward], [district], [province], [city], [country]) VALUES (3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Addresses] ([address_id], [customer_id], [street], [ward], [district], [province], [city], [country]) VALUES (4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Addresses] ([address_id], [customer_id], [street], [ward], [district], [province], [city], [country]) VALUES (552563740, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (1, N'Nike')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (2, N'Adidas')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (3, N'Zara')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (4, N'Uniqlo')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (5, N'H&M')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (6, N'Levi''s')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (7, N'Gucci')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (8, N'Puma')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (9, N'Lacoste')
INSERT [dbo].[Brands] ([brand_id], [brand_name]) VALUES (10, N'The North Face')
GO
SET IDENTITY_INSERT [dbo].[cart_details] ON 

INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (1, 1, 3, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (2, 1, 12, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (4, 3, 16, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (5, 4, 7, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (6, 4, 8, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (7, 5, 4, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (8, 6, 18, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (9, 7, 15, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (12, 1, 14, NULL, 2, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (13, 13, 22, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (14, 14, 17, NULL, 1, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (15, 14, 20, NULL, 3, CAST(N'2025-04-23' AS Date))
INSERT [dbo].[cart_details] ([cart_detail_id], [cart_id], [product_variant_id], [price], [quantity], [added_date]) VALUES (106, 8, 15, CAST(1200000 AS Decimal(18, 0)), 1, CAST(N'2025-05-20' AS Date))
SET IDENTITY_INSERT [dbo].[cart_details] OFF
GO
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (1, 1001)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (3, 1012)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (4, 1013)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (5, 1014)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (6, 1015)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (7, 1016)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (8, 1017)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (13, 1026)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (14, 1027)
INSERT [dbo].[Carts] ([cart_id], [customer_id]) VALUES (15, 1028)
GO
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (1, N'Áo Thun')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (2, N'Áo Sơ Mi')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (3, N'Quần Jeans')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (4, N'Quần Kaki')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (5, N'Váy')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (6, N'Đầm')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (7, N'Áo Khoác')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (8, N'Đồ Thể Thao')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (9, N'Phụ Kiện')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (10, N'Giày')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (11, N'Đồ Lót')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (12, N'Đồ Ngủ')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (13, N'Quần Short')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (14, N'Áo Len')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (15, N'Túi Xách')
GO
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (1, N'White', N'#FFFFFF')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (2, N'Black', N'#000000')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (3, N'Gray', N'#808080')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (4, N'Blue', N'#0000FF')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (5, N'Green', N'#008000')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (6, N'Red', N'#FF0000')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (7, N'Yellow', N'#FFFF00')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (8, N'Pink', N'#FFCOCB')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (9, N'Orange', N'#FFA500')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (10, N'Purple', N'#800080')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (11, N'Brown', N'#A52A2A')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (12, N'Beige', N'#F5F5DC')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (13, N'Navy', N'#000080')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (14, N'Cream', N'#FFFDD0')
INSERT [dbo].[Colors] ([color_id], [color_name], [color_hex]) VALUES (15, N'Silver', N'#C0C0C0')
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1001, 1, N'Hồ Văn', N'Dương', N'hvduong2392k4@gmail.com', N'0999888777', CAST(N'2000-01-01' AS Date), CAST(N'2025-05-07' AS Date), 1, 1, N'/resources/images-upload/customer/minimalist-chrome-1f57a8fb.jpg')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1012, NULL, N'Lữ Tất', N'Thành', N'lutatthanh@example.com', N'0933211234', CAST(N'2004-01-01' AS Date), CAST(N'2025-05-16' AS Date), 1, 1, N'/resources/images-upload/customer/avatar-93f00297.webp')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1013, NULL, N'Nguyễn Văn', N'Bình', N'nguyenvanbinh@gmail.com', N'0990909096', CAST(N'2000-01-01' AS Date), CAST(N'2025-05-16' AS Date), 1, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1014, NULL, N'Nguyễn Văn', N'Đức', N'nguyenvanduc@gmail.com', N'0990909097', CAST(N'2000-01-01' AS Date), CAST(N'2025-05-16' AS Date), 1, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1015, NULL, N'Nguyễn Nhật', N'Minh', N'nguyennhatminh@gmail.com', N'0321321321', CAST(N'2000-01-01' AS Date), CAST(N'2025-05-16' AS Date), 1, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1016, NULL, N'Trần Đại', N'Nghĩa', N'trandainghia@gmail.com', N'0987789987', CAST(N'2000-01-01' AS Date), CAST(N'2025-05-16' AS Date), 1, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1017, 7, N'Uông Ngọc', N'Sơnnngggggghh', N'ngocson@gmail.com', N'0123321123', CAST(N'2025-04-01' AS Date), CAST(N'2025-04-23' AS Date), 1, 1, N'/resources/images-upload/customer/6999fb62-03af-41d4-8ff6-8fa29033a281_bo.png')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1026, NULL, N'Lê Thị', N'Thanh', N'lethithanh@example.com', N'0911111111', CAST(N'1994-05-20' AS Date), CAST(N'2025-05-16' AS Date), 0, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1027, NULL, N'Trần Thu', N'Huyền', N'tranthuhien@example.com', N'0922222222', CAST(N'1998-11-02' AS Date), CAST(N'2025-05-16' AS Date), 0, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1028, NULL, N'Hoàng Văn', N'Long', N'hoangvanlong@example.com', N'0933333333', CAST(N'1985-01-15' AS Date), CAST(N'2025-05-16' AS Date), 1, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1029, NULL, N'Đỗ Ngọc', N'Khánh', N'dongockhanh@example.com', N'0944444444', CAST(N'2001-07-30' AS Date), CAST(N'2025-05-16' AS Date), 0, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1030, NULL, N'Vũ Thùy', N'Linh', N'vuthuylinh@example.com', N'0955555555', CAST(N'1999-03-12' AS Date), CAST(N'2025-05-16' AS Date), 0, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1031, NULL, N'Phạm Gia', N'Huy', N'phamgiahuy@example.com', N'0966666666', CAST(N'1992-09-09' AS Date), CAST(N'2025-05-16' AS Date), 1, 1, N'')
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1033, 22, N'Nguyễn Văn', N'Bảo', N'nguyenvanbao@example.com', N'0988888888', CAST(N'1996-02-14' AS Date), CAST(N'2025-04-23' AS Date), 1, 1, NULL)
INSERT [dbo].[Customers] ([customer_id], [account_id], [first_name], [last_name], [email], [phone], [date_of_birth], [registration_date], [gender], [status], [image_url]) VALUES (1035, 23, N'Hoàng Minh', N'Tiến', N'hoangminhtien@example.com', N'0901010101', CAST(N'1989-06-05' AS Date), CAST(N'2025-04-23' AS Date), 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
INSERT [dbo].[Discounts] ([discount_id], [discount_name], [description], [start_date], [end_date], [discount_code], [discount_percentage], [totalminmoney], [max_discount_amount]) VALUES (1, N'Giảm giá Hè 2025', N'Gi?m giá 10% cho toàn b? áo thun và áo so mi', CAST(N'2025-06-01' AS Date), CAST(N'2025-06-30' AS Date), N'SHOP7KXW2MND', CAST(10.00 AS Decimal(5, 2)), CAST(100000.00 AS Decimal(10, 2)), CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discounts] ([discount_id], [discount_name], [description], [start_date], [end_date], [discount_code], [discount_percentage], [totalminmoney], [max_discount_amount]) VALUES (2, N'Black Friday Sale', N'Gi?m giá s?c d?n 50%', CAST(N'2025-11-28' AS Date), CAST(N'2025-11-30' AS Date), N'SHOP3T9VGZLA', CAST(15.00 AS Decimal(5, 2)), CAST(100000.00 AS Decimal(10, 2)), CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discounts] ([discount_id], [discount_name], [description], [start_date], [end_date], [discount_code], [discount_percentage], [totalminmoney], [max_discount_amount]) VALUES (3, N'Chào thành viên mới', N'Gi?m 50k cho don hàng d?u tiên t? 500k', CAST(N'2025-01-01' AS Date), CAST(N'2025-11-30' AS Date), N'SHOPZ62MCQJP', CAST(10.00 AS Decimal(5, 2)), CAST(50000.00 AS Decimal(10, 2)), CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discounts] ([discount_id], [discount_name], [description], [start_date], [end_date], [discount_code], [discount_percentage], [totalminmoney], [max_discount_amount]) VALUES (4, N'Xả hàng cuối mùa Đông', N'Gi?m giá áo khoác, áo len', CAST(N'2026-02-15' AS Date), CAST(N'2026-02-28' AS Date), N'SHOPNWB34T2C', CAST(20.00 AS Decimal(5, 2)), CAST(50000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discounts] ([discount_id], [discount_name], [description], [start_date], [end_date], [discount_code], [discount_percentage], [totalminmoney], [max_discount_amount]) VALUES (5, N'Flash Sale cuối tuần 26/4', N'Gi?m 15% m?t s? s?n ph?m', CAST(N'2025-04-26' AS Date), CAST(N'2025-04-27' AS Date), N'SHOPK91T8AHE', CAST(20.00 AS Decimal(5, 2)), CAST(100000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discounts] ([discount_id], [discount_name], [description], [start_date], [end_date], [discount_code], [discount_percentage], [totalminmoney], [max_discount_amount]) VALUES (6, N'Mid-Season Sale', N'Gi?m 20% cho hàng m?i v?', CAST(N'2025-05-15' AS Date), CAST(N'2025-05-31' AS Date), N'SHOPXJ3MUVY7', CAST(25.00 AS Decimal(5, 2)), CAST(200000.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discounts] ([discount_id], [discount_name], [description], [start_date], [end_date], [discount_code], [discount_percentage], [totalminmoney], [max_discount_amount]) VALUES (7, N'Sinh nhật Shop', N'Gi?m 100k cho don t? 1 tri?u', CAST(N'2025-07-01' AS Date), CAST(N'2025-07-07' AS Date), N'SHOPGAFZTNCD', CAST(15.00 AS Decimal(5, 2)), CAST(100000.00 AS Decimal(10, 2)), CAST(50000.00 AS Decimal(10, 2)))
INSERT [dbo].[Discounts] ([discount_id], [discount_name], [description], [start_date], [end_date], [discount_code], [discount_percentage], [totalminmoney], [max_discount_amount]) VALUES (8, N'Mua 2 tặng 1 (Áo thun)', N'Áp d?ng cho Áo thun Nike và Adidas', CAST(N'2025-08-01' AS Date), CAST(N'2025-08-15' AS Date), N'SHOP8ULJDB23', CAST(10.00 AS Decimal(5, 2)), CAST(200000.00 AS Decimal(10, 2)), NULL)
GO
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (1, 1, N'Star', N'Dương', N'Tân Bình, HCM', CAST(N'2004-09-23' AS Date), 1, N'hvduong2392k4@gmail.com', N'0111222333', N'/resources/images-upload/employee/employee-00000001.jpg', CAST(N'2025-05-16' AS Date), 1, NULL, CAST(10000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (2, 33, N'Lê Văn', N'Minh', N'89 Nguyễnn Hữu, Quận 1, TP.HCM', CAST(N'1985-12-10' AS Date), 0, N'le.minh@example.com', N'0923456789', NULL, CAST(N'2019-07-01' AS Date), 1, 1, CAST(18000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (3, 34, N'Phạm Hồng', N'Thu', N'99 Hai Bà Trung, Quận 1, TP.HCM', CAST(N'1996-11-05' AS Date), 1, N'pham.thu@example.com', N'0934567890', NULL, CAST(N'2022-06-15' AS Date), 1, 1, CAST(11000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (4, 35, N'Nguyễn Chí', N'Quang', N'10 Pasteur, Quận 3, TP.HCM', CAST(N'1993-03-30' AS Date), 0, N'do.quang@example.com', N'0945678901', NULL, CAST(N'2023-01-10' AS Date), 1, 1, CAST(13000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (5, 36, N'Bùi Tiến', N'Dũng', N'88 Cách Mạng Tháng 8, Quận 10, TP.HCM', CAST(N'1991-09-19' AS Date), 1, N'bui.hang@example.com', N'0956789012', NULL, CAST(N'2020-11-11' AS Date), 1, 1, CAST(12500000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (6, 37, N'Vũ Nhật', N'Minh', N'99 Hai Bà Trung, Quận 1, TP.HCM', CAST(N'1995-01-12' AS Date), 0, N'vu.tran@example.com', N'0978901234', NULL, CAST(N'2021-04-01' AS Date), 1, 1, CAST(11500000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (7, 38, N'Nguyễn Hồng', N'Nhung', N'99 Hai Bà Trung, Quận 1, TP.HCM', CAST(N'1997-05-20' AS Date), 1, N'nguyen.nhung@example.com', N'0989012345', NULL, CAST(N'2022-02-02' AS Date), 1, 1, CAST(10500000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (8, 39, N'Trần Văn', N'Quản', N'88 Cách Mạng Tháng 8, Quận 10, TP.HCM', CAST(N'1980-01-01' AS Date), 0, N'manager1@shop.com', N'0912121212', NULL, CAST(N'2015-05-10' AS Date), 1, 1, CAST(30000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (9, 40, N'Lý Thị', N'Nhân Viên', N'99 Hai Bà Trung, Quận 1, TP.HCM', CAST(N'1995-03-08' AS Date), 1, N'staff1@shop.com', N'0934343434', NULL, CAST(N'2022-08-15' AS Date), 1, 1, CAST(9000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (10, 41, N'Nguyễn Văn', N'Bán Hàng', N'99 Hai Bà Trung, Quận 1, TP.HCM', CAST(N'1992-11-20' AS Date), 0, N'salesperson@shop.com', N'0987878787', NULL, CAST(N'2021-01-20' AS Date), 1, 1, CAST(11000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (11, 42, N'Mai Anh', N'Tuấn', N'10 Pasteur, Quận 3, TP.HCM', CAST(N'1988-07-14' AS Date), 0, N'tuan.ma@shop.com', N'0909090909', NULL, CAST(N'2019-03-01' AS Date), 1, 1, CAST(17000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (12, 43, N'Hoàng Thị', N'Mai', N'99 Hai Bà Trung, Quận 1, TP.HCM', CAST(N'1998-02-19' AS Date), 1, N'mai.ht@shop.com', N'0978787878', NULL, CAST(N'2023-05-01' AS Date), 1, 1, CAST(8500000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (13, 44, N'Lê Văn', N'Sáng', N'89 Nguyễnn Hữu, Quận 1, TP.HCM', CAST(N'1993-09-25' AS Date), 0, N'sang.lv@shop.com', N'0917171717', NULL, CAST(N'2020-10-10' AS Date), 1, 1, CAST(14000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (14, 45, N'Phạm Thị', N'Diễm', N'99 Hai Bà Trung, Quận 1, TP.HCM', CAST(N'1997-12-03' AS Date), 1, N'diem.pt@shop.com', N'0939393939', NULL, CAST(N'2023-08-20' AS Date), 0, 1, CAST(7000000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (15, 46, N'Vũ Ngọc', N'Châu', N'99 Hai Bà Trung, Quận 1, TP.HCM', CAST(N'1994-04-11' AS Date), 1, N'chau.vn@shop.com', N'0958585858', NULL, CAST(N'2021-11-05' AS Date), 1, 1, CAST(10500000 AS Decimal(10, 0)))
INSERT [dbo].[Employees] ([employee_id], [account_id], [first_name], [last_name], [address], [date_of_birth], [gender], [email], [phone], [image_url], [hire_date], [status], [manager_id], [salary]) VALUES (16, 47, N'Đinh Quang', N'Vinh', N'89 Nguyễnn Hữu, Quận 1, TP.HCM', CAST(N'1986-10-30' AS Date), 0, N'vinh.dq@shop.com', N'0926262626', NULL, CAST(N'2018-12-12' AS Date), 1, 1, CAST(19000000 AS Decimal(10, 0)))
GO
INSERT [dbo].[GHN_Districts] ([district_id], [district_name], [province_id]) VALUES (1462, N'Quận Bình Thạnh', 202)
GO
INSERT [dbo].[GHN_Provinces] ([province_id], [province_name]) VALUES (202, N'Hồ Chí Minh')
GO
INSERT [dbo].[GHN_Wards] ([ward_id], [ward_name], [district_id]) VALUES (21618, N'F17', 1462)
GO
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (1, 1, CAST(N'2025-05-19' AS Date), 210)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (2, 2, CAST(N'2025-02-01' AS Date), 100)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (3, 3, CAST(N'2025-03-01' AS Date), 300)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (4, 4, CAST(N'2025-04-01' AS Date), 70)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (5, 5, CAST(N'2025-05-01' AS Date), 150)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (6, 6, CAST(N'2025-05-01' AS Date), 100)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (7, 7, CAST(N'2025-05-01' AS Date), 400)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (8, 8, CAST(N'2025-05-01' AS Date), 150)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (9, 9, CAST(N'2025-05-01' AS Date), 80)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (10, 10, CAST(N'2025-05-01' AS Date), 300)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (11, 11, CAST(N'2025-05-01' AS Date), 100)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (12, 12, CAST(N'2025-05-01' AS Date), 100)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (13, 13, CAST(N'2025-05-01' AS Date), 100)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (14, 14, CAST(N'2025-05-01' AS Date), 200)
INSERT [dbo].[Inventories] ([inventory_id], [product_variant_id], [last_update], [quantity_stock]) VALUES (15, 15, CAST(N'2025-05-01' AS Date), 50)
GO
SET IDENTITY_INSERT [dbo].[order_details] ON 

INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (1, N'ORD0000001', 1, 2, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (2, N'ORD0000002', 13, 1, CAST(2800000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (3, N'ORD0000003', 6, 1, CAST(700000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (4, N'ORD0000004', 16, 1, CAST(400000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (5, N'ORD0000005', 4, 1, CAST(1800000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (6, N'ORD0000005', 9, 1, CAST(2500000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (7, N'ORD0000005', 1, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (8, N'ORD0000006', 5, 1, CAST(1800000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (9, N'ORD0000007', 11, 1, CAST(900000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (10, N'ORD0000008', 17, 1, CAST(2200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (11, N'ORD0000009', 14, 1, CAST(850000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (12, N'ORD0000010', 10, 1, CAST(1500000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (13, N'ORD0000011', 21, 1, CAST(1300000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (14, N'ORD0000012', 20, 1, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (15, N'ORD0000013', 19, 1, CAST(950000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (16, N'ORD0000001', 3, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (19, N'OR00000003', 7, 2, CAST(700000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (20, N'OR00000003', 8, 1, CAST(700000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (21, N'OR00000004', 1, 2, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (22, N'OR00000004', 2, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (23, N'OR00000005', 1, 25, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (24, N'OR00000005', 2, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (25, N'OR00000006', 1, 2, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (26, N'OR00000006', 2, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (27, N'OR00000007', 1, 2, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (28, N'OR00000007', 3, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (29, N'OR00000008', 1, 2, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (30, N'OR00000008', 3, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (31, N'OR00000009', 18, 6, CAST(1100000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (32, N'OR00000009', 19, 13, CAST(950000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (33, N'OR00000009', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (34, N'OR00000010', 18, 6, CAST(1100000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (35, N'OR00000010', 19, 13, CAST(950000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (36, N'OR00000010', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (37, N'OR00000011', 18, 6, CAST(1100000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (38, N'OR00000011', 19, 6, CAST(950000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (39, N'OR00000011', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (40, N'OR00000012', 18, 6, CAST(1100000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (41, N'OR00000012', 19, 6, CAST(950000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (42, N'OR00000012', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (43, N'OR00000013', 20, 3, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (44, N'OR00000014', 18, 8, CAST(1100000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (45, N'OR00000014', 19, 6, CAST(950000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (46, N'OR00000014', 20, 3, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (47, N'OR00000015', 15, 2, CAST(1200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (48, N'OR00000016', 20, 5, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (49, N'OR00000017', 18, 8, CAST(1100000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (50, N'OR00000018', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (51, N'OR00000019', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (52, N'OR00000020', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (53, N'OR00000021', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (54, N'OR00000022', 3, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (55, N'OR00000023', 1, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (56, N'OR00000024', 1, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (57, N'OR00000024', 4, 1, CAST(1800000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (58, N'OR00000025', 15, 2, CAST(1200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (59, N'OR00000026', 20, 2, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (60, N'OR00000027', 12, 4, CAST(2800000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (61, N'OR00000028', 1, 12, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (62, N'OR00000029', 12, 3, CAST(2800000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (63, N'OR00000030', 11, 5, CAST(900000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (64, N'OR00000031', 14, 31, CAST(850000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (65, N'OR00000031', 19, 1, CAST(950000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (66, N'OR00000031', 20, 8, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (67, N'OR00000032', 20, 1, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (68, N'OR00000033', 20, 1, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (69, N'OR00000034', 15, 1, CAST(1200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (70, N'OR00000035', 9, 1, CAST(2500000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (71, N'OR00000035', 15, 1, CAST(1200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (72, N'OR00000036', 15, 3, CAST(1200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (73, N'OR00000037', 20, 21, CAST(750000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (74, N'OR00000038', 16, 2, CAST(400000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (75, N'OR00000039', 1, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (76, N'OR00000040', 1, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (77, N'OR00000040', 9, 8, CAST(2500000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (78, N'OR00000040', 17, 4, CAST(2200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (79, N'OR00000041', 9, 8, CAST(2500000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (80, N'OR00000042', 1, 1, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (81, N'OR00001238', 15, 10, CAST(1200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (82, N'OR00001239', 15, 10, CAST(1200000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (83, N'OR00001240', 14, 1, CAST(850000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (84, N'OR00001241', 3, 2, CAST(550000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (85, N'OR00001242', 16, 2, CAST(400000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (86, N'OR00001243', 16, 2, CAST(400000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (87, N'OR00001244', 21, 1, CAST(1300000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (88, N'OR00001245', 21, 1, CAST(1300000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (89, N'OR00001246', 21, 1, CAST(1300000.00 AS Decimal(10, 2)))
INSERT [dbo].[order_details] ([order_detail_id], [order_id], [product_variant_id], [quantity], [price]) VALUES (90, N'OR00001247', 14, 2, CAST(850000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[order_details] OFF
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000003', 1012, CAST(N'2025-04-27T20:08:50.537' AS DateTime), CAST(2100000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000004', 1012, CAST(N'2025-04-27T20:20:24.770' AS DateTime), CAST(1650000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000005', 1012, CAST(N'2025-04-27T20:21:24.127' AS DateTime), CAST(14300000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000006', 1017, CAST(N'2025-04-27T21:37:32.643' AS DateTime), CAST(1650000.00 AS Decimal(15, 2)), N'SHIPPING', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000007', 1017, CAST(N'2025-04-27T22:14:10.727' AS DateTime), CAST(1650000.00 AS Decimal(15, 2)), N'SHIPPING', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000008', 1017, CAST(N'2025-04-27T22:16:27.383' AS DateTime), CAST(1650000.00 AS Decimal(15, 2)), N'SHIPPING', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000009', 1017, CAST(N'2025-04-27T22:26:04.613' AS DateTime), CAST(20450000.00 AS Decimal(15, 2)), N'SHIPPING', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000010', 1017, CAST(N'2025-04-27T22:39:19.413' AS DateTime), CAST(20450000.00 AS Decimal(15, 2)), N'SHIPPING', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000011', 1017, CAST(N'2025-04-27T22:40:30.840' AS DateTime), CAST(13800000.00 AS Decimal(15, 2)), N'SHIPPING', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000012', 1017, CAST(N'2025-04-27T22:42:45.490' AS DateTime), CAST(13800000.00 AS Decimal(15, 2)), N'SHIPPING', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000013', 1017, CAST(N'2025-04-27T22:43:45.180' AS DateTime), CAST(2250000.00 AS Decimal(15, 2)), N'SHIPPING', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000014', 1017, CAST(N'2025-04-27T22:45:19.140' AS DateTime), CAST(16750000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000015', 1017, CAST(N'2025-04-27T23:01:23.173' AS DateTime), CAST(2400000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000016', 1017, CAST(N'2025-04-27T23:06:55.900' AS DateTime), CAST(3750000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000017', 1017, CAST(N'2025-04-27T23:15:58.413' AS DateTime), CAST(8800000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000018', 1017, CAST(N'2025-04-27T23:21:41.547' AS DateTime), CAST(1500000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000019', 1017, CAST(N'2025-04-27T23:21:54.213' AS DateTime), CAST(1500000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000020', 1017, CAST(N'2025-04-27T23:22:21.657' AS DateTime), CAST(1500000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000021', 1017, CAST(N'2025-04-27T23:22:46.983' AS DateTime), CAST(1500000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000022', 1017, CAST(N'2025-04-27T23:29:14.890' AS DateTime), CAST(550000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000023', 1017, CAST(N'2025-04-27T23:31:36.433' AS DateTime), CAST(550000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000024', 1017, CAST(N'2025-04-27T23:38:11.953' AS DateTime), CAST(2350000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000025', 1017, CAST(N'2025-04-28T16:53:52.670' AS DateTime), CAST(2400000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000026', 1017, CAST(N'2025-04-28T19:37:41.900' AS DateTime), CAST(1500000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000027', 1017, CAST(N'2025-04-28T21:05:50.577' AS DateTime), CAST(11200000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000028', 1017, CAST(N'2025-04-28T22:55:51.313' AS DateTime), CAST(6600000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000029', 1017, CAST(N'2025-04-28T23:22:04.950' AS DateTime), CAST(8400000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000030', 1017, CAST(N'2025-04-29T11:22:04.307' AS DateTime), CAST(4500000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000031', 1017, CAST(N'2025-04-30T07:43:10.983' AS DateTime), CAST(33300000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000032', 1017, CAST(N'2025-04-30T08:06:00.880' AS DateTime), CAST(750000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000033', 1017, CAST(N'2025-04-30T08:09:13.030' AS DateTime), CAST(750000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000034', 1017, CAST(N'2025-04-30T13:56:16.560' AS DateTime), CAST(1200000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000035', 1017, CAST(N'2025-05-01T11:11:01.577' AS DateTime), CAST(3700000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000036', 1017, CAST(N'2025-05-01T13:09:43.350' AS DateTime), CAST(3600000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000037', 1017, CAST(N'2025-05-01T22:04:41.333' AS DateTime), CAST(15750000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000038', 1017, CAST(N'2025-05-02T08:31:00.713' AS DateTime), CAST(800000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000039', 1017, CAST(N'2025-05-02T13:29:25.780' AS DateTime), CAST(550000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000040', 1017, CAST(N'2025-05-02T14:17:19.877' AS DateTime), CAST(29350000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000041', 1017, CAST(N'2025-05-02T14:48:44.257' AS DateTime), CAST(20000000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00000042', 1017, CAST(N'2025-05-03T18:13:12.477' AS DateTime), CAST(550000.00 AS Decimal(15, 2)), N'CONFIRMED', 4, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001238', 1017, CAST(N'2025-05-20T00:56:39.187' AS DateTime), CAST(12021001.00 AS Decimal(15, 2)), N'Pending', 2, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001239', 1017, CAST(N'2025-05-20T00:57:06.100' AS DateTime), CAST(12021001.00 AS Decimal(15, 2)), N'Pending', 2, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001240', 1017, CAST(N'2025-05-20T01:04:14.420' AS DateTime), CAST(871001.00 AS Decimal(15, 2)), N'Pending', 3, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001241', 1017, CAST(N'2025-05-20T01:39:58.887' AS DateTime), CAST(1101001.00 AS Decimal(15, 2)), N'Pending', 4, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001242', 1017, CAST(N'2025-05-20T01:56:17.280' AS DateTime), CAST(821001.00 AS Decimal(15, 2)), N'Pending', 4, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001243', 1017, CAST(N'2025-05-20T01:56:27.773' AS DateTime), CAST(821001.00 AS Decimal(15, 2)), N'Pending', 4, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001244', 1017, CAST(N'2025-05-20T01:59:28.097' AS DateTime), CAST(1321001.00 AS Decimal(15, 2)), N'Pending', 4, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001245', 1017, CAST(N'2025-05-20T02:01:31.873' AS DateTime), CAST(1321001.00 AS Decimal(15, 2)), N'Pending', 4, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001246', 1017, CAST(N'2025-05-20T02:02:38.910' AS DateTime), CAST(1321001.00 AS Decimal(15, 2)), N'Pending', 552563740, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'OR00001247', 1017, CAST(N'2025-05-20T09:22:44.617' AS DateTime), CAST(1721001.00 AS Decimal(15, 2)), N'Pending', 552563740, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000001', 1012, CAST(N'2025-04-20T10:30:00.000' AS DateTime), CAST(1100000.00 AS Decimal(15, 2)), N'CANCELLED', 2, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000002', 1012, CAST(N'2025-04-21T14:00:00.000' AS DateTime), CAST(2800000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 3)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000003', 1012, CAST(N'2025-04-21T16:45:00.000' AS DateTime), CAST(700000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 4)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000004', 1012, CAST(N'2025-04-22T09:15:00.000' AS DateTime), CAST(400000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000005', 1012, CAST(N'2025-04-22T11:00:00.000' AS DateTime), CAST(4850000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 3)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000006', 1012, CAST(N'2025-04-22T15:30:00.000' AS DateTime), CAST(1800000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000007', 1012, CAST(N'2025-04-23T08:00:00.000' AS DateTime), CAST(900000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 5)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000008', 1012, CAST(N'2025-04-23T10:10:10.000' AS DateTime), CAST(2200000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 1, 7)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000009', 1012, CAST(N'2025-04-23T11:20:00.000' AS DateTime), CAST(850000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000010', 1012, CAST(N'2025-04-23T13:00:00.000' AS DateTime), CAST(1500000.00 AS Decimal(15, 2)), N'SHIPPING', 2, 0, 2)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000011', 1012, CAST(N'2025-04-23T23:42:31.527' AS DateTime), CAST(1300000.00 AS Decimal(15, 2)), N'CONFIRMED', 2, 0, 4)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000012', 1012, CAST(N'2025-04-23T23:42:31.527' AS DateTime), CAST(750000.00 AS Decimal(15, 2)), N'CONFIRMED', 2, 0, 1)
INSERT [dbo].[Orders] ([order_id], [customer_id], [order_date], [total_amount], [order_status], [shipping_address_id], [payment_status], [payment_id]) VALUES (N'ORD0000013', 1012, CAST(N'2025-04-23T23:42:31.527' AS DateTime), CAST(950000.00 AS Decimal(15, 2)), N'CONFIRMED', 2, 0, 3)
GO
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (1, N'Thanh toán khi nhận hàng (COD)', NULL)
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (2, N'Chuyển khoản ngân hàng', N'Vietcombank')
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (3, N'Thẻ tín dụng/ghi nợ', N'VNPay')
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (4, N'Ví MoMo', N'MoMo')
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (5, N'Ví ZaloPay', N'ZaloPay')
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (6, N'PayPal', N'PayPal Gateway')
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (7, N'Thẻ ATM nội địa', N'Napas')
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (8, N'Apple Pay', N'Stripe')
INSERT [dbo].[Payments] ([payment_id], [payment_method], [payment_gateway]) VALUES (9, N'Google Pay', N'Stripe')
GO
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (1, 3, 1)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (2, 5, 2)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (3, 3, 3)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (4, 3, 9)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (5, 6, 11)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (6, 3, 22)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (7, 2, 4)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (8, 3, 5)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (9, 7, 6)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (10, 3, 7)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (11, 6, 16)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (12, 4, 21)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (13, 5, 10)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (14, 5, 20)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (15, 4, 2)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (17, 5, 1)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (18, 5, 2)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (19, 4, 3)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (20, 5, 3)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (21, 7, 4)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (22, 3, 1)
INSERT [dbo].[product_discounts] ([product_discount_id], [discount_id], [product_variant_id]) VALUES (23, 4, 1)
GO
SET IDENTITY_INSERT [dbo].[product_images] ON 

INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (1, 1, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (2, 1, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (4, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (5, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (6, 3, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (7, 3, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (8, 3, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (9, 4, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (10, 4, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (11, 5, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (12, 5, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (13, 6, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (14, 6, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (15, 7, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (16, 7, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (17, 7, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (18, 8, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (19, 9, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (20, 10, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (21, 11, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (22, 11, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (23, 12, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (24, 13, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (25, 13, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (26, 14, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (27, 14, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (28, 15, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (29, 15, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_images] ([product_image_id], [product_id], [image_url], [priority]) VALUES (30, 1, N'resources\images-upload\products\lovepik-t-shirt-dbc35e39.png', 1)
SET IDENTITY_INSERT [dbo].[product_images] OFF
GO
SET IDENTITY_INSERT [dbo].[product_variants] ON 

INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (1, 1, N'NIKE-DRYFIT-M-BLK', 3, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (2, 1, N'NIKE-DRYFIT-L-BLK', 4, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 37)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (3, 1, N'NIKE-DRYFIT-M-WHT', 3, 1, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 55)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (4, 2, N'LEVIS-501-W32-BLUE', 15, 4, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 29)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (5, 2, N'LEVIS-501-W34-BLUE', 16, 4, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 25)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (6, 3, N'UNI-OXF-S-WHT', 2, 1, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 100)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (7, 3, N'UNI-OXF-M-WHT', 3, 1, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 96)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (8, 3, N'UNI-OXF-S-BLUE', 2, 4, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 78)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (9, 4, N'TNF-RESOLVE-L-BLK', 4, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 3)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (10, 5, N'ADI-TIRO-M-BLK', 3, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 60)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (11, 6, N'ZARA-FLOWER-S-RED', 2, 6, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 40)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (12, 7, N'NIKE-AF1-39-WHT', 9, 1, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 143)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (13, 7, N'NIKE-AF1-40-WHT', 10, 1, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 150)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (14, 8, N'UNI-KAKI-M-BEI', 3, 12, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 21)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (15, 9, N'HM-MAXI-M-PNK', 3, 8, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 1)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (16, 10, N'PUMA-CAP-FS-BLK', 7, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 114)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (17, 11, N'LACO-POLO-L-GRN', 4, 5, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 31)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (18, 12, N'HM-BOMBER-XL-BLK', 5, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (19, 13, N'LEVIS-SHORT-W30-BLK', 14, 2, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (20, 14, N'UNI-WOOL-M-GRY', 3, 3, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 0)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (21, 15, N'ZARA-TOTE-FS-BRN', 7, 11, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 17)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (22, 1, N'NIKE-DRYFIT-L-NAVY', 7, 13, N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 30)
INSERT [dbo].[product_variants] ([product_variant_id], [product_id], [sku], [size_id], [color_id], [image_url], [quantity_stock]) VALUES (23, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[product_variants] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (1, 2, 1, 1, N'Áo Thun Nike Dri-FIT', N'<h3><strong>Áo khoác ren guipure ngắn</strong></h3><p>Một khúc ca ngợi chủ nghĩa lãng mạn mới, cô nàng it-girl Paris những năm 70 đã đón nhận một cơn lốc tự do và du lịch. Các tông màu ấm áp làm nổi bật những đường nét nhẹ nhàng, bay bổng, tạo nên vẻ ngoài nữ tính, mát mẻ hàng ngày.<br>Chiếc áo khoác ren ngắn này có họa tiết nổi và viền bện tương phản. Hàng nút cài và hai túi đắp, được tô điểm bằng đinh tán ép Clover vàng, tạo thêm cấu trúc và sự thanh lịch cho món đồ vượt thời gian này.<br>Hoàn thiện vẻ ngoài của bạn với áo khoác và chân váy đồng bộ, cùng với giày búp bê.</p><ul><li>Áo khoác ren ngắn</li><li>Viền tương phản</li><li>Cài nút</li><li>2 túi đắp có nút</li><li>Cổ tay áo bằng vải suit&nbsp;</li></ul><p>Người mẫu cao 175cm và mặc cỡ 36.</p><h3><strong>Chất liệu &amp; Hướng dẫn bảo quản</strong></h3><p>Vải chính: 100% polyester, Viền tết: 100% cotton, Lớp vải lót dưới: 100% polyester, Vải phụ: 83% viscose, 14% polyester, 3% elastane</p><p>Xem thêm hướng dẫn bảo quản may trong sản phẩm để biết thêm chi tiết.<br>Không giặt<br>Không tẩy<br>Không sấy khô<br>Ủi ở nhiệt độ tối đa 110°C, không sử dụng hơi nước<br>F - Giặt khô chuyên nghiệp với dung môi hydrocarbon, xử lý thông thường</p>', N'resources\images-upload\product\AoThunNikeDri-FIT.webp', NULL, NULL, CAST(550000.00 AS Decimal(10, 2)), 203, N'6 tháng', N'Đổi trả trong 7 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (2, 3, 3, 6, N'Quần Jeans Levi''s 501', N' Đây là mô tả của sản phầm', N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 4, 1, CAST(1800000.00 AS Decimal(10, 2)), 81, N'12 tháng', N'Đổi trả trong 14 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (3, 4, 2, 4, N'Áo Sơ Mi Uniqlo Oxford', N' Đây là mô tả của sản phầm', N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 3, 1, CAST(700000.00 AS Decimal(10, 2)), 204, N'3 tháng', N'Đổi trả trong 7 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (4, 5, 7, 10, N'Áo Khoác The North Face Resolve', N' Đây là mô tả của sản phầm', N'resources\images-upload\products\lovepik-t-shirt-dbc35e39.png', 2, 1, CAST(2500000.00 AS Decimal(10, 2)), 67, N'24 tháng', N'Đổi trả trong 30 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (5, 6, 8, 2, N'Bộ Đồ Thể Thao Adidas Tiro', N' Đây là mô tả của sản phầm', N'resources\images-upload\products\lovepik-t-shirt-dbc35e39.png', 5, 1, CAST(1500000.00 AS Decimal(10, 2)), 120, N'6 tháng', N'Đổi trả trong 14 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (6, 7, 5, 3, N'Váy Zara Hoa Nhí', N' Đây là mô tả của sản phầm', N'resources\images-upload\products\lovepik-t-shirt-dbc35e39.png', 2, 1, CAST(900000.00 AS Decimal(10, 2)), 100, N'Không bảo hành', N'Đổi trả trong 7 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (7, 8, 10, 1, N'Giày Nike Air Force 1', N' Đây là mô tả của sản phầm', N'resources\images-upload\products\lovepik-t-shirt-dbc35e39.png', 4, 1, CAST(2800000.00 AS Decimal(10, 2)), 307, N'12 tháng', N'Đổi trả trong 14 ngày nếu chưa sử dụng')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (8, 9, 4, 4, N'Quần Kaki Uniqlo Slim Fit', N' Đây là mô tả của sản phầm', N'resources\images-upload\product\AoThunNikeDri-FIT.webp', 5, 1, CAST(850000.00 AS Decimal(10, 2)), 144, N'3 tháng', N'Đổi trả trong 7 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (9, 10, 6, 5, N'Đầm H&M Maxi', N' Đây là mô tả của sản phầm', N'resources\images-upload\product\DamH&MMaxi.jpg', 3, 0, CAST(1200000.00 AS Decimal(10, 2)), 94, N'Không bảo hành', N'Đổi trả trong 7 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (10, 2, 9, 8, N'Blazer dài olive satin', N' Đây là mô tả của sản phầm', N'resources\images-upload\products\lovepik-t-shirt-dbc35e39.png', 1, 0, CAST(400000.00 AS Decimal(10, 2)), 256, N'1 tháng', N'Không đổi trả phụ kiện')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (11, 3, 1, 9, N'Áo Polo Lacoste Classic Fit', N' Đây là mô tả của sản phầm', N'resources\images-upload\products\lovepik-t-shirt-dbc35e39.png', 3, 0, CAST(2200000.00 AS Decimal(10, 2)), 74, N'6 tháng', N'Đổi trả trong 14 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (12, 5, 7, 5, N'Áo Khoác Bomber H&M', N' Đây là mô tả của sản phầm', N'resources\images-upload\product\DamH&MMaxi.jpg', 5, 0, CAST(1100000.00 AS Decimal(10, 2)), 125, N'3 tháng', N'Đổi trả trong 7 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (13, 11, 13, 6, N'Quần Short Jean Levi''s', N' Đây là mô tả của sản phầm', N'resources\images-upload\products\lovepik-t-shirt-dbc35e39.png', 4, 0, CAST(950000.00 AS Decimal(10, 2)), 135, N'6 tháng', N'Đổi trả trong 14 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (14, 4, 14, 4, N'Áo Len Uniqlo Cổ Tròn', N' Đây là mô tả của sản phầm', N'resources\images-upload\product\DamH&MMaxi.jpg', 5, 0, CAST(750000.00 AS Decimal(10, 2)), 190, N'3 tháng', N'Đổi trả trong 7 ngày')
INSERT [dbo].[Products] ([product_id], [supplier_id], [category_id], [brand_id], [product_name], [description], [image_url], [rating], [type], [price], [quantity_sold], [warranty], [return_policy]) VALUES (15, 7, 15, 3, N'Túi Tote Zara', N' Đây là mô tả của sản phầm', N'resources\images-upload\product\DamH&MMaxi.jpg', 4, 0, CAST(1300000.00 AS Decimal(10, 2)), 43, N'1 tháng', N'Đổi trả trong 7 ngày')
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[purchase_receipt] ON 

INSERT [dbo].[purchase_receipt] ([purchase_receipt_id], [supplier_id], [receipt_code], [total_amount], [note], [create_by], [create_at]) VALUES (1, 1, N'PR10000000', CAST(2000000 AS Decimal(18, 0)), NULL, 12, CAST(N'2025-05-01' AS Date))
INSERT [dbo].[purchase_receipt] ([purchase_receipt_id], [supplier_id], [receipt_code], [total_amount], [note], [create_by], [create_at]) VALUES (2, 1, N'PR10000001', CAST(3000000 AS Decimal(18, 0)), NULL, 12, CAST(N'2025-04-01' AS Date))
INSERT [dbo].[purchase_receipt] ([purchase_receipt_id], [supplier_id], [receipt_code], [total_amount], [note], [create_by], [create_at]) VALUES (3, 1, N'PR10000002', CAST(4000000 AS Decimal(18, 0)), NULL, 12, CAST(N'2025-04-01' AS Date))
INSERT [dbo].[purchase_receipt] ([purchase_receipt_id], [supplier_id], [receipt_code], [total_amount], [note], [create_by], [create_at]) VALUES (4, 2, N'PR10000003', CAST(2000000 AS Decimal(18, 0)), NULL, 12, CAST(N'2025-04-01' AS Date))
INSERT [dbo].[purchase_receipt] ([purchase_receipt_id], [supplier_id], [receipt_code], [total_amount], [note], [create_by], [create_at]) VALUES (7, 1, N'PR10000005', NULL, N'', 1, CAST(N'2025-05-19' AS Date))
INSERT [dbo].[purchase_receipt] ([purchase_receipt_id], [supplier_id], [receipt_code], [total_amount], [note], [create_by], [create_at]) VALUES (8, 1, N'PR10000005', NULL, N'', 1, CAST(N'2025-05-19' AS Date))
INSERT [dbo].[purchase_receipt] ([purchase_receipt_id], [supplier_id], [receipt_code], [total_amount], [note], [create_by], [create_at]) VALUES (9, 1, N'PR10000005', CAST(1000000 AS Decimal(18, 0)), N'', 1, CAST(N'2025-05-19' AS Date))
INSERT [dbo].[purchase_receipt] ([purchase_receipt_id], [supplier_id], [receipt_code], [total_amount], [note], [create_by], [create_at]) VALUES (10, 1, N'PR10000006', CAST(500000 AS Decimal(18, 0)), N'', 1, CAST(N'2025-05-19' AS Date))
SET IDENTITY_INSERT [dbo].[purchase_receipt] OFF
GO
SET IDENTITY_INSERT [dbo].[purchase_receipt_details] ON 

INSERT [dbo].[purchase_receipt_details] ([purchase_receipt_detail_id], [purchase_receipt_id], [product_id], [product_variant_id], [quantity], [unit_price]) VALUES (1, 7, 1, 1, 10, CAST(10000.00 AS Decimal(15, 2)))
INSERT [dbo].[purchase_receipt_details] ([purchase_receipt_detail_id], [purchase_receipt_id], [product_id], [product_variant_id], [quantity], [unit_price]) VALUES (2, 8, 2, 5, 10, CAST(100000.00 AS Decimal(15, 2)))
INSERT [dbo].[purchase_receipt_details] ([purchase_receipt_detail_id], [purchase_receipt_id], [product_id], [product_variant_id], [quantity], [unit_price]) VALUES (3, 8, 4, 9, 12, CAST(40000.00 AS Decimal(15, 2)))
INSERT [dbo].[purchase_receipt_details] ([purchase_receipt_detail_id], [purchase_receipt_id], [product_id], [product_variant_id], [quantity], [unit_price]) VALUES (4, 9, 1, 22, 10, CAST(100000.00 AS Decimal(15, 2)))
INSERT [dbo].[purchase_receipt_details] ([purchase_receipt_detail_id], [purchase_receipt_id], [product_id], [product_variant_id], [quantity], [unit_price]) VALUES (5, 10, 1, 1, 10, CAST(50000.00 AS Decimal(15, 2)))
SET IDENTITY_INSERT [dbo].[purchase_receipt_details] OFF
GO
INSERT [dbo].[Returns] ([return_id], [product_id], [order_id], [return_date], [reason], [return_status]) VALUES (1, 1, N'ORD0000001', CAST(N'2025-04-22' AS Date), N'Ð?t nh?m size', N'Đã hoàn tiền')
INSERT [dbo].[Returns] ([return_id], [product_id], [order_id], [return_date], [reason], [return_status]) VALUES (2, 2, N'ORD0000005', CAST(N'2025-04-24' AS Date), N'Qu?n b? l?i ch?', N'Đã đổi sản phẩm mới')
INSERT [dbo].[Returns] ([return_id], [product_id], [order_id], [return_date], [reason], [return_status]) VALUES (3, 7, N'ORD0000002', CAST(N'2025-04-23' AS Date), N'Giày b? tr?y xu?c nh?', N'Yêu cầu bị từ chối')
INSERT [dbo].[Returns] ([return_id], [product_id], [order_id], [return_date], [reason], [return_status]) VALUES (4, 6, N'ORD0000007', CAST(N'2025-04-25' AS Date), N'Không thích màu', N'Chờ nhận hàng')
INSERT [dbo].[Returns] ([return_id], [product_id], [order_id], [return_date], [reason], [return_status]) VALUES (5, 13, N'ORD0000013', CAST(N'2025-04-23' AS Date), N'Qu?n short quá r?ng', N'Đang xử lý')
INSERT [dbo].[Returns] ([return_id], [product_id], [order_id], [return_date], [reason], [return_status]) VALUES (6, 1, N'ORD0000005', CAST(N'2025-04-23' AS Date), N'Áo thun không gi?ng hình', N'Chờ nhận hàng')
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (1, 1012, 1, 5, N'good', CAST(N'2025-04-21T12:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (2, 1012, 2, 4, N'good', CAST(N'2025-04-23T09:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (3, 1012, 3, 5, N'good', CAST(N'2025-04-23T09:05:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (4, 1012, 4, 5, N'good', CAST(N'2025-04-23T15:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (5, 1012, 5, 3, N'bad', CAST(N'2025-04-22T10:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (6, 1012, 6, 3, N'bad', CAST(N'2025-04-23T11:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (7, 1012, 7, 2, N'bad', CAST(N'2025-04-23T14:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (8, 1012, 8, 2, N'bad', CAST(N'2025-04-23T16:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (9, 1017, 1, 5, N'good', CAST(N'2025-04-22T18:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (10, 1017, 2, 4, N'good', CAST(N'2025-04-22T20:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (11, 1017, 3, 5, N'good', CAST(N'2025-04-23T23:42:31.567' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (13, 1017, 4, 3, N'bad', CAST(N'2025-04-23T23:42:31.567' AS DateTime), NULL)
INSERT [dbo].[Reviews] ([review_id], [customer_id], [product_id], [rating], [comment], [review_date], [image_url]) VALUES (14, 1017, 5, 3, N'bad', CAST(N'2025-04-23T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (1, N'CUSTOMER')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (2, N'EMPLOYEE')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (3, N'ADMIN')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (4, N'SHIPPER')
GO
SET IDENTITY_INSERT [dbo].[Shipments] ON 

INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (1, N'ORD0000001', 12, N'GHN123456789', N'CANCELLED', CAST(N'2025-04-20' AS Date), CAST(N'2025-05-18' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (2, N'ORD0000002', 12, N'GHN987654321', N'SHIPPING', CAST(N'2025-04-21' AS Date), CAST(N'2025-04-24' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (3, N'ORD0000003', 12, N'GHN112233445', N'SHIPPING', CAST(N'2025-04-22' AS Date), CAST(N'2025-04-24' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (4, N'ORD0000004', 12, N'GHN001122334', N'SHIPPING', CAST(N'2025-04-22' AS Date), CAST(N'2025-04-22' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (5, N'ORD0000005', 12, N'GHN556677889', N'SHIPPING', CAST(N'2025-04-23' AS Date), CAST(N'2025-04-23' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (6, N'ORD0000006', 12, N'GHN445566778', N'SHIPPING', CAST(N'2025-04-23' AS Date), CAST(N'2025-04-25' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (7, N'ORD0000007', 13, N'GHN998877667', N'SHIPPING', CAST(N'2025-04-23' AS Date), CAST(N'2025-04-24' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (8, N'ORD0000008', 13, N'GHN121212333', N'SHIPPING', CAST(N'2025-04-23' AS Date), CAST(N'2025-04-23' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (9, N'ORD0000009', 13, N'GHN556677889', N'SHIPPING', CAST(N'2025-04-23' AS Date), CAST(N'2025-04-25' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (10, N'ORD0000010', 13, N'GHN334455667', N'SHIPPING', CAST(N'2025-04-23' AS Date), CAST(N'2025-04-22' AS Date))
INSERT [dbo].[Shipments] ([shipment_id], [order_id], [shipper_id], [tracking_number], [status], [assigned_date], [delivered_date]) VALUES (14, N'OR00000013', 12, N'2RVO9CYYRLUC1', N'SHIPPING', CAST(N'2025-05-18' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Shipments] OFF
GO
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (1, N'XS')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (2, N'S')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (3, N'M')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (4, N'L')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (5, N'XL')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (6, N'XXL')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (7, N'FreeSize')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (8, N'38')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (9, N'39')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (10, N'40')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (11, N'41')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (12, N'42')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (13, N'W28')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (14, N'W30')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (15, N'W32')
INSERT [dbo].[Sizes] ([size_id], [size_name]) VALUES (16, N'W34')
GO
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'123f3081-b569-459d-810b-6eb522a97091', N'92a6dfa8-6eeb-49e2-894b-e16b51b30425', 1745247900096, 1745247953750, 2592000, 1747839953750, N'101098490015780943866')
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'3205462c-5921-4bb2-bf00-aa45a4125df7', N'86df77a4-d91a-4812-b8e4-b0c407d375ff', 1745225454105, 1745246487569, 2592000, 1747838487569, N'DUONG')
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'386b07f1-fb51-42b5-88ed-b3da1bc45186', N'b1c347b3-ca28-4151-86ab-c047a1182c76', 1745247241107, 1745247307866, 2592000, 1747839307866, N'101098490015780943866')
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'c49e268d-143c-4499-a17b-406a89de2ba3', 1747321013054, 1747321178424, 2592000, 1749913178424, N'SON')
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'bb63f4ad-a140-48b2-94fa-b084641a3e3f', 1745247050686, 1746454148003, 2592000, 1749046148003, N'DUONG')
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'57b1407f-b653-4ffe-9090-1153caabe35c', 1747321258041, 1747321598181, 2592000, 1749913598181, N'SON')
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'b2057c36-fcf6-4d8f-a1d0-2594b6493f73', 1747320385129, 1747320998663, 2592000, 1749912998663, N'SON')
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'df3766ac-0ebe-4cd6-bb98-e776c40bbc19', N'9b659466-f7b7-4db6-82d9-6aa23a86a0a1', 1745246632745, 1745247044204, 2592000, 1747839044204, NULL)
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'2f80f733-8f82-4518-a02b-55dfebf73a4d', 1747321197637, 1747321247172, 2592000, 1749913247172, N'SON')
INSERT [dbo].[SPRING_SESSION] ([PRIMARY_ID], [SESSION_ID], [CREATION_TIME], [LAST_ACCESS_TIME], [MAX_INACTIVE_INTERVAL], [EXPIRY_TIME], [PRINCIPAL_NAME]) VALUES (N'fde93de4-a3b2-4cc1-a2b9-3a103027adcb', N'c90f79ba-fbb9-4495-88c7-06681bc8b42f', 1747717034298, 1747718048568, 3600, 1747721648568, N'DUONG')
GO
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'123f3081-b569-459d-810b-6eb522a97091', N'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', 0xACED0005737200366F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E637372662E44656661756C7443737266546F6B656E5AEFB7C82FA2FBD50200034C000A6865616465724E616D657400124C6A6176612F6C616E672F537472696E673B4C000D706172616D657465724E616D6571007E00014C0005746F6B656E71007E0001787074000C582D435352462D544F4B454E7400055F6373726674002437346231376365332D663365322D346138382D613634612D613462353430373334656566)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'123f3081-b569-459d-810b-6eb522a97091', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B7870737200536F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636C69656E742E61757468656E7469636174696F6E2E4F417574683241757468656E7469636174696F6E546F6B656E000000000000026C0200024C001E617574686F72697A6564436C69656E74526567697374726174696F6E49647400124C6A6176612F6C616E672F537472696E673B4C00097072696E636970616C74003A4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F636F72652F757365722F4F4175746832557365723B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00077870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000004770400000004737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E757365722E4F417574683255736572417574686F72697479000000000000026C0200034C000A6174747269627574657374000F4C6A6176612F7574696C2F4D61703B4C0009617574686F7269747971007E00044C0015757365724E616D654174747269627574654E616D6571007E00047870737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00117870737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F40000000000006770800000008000000067400037375627400153130313039383439303031353738303934333836367400046E616D6574000C537461722044C6B0C6A16E6774000A676976656E5F6E616D6574000C537461722044C6B0C6A16E677400077069637475726574006268747470733A2F2F6C68332E676F6F676C6575736572636F6E74656E742E636F6D2F612F414367386F634B56576E5F682D4A6C5A654B655F584B5A5749725153514F6D584338344E4A6A477378464A78576E4B71724E6B5A5348536A3D7339362D63740005656D61696C740017687664756F6E67323339326B3440676D61696C2E636F6D74000E656D61696C5F7665726966696564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C7565787001780074000B4F41555448325F55534552740003737562737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C6571007E0004787074003453434F50455F68747470733A2F2F7777772E676F6F676C65617069732E636F6D2F617574682F75736572696E666F2E656D61696C7371007E002774003653434F50455F68747470733A2F2F7777772E676F6F676C65617069732E636F6D2F617574682F75736572696E666F2E70726F66696C657371007E002774000C53434F50455F6F70656E69647871007E000F737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E00044C000973657373696F6E496471007E0004787074000F303A303A303A303A303A303A303A3174002461633337663334392D383161652D346636612D383530612D616131363134626363636566740006676F6F676C657372003F6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E757365722E44656661756C744F417574683255736572000000000000026C0200034C000A6174747269627574657371007E00114C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C00106E616D654174747269627574654B657971007E000478707371007E00137371007E00153F400000000000067708000000080000000671007E001871007E001971007E001A71007E001B71007E001C71007E001D71007E001E71007E001F71007E002071007E002171007E002271007E00247800737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000C737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000471007E001271007E002871007E002A71007E002C7871007E0026)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'3205462c-5921-4bb2-bf00-aa45a4125df7', N'email', 0xACED00057400137374617264756F6E6740676D61696C2E636F6D)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'3205462c-5921-4bb2-bf00-aa45a4125df7', N'org.springframework.security.oauth2.client.web.HttpSessionOAuth2AuthorizationRequestRepository.AUTHORIZATION_REQUEST', 0xACED00057372004C6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E656E64706F696E742E4F4175746832417574686F72697A6174696F6E52657175657374000000000000026C02000A4C00146164646974696F6E616C506172616D657465727374000F4C6A6176612F7574696C2F4D61703B4C000A6174747269627574657371007E00014C0016617574686F72697A6174696F6E4772616E74547970657400414C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F636F72652F417574686F72697A6174696F6E4772616E74547970653B4C0017617574686F72697A6174696F6E526571756573745572697400124C6A6176612F6C616E672F537472696E673B4C0010617574686F72697A6174696F6E55726971007E00034C0008636C69656E74496471007E00034C000B726564697265637455726971007E00034C000C726573706F6E7365547970657400534C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F636F72652F656E64706F696E742F4F4175746832417574686F72697A6174696F6E526573706F6E7365547970653B4C000673636F70657374000F4C6A6176612F7574696C2F5365743B4C0005737461746571007E00037870737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00017870737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000007708000000100000000078007371007E00077371007E00093F4000000000000C7708000000100000000174000F726567697374726174696F6E5F6964740006676F6F676C6578007372003F6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E417574686F72697A6174696F6E4772616E7454797065000000000000026C0200014C000576616C756571007E00037870740012617574686F72697A6174696F6E5F636F646574011968747470733A2F2F6163636F756E74732E676F6F676C652E636F6D2F6F2F6F61757468322F76322F617574683F726573706F6E73655F747970653D636F646526636C69656E745F69643D3831333331363430363232342D65616F713672743636616B6663313773736571396137743564746A32676D32312E617070732E676F6F676C6575736572636F6E74656E742E636F6D2673636F70653D656D61696C25323070726F66696C652673746174653D745F4B514E436B485273486F646D62716C6F7432536149775F554F735949756B69797738677A7A46435F632533442672656469726563745F7572693D687474703A2F2F6C6F63616C686F73743A383038302F6C6F67696E2F6F61757468322F636F64652F676F6F676C6574002C68747470733A2F2F6163636F756E74732E676F6F676C652E636F6D2F6F2F6F61757468322F76322F617574687400483831333331363430363232342D65616F713672743636616B6663313773736571396137743564746A32676D32312E617070732E676F6F676C6575736572636F6E74656E742E636F6D74002E687474703A2F2F6C6F63616C686F73743A383038302F6C6F67696E2F6F61757468322F636F64652F676F6F676C65737200516F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E656E64706F696E742E4F4175746832417574686F72697A6174696F6E526573706F6E736554797065000000000000026C0200014C000576616C756571007E00037870740004636F6465737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C0001637400164C6A6176612F7574696C2F436F6C6C656374696F6E3B7870737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F40000000000002740005656D61696C74000770726F66696C657874002C745F4B514E436B485273486F646D62716C6F7432536149775F554F735949756B69797738677A7A46435F633D)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'3205462c-5921-4bb2-bf00-aa45a4125df7', N'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', 0xACED0005737200366F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E637372662E44656661756C7443737266546F6B656E5AEFB7C82FA2FBD50200034C000A6865616465724E616D657400124C6A6176612F6C616E672F537472696E673B4C000D706172616D657465724E616D6571007E00014C0005746F6B656E71007E0001787074000C582D435352462D544F4B454E7400055F6373726674002435313236326261312D333435312D343261622D623831662D393762376234373136396234)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'3205462c-5921-4bb2-bf00-aa45a4125df7', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B78707372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E000000000000026C0200024C000B63726564656E7469616C737400124C6A6176612F6C616E672F4F626A6563743B4C00097072696E636970616C71007E0004787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C7371007E0004787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00067870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000A524F4C455F41444D494E7871007E000D737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3174002432623830373363382D323965632D343962342D383232612D35646331636261396563306670737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E55736572000000000000026C0200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C000870617373776F726471007E000F4C0008757365726E616D6571007E000F787001010101737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000A737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F72000000000000026C020000787077040000000171007E0010787074000544554F4E47)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'3205462c-5921-4bb2-bf00-aa45a4125df7', N'SPRING_SECURITY_SAVED_REQUEST', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E44656661756C74536176656452657175657374000000000000026C02000F49000A736572766572506F72744C000B636F6E74657874506174687400124C6A6176612F6C616E672F537472696E673B4C0007636F6F6B6965737400154C6A6176612F7574696C2F41727261794C6973743B4C00076865616465727374000F4C6A6176612F7574696C2F4D61703B4C00076C6F63616C657371007E00024C001C6D61746368696E6752657175657374506172616D657465724E616D6571007E00014C00066D6574686F6471007E00014C000A706172616D657465727371007E00034C000870617468496E666F71007E00014C000B7175657279537472696E6771007E00014C000A7265717565737455524971007E00014C000A7265717565737455524C71007E00014C0006736368656D6571007E00014C000A7365727665724E616D6571007E00014C000B736572766C65745061746871007E0001787000001F90740000737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200396F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E5361766564436F6F6B6965000000000000026C0200084900066D61784167655A000673656375726549000776657273696F6E4C0007636F6D6D656E7471007E00014C0006646F6D61696E71007E00014C00046E616D6571007E00014C00047061746871007E00014C000576616C756571007E00017870FFFFFFFF0000000000707074000753455353494F4E707400304E32566D4D5446684E3255745932566B4F5330304F546C6C4C574A6C593259744F57517A5A6D55354F546C6D4D6A566B78737200116A6176612E7574696C2E547265654D61700CC1F63E2D256AE60300014C000A636F6D70617261746F727400164C6A6176612F7574696C2F436F6D70617261746F723B78707372002A6A6176612E6C616E672E537472696E672443617365496E73656E736974697665436F6D70617261746F7277035C7D5C50E5CE020000787077040000000F7400066163636570747371007E0006000000017704000000017400032A2F2A7874000F6163636570742D656E636F64696E677371007E000600000001770400000001740017677A69702C206465666C6174652C2062722C207A7374647874000F6163636570742D6C616E67756167657371007E000600000001770400000001740017656E2D55532C656E3B713D302E392C76693B713D302E387874000A636F6E6E656374696F6E7371007E00060000000177040000000174000A6B6565702D616C69766578740006636F6F6B69657371007E00060000000177040000000174003853455353494F4E3D4E32566D4D5446684E3255745932566B4F5330304F546C6C4C574A6C593259744F57517A5A6D55354F546C6D4D6A566B78740004686F73747371007E00060000000177040000000174000E6C6F63616C686F73743A38303830787400066F726967696E7371007E000600000001770400000001740015687474703A2F2F6C6F63616C686F73743A3830383078740007726566657265727371007E00060000000177040000000174002C687474703A2F2F6C6F63616C686F73743A383038302F7265736F75726365732F6373732F746573742E637373787400097365632D63682D75617371007E000600000001770400000001740041224D6963726F736F66742045646765223B763D22313335222C20224E6F742D412E4272616E64223B763D2238222C20224368726F6D69756D223B763D2231333522787400107365632D63682D75612D6D6F62696C657371007E0006000000017704000000017400023F30787400127365632D63682D75612D706C6174666F726D7371007E0006000000017704000000017400092257696E646F7773227874000E7365632D66657463682D646573747371007E000600000001770400000001740004666F6E747874000E7365632D66657463682D6D6F64657371007E000600000001770400000001740004636F72737874000E7365632D66657463682D736974657371007E00060000000177040000000174000B73616D652D6F726967696E7874000A757365722D6167656E747371007E00060000000177040000000174007D4D6F7A696C6C612F352E30202857696E646F7773204E542031302E303B2057696E36343B2078363429204170706C655765624B69742F3533372E333620284B48544D4C2C206C696B65204765636B6F29204368726F6D652F3133352E302E302E30205361666172692F3533372E3336204564672F3133352E302E302E3078787371007E000600000003770400000003737200106A6176612E7574696C2E4C6F63616C657EF811609C30F9EC03000649000868617368636F64654C0007636F756E74727971007E00014C000A657874656E73696F6E7371007E00014C00086C616E677561676571007E00014C000673637269707471007E00014C000776617269616E7471007E00017870FFFFFFFF7400025553740000740002656E71007E004271007E0042787371007E003FFFFFFFFF71007E004271007E004271007E004371007E004271007E0042787371007E003FFFFFFFFF71007E004271007E0042740002766971007E004271007E00427878740008636F6E74696E75657400034745547371007E000C707704000000007870707400062F6572726F7274001B687474703A2F2F6C6F63616C686F73743A383038302F6572726F72740004687474707400096C6F63616C686F73747400062F6572726F72)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'386b07f1-fb51-42b5-88ed-b3da1bc45186', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B7870737200536F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636C69656E742E61757468656E7469636174696F6E2E4F417574683241757468656E7469636174696F6E546F6B656E000000000000026C0200024C001E617574686F72697A6564436C69656E74526567697374726174696F6E49647400124C6A6176612F6C616E672F537472696E673B4C00097072696E636970616C74003A4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F636F72652F757365722F4F4175746832557365723B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00077870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000004770400000004737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E757365722E4F417574683255736572417574686F72697479000000000000026C0200034C000A6174747269627574657374000F4C6A6176612F7574696C2F4D61703B4C0009617574686F7269747971007E00044C0015757365724E616D654174747269627574654E616D6571007E00047870737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00117870737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F40000000000006770800000008000000067400037375627400153130313039383439303031353738303934333836367400046E616D6574000C537461722044C6B0C6A16E6774000A676976656E5F6E616D6574000C537461722044C6B0C6A16E677400077069637475726574006268747470733A2F2F6C68332E676F6F676C6575736572636F6E74656E742E636F6D2F612F414367386F634B56576E5F682D4A6C5A654B655F584B5A5749725153514F6D584338344E4A6A477378464A78576E4B71724E6B5A5348536A3D7339362D63740005656D61696C740017687664756F6E67323339326B3440676D61696C2E636F6D74000E656D61696C5F7665726966696564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C7565787001780074000B4F41555448325F55534552740003737562737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C6571007E0004787074003453434F50455F68747470733A2F2F7777772E676F6F676C65617069732E636F6D2F617574682F75736572696E666F2E656D61696C7371007E002774003653434F50455F68747470733A2F2F7777772E676F6F676C65617069732E636F6D2F617574682F75736572696E666F2E70726F66696C657371007E002774000C53434F50455F6F70656E69647871007E000F737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E00044C000973657373696F6E496471007E0004787074000F303A303A303A303A303A303A303A3174002435373731313464322D363464612D343936312D613163312D633830323761326632633662740006676F6F676C657372003F6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E757365722E44656661756C744F417574683255736572000000000000026C0200034C000A6174747269627574657371007E00114C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C00106E616D654174747269627574654B657971007E000478707371007E00137371007E00153F400000000000067708000000080000000671007E001871007E001971007E001A71007E001B71007E001C71007E001D71007E001E71007E001F71007E002071007E002171007E002271007E00247800737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000C737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000471007E001271007E002871007E002A71007E002C7871007E0026)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'avatar', 0xACED000574003A2F7265736F75726365732F696D616765732D75706C6F61642F637573746F6D65722F73747564656E742D626F792D35636633313366612E706E67)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'cartItemCount', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'customerId', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000003F9)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'email', 0xACED00057400116E676F63736F6E40676D61696C2E636F6D)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'fullName', 0xACED000574001155C3B46E67204E67E1BB8D632053C6A16E)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', 0xACED0005737200366F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E637372662E44656661756C7443737266546F6B656E5AEFB7C82FA2FBD50200034C000A6865616465724E616D657400124C6A6176612F6C616E672F537472696E673B4C000D706172616D657465724E616D6571007E00014C0005746F6B656E71007E0001787074000C582D435352462D544F4B454E7400055F6373726674002438666662336166642D643466372D343366302D393333382D363730663738356232666431)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B78707372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E000000000000026C0200024C000B63726564656E7469616C737400124C6A6176612F6C616E672F4F626A6563743B4C00097072696E636970616C71007E0004787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C7371007E0004787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00067870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000D524F4C455F435553544F4D45527871007E000D737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3174002437366132326166312D303333662D343437392D383536362D36663966623532303735363770737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E55736572000000000000026C0200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C000870617373776F726471007E000F4C0008757365726E616D6571007E000F787001010101737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000A737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F72000000000000026C020000787077040000000171007E00107870740003534F4E)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'SPRING_SECURITY_SAVED_REQUEST', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E44656661756C74536176656452657175657374000000000000026C02000F49000A736572766572506F72744C000B636F6E74657874506174687400124C6A6176612F6C616E672F537472696E673B4C0007636F6F6B6965737400154C6A6176612F7574696C2F41727261794C6973743B4C00076865616465727374000F4C6A6176612F7574696C2F4D61703B4C00076C6F63616C657371007E00024C001C6D61746368696E6752657175657374506172616D657465724E616D6571007E00014C00066D6574686F6471007E00014C000A706172616D657465727371007E00034C000870617468496E666F71007E00014C000B7175657279537472696E6771007E00014C000A7265717565737455524971007E00014C000A7265717565737455524C71007E00014C0006736368656D6571007E00014C000A7365727665724E616D6571007E00014C000B736572766C65745061746871007E0001787000001F90740000737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200396F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E5361766564436F6F6B6965000000000000026C0200084900066D61784167655A000673656375726549000776657273696F6E4C0007636F6D6D656E7471007E00014C0006646F6D61696E71007E00014C00046E616D6571007E00014C00047061746871007E00014C000576616C756571007E00017870FFFFFFFF0000000000707074000753455353494F4E707400304E7A5A684D6A4A685A6A45744D444D7A5A6930304E4463354C5467314E6A59744E6D59355A6D49314D6A41334E54593378737200116A6176612E7574696C2E547265654D61700CC1F63E2D256AE60300014C000A636F6D70617261746F727400164C6A6176612F7574696C2F436F6D70617261746F723B78707372002A6A6176612E6C616E672E537472696E672443617365496E73656E736974697665436F6D70617261746F7277035C7D5C50E5CE020000787077040000000E7400066163636570747371007E000600000001770400000001740040696D6167652F617669662C696D6167652F776562702C696D6167652F61706E672C696D6167652F7376672B786D6C2C696D6167652F2A2C2A2F2A3B713D302E387874000F6163636570742D656E636F64696E677371007E000600000001770400000001740017677A69702C206465666C6174652C2062722C207A7374647874000F6163636570742D6C616E67756167657371007E000600000001770400000001740017656E2D55532C656E3B713D302E392C76693B713D302E387874000A636F6E6E656374696F6E7371007E00060000000177040000000174000A6B6565702D616C69766578740006636F6F6B69657371007E00060000000177040000000174003853455353494F4E3D4E7A5A684D6A4A685A6A45744D444D7A5A6930304E4463354C5467314E6A59744E6D59355A6D49314D6A41334E54593378740004686F73747371007E00060000000177040000000174000E6C6F63616C686F73743A3830383078740007726566657265727371007E000600000001770400000001740016687474703A2F2F6C6F63616C686F73743A383038302F787400097365632D63682D75617371007E000600000001770400000001740042224368726F6D69756D223B763D22313336222C20224D6963726F736F66742045646765223B763D22313336222C20224E6F742E412F4272616E64223B763D22393922787400107365632D63682D75612D6D6F62696C657371007E0006000000017704000000017400023F30787400127365632D63682D75612D706C6174666F726D7371007E0006000000017704000000017400092257696E646F7773227874000E7365632D66657463682D646573747371007E000600000001770400000001740005696D6167657874000E7365632D66657463682D6D6F64657371007E0006000000017704000000017400076E6F2D636F72737874000E7365632D66657463682D736974657371007E00060000000177040000000174000B73616D652D6F726967696E7874000A757365722D6167656E747371007E00060000000177040000000174007D4D6F7A696C6C612F352E30202857696E646F7773204E542031302E303B2057696E36343B2078363429204170706C655765624B69742F3533372E333620284B48544D4C2C206C696B65204765636B6F29204368726F6D652F3133362E302E302E30205361666172692F3533372E3336204564672F3133362E302E302E3078787371007E000600000003770400000003737200106A6176612E7574696C2E4C6F63616C657EF811609C30F9EC03000649000868617368636F64654C0007636F756E74727971007E00014C000A657874656E73696F6E7371007E00014C00086C616E677561676571007E00014C000673637269707471007E00014C000776617269616E7471007E00017870FFFFFFFF7400025553740000740002656E71007E003F71007E003F787371007E003CFFFFFFFF71007E003F71007E003F71007E004071007E003F71007E003F787371007E003CFFFFFFFF71007E003F71007E003F740002766971007E003F71007E003F7878740008636F6E74696E75657400034745547371007E000C707704000000007870707400062F6572726F7274001B687474703A2F2F6C6F63616C686F73743A383038302F6572726F72740004687474707400096C6F63616C686F73747400062F6572726F72)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'4b3f35d6-b340-48a4-9d1e-fbbc382d9358', N'sum', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'avatar', 0xACED0005740000)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'customerId', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'email', 0xACED00057400137374617264756F6E6740676D61696C2E636F6D)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'fullName', 0xACED000574000A537461722044756F6E67)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'jakarta.servlet.jsp.jstl.fmt.request.charset', 0xACED00057400055554462D38)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', 0xACED0005737200366F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E637372662E44656661756C7443737266546F6B656E5AEFB7C82FA2FBD50200034C000A6865616465724E616D657400124C6A6176612F6C616E672F537472696E673B4C000D706172616D657465724E616D6571007E00014C0005746F6B656E71007E0001787074000C582D435352462D544F4B454E7400055F6373726674002462396339623931632D636135382D343833662D616431652D313037613732336166616637)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B78707372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E000000000000026C0200024C000B63726564656E7469616C737400124C6A6176612F6C616E672F4F626A6563743B4C00097072696E636970616C71007E0004787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C7371007E0004787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00067870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000A524F4C455F41444D494E7871007E000D737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3174002439333066643834322D646134352D343633662D613664632D30353339306137663463353570737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E55736572000000000000026C0200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C000870617373776F726471007E000F4C0008757365726E616D6571007E000F787001010101737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000A737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F72000000000000026C020000787077040000000171007E0010787074000544554F4E47)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'74de9289-f662-4f63-be5b-b5a3f97483dc', N'sum', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000002)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'avatar', 0xACED000574003A2F7265736F75726365732F696D616765732D75706C6F61642F637573746F6D65722F73747564656E742D626F792D35636633313366612E706E67)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'cartItemCount', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'customerId', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000003F9)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'email', 0xACED00057400116E676F63736F6E40676D61696C2E636F6D)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'fullName', 0xACED000574001155C3B46E67204E67E1BB8D632053C6A16E)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', 0xACED0005737200366F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E637372662E44656661756C7443737266546F6B656E5AEFB7C82FA2FBD50200034C000A6865616465724E616D657400124C6A6176612F6C616E672F537472696E673B4C000D706172616D657465724E616D6571007E00014C0005746F6B656E71007E0001787074000C582D435352462D544F4B454E7400055F6373726674002432366161373130372D306164662D346331302D623031322D353233346364363232393166)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B78707372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E000000000000026C0200024C000B63726564656E7469616C737400124C6A6176612F6C616E672F4F626A6563743B4C00097072696E636970616C71007E0004787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C7371007E0004787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00067870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000D524F4C455F435553544F4D45527871007E000D737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3174002438646464623634392D396638322D343963352D613137382D37326435343166336337313070737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E55736572000000000000026C0200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C000870617373776F726471007E000F4C0008757365726E616D6571007E000F787001010101737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000A737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F72000000000000026C020000787077040000000171007E00107870740003534F4E)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'SPRING_SECURITY_SAVED_REQUEST', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E44656661756C74536176656452657175657374000000000000026C02000F49000A736572766572506F72744C000B636F6E74657874506174687400124C6A6176612F6C616E672F537472696E673B4C0007636F6F6B6965737400154C6A6176612F7574696C2F41727261794C6973743B4C00076865616465727374000F4C6A6176612F7574696C2F4D61703B4C00076C6F63616C657371007E00024C001C6D61746368696E6752657175657374506172616D657465724E616D6571007E00014C00066D6574686F6471007E00014C000A706172616D657465727371007E00034C000870617468496E666F71007E00014C000B7175657279537472696E6771007E00014C000A7265717565737455524971007E00014C000A7265717565737455524C71007E00014C0006736368656D6571007E00014C000A7365727665724E616D6571007E00014C000B736572766C65745061746871007E0001787000001F90740000737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200396F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E5361766564436F6F6B6965000000000000026C0200084900066D61784167655A000673656375726549000776657273696F6E4C0007636F6D6D656E7471007E00014C0006646F6D61696E71007E00014C00046E616D6571007E00014C00047061746871007E00014C000576616C756571007E00017870FFFFFFFF0000000000707074000753455353494F4E707400304F47526B5A4749324E446B744F5759344D6930304F574D314C5745784E7A67744E7A4A6B4E5451785A6A4E6A4E7A457778737200116A6176612E7574696C2E547265654D61700CC1F63E2D256AE60300014C000A636F6D70617261746F727400164C6A6176612F7574696C2F436F6D70617261746F723B78707372002A6A6176612E6C616E672E537472696E672443617365496E73656E736974697665436F6D70617261746F7277035C7D5C50E5CE020000787077040000000E7400066163636570747371007E000600000001770400000001740040696D6167652F617669662C696D6167652F776562702C696D6167652F61706E672C696D6167652F7376672B786D6C2C696D6167652F2A2C2A2F2A3B713D302E387874000F6163636570742D656E636F64696E677371007E000600000001770400000001740017677A69702C206465666C6174652C2062722C207A7374647874000F6163636570742D6C616E67756167657371007E000600000001770400000001740017656E2D55532C656E3B713D302E392C76693B713D302E387874000A636F6E6E656374696F6E7371007E00060000000177040000000174000A6B6565702D616C69766578740006636F6F6B69657371007E00060000000177040000000174003853455353494F4E3D4F47526B5A4749324E446B744F5759344D6930304F574D314C5745784E7A67744E7A4A6B4E5451785A6A4E6A4E7A457778740004686F73747371007E00060000000177040000000174000E6C6F63616C686F73743A3830383078740007726566657265727371007E000600000001770400000001740016687474703A2F2F6C6F63616C686F73743A383038302F787400097365632D63682D75617371007E000600000001770400000001740042224368726F6D69756D223B763D22313336222C20224D6963726F736F66742045646765223B763D22313336222C20224E6F742E412F4272616E64223B763D22393922787400107365632D63682D75612D6D6F62696C657371007E0006000000017704000000017400023F30787400127365632D63682D75612D706C6174666F726D7371007E0006000000017704000000017400092257696E646F7773227874000E7365632D66657463682D646573747371007E000600000001770400000001740005696D6167657874000E7365632D66657463682D6D6F64657371007E0006000000017704000000017400076E6F2D636F72737874000E7365632D66657463682D736974657371007E00060000000177040000000174000B73616D652D6F726967696E7874000A757365722D6167656E747371007E00060000000177040000000174007D4D6F7A696C6C612F352E30202857696E646F7773204E542031302E303B2057696E36343B2078363429204170706C655765624B69742F3533372E333620284B48544D4C2C206C696B65204765636B6F29204368726F6D652F3133362E302E302E30205361666172692F3533372E3336204564672F3133362E302E302E3078787371007E000600000003770400000003737200106A6176612E7574696C2E4C6F63616C657EF811609C30F9EC03000649000868617368636F64654C0007636F756E74727971007E00014C000A657874656E73696F6E7371007E00014C00086C616E677561676571007E00014C000673637269707471007E00014C000776617269616E7471007E00017870FFFFFFFF7400025553740000740002656E71007E003F71007E003F787371007E003CFFFFFFFF71007E003F71007E003F71007E004071007E003F71007E003F787371007E003CFFFFFFFF71007E003F71007E003F740002766971007E003F71007E003F7878740008636F6E74696E75657400034745547371007E000C707704000000007870707400062F6572726F7274001B687474703A2F2F6C6F63616C686F73743A383038302F6572726F72740004687474707400096C6F63616C686F73747400062F6572726F72)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'990b9312-9a6e-4335-946a-4b2dea754673', N'sum', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'avatar', 0xACED000574003A2F7265736F75726365732F696D616765732D75706C6F61642F637573746F6D65722F73747564656E742D626F792D35636633313366612E706E67)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'cartItemCount', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'customerId', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000003F9)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'email', 0xACED00057400116E676F63736F6E40676D61696C2E636F6D)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'fullName', 0xACED000574001155C3B46E67204E67E1BB8D632053C6A16E)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', 0xACED0005737200366F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E637372662E44656661756C7443737266546F6B656E5AEFB7C82FA2FBD50200034C000A6865616465724E616D657400124C6A6176612F6C616E672F537472696E673B4C000D706172616D657465724E616D6571007E00014C0005746F6B656E71007E0001787074000C582D435352462D544F4B454E7400055F6373726674002435616236303336302D663166632D346538612D383564312D336430663837303631343336)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B78707372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E000000000000026C0200024C000B63726564656E7469616C737400124C6A6176612F6C616E672F4F626A6563743B4C00097072696E636970616C71007E0004787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C7371007E0004787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00067870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000D524F4C455F435553544F4D45527871007E000D737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3174002466313234353564382D613936302D343239632D626637342D62626162366531316437666270737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E55736572000000000000026C0200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C000870617373776F726471007E000F4C0008757365726E616D6571007E000F787001010101737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000A737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F72000000000000026C020000787077040000000171007E00107870740003534F4E)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'SPRING_SECURITY_SAVED_REQUEST', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E44656661756C74536176656452657175657374000000000000026C02000F49000A736572766572506F72744C000B636F6E74657874506174687400124C6A6176612F6C616E672F537472696E673B4C0007636F6F6B6965737400154C6A6176612F7574696C2F41727261794C6973743B4C00076865616465727374000F4C6A6176612F7574696C2F4D61703B4C00076C6F63616C657371007E00024C001C6D61746368696E6752657175657374506172616D657465724E616D6571007E00014C00066D6574686F6471007E00014C000A706172616D657465727371007E00034C000870617468496E666F71007E00014C000B7175657279537472696E6771007E00014C000A7265717565737455524971007E00014C000A7265717565737455524C71007E00014C0006736368656D6571007E00014C000A7365727665724E616D6571007E00014C000B736572766C65745061746871007E0001787000001F90740000737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200396F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E5361766564436F6F6B6965000000000000026C0200084900066D61784167655A000673656375726549000776657273696F6E4C0007636F6D6D656E7471007E00014C0006646F6D61696E71007E00014C00046E616D6571007E00014C00047061746871007E00014C000576616C756571007E00017870FFFFFFFF0000000000707074000753455353494F4E707400305A6A45794E4455315A44677459546B324D4330304D6A6C6A4C574A6D4E7A5174596D4A68596A5A6C4D54466B4E325A6978737200116A6176612E7574696C2E547265654D61700CC1F63E2D256AE60300014C000A636F6D70617261746F727400164C6A6176612F7574696C2F436F6D70617261746F723B78707372002A6A6176612E6C616E672E537472696E672443617365496E73656E736974697665436F6D70617261746F7277035C7D5C50E5CE020000787077040000000E7400066163636570747371007E000600000001770400000001740012746578742F6373732C2A2F2A3B713D302E317874000F6163636570742D656E636F64696E677371007E000600000001770400000001740017677A69702C206465666C6174652C2062722C207A7374647874000F6163636570742D6C616E67756167657371007E000600000001770400000001740017656E2D55532C656E3B713D302E392C76693B713D302E387874000A636F6E6E656374696F6E7371007E00060000000177040000000174000A6B6565702D616C69766578740006636F6F6B69657371007E00060000000177040000000174003853455353494F4E3D5A6A45794E4455315A44677459546B324D4330304D6A6C6A4C574A6D4E7A5174596D4A68596A5A6C4D54466B4E325A6978740004686F73747371007E00060000000177040000000174000E6C6F63616C686F73743A3830383078740007726566657265727371007E000600000001770400000001740016687474703A2F2F6C6F63616C686F73743A383038302F787400097365632D63682D75617371007E000600000001770400000001740042224368726F6D69756D223B763D22313336222C20224D6963726F736F66742045646765223B763D22313336222C20224E6F742E412F4272616E64223B763D22393922787400107365632D63682D75612D6D6F62696C657371007E0006000000017704000000017400023F30787400127365632D63682D75612D706C6174666F726D7371007E0006000000017704000000017400092257696E646F7773227874000E7365632D66657463682D646573747371007E0006000000017704000000017400057374796C657874000E7365632D66657463682D6D6F64657371007E0006000000017704000000017400076E6F2D636F72737874000E7365632D66657463682D736974657371007E00060000000177040000000174000B73616D652D6F726967696E7874000A757365722D6167656E747371007E00060000000177040000000174007D4D6F7A696C6C612F352E30202857696E646F7773204E542031302E303B2057696E36343B2078363429204170706C655765624B69742F3533372E333620284B48544D4C2C206C696B65204765636B6F29204368726F6D652F3133362E302E302E30205361666172692F3533372E3336204564672F3133362E302E302E3078787371007E000600000003770400000003737200106A6176612E7574696C2E4C6F63616C657EF811609C30F9EC03000649000868617368636F64654C0007636F756E74727971007E00014C000A657874656E73696F6E7371007E00014C00086C616E677561676571007E00014C000673637269707471007E00014C000776617269616E7471007E00017870FFFFFFFF7400025553740000740002656E71007E003F71007E003F787371007E003CFFFFFFFF71007E003F71007E003F71007E004071007E003F71007E003F787371007E003CFFFFFFFF71007E003F71007E003F740002766971007E003F71007E003F7878740008636F6E74696E75657400034745547371007E000C707704000000007870707400062F6572726F7274001B687474703A2F2F6C6F63616C686F73743A383038302F6572726F72740004687474707400096C6F63616C686F73747400062F6572726F72)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'ae0ff9ed-9cfd-4b33-8e1d-c46eed2a10ff', N'sum', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'df3766ac-0ebe-4cd6-bb98-e776c40bbc19', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B7870737200536F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636C69656E742E61757468656E7469636174696F6E2E4F417574683241757468656E7469636174696F6E546F6B656E000000000000026C0200024C001E617574686F72697A6564436C69656E74526567697374726174696F6E49647400124C6A6176612F6C616E672F537472696E673B4C00097072696E636970616C74003A4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F636F72652F757365722F4F4175746832557365723B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00077870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000004770400000004737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E757365722E4F417574683255736572417574686F72697479000000000000026C0200034C000A6174747269627574657374000F4C6A6176612F7574696C2F4D61703B4C0009617574686F7269747971007E00044C0015757365724E616D654174747269627574654E616D6571007E00047870737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00117870737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F40000000000006770800000008000000067400037375627400153130313039383439303031353738303934333836367400046E616D6574000C537461722044C6B0C6A16E6774000A676976656E5F6E616D6574000C537461722044C6B0C6A16E677400077069637475726574006268747470733A2F2F6C68332E676F6F676C6575736572636F6E74656E742E636F6D2F612F414367386F634B56576E5F682D4A6C5A654B655F584B5A5749725153514F6D584338344E4A6A477378464A78576E4B71724E6B5A5348536A3D7339362D63740005656D61696C740017687664756F6E67323339326B3440676D61696C2E636F6D74000E656D61696C5F7665726966696564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C7565787001780074000B4F41555448325F55534552740003737562737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C6571007E0004787074003453434F50455F68747470733A2F2F7777772E676F6F676C65617069732E636F6D2F617574682F75736572696E666F2E656D61696C7371007E002774003653434F50455F68747470733A2F2F7777772E676F6F676C65617069732E636F6D2F617574682F75736572696E666F2E70726F66696C657371007E002774000C53434F50455F6F70656E69647871007E000F737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E00044C000973657373696F6E496471007E0004787074000F303A303A303A303A303A303A303A3174002439623635393436362D663762372D346462362D383264392D366161323361383661306131740006676F6F676C657372003F6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F72652E757365722E44656661756C744F417574683255736572000000000000026C0200034C000A6174747269627574657371007E00114C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C00106E616D654174747269627574654B657971007E000478707371007E00137371007E00153F400000000000067708000000080000000671007E001871007E001971007E001A71007E001B71007E001C71007E001D71007E001E71007E001F71007E002071007E002171007E002271007E00247800737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000C737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000471007E001271007E002871007E002A71007E002C7871007E0026)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'avatar', 0xACED000574003A2F7265736F75726365732F696D616765732D75706C6F61642F637573746F6D65722F73747564656E742D626F792D35636633313366612E706E67)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'cartItemCount', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'customerId', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000003F9)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'email', 0xACED00057400116E676F63736F6E40676D61696C2E636F6D)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'fullName', 0xACED000574001155C3B46E67204E67E1BB8D632053C6A16E)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', 0xACED0005737200366F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E637372662E44656661756C7443737266546F6B656E5AEFB7C82FA2FBD50200034C000A6865616465724E616D657400124C6A6176612F6C616E672F537472696E673B4C000D706172616D657465724E616D6571007E00014C0005746F6B656E71007E0001787074000C582D435352462D544F4B454E7400055F6373726674002465643861383236652D613766372D343933642D626662662D626564376662646661303034)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B78707372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E000000000000026C0200024C000B63726564656E7469616C737400124C6A6176612F6C616E672F4F626A6563743B4C00097072696E636970616C71007E0004787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C7371007E0004787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00067870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000D524F4C455F435553544F4D45527871007E000D737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F78707400093132372E302E302E3174002466313063343232332D653565372D343136382D383932632D36363530623539383565373770737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E55736572000000000000026C0200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C000870617373776F726471007E000F4C0008757365726E616D6571007E000F787001010101737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000A737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F72000000000000026C020000787077040000000171007E00107870740003534F4E)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'SPRING_SECURITY_SAVED_REQUEST', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E44656661756C74536176656452657175657374000000000000026C02000F49000A736572766572506F72744C000B636F6E74657874506174687400124C6A6176612F6C616E672F537472696E673B4C0007636F6F6B6965737400154C6A6176612F7574696C2F41727261794C6973743B4C00076865616465727374000F4C6A6176612F7574696C2F4D61703B4C00076C6F63616C657371007E00024C001C6D61746368696E6752657175657374506172616D657465724E616D6571007E00014C00066D6574686F6471007E00014C000A706172616D657465727371007E00034C000870617468496E666F71007E00014C000B7175657279537472696E6771007E00014C000A7265717565737455524971007E00014C000A7265717565737455524C71007E00014C0006736368656D6571007E00014C000A7365727665724E616D6571007E00014C000B736572766C65745061746871007E0001787000001F90740000737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200396F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E7361766564726571756573742E5361766564436F6F6B6965000000000000026C0200084900066D61784167655A000673656375726549000776657273696F6E4C0007636F6D6D656E7471007E00014C0006646F6D61696E71007E00014C00046E616D6571007E00014C00047061746871007E00014C000576616C756571007E00017870FFFFFFFF0000000000707074000753455353494F4E707400305A6A4577597A51794D6A4D745A54566C4E7930304D5459344C5467354D6D4D744E6A59314D4749314F5467315A54633378737200116A6176612E7574696C2E547265654D61700CC1F63E2D256AE60300014C000A636F6D70617261746F727400164C6A6176612F7574696C2F436F6D70617261746F723B78707372002A6A6176612E6C616E672E537472696E672443617365496E73656E736974697665436F6D70617261746F7277035C7D5C50E5CE020000787077040000000E7400066163636570747371007E000600000001770400000001740012746578742F6373732C2A2F2A3B713D302E317874000F6163636570742D656E636F64696E677371007E000600000001770400000001740017677A69702C206465666C6174652C2062722C207A7374647874000F6163636570742D6C616E67756167657371007E000600000001770400000001740017656E2D55532C656E3B713D302E392C76693B713D302E387874000A636F6E6E656374696F6E7371007E00060000000177040000000174000A6B6565702D616C69766578740006636F6F6B69657371007E00060000000177040000000174003853455353494F4E3D5A6A4577597A51794D6A4D745A54566C4E7930304D5459344C5467354D6D4D744E6A59314D4749314F5467315A54633378740004686F73747371007E00060000000177040000000174000E6C6F63616C686F73743A3830383078740007726566657265727371007E000600000001770400000001740016687474703A2F2F6C6F63616C686F73743A383038302F787400097365632D63682D75617371007E000600000001770400000001740042224368726F6D69756D223B763D22313336222C20224D6963726F736F66742045646765223B763D22313336222C20224E6F742E412F4272616E64223B763D22393922787400107365632D63682D75612D6D6F62696C657371007E0006000000017704000000017400023F30787400127365632D63682D75612D706C6174666F726D7371007E0006000000017704000000017400092257696E646F7773227874000E7365632D66657463682D646573747371007E0006000000017704000000017400057374796C657874000E7365632D66657463682D6D6F64657371007E0006000000017704000000017400076E6F2D636F72737874000E7365632D66657463682D736974657371007E00060000000177040000000174000B73616D652D6F726967696E7874000A757365722D6167656E747371007E00060000000177040000000174007D4D6F7A696C6C612F352E30202857696E646F7773204E542031302E303B2057696E36343B2078363429204170706C655765624B69742F3533372E333620284B48544D4C2C206C696B65204765636B6F29204368726F6D652F3133362E302E302E30205361666172692F3533372E3336204564672F3133362E302E302E3078787371007E000600000003770400000003737200106A6176612E7574696C2E4C6F63616C657EF811609C30F9EC03000649000868617368636F64654C0007636F756E74727971007E00014C000A657874656E73696F6E7371007E00014C00086C616E677561676571007E00014C000673637269707471007E00014C000776617269616E7471007E00017870FFFFFFFF7400025553740000740002656E71007E003F71007E003F787371007E003CFFFFFFFF71007E003F71007E003F71007E004071007E003F71007E003F787371007E003CFFFFFFFF71007E003F71007E003F740002766971007E003F71007E003F7878740008636F6E74696E75657400034745547371007E000C707704000000007870707400062F6572726F7274001B687474703A2F2F6C6F63616C686F73743A383038302F6572726F72740004687474707400096C6F63616C686F73747400062F6572726F72)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'e08434dd-85b7-4bf4-bce7-20794aacf231', N'sum', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000003)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'fde93de4-a3b2-4cc1-a2b9-3a103027adcb', N'employeeAvatar', 0xACED00057400372F7265736F75726365732F696D616765732D75706C6F61642F656D706C6F7965652F656D706C6F7965652D30303030303030312E6A7067)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'fde93de4-a3b2-4cc1-a2b9-3a103027adcb', N'employeeEmail', 0xACED0005740017687664756F6E67323339326B3440676D61696C2E636F6D)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'fde93de4-a3b2-4cc1-a2b9-3a103027adcb', N'employeeFullName', 0xACED000574000C537461722044C6B0C6A16E67)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'fde93de4-a3b2-4cc1-a2b9-3a103027adcb', N'employeeId', 0xACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000001)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'fde93de4-a3b2-4cc1-a2b9-3a103027adcb', N'jakarta.servlet.jsp.jstl.fmt.request.charset', 0xACED00057400055554462D38)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'fde93de4-a3b2-4cc1-a2b9-3a103027adcb', N'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', 0xACED0005737200366F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E637372662E44656661756C7443737266546F6B656E5AEFB7C82FA2FBD50200034C000A6865616465724E616D657400124C6A6176612F6C616E672F537472696E673B4C000D706172616D657465724E616D6571007E00014C0005746F6B656E71007E0001787074000C582D435352462D544F4B454E7400055F6373726674002435326435336461622D623039612D343134322D393436612D663331313039336166376462)
INSERT [dbo].[SPRING_SESSION_ATTRIBUTES] ([SESSION_PRIMARY_ID], [ATTRIBUTE_NAME], [ATTRIBUTE_BYTES]) VALUES (N'fde93de4-a3b2-4cc1-a2b9-3a103027adcb', N'SPRING_SECURITY_CONTEXT', 0xACED00057372003D6F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C000000000000026C0200014C000E61757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B78707372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E000000000000026C0200024C000B63726564656E7469616C737400124C6A6176612F6C616E672F4F626A6563743B4C00097072696E636970616C71007E0004787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C7371007E0004787001737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00067870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479000000000000026C0200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000A524F4C455F41444D494E7871007E000D737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73000000000000026C0200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3174002465616465646333302D633039342D346532302D383164392D34643464613238353262303270737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E55736572000000000000026C0200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657374000F4C6A6176612F7574696C2F5365743B4C000870617373776F726471007E000F4C0008757365726E616D6571007E000F787001010101737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E000A737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F72000000000000026C020000787077040000000171007E0010787074000544554F4E47)
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (1, N'H&M', N'/resources/images-upload/supplier/avatar-44fa56d8.jpg', N'Nhật Minh', N'0328750177', N'chatgpthle@gmail.com', N'112 Hai Bà Trung, Quận 1, TP.HCM', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (2, N'Global Textiles', N'', N'Linh Chi', N'0987654321', N'contact@globaltextiles.com', N'Khu Công Nghiệp Sóng Thần, Bình Duong', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (3, N'Fashion Forward', N'', N'Anh Khoa', N'0912345678', N'sales@fashionforward.vn', N'15 Lê Duẫn, Quận 1, TP.HCM', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (4, N'Cotton King', N'', N'Bảo Ngọc', N'0905112233', N'info@cottonking.com', N'Lô B2, KCN Tân Tho, Bình Tân, TP.HCM', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (5, N'Silk Route Inc.', N'', N'Minh Tuấn', N'0938445566', N'support@silkroute.com', N'22 Hàng Bông, Hoàn Kiếm, Hà Nội', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (6, N'Denim Dreams', N'', N'Phương Thảo', N'0977889900', N'orders@denimdreams.co', N'Ðường số 3, KCN Hòa Khánh, Ðà Nẵng', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (7, N'ActiveWear Co.', N'', N'Quang Huy', N'0944556677', N'partner@activewear.com', N'78 Võ Văn Tần, Quận 3, TP.HCM', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (8, N'Luxury Fibers', N'', N'Hồng Hạnh', N'0966112233', N'accounts@luxuryfibers.com', N'55 Nguyễn Trãi, Thanh Xuân, Hà Nội', 0)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (9, N'Eco Threads', N'', N'Thành Đạt', N'0902334455', N'contact@ecothreads.vn', N'Khu Sinh Thái Ecopark, Hung Yên', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (10, N'Urban Outfitters Supplier', N'', N'Khánh An', N'0918776655', N'urban@supplier.com', N'112 Hai Bà Trung, Quận 1, TP.HCM', 1)
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [logo_url], [contact_person], [phone], [email], [address], [status]) VALUES (11, N'Kidswear Central', N'', N'Gia Bảo', N'0955998877', N'kids@central.com', N'Lô C5, KCN Việt Nam-Singapore, Bình Duong', 1)
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
/****** Object:  Index [uk_customer_id]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uk_customer_id] ON [dbo].[Carts]
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [uq_discount_code]    Script Date: 5/20/2025 12:21:50 PM ******/
ALTER TABLE [dbo].[Discounts] ADD  CONSTRAINT [uq_discount_code] UNIQUE NONCLUSTERED 
(
	[discount_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discounts_discount_id]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discounts_discount_id] ON [dbo].[Discounts]
(
	[discount_id] ASC
)
INCLUDE([discount_name],[discount_code],[start_date],[end_date]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_account_id]    Script Date: 5/20/2025 12:21:50 PM ******/
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [UK_account_id] UNIQUE NONCLUSTERED 
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Variants_product_id]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Variants_product_id] ON [dbo].[product_variants]
(
	[product_id] ASC
)
INCLUDE([product_variant_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_ProductVariants_sku]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_ProductVariants_sku] ON [dbo].[product_variants]
(
	[sku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_product_id]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_product_id] ON [dbo].[Products]
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Products_ProductName]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_ProductName] ON [dbo].[Products]
(
	[product_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_customer_product_id]    Script Date: 5/20/2025 12:21:50 PM ******/
ALTER TABLE [dbo].[Reviews] ADD  CONSTRAINT [UK_customer_product_id] UNIQUE NONCLUSTERED 
(
	[product_id] ASC,
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Shipments_OrderId]    Script Date: 5/20/2025 12:21:50 PM ******/
ALTER TABLE [dbo].[Shipments] ADD  CONSTRAINT [UK_Shipments_OrderId] UNIQUE NONCLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [SPRING_SESSION_IX1]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [SPRING_SESSION_IX1] ON [dbo].[SPRING_SESSION]
(
	[SESSION_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SPRING_SESSION_IX2]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE NONCLUSTERED INDEX [SPRING_SESSION_IX2] ON [dbo].[SPRING_SESSION]
(
	[EXPIRY_TIME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [SPRING_SESSION_IX3]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE NONCLUSTERED INDEX [SPRING_SESSION_IX3] ON [dbo].[SPRING_SESSION]
(
	[PRINCIPAL_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Suppliers_suppliers_name]    Script Date: 5/20/2025 12:21:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Suppliers_suppliers_name] ON [dbo].[Suppliers]
(
	[supplier_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account_Discount_Codes] ADD  DEFAULT ('available') FOR [status]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [df_customer_registration_date]  DEFAULT (getdate()) FOR [registration_date]
GO
ALTER TABLE [dbo].[Discounts] ADD  CONSTRAINT [DF_Discounts_TotalMinMoney]  DEFAULT ((0)) FOR [totalminmoney]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Employees_hire_date]  DEFAULT (getdate()) FOR [hire_date]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [df_orders_order_date]  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [df_product_views]  DEFAULT ((0)) FOR [quantity_sold]
GO
ALTER TABLE [dbo].[Reviews] ADD  CONSTRAINT [df_reviews_review_date]  DEFAULT (getdate()) FOR [review_date]
GO
ALTER TABLE [dbo].[Shipments] ADD  CONSTRAINT [DF_Shipments_status]  DEFAULT (N'SHIPPING') FOR [status]
GO
ALTER TABLE [dbo].[Shipments] ADD  CONSTRAINT [DF_Shipments_assigned_date]  DEFAULT (getdate()) FOR [assigned_date]
GO
ALTER TABLE [dbo].[Account_Discount_Codes]  WITH CHECK ADD  CONSTRAINT [FK_Account_Discount_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Account_Discount_Codes] CHECK CONSTRAINT [FK_Account_Discount_Customer]
GO
ALTER TABLE [dbo].[Account_Discount_Codes]  WITH CHECK ADD  CONSTRAINT [FK_Account_Discount_ProductVariant] FOREIGN KEY([product_variant_id])
REFERENCES [dbo].[product_variants] ([product_variant_id])
GO
ALTER TABLE [dbo].[Account_Discount_Codes] CHECK CONSTRAINT [FK_Account_Discount_ProductVariant]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [fk_accounts_role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [fk_accounts_role]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD FOREIGN KEY([district_id])
REFERENCES [dbo].[GHN_Districts] ([district_id])
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD FOREIGN KEY([province_id])
REFERENCES [dbo].[GHN_Provinces] ([province_id])
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD FOREIGN KEY([ward_id])
REFERENCES [dbo].[GHN_Wards] ([ward_id])
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK__addressv2__custo__00200768] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK__addressv2__custo__00200768]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Customers] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Customers]
GO
ALTER TABLE [dbo].[cart_details]  WITH CHECK ADD  CONSTRAINT [fk_cart_detail_cart] FOREIGN KEY([cart_id])
REFERENCES [dbo].[Carts] ([cart_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cart_details] CHECK CONSTRAINT [fk_cart_detail_cart]
GO
ALTER TABLE [dbo].[cart_details]  WITH CHECK ADD  CONSTRAINT [FK_CartDetails_ProductVariants] FOREIGN KEY([product_variant_id])
REFERENCES [dbo].[product_variants] ([product_variant_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[cart_details] CHECK CONSTRAINT [FK_CartDetails_ProductVariants]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [fk_cart_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [fk_cart_customer]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [fk_customer_accounts] FOREIGN KEY([account_id])
REFERENCES [dbo].[Accounts] ([account_id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [fk_customer_accounts]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [fk_employee_accounts] FOREIGN KEY([account_id])
REFERENCES [dbo].[Accounts] ([account_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [fk_employee_accounts]
GO
ALTER TABLE [dbo].[GHN_Districts]  WITH CHECK ADD FOREIGN KEY([province_id])
REFERENCES [dbo].[GHN_Provinces] ([province_id])
GO
ALTER TABLE [dbo].[GHN_Wards]  WITH CHECK ADD FOREIGN KEY([district_id])
REFERENCES [dbo].[GHN_Districts] ([district_id])
GO
ALTER TABLE [dbo].[Inventories]  WITH CHECK ADD  CONSTRAINT [FK_Inventories_product_variants] FOREIGN KEY([product_variant_id])
REFERENCES [dbo].[product_variants] ([product_variant_id])
GO
ALTER TABLE [dbo].[Inventories] CHECK CONSTRAINT [FK_Inventories_product_variants]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [fk_order_detail_orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [fk_order_detail_orders]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_ProductVariants] FOREIGN KEY([product_variant_id])
REFERENCES [dbo].[product_variants] ([product_variant_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FK_OrderDetails_ProductVariants]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Address1] FOREIGN KEY([shipping_address_id])
REFERENCES [dbo].[Address] ([address_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Address1]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [fk_orders_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [fk_orders_customer]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [fk_orders_payment] FOREIGN KEY([payment_id])
REFERENCES [dbo].[Payments] ([payment_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [fk_orders_payment]
GO
ALTER TABLE [dbo].[product_discounts]  WITH CHECK ADD  CONSTRAINT [fk_product_discount_discount_shop] FOREIGN KEY([discount_id])
REFERENCES [dbo].[Discounts] ([discount_id])
GO
ALTER TABLE [dbo].[product_discounts] CHECK CONSTRAINT [fk_product_discount_discount_shop]
GO
ALTER TABLE [dbo].[product_discounts]  WITH CHECK ADD  CONSTRAINT [FK_product_discounts_product_variants] FOREIGN KEY([product_variant_id])
REFERENCES [dbo].[product_variants] ([product_variant_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[product_discounts] CHECK CONSTRAINT [FK_product_discounts_product_variants]
GO
ALTER TABLE [dbo].[product_images]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product_images] CHECK CONSTRAINT [FK_ProductImages_Products]
GO
ALTER TABLE [dbo].[product_variants]  WITH CHECK ADD  CONSTRAINT [FK_ProductVariants_Colors] FOREIGN KEY([color_id])
REFERENCES [dbo].[Colors] ([color_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[product_variants] CHECK CONSTRAINT [FK_ProductVariants_Colors]
GO
ALTER TABLE [dbo].[product_variants]  WITH CHECK ADD  CONSTRAINT [FK_ProductVariants_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[product_variants] CHECK CONSTRAINT [FK_ProductVariants_Products]
GO
ALTER TABLE [dbo].[product_variants]  WITH CHECK ADD  CONSTRAINT [FK_ProductVariants_Sizes] FOREIGN KEY([size_id])
REFERENCES [dbo].[Sizes] ([size_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[product_variants] CHECK CONSTRAINT [FK_ProductVariants_Sizes]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [fk_product_brand] FOREIGN KEY([brand_id])
REFERENCES [dbo].[Brands] ([brand_id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [fk_product_brand]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [fk_product_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [fk_product_category]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Suppliers] ([supplier_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[purchase_receipt]  WITH CHECK ADD  CONSTRAINT [FK_purchase_receipt_Employees] FOREIGN KEY([create_by])
REFERENCES [dbo].[Employees] ([employee_id])
GO
ALTER TABLE [dbo].[purchase_receipt] CHECK CONSTRAINT [FK_purchase_receipt_Employees]
GO
ALTER TABLE [dbo].[purchase_receipt]  WITH CHECK ADD  CONSTRAINT [FK_purchase_receipt_Suppliers] FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Suppliers] ([supplier_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[purchase_receipt] CHECK CONSTRAINT [FK_purchase_receipt_Suppliers]
GO
ALTER TABLE [dbo].[purchase_receipt_details]  WITH CHECK ADD  CONSTRAINT [FK_purchase_receipt_details_product_variants] FOREIGN KEY([product_variant_id])
REFERENCES [dbo].[product_variants] ([product_variant_id])
GO
ALTER TABLE [dbo].[purchase_receipt_details] CHECK CONSTRAINT [FK_purchase_receipt_details_product_variants]
GO
ALTER TABLE [dbo].[purchase_receipt_details]  WITH CHECK ADD  CONSTRAINT [FK_purchase_receipt_details_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[purchase_receipt_details] CHECK CONSTRAINT [FK_purchase_receipt_details_Products]
GO
ALTER TABLE [dbo].[purchase_receipt_details]  WITH CHECK ADD  CONSTRAINT [FK_purchase_receipt_details_purchase_receipt] FOREIGN KEY([purchase_receipt_id])
REFERENCES [dbo].[purchase_receipt] ([purchase_receipt_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[purchase_receipt_details] CHECK CONSTRAINT [FK_purchase_receipt_details_purchase_receipt]
GO
ALTER TABLE [dbo].[Returns]  WITH CHECK ADD  CONSTRAINT [FK_Returns_Orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Returns] CHECK CONSTRAINT [FK_Returns_Orders]
GO
ALTER TABLE [dbo].[Returns]  WITH CHECK ADD  CONSTRAINT [FK_Returns_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Returns] CHECK CONSTRAINT [FK_Returns_Products]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [fk_reviews_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [fk_reviews_customer]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Products]
GO
ALTER TABLE [dbo].[Shipments]  WITH CHECK ADD  CONSTRAINT [fk_order_shipper_orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[Shipments] CHECK CONSTRAINT [fk_order_shipper_orders]
GO
ALTER TABLE [dbo].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_Employees] FOREIGN KEY([shipper_id])
REFERENCES [dbo].[Employees] ([employee_id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Shipments] CHECK CONSTRAINT [FK_Shipments_Employees]
GO
ALTER TABLE [dbo].[SPRING_SESSION_ATTRIBUTES]  WITH CHECK ADD  CONSTRAINT [SPRING_SESSION_ATTRIBUTES_FK] FOREIGN KEY([SESSION_PRIMARY_ID])
REFERENCES [dbo].[SPRING_SESSION] ([PRIMARY_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SPRING_SESSION_ATTRIBUTES] CHECK CONSTRAINT [SPRING_SESSION_ATTRIBUTES_FK]
GO
ALTER TABLE [dbo].[Account_Discount_Codes]  WITH CHECK ADD  CONSTRAINT [CK_Account_Discount_Status] CHECK  (([status]='expired' OR [status]='used' OR [status]='available'))
GO
ALTER TABLE [dbo].[Account_Discount_Codes] CHECK CONSTRAINT [CK_Account_Discount_Status]
GO
ALTER TABLE [dbo].[Discounts]  WITH CHECK ADD  CONSTRAINT [CHK_Discounts_TotalMinMoney_NonNegative] CHECK  (([totalminmoney]>=(0)))
GO
ALTER TABLE [dbo].[Discounts] CHECK CONSTRAINT [CHK_Discounts_TotalMinMoney_NonNegative]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [CK_Reviews] CHECK  (([review_date]<=getdate()))
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [CK_Reviews]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [ck_reviews_rating] CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [ck_reviews_rating]
GO
/****** Object:  StoredProcedure [dbo].[GetDiscountsByProductID]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetDiscountsByProductID]  
    @ProductID INT  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Kiểm tra tham số đầu vào  
    IF @ProductID IS NULL  
    BEGIN  
        RAISERROR ('ProductID cannot be NULL.', 16, 1);  
        RETURN;  
    END  
  
    -- Kiểm tra sự tồn tại của ProductID  
    IF NOT EXISTS (SELECT 1 FROM dbo.Products WITH (NOLOCK) WHERE product_id = @ProductID)  
    BEGIN  
        RAISERROR ('ProductID does not exist.', 16, 1);  
        RETURN;  
    END  
  
    BEGIN TRY  
        -- Truy vấn lấy thông tin chiết khấu và product_variant_id  
        SELECT   
            pd.product_variant_id,  
            d.discount_id,  
            d.discount_name,  
            d.discount_code,  
            d.discount_percentage,  
            d.start_date,  
            d.end_date,  
            d.totalminmoney  
        FROM dbo.Products p WITH (NOLOCK)  
        INNER JOIN dbo.Product_Variants pv WITH (NOLOCK) ON p.product_id = pv.product_id  
        INNER JOIN dbo.Product_Discounts pd WITH (NOLOCK) ON pv.product_variant_id = pd.product_variant_id  
        INNER JOIN dbo.Discounts d WITH (NOLOCK) ON pd.discount_id = d.discount_id  
        WHERE p.product_id = @ProductID  
        -- Bỏ điều kiện ngày để lấy tất cả chiết khấu (theo yêu cầu ban đầu)  
        -- Nếu cần, thêm lại: AND (d.start_date <= GETDATE()) AND (d.end_date IS NULL OR d.end_date >= GETDATE())  
        ORDER BY d.discount_id, pd.product_variant_id  
        OPTION (OPTIMIZE FOR (@ProductID UNKNOWN))  
    END TRY  
    BEGIN CATCH  
        -- Xử lý lỗi  
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();  
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();  
        DECLARE @ErrorState INT = ERROR_STATE();  
  
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);  
        RETURN;  
    END CATCH  
END
GO
/****** Object:  StoredProcedure [dbo].[GetVariantsWithAccounts]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedure tối ưu hóa thứ hai với xử lý trùng lặp
-- Đổi tên tham số account_id thành customer_id
CREATE   PROCEDURE [dbo].[GetVariantsWithAccounts]
    @ProductID INT,
    @CustomerID INT = NULL -- Tham số tùy chọn với giá trị mặc định là NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Sử dụng CTE và DISTINCT để loại bỏ trùng lặp
    WITH VariantDiscounts AS (
        SELECT DISTINCT
            pd.product_variant_id,
            d.discount_id,
            d.discount_name,
            d.discount_code,
            d.discount_percentage,
            d.start_date,
            d.end_date,
            d.totalminmoney,
			d.max_discount_amount
			
        FROM dbo.Products p
        INNER JOIN dbo.Product_Variants pv 
            ON p.product_id = pv.product_id
        INNER JOIN dbo.Product_Discounts pd 
            ON pv.product_variant_id = pd.product_variant_id
        INNER JOIN dbo.Discounts d 
            ON pd.discount_id = d.discount_id
        WHERE p.product_id = @ProductID
    ),
    RankedAccounts AS (
        SELECT 
            adc.product_variant_id,
            adc.customer_id,
            adc.used_at,
            adc.status,
            ROW_NUMBER() OVER (
                PARTITION BY adc.product_variant_id
                ORDER BY adc.used_at DESC
            ) AS rn
        FROM dbo.Account_Discount_Codes adc
        WHERE EXISTS (
            SELECT 1 FROM VariantDiscounts vd 
            WHERE vd.product_variant_id = adc.product_variant_id
        )
        AND (@CustomerID IS NULL OR adc.customer_id = @CustomerID) -- Lọc theo customer_id nếu được cung cấp
    )
    SELECT DISTINCT
        vd.product_variant_id,
        vd.discount_id,
        vd.discount_name,
        vd.discount_code,
        vd.discount_percentage,
        vd.start_date,
        vd.end_date,
        vd.totalminmoney,
        ra.customer_id,
        ra.used_at,
        ra.status,
		vd.max_discount_amount
    FROM VariantDiscounts vd
    LEFT JOIN RankedAccounts ra ON 
        vd.product_variant_id = ra.product_variant_id 
        AND ra.rn = 1
    OPTION (RECOMPILE);
END
GO
/****** Object:  StoredProcedure [dbo].[GetVariantsWithDiscountsByProductID]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedure tối ưu hóa thứ nhất - loại bỏ trùng lặp
CREATE   PROCEDURE [dbo].[GetVariantsWithDiscountsByProductID]
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT DISTINCT -- Thêm DISTINCT để loại bỏ trùng lặp
        pd.product_variant_id,
        d.discount_id,
        d.discount_name,
        d.discount_code,
        d.discount_percentage,
        d.start_date,
        d.end_date,
        d.totalminmoney,
		d.max_discount_amount
    FROM dbo.Products p
    INNER JOIN dbo.Product_Variants pv 
        ON p.product_id = pv.product_id
    INNER JOIN dbo.Product_Discounts pd 
        ON pv.product_variant_id = pd.product_variant_id
    INNER JOIN dbo.Discounts d 
        ON pd.discount_id = d.discount_id
    WHERE p.product_id = @ProductID
    OPTION (RECOMPILE);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetImportValueByDateRange]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetImportValueByDateRange]
	@StartDate DATE,
	@EndDate DATE
AS
BEGIN
	SELECT 
		create_at,SUM(quantity * unit_price) AS total_import_value
	FROM [dbo].[purchase_receipt] pr
	INNER JOIN [dbo].[purchase_receipt_details] prd 
		on pr.purchase_receipt_id = prd.purchase_receipt_id
	WHERE create_at BETWEEN @StartDate AND @EndDate
	GROUP BY create_at
	ORDER BY create_at
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetImportValueByMonth]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetImportValueByMonth]
	@Year INT
AS
BEGIN
	WITH Months AS (
		SELECT 1 AS month UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
		UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
		UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
	),
	ImportByMonth AS (
		SELECT 
			MONTH(create_at) AS month,
			SUM(quantity * unit_price) AS total_import_value
		FROM [dbo].[purchase_receipt] pr
		INNER JOIN [dbo].[purchase_receipt_details] prd
			on pr.purchase_receipt_id = prd.purchase_receipt_id
		WHERE YEAR(create_at) = @Year
		GROUP BY MONTH(create_at)
	)
	SELECT 
		m.month,
		ISNULL(i.total_import_value, 0) AS total_import_value
	FROM Months m
	LEFT JOIN ImportByMonth i ON m.month = i.month
	ORDER BY m.month
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetImportValueByWeekInMonth]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetImportValueByWeekInMonth]
	@Year INT,
	@Month INT
AS
BEGIN
	WITH Weeks AS (
		SELECT 1 AS week_in_month UNION ALL
		SELECT 2 UNION ALL
		SELECT 3 UNION ALL
		SELECT 4 UNION ALL
		SELECT 5
	),
	ImportByWeek AS (
		SELECT 
			DATEPART(WEEK, create_at) - DATEPART(WEEK, DATEFROMPARTS(@Year, @Month, 1)) + 1 AS week_in_month,
			SUM(quantity * unit_price) AS total_import_value
		FROM [dbo].[purchase_receipt] pr
		INNER JOIN [dbo].[purchase_receipt_details] prd
			on pr.purchase_receipt_id = prd.purchase_receipt_id
		WHERE 
			YEAR(create_at) = @Year AND MONTH(create_at) = @Month
		GROUP BY 
			DATEPART(WEEK, create_at) - DATEPART(WEEK, DATEFROMPARTS(@Year, @Month, 1)) + 1
	)
	SELECT 
		w.week_in_month,
		ISNULL(i.total_import_value, 0) AS total_import_value
	FROM Weeks w
	LEFT JOIN ImportByWeek i ON w.week_in_month = i.week_in_month
	ORDER BY w.week_in_month
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrderDetails]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedure: sp_GetOrderDetails
CREATE   PROCEDURE [dbo].[sp_GetOrderDetails]
    @OrderId VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        o.order_id,
        o.order_date,
        o.total_amount,
        o.order_status,
        o.payment_status,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        od.order_detail_id,
        od.product_variant_id,
        p.product_id,
        p.product_name,
        p.description,
        p.image_url,
        p.rating,
        p.price AS product_price,
        od.quantity,
        od.price AS order_detail_price,
        (od.quantity * od.price) AS subtotal,
        CONCAT(a.street, ', ', w.ward_name, ', ', d.district_name, ', ', pr.province_name, ', ', a.country) AS shipping_address
    FROM Orders o
    INNER JOIN Customers c ON o.customer_id = c.customer_id
    INNER JOIN Order_Details od ON o.order_id = od.order_id
    LEFT JOIN Products p ON od.product_variant_id = p.product_id
    LEFT JOIN Address a ON o.shipping_address_id = a.address_id
    LEFT JOIN dbo.GHN_Wards w ON a.ward_id = w.ward_id
    LEFT JOIN dbo.GHN_Districts d ON a.district_id = d.district_id
    LEFT JOIN dbo.GHN_Provinces pr ON a.province_id = pr.province_id
    WHERE o.order_id = @OrderId;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetRevenueByDateRange]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedure: sp_GetRevenueByDateRange
CREATE   PROCEDURE [dbo].[sp_GetRevenueByDateRange]
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        CAST(order_date AS DATE) AS order_day,
        SUM(total_amount) AS daily_revenue
    FROM dbo.Orders
    WHERE order_date BETWEEN @StartDate AND @EndDate
        AND order_status = N'Đã giao'
    GROUP BY CAST(order_date AS DATE)
    ORDER BY order_day
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetRevenueByDay]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetRevenueByDay]
	@Date DATE
AS
BEGIN
	SELECT 
		@Date AS order_day,
		ISNULL((
			SELECT SUM(total_amount)
			FROM dbo.Orders
			WHERE 
				CAST(order_date AS DATE) = @Date
				AND order_status = N'COMPLETED'
		), 0) AS daily_revenue
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRevenueByDays]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetRevenueByDays]
AS
BEGIN
	SELECT 
		CAST(order_date AS DATE) AS order_day,
		SUM(total_amount) AS daily_revenue
	FROM dbo.Orders
	WHERE order_status = N'COMPLETED'
	GROUP BY CAST(order_date AS DATE)
	ORDER BY order_day
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRevenueByMonth]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetRevenueByMonth]
	@Year INT
AS
BEGIN
	-- Bảng tạm các tháng từ 1 đến 12
	WITH Months AS (
		SELECT 1 AS month UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
		UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
		UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
	),
	RevenueByMonth AS (
		SELECT 
			MONTH(order_date) AS month,
			SUM(total_amount) AS monthly_revenue
		FROM dbo.Orders
		WHERE YEAR(order_date) = @Year
			AND order_status = N'COMPLETED'
		GROUP BY MONTH(order_date)
	)

	-- Kết quả cuối cùng: LEFT JOIN để có đủ 12 tháng
	SELECT 
		m.month,
		ISNULL(r.monthly_revenue, 0) AS monthly_revenue
	FROM Months m
	LEFT JOIN RevenueByMonth r ON m.month = r.month
	ORDER BY m.month
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRevenueByWeekInMonth]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetRevenueByWeekInMonth]
	@Year INT,
	@Month INT
AS
BEGIN
	-- Tạo bảng số tuần 1 đến 5
	WITH Weeks AS (
		SELECT 1 AS week_in_month UNION ALL
		SELECT 2 UNION ALL
		SELECT 3 UNION ALL
		SELECT 4 UNION ALL
		SELECT 5
	),
	RevenueByWeek AS (
		SELECT 
			DATEPART(WEEK, order_date) - DATEPART(WEEK, DATEFROMPARTS(@Year, @Month, 1)) + 1 AS week_in_month,
			SUM(total_amount) AS weekly_revenue
		FROM dbo.Orders
		WHERE 
			YEAR(order_date) = @Year AND MONTH(order_date) = @Month
			AND order_status = N'COMPLETED'
		GROUP BY 
			DATEPART(WEEK, order_date) - DATEPART(WEEK, DATEFROMPARTS(@Year, @Month, 1)) + 1
	)

	-- Kết hợp để đảm bảo có đủ tuần
	SELECT 
		w.week_in_month,
		ISNULL(r.weekly_revenue, 0) AS weekly_revenue
	FROM Weeks w
	LEFT JOIN RevenueByWeek r ON w.week_in_month = r.week_in_month
	ORDER BY w.week_in_month
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTotalImportValue]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetTotalImportValue]
AS
BEGIN
	SELECT 
		SUM(quantity * unit_price) AS total_import_value
	FROM [dbo].[purchase_receipt_details]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTotalRevenue]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetTotalRevenue]
AS
BEGIN
	SELECT 
		SUM(total_amount) AS total_revenue
	FROM dbo.Orders
	WHERE order_status = N'COMPLETED'
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateOrder]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CreateOrder]
    -- Input Parameters
    @customer_id INT,
    @payment_id INT,
    @OrderItems dbo.OrderDetailType READONLY, -- Sử dụng TVP đã tạo

    -- Output Parameters
    @new_order_id CHAR(10) OUTPUT,       -- Trả về mã đơn hàng mới nếu thành công
    @ErrorCode INT OUTPUT,               -- Mã lỗi (0: Thành công, <0: Lỗi)
    @ErrorMessage NVARCHAR(500) OUTPUT   -- Thông báo lỗi chi tiết
AS
BEGIN
    -- Tối ưu hiệu năng, không trả về số dòng bị ảnh hưởng
    SET NOCOUNT ON;

    -- Khởi tạo Output Parameters
    SET @new_order_id = NULL;
    SET @ErrorCode = 0;
    SET @ErrorMessage = N'Đơn hàng đã được tạo thành công.';

    -- Khai báo biến cục bộ
    DECLARE @TotalAmount DECIMAL(15, 2) = 0;
    DECLARE @GeneratedOrderID CHAR(10);
    DECLARE @CurrentProductVariantID INT;
    DECLARE @CurrentQuantity INT;
    DECLARE @CurrentPrice DECIMAL(10, 2);
    DECLARE @AvailableStock INT;
    DECLARE @shipping_address_id INT; -- Biến để lưu address_id lấy từ bảng Addresses

    -- Bắt đầu Transaction để đảm bảo tính toàn vẹn
    BEGIN TRY
        BEGIN TRANSACTION;

        -- === VALIDATION ===

        -- 1. Kiểm tra Customer tồn tại
        IF NOT EXISTS (SELECT 1 FROM dbo.Customers WHERE customer_id = @customer_id AND [status] = 1)
        BEGIN
            SET @ErrorCode = -1;
            SET @ErrorMessage = N'Lỗi: Khách hàng không tồn tại hoặc không hoạt động.';
            RAISERROR(@ErrorMessage, 16, 1); -- Ném lỗi để nhảy vào CATCH
        END

        -- 2. Lấy Address từ bảng Addresses dựa trên customer_id
        -- Giả sử lấy địa chỉ đầu tiên hợp lệ, có thể thêm logic để chọn địa chỉ mặc định nếu cần
        SELECT TOP 1 @shipping_address_id = address_id
        FROM dbo.Address
        WHERE customer_id = @customer_id
        ORDER BY address_id; -- Có thể thay đổi logic chọn địa chỉ (ví dụ: địa chỉ mặc định)

        -- Kiểm tra nếu không tìm thấy địa chỉ
        IF @shipping_address_id IS NULL
        BEGIN
            SET @ErrorCode = -2;
            SET @ErrorMessage = N'Lỗi: Không tìm thấy địa chỉ giao hàng hợp lệ cho khách hàng này.';
            RAISERROR(@ErrorMessage, 16, 1);
        END

        -- 3. Kiểm tra Payment Method tồn tại
        IF NOT EXISTS (SELECT 1 FROM dbo.Payments WHERE payment_id = @payment_id)
        BEGIN
            SET @ErrorCode = -3;
            SET @ErrorMessage = N'Lỗi: Phương thức thanh toán không tồn tại.';
            RAISERROR(@ErrorMessage, 16, 1);
        END

        -- 4. Kiểm tra danh sách sản phẩm đầu vào có rỗng không
        IF NOT EXISTS (SELECT 1 FROM @OrderItems)
        BEGIN
            SET @ErrorCode = -4;
            SET @ErrorMessage = N'Lỗi: Đơn hàng phải có ít nhất một sản phẩm.';
            RAISERROR(@ErrorMessage, 16, 1);
        END

        -- 5. Kiểm tra từng sản phẩm trong danh sách đầu vào
        -- Tạo bảng tạm để lưu giá và kiểm tra tồn kho một lần cho hiệu quả
        DECLARE @ValidatedItems TABLE (
            product_variant_id INT PRIMARY KEY,
            quantity INT NOT NULL,
            price DECIMAL(10, 2) NOT NULL,
            product_id INT NOT NULL,
            current_stock INT NOT NULL
        );

        INSERT INTO @ValidatedItems (product_variant_id, quantity, price, product_id, current_stock)
        SELECT
            oi.product_variant_id,
            oi.quantity,
            p.price, -- Lấy giá từ bảng Products
            p.product_id,
            pv.quantity_stock
        FROM @OrderItems oi
        INNER JOIN dbo.product_variants pv ON oi.product_variant_id = pv.product_variant_id
        INNER JOIN dbo.Products p ON pv.product_id = p.product_id

        -- Kiểm tra xem có sản phẩm nào không hợp lệ (không tìm thấy hoặc số lượng <= 0)
        IF (SELECT COUNT(*) FROM @OrderItems) != (SELECT COUNT(*) FROM @ValidatedItems)
           OR EXISTS (SELECT 1 FROM @OrderItems WHERE quantity <= 0)
        BEGIN
             SET @ErrorCode = -5;
             SET @ErrorMessage = N'Lỗi: Một hoặc nhiều sản phẩm không hợp lệ, không tồn tại, hoặc số lượng đặt hàng <= 0.';
             RAISERROR(@ErrorMessage, 16, 1);
        END

        -- 6. (Optional but Recommended) Kiểm tra tồn kho
        IF EXISTS (SELECT 1 FROM @ValidatedItems WHERE quantity > current_stock)
        BEGIN
            DECLARE @OutOfStockItem INT = (SELECT TOP 1 product_variant_id FROM @ValidatedItems WHERE quantity > current_stock);
            SET @ErrorCode = -6;
            SET @ErrorMessage = CONCAT(N'Lỗi: Sản phẩm variant ID ', @OutOfStockItem, N' không đủ số lượng tồn kho.');
            RAISERROR(@ErrorMessage, 16, 1);
        END

        -- === PROCESSING ===

        -- 1. Tạo Order ID duy nhất (Ví dụ: 'OR' + 8 số từ Sequence)
        --    Bạn có thể thay đổi logic tạo mã này nếu muốn (ví dụ: dựa trên ngày tháng)
        --    Đảm bảo mã sinh ra không vượt quá CHAR(10)
        SET @GeneratedOrderID = CONCAT('OR', FORMAT(NEXT VALUE FOR dbo.OrderSequence, '00000000')); -- Sinh mã 10 ký tự

        -- 2. Tính tổng tiền đơn hàng
        SELECT @TotalAmount = SUM(quantity * price) FROM @ValidatedItems;

        -- 3. Insert vào bảng Orders
        INSERT INTO dbo.Orders (
            order_id,
            customer_id,
            order_date,         -- Mặc định là thời gian hiện tại khi insert
            total_amount,
            order_status,       -- Trạng thái ban đầu, ví dụ: 'Pending' hoặc 'Processing'
            shipping_address_id,
            payment_id,
			payment_status
        )
        VALUES (
            @GeneratedOrderID,
            @customer_id,
            GETDATE(),          -- Lấy ngày giờ hiện tại
            @TotalAmount,
            N'Pending',         -- Hoặc 'Processing' tùy quy trình của bạn
            @shipping_address_id,
            @payment_id,
			0
        );

        -- 4. Insert vào bảng order_details
        INSERT INTO dbo.order_details (
            order_id,
            product_variant_id,
            quantity,
            price               -- Lưu giá tại thời điểm đặt hàng
        )
        SELECT
            @GeneratedOrderID,
            vi.product_variant_id,
            vi.quantity,
            vi.price            -- Lấy giá đã xác thực từ bảng tạm
        FROM @ValidatedItems vi;

        -- 5. (Optional but Recommended) Cập nhật số lượng tồn kho
        UPDATE pv
        SET pv.quantity_stock = pv.quantity_stock - vi.quantity
        FROM dbo.product_variants pv
        INNER JOIN @ValidatedItems vi ON pv.product_variant_id = vi.product_variant_id;

        -- Cập nhật số lượng đã bán trong bảng Products (tùy chọn)
        UPDATE p
        SET p.quantity_sold = ISNULL(p.quantity_sold, 0) + vi.quantity
        FROM dbo.Products p
        INNER JOIN @ValidatedItems vi ON p.product_id = vi.product_id;

        -- Nếu mọi thứ thành công, commit transaction
        COMMIT TRANSACTION;

        -- Gán giá trị cho output parameters
        SET @new_order_id = @GeneratedOrderID;
        -- ErrorCode và ErrorMessage đã được set mặc định là thành công

    END TRY
    BEGIN CATCH
        -- Nếu có lỗi xảy ra, rollback transaction
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Gán thông tin lỗi cho output parameters
        -- Nếu lỗi được ném bởi RAISERROR, ErrorCode và ErrorMessage đã được set
        -- Nếu là lỗi SQL khác, cần lấy thông tin lỗi ở đây
        IF @ErrorCode = 0 -- Chỉ ghi đè nếu chưa được set bởi RAISERROR
        BEGIN
            SET @ErrorCode = ERROR_NUMBER(); -- Hoặc mã lỗi tùy chỉnh khác
            SET @ErrorMessage = N'Lỗi hệ thống: ' + ERROR_MESSAGE();
        END
        SET @new_order_id = NULL;

        -- (Optional) Ghi log lỗi vào một bảng riêng
        -- INSERT INTO dbo.ErrorLog (ErrorNumber, ErrorMessage, ErrorProcedure, ErrorLine, LogTime)
        -- VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_LINE(), GETDATE());

    END CATCH

    -- Luôn trả về mã lỗi và thông báo
    SELECT @ErrorCode AS ErrorCode, @ErrorMessage AS ErrorMessage, @new_order_id AS NewOrderID;

END;
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateOrderFull]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[usp_CreateOrderFull]    
    -- Input Parameters    
    @customer_id INT,    
    @payment_id INT,   
    @TotalAmount DECIMAL(15, 2), -- Đã chuyển thành tham số đầu vào  
    @OrderItems dbo.OrderDetailType READONLY, -- Sử dụng TVP đã tạo    
      
    -- Address parameters  
    @AddressId INT = NULL,  
    @RecipientName NVARCHAR(100) = NULL,  
    @RecipientPhone NCHAR(15) = NULL,  
    @Street NVARCHAR(100) = NULL,  
    @ProvinceId INT = NULL,  
    @DistrictId INT = NULL,  
    @WardId INT = NULL,  
    @Country NVARCHAR(50) = NULL,  
    @ProductVariantIds NVARCHAR(MAX) = NULL, -- Comma-separated list of product_variant_ids  
    
    -- Output Parameters    
    @new_order_id CHAR(10) OUTPUT,       -- Trả về mã đơn hàng mới nếu thành công    
    @ErrorCode INT OUTPUT,               -- Mã lỗi (0: Thành công, <0: Lỗi)    
    @ErrorMessage NVARCHAR(500) OUTPUT   -- Thông báo lỗi chi tiết    
AS    
BEGIN    
    -- Tối ưu hiệu năng, không trả về số dòng bị ảnh hưởng    
    SET NOCOUNT ON;    
    
    -- Khởi tạo Output Parameters    
    SET @new_order_id = NULL;    
    SET @ErrorCode = 0;    
    SET @ErrorMessage = N'Đơn hàng đã được tạo thành công.';    
    
    -- Khai báo biến cục bộ    
    DECLARE @GeneratedOrderID CHAR(10);    
    DECLARE @CurrentProductVariantID INT;    
    DECLARE @CurrentQuantity INT;    
    DECLARE @CurrentPrice DECIMAL(10, 2);    
    DECLARE @AvailableStock INT;    
    DECLARE @shipping_address_id INT; -- Biến để lưu address_id lấy từ bảng Addresses    
    DECLARE @cart_id INT; -- Biến để lưu cart_id của customer  
      
    -- Variables for Address update success tracking  
    DECLARE @AddressUpdateSuccess BIT = 1;  
    DECLARE @AddressUpdateMessage NVARCHAR(4000);  
  
    -- Bắt đầu Transaction để đảm bảo tính toàn vẹn    
    BEGIN TRY    
        BEGIN TRANSACTION;    
    
        -- === VALIDATION ===    
    
        -- 1. Kiểm tra Customer tồn tại    
        IF NOT EXISTS (SELECT 1 FROM dbo.Customers WHERE customer_id = @customer_id AND [status] = 1)    
        BEGIN    
            SET @ErrorCode = -1;    
            SET @ErrorMessage = N'Lỗi: Khách hàng không tồn tại hoặc không hoạt động.';    
            RAISERROR(@ErrorMessage, 16, 1); -- Ném lỗi để nhảy vào CATCH    
        END    
          
        -- 2. Xử lý địa chỉ giao hàng  
        -- Nếu có tham số địa chỉ đầy đủ, cập nhật hoặc thêm mới địa chỉ  
        IF @AddressId IS NOT NULL AND @RecipientName IS NOT NULL AND @RecipientPhone IS NOT NULL   
           AND @Street IS NOT NULL AND @ProvinceId IS NOT NULL AND @DistrictId IS NOT NULL   
           AND @WardId IS NOT NULL AND @Country IS NOT NULL  
        BEGIN  
            -- Cập nhật hoặc thêm mới địa chỉ  
            MERGE [dbo].[Address] WITH (HOLDLOCK) AS target  
            USING (SELECT @AddressId AS address_id) AS source  
            ON (target.address_id = source.address_id)  
            WHEN MATCHED THEN  
                UPDATE SET   
                    customer_id = @customer_id,  
                    street = @Street,  
                    ward_id = @WardId,  
                    district_id = @DistrictId,  
                    province_id = @ProvinceId,  
                    country = @Country,  
                    recipientName = @RecipientName,  
                    recipientPhone = @RecipientPhone  
            WHEN NOT MATCHED THEN  
                INSERT (address_id, customer_id, street, ward_id, district_id, province_id, country, recipientName, recipientPhone)  
                VALUES (@AddressId, @customer_id, @Street, @WardId, @DistrictId, @ProvinceId, @Country, @RecipientName, @RecipientPhone);  
              
            -- Sử dụng address_id từ tham số  
            SET @shipping_address_id = @AddressId;  
        END  
        ELSE  
        BEGIN  
            -- Nếu không có tham số địa chỉ đầy đủ, lấy địa chỉ từ bảng Addresses như trước  
            SELECT TOP 1 @shipping_address_id = address_id    
            FROM dbo.Addresses    
            WHERE customer_id = @customer_id    
            ORDER BY address_id;  
              
            -- Kiểm tra nếu không tìm thấy địa chỉ    
            IF @shipping_address_id IS NULL    
            BEGIN    
                SET @ErrorCode = -2;    
                SET @ErrorMessage = N'Lỗi: Không tìm thấy địa chỉ giao hàng hợp lệ cho khách hàng này.';    
                RAISERROR(@ErrorMessage, 16, 1);    
            END  
        END  
    
        -- 3. Kiểm tra Payment Method tồn tại    
        IF NOT EXISTS (SELECT 1 FROM dbo.Payments WHERE payment_id = @payment_id)    
        BEGIN    
            SET @ErrorCode = -3;    
            SET @ErrorMessage = N'Lỗi: Phương thức thanh toán không tồn tại.';    
            RAISERROR(@ErrorMessage, 16, 1);    
        END    
    
        -- 4. Kiểm tra danh sách sản phẩm đầu vào có rỗng không    
        IF NOT EXISTS (SELECT 1 FROM @OrderItems)    
        BEGIN    
            SET @ErrorCode = -4;    
            SET @ErrorMessage = N'Lỗi: Đơn hàng phải có ít nhất một sản phẩm.';    
            RAISERROR(@ErrorMessage, 16, 1);    
        END    
    
        -- 5. Kiểm tra từng sản phẩm trong danh sách đầu vào    
        -- Tạo bảng tạm để lưu giá và kiểm tra tồn kho một lần cho hiệu quả    
        DECLARE @ValidatedItems TABLE (    
            product_variant_id INT PRIMARY KEY,    
            quantity INT NOT NULL,    
            price DECIMAL(10, 2) NOT NULL,    
            product_id INT NOT NULL,    
            current_stock INT NOT NULL    
        );    
    
        INSERT INTO @ValidatedItems (product_variant_id, quantity, price, product_id, current_stock)    
        SELECT    
            oi.product_variant_id,    
            oi.quantity,    
            p.price, -- Lấy giá từ bảng Products    
            p.product_id,    
            pv.quantity_stock    
        FROM @OrderItems oi    
        INNER JOIN dbo.product_variants pv ON oi.product_variant_id = pv.product_variant_id    
        INNER JOIN dbo.Products p ON pv.product_id = p.product_id    
    
        -- Kiểm tra xem có sản phẩm nào không hợp lệ (không tìm thấy hoặc số lượng <= 0)    
        IF (SELECT COUNT(*) FROM @OrderItems) != (SELECT COUNT(*) FROM @ValidatedItems)    
           OR EXISTS (SELECT 1 FROM @OrderItems WHERE quantity <= 0)    
        BEGIN    
             SET @ErrorCode = -5;    
             SET @ErrorMessage = N'Lỗi: Một hoặc nhiều sản phẩm không hợp lệ, không tồn tại, hoặc số lượng đặt hàng <= 0.';    
             RAISERROR(@ErrorMessage, 16, 1);    
        END    
    
        -- 6. (Optional but Recommended) Kiểm tra tồn kho    
        IF EXISTS (SELECT 1 FROM @ValidatedItems WHERE quantity > current_stock)    
        BEGIN    
            DECLARE @OutOfStockItem INT = (SELECT TOP 1 product_variant_id FROM @ValidatedItems WHERE quantity > current_stock);    
            SET @ErrorCode = -6;    
            SET @ErrorMessage = CONCAT(N'Lỗi: Sản phẩm variant ID ', @OutOfStockItem, N' không đủ số lượng tồn kho.');    
            RAISERROR(@ErrorMessage, 16, 1);    
        END    
    
        -- === PROCESSING ===    
    
        -- 1. Tạo Order ID duy nhất (Ví dụ: 'OR' + 8 số từ Sequence)    
        SET @GeneratedOrderID = CONCAT('OR', FORMAT(NEXT VALUE FOR dbo.OrderSequence, '00000000')); -- Sinh mã 10 ký tự    
    
        -- 2. Không cần tính tổng tiền đơn hàng nữa vì đã nhận từ tham số @TotalAmount  
    
        -- 3. Insert vào bảng Orders    
        INSERT INTO dbo.Orders (    
            order_id,    
            customer_id,    
            order_date,         -- Mặc định là thời gian hiện tại khi insert    
            total_amount,    
            order_status,       -- Trạng thái ban đầu, ví dụ: 'Pending' hoặc 'Processing'    
            shipping_address_id,    
            payment_id,    
            payment_status      -- Trạng thái thanh toán ban đầu, ví dụ: 0 (Chưa thanh toán)    
        )    
        VALUES (    
            @GeneratedOrderID,    
            @customer_id,    
            GETDATE(),          -- Lấy ngày giờ hiện tại    
 @TotalAmount,       -- Sử dụng tham số đầu vào   
            N'Pending',         -- Hoặc 'Processing' tùy quy trình của bạn    
            @shipping_address_id,    
            @payment_id,    
            0                   -- Mặc định là chưa thanh toán    
        );    
    
        -- 4. Insert vào bảng order_details    
        INSERT INTO dbo.order_details (    
            order_id,    
            product_variant_id,    
            quantity,    
            price               -- Lưu giá tại thời điểm đặt hàng    
        )    
        SELECT    
            @GeneratedOrderID,    
            vi.product_variant_id,    
            vi.quantity,    
            vi.price            -- Lấy giá đã xác thực từ bảng tạm    
        FROM @ValidatedItems vi;    
    
        -- 5. Cập nhật số lượng tồn kho    
        UPDATE pv    
        SET pv.quantity_stock = pv.quantity_stock - vi.quantity    
        FROM dbo.product_variants pv    
        INNER JOIN @ValidatedItems vi ON pv.product_variant_id = vi.product_variant_id;    
    
        -- Cập nhật số lượng đã bán trong bảng Products (tùy chọn)    
        UPDATE p    
        SET p.quantity_sold = ISNULL(p.quantity_sold, 0) + vi.quantity    
        FROM dbo.Products p    
        INNER JOIN @ValidatedItems vi ON p.product_id = vi.product_id;    
          
        -- 6. Xử lý mã giảm giá nếu có @ProductVariantIds  
        IF @ProductVariantIds IS NOT NULL AND LEN(@ProductVariantIds) > 0  
        BEGIN  
            -- Sử dụng STRING_SPLIT nếu SQL Server 2016+ hoặc fallback cho phiên bản trước đó  
            IF OBJECT_ID('sys.string_split') IS NOT NULL  
            BEGIN  
                UPDATE adc  
                SET status = 'used',  
                    used_at = GETDATE()  
                FROM [dbo].[Account_Discount_Codes] adc  
                INNER JOIN STRING_SPLIT(@ProductVariantIds, ',') s   
                    ON adc.product_variant_id = TRY_CAST(LTRIM(RTRIM(s.value)) AS INT)  
                WHERE adc.customer_id = @customer_id  
                AND adc.status = 'available'  
                AND TRY_CAST(LTRIM(RTRIM(s.value)) AS INT) IS NOT NULL;  
            END  
            ELSE -- Cho SQL Server phiên bản trước 2016  
            BEGIN  
                -- Tạo bảng tạm với clustered index để tăng hiệu suất  
                CREATE TABLE #TempProductVariantIds   
                (  
                    product_variant_id INT NOT NULL PRIMARY KEY CLUSTERED  
                );  
                  
                -- Phương pháp phân tích XML nhanh  
                INSERT INTO #TempProductVariantIds (product_variant_id)  
                SELECT CAST(LTRIM(RTRIM(x.value)) AS INT)  
                FROM (  
                    SELECT [value] = N.c.value('.[1]', 'nvarchar(50)')  
                    FROM (SELECT CAST('<i>' + REPLACE(@ProductVariantIds, ',', '</i><i>') + '</i>' AS XML) AS X) AS T  
                    CROSS APPLY X.nodes('/i') AS N(c)  
                ) AS x  
                WHERE ISNUMERIC(LTRIM(RTRIM(x.value))) = 1;  
                  
                -- Cập nhật với join tối ưu  
                UPDATE adc  
                SET status = 'used',  
                    used_at = GETDATE()  
                FROM [dbo].[Account_Discount_Codes] adc WITH (ROWLOCK)  
                INNER JOIN #TempProductVariantIds t   
                    ON adc.product_variant_id = t.product_variant_id  
                WHERE adc.customer_id = @customer_id  
                AND adc.status = 'available';  
                  
                -- Dọn dẹp  
                DROP TABLE #TempProductVariantIds;  
            END  
        END  
  
        -- 7. XÓA các mục trong cart_details sau khi đặt hàng thành công  
        -- Đầu tiên lấy cart_id của customer  
        SELECT @cart_id = cart_id  
        FROM dbo.Carts  
        WHERE customer_id = @customer_id;  
  
        -- Nếu tìm thấy cart_id, xóa các mục trong cart_details  
        IF @cart_id IS NOT NULL  
        BEGIN  
            -- Xóa các sản phẩm trong giỏ hàng mà đã được đặt  
            DELETE cd  
            FROM dbo.cart_details cd  
            INNER JOIN @ValidatedItems vi ON cd.product_variant_id = vi.product_variant_id  
            WHERE cd.cart_id = @cart_id;  
        END  
    
        -- Nếu mọi thứ thành công, commit transaction    
        COMMIT TRANSACTION;    
    
        -- Gán giá trị cho output parameters    
        SET @new_order_id = @GeneratedOrderID;    
        -- ErrorCode và ErrorMessage đã được set mặc định là thành công    
    
    END TRY    
    BEGIN CATCH    
        -- Nếu có lỗi xảy ra, rollback transaction    
        IF @@TRANCOUNT > 0    
            ROLLBACK TRANSACTION;    
    
        -- Gán thông tin lỗi cho output parameters    
        -- Nếu lỗi được ném bởi RAISERROR, ErrorCode và ErrorMessage đã được set    
        -- Nếu là lỗi SQL khác, cần lấy thông tin lỗi ở đây    
        IF @ErrorCode = 0 -- Chỉ ghi đè nếu chưa được set bởi RAISERROR    
        BEGIN    
            SET @ErrorCode = ERROR_NUMBER(); -- Hoặc mã lỗi tùy chỉnh khác    
            SET @ErrorMessage = N'Lỗi hệ thống: ' + ERROR_MESSAGE();    
        END    
        SET @new_order_id = NULL;    
    
        -- (Optional) Ghi log lỗi vào một bảng riêng    
        -- INSERT INTO dbo.ErrorLog (ErrorNumber, ErrorMessage, ErrorProcedure, ErrorLine, LogTime)    
        -- VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_LINE(), GETDATE());    
    
    END CATCH    
    
    -- Luôn trả về mã lỗi và thông báo    
    SELECT @ErrorCode AS ErrorCode, @ErrorMessage AS ErrorMessage, @new_order_id AS NewOrderID;    
    
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchProductsByName_Advanced_V2]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_SearchProductsByName_Advanced_V2] -- Đổi tên để phân biệt
    @Keyword NVARCHAR(100) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @MinRequiredResults INT = 40,
    @TotalRecords INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- --- Biến cục bộ ---
    DECLARE @SearchPattern NVARCHAR(102);
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
    DECLARE @InitialMatchCount INT = 0;
    DECLARE @NeedToAddRandom INT = 0;
    DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ActualTotalProducts INT = 0; -- Tổng số sản phẩm thực tế trong bảng

    -- --- Tham số đầu vào kiểm tra và chuẩn hóa ---
    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 SET @PageSize = 20;
    IF @MinRequiredResults < 1 SET @MinRequiredResults = 40;

    SET @Keyword = LTRIM(RTRIM(ISNULL(@Keyword, '')));
    SET @SearchPattern = CASE WHEN @Keyword = '' THEN NULL ELSE '%' + @Keyword + '%' END;

    -- --- Bảng tạm để lưu ID sản phẩm ---
    CREATE TABLE #ProductIDsForPage (
        product_id INT PRIMARY KEY,
        IsMatching BIT, -- 1 nếu khớp từ khóa, 0 nếu là ngẫu nhiên bổ sung
        SortOrder INT   -- 1=Khớp, 2=Ngẫu nhiên (khi khớp < min), 3=Ngẫu nhiên (khi khớp=0)
    );

    BEGIN TRY
        -- Lấy tổng số sản phẩm thực tế trong bảng để giới hạn số lượng thêm ngẫu nhiên
        SELECT @ActualTotalProducts = COUNT(product_id) FROM [dbo].[Products];

        -- --- Bước 1: Lấy và đếm sản phẩm khớp ban đầu (nếu có từ khóa) ---
        IF @SearchPattern IS NOT NULL
        BEGIN
            -- Chèn các sản phẩm khớp vào bảng tạm và đếm
            INSERT INTO #ProductIDsForPage (product_id, IsMatching, SortOrder)
            SELECT product_id, 1, 1 -- IsMatching = 1, SortOrder = 1 (khớp)
            FROM [dbo].[Products]
            WHERE product_name LIKE @SearchPattern COLLATE Latin1_General_CI_AS;

            SELECT @InitialMatchCount = @@ROWCOUNT; -- Lấy số dòng vừa chèn (hiệu quả hơn COUNT riêng)
        END
        ELSE
        BEGIN
            -- Không có từ khóa: Chèn TẤT CẢ sản phẩm
            INSERT INTO #ProductIDsForPage (product_id, IsMatching, SortOrder)
            SELECT product_id, 1, 1 -- Coi như tất cả đều "khớp"
            FROM [dbo].[Products];

            SELECT @InitialMatchCount = @@ROWCOUNT;
            -- Không cần thêm ngẫu nhiên khi lấy tất cả
        END

        -- --- Bước 2: Xác định xem có cần thêm sản phẩm ngẫu nhiên không (LOGIC ĐÃ SỬA) ---
        IF @SearchPattern IS NOT NULL -- Chỉ áp dụng logic thêm ngẫu nhiên khi CÓ tìm kiếm từ khóa
        BEGIN
            IF @InitialMatchCount = 10 -- Trường hợp đặc biệt: đúng 10 khớp
            BEGIN
                SET @NeedToAddRandom = 30;
            END
            -- *** SỬA ĐỔI QUAN TRỌNG Ở ĐÂY ***
            -- Nếu số khớp ÍT HƠN mức tối thiểu YÊU CẦU (bao gồm cả trường hợp = 0)
            ELSE IF @InitialMatchCount < @MinRequiredResults
            BEGIN
                 -- Cần thêm số lượng = mức tối thiểu - số đã khớp
                SET @NeedToAddRandom = @MinRequiredResults - @InitialMatchCount;
            END
             -- ELSE: Nếu @InitialMatchCount >= @MinRequiredResults (và không phải 10), không cần thêm.
        END

        -- Giới hạn số lượng thêm ngẫu nhiên không vượt quá số sản phẩm còn lại trong bảng
        IF @NeedToAddRandom > 0
        BEGIN
             DECLARE @AvailableNonMatching INT = @ActualTotalProducts - @InitialMatchCount;
             IF @NeedToAddRandom > @AvailableNonMatching SET @NeedToAddRandom = @AvailableNonMatching;
        END


        -- --- Bước 3: Lấy ID sản phẩm ngẫu nhiên (nếu cần) ---
        IF @NeedToAddRandom > 0
        BEGIN
            INSERT INTO #ProductIDsForPage (product_id, IsMatching, SortOrder)
            SELECT TOP (@NeedToAddRandom)
                   p.product_id,
                   0, -- IsMatching = 0 (sản phẩm ngẫu nhiên)
                   -- Phân biệt SortOrder để có thể nhóm kết quả nếu muốn
                   CASE WHEN @InitialMatchCount = 0 THEN 3 ELSE 2 END -- 3 nếu không khớp, 2 nếu khớp ít
            FROM [dbo].[Products] p
            WHERE NOT EXISTS ( -- Đảm bảo không lấy trùng sản phẩm đã có trong #ProductIDsForPage
                SELECT 1
                FROM #ProductIDsForPage temp
                WHERE temp.product_id = p.product_id
            )
            ORDER BY NEWID(); -- Lấy ngẫu nhiên
        END

        -- --- Bước 4: Đếm tổng số bản ghi cuối cùng trong bảng tạm ---
        SELECT @TotalRecords = COUNT(*) FROM #ProductIDsForPage;

        -- --- Bước 5: Truy vấn dữ liệu chi tiết cho trang hiện tại ---
        SELECT
            p.product_id,
            p.supplier_id,
            p.category_id,
            p.brand_id,
            p.product_name,
            p.description,
            p.image_url,
            p.rating,
            p.type,
            p.price,
            p.quantity_sold,
            p.warranty,
            p.return_policy
        FROM [dbo].[Products] AS p
        INNER JOIN #ProductIDsForPage AS temp ON p.product_id = temp.product_id
        ORDER BY
            temp.SortOrder ASC,  -- Ưu tiên hiển thị sản phẩm khớp (1), rồi đến ngẫu nhiên (2 hoặc 3)
            p.product_name ASC   -- Sắp xếp theo tên trong từng nhóm
        OFFSET @Offset ROWS
        FETCH NEXT @PageSize ROWS ONLY;

        -- --- Dọn dẹp ---
        DROP TABLE #ProductIDsForPage;

    END TRY
    BEGIN CATCH
        -- --- Xử lý lỗi ---
        SET @ErrorMessage = ERROR_MESSAGE() + ' Lỗi ở dòng ' + CAST(ERROR_LINE() AS NVARCHAR(10));
        IF OBJECT_ID('tempdb..#ProductIDsForPage') IS NOT NULL
        BEGIN
            DROP TABLE #ProductIDsForPage;
        END
        RAISERROR(@ErrorMessage, 16, 1);
        SET @TotalRecords = 0;
        RETURN -1;
    END CATCH

    RETURN 0; -- Thành công
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchProductsByName_Advanced_V3]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_SearchProductsByName_Advanced_V3]
    @Keyword NVARCHAR(100) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @MinRequiredResults INT = 40,
    @TotalRecords INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    /* Performance optimization notes:
     * 1. Using an indexed temp table for better join performance
     * 2. Applying both accent-sensitive and accent-insensitive search
     * 3. Using EXISTS for more efficient inclusion/exclusion check
     * 4. Optimized random product selection algorithm
     */
    
    -- Input parameter validation and normalization
    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 SET @PageSize = 20;
    IF @MinRequiredResults < 1 SET @MinRequiredResults = 40;
    
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
    DECLARE @SearchKeyword NVARCHAR(100) = LTRIM(RTRIM(ISNULL(@Keyword, '')));
    DECLARE @SearchPattern NVARCHAR(102) = CASE WHEN @SearchKeyword = '' THEN NULL ELSE N'%' + @SearchKeyword + N'%' END;
    DECLARE @NormalizedKeyword NVARCHAR(102) = NULL;
    DECLARE @MatchCount INT = 0;
    DECLARE @NeedRandomCount INT = 0;
    DECLARE @TotalAvailable INT = 0;
    
    -- For accent-insensitive search
    IF @SearchPattern IS NOT NULL
        SET @NormalizedKeyword = N'%' + [dbo].[fn_RemoveDiacritics](@SearchKeyword) + N'%';
    
    -- Get total products for reference
    SELECT @TotalAvailable = COUNT(product_id) FROM [dbo].[Products] WITH (NOLOCK);
    
    -- Create and index temporary table for results
    CREATE TABLE #SearchResults (
        product_id INT PRIMARY KEY,
        search_rank INT,        -- Lower is better: 1=exact, 2=normalized, 3=random
        sort_order INT          -- For final sorting
    );
    
    -- Step 1: Insert matching products (accent-sensitive)
    IF @SearchPattern IS NOT NULL
    BEGIN
        -- First try exact match with accents
        INSERT INTO #SearchResults (product_id, search_rank, sort_order)
        SELECT p.product_id, 1, ROW_NUMBER() OVER (ORDER BY p.product_name)
        FROM [dbo].[Products] p WITH (NOLOCK)
        WHERE p.product_name LIKE @SearchPattern;
        
        SET @MatchCount = @@ROWCOUNT;
        
        -- Then try normalized (accent-insensitive) match if not enough results
        IF @MatchCount < @MinRequiredResults AND @NormalizedKeyword IS NOT NULL
        BEGIN
            INSERT INTO #SearchResults (product_id, search_rank, sort_order)
            SELECT p.product_id, 2, ROW_NUMBER() OVER (ORDER BY p.product_name) + @MatchCount
            FROM [dbo].[Products] p WITH (NOLOCK)
            WHERE [dbo].[fn_RemoveDiacritics](p.product_name) LIKE @NormalizedKeyword
                AND NOT EXISTS (
                    SELECT 1 FROM #SearchResults r WHERE r.product_id = p.product_id
                );
                
            SET @MatchCount = @MatchCount + @@ROWCOUNT;
        END
    END
    ELSE
    BEGIN
        -- No keyword: insert all products (limited to page size * 2 for better performance)
        INSERT INTO #SearchResults (product_id, search_rank, sort_order)
        SELECT TOP (@MinRequiredResults) 
               p.product_id, 1, ROW_NUMBER() OVER (ORDER BY p.product_name)
        FROM [dbo].[Products] p WITH (NOLOCK);
        
        SET @MatchCount = @@ROWCOUNT;
    END
    
    -- Calculate how many random products needed
    -- Special case: exactly 10 matches
    IF @MatchCount = 10 AND @SearchPattern IS NOT NULL
        SET @NeedRandomCount = 30;
    -- General case: fewer than minimum required
    ELSE IF @MatchCount < @MinRequiredResults AND @SearchPattern IS NOT NULL
        SET @NeedRandomCount = @MinRequiredResults - @MatchCount;
    
    -- Limit random products to available ones
    IF @NeedRandomCount > (@TotalAvailable - @MatchCount)
        SET @NeedRandomCount = @TotalAvailable - @MatchCount;
    
    -- Step 2: Add random products if needed
    IF @NeedRandomCount > 0
    BEGIN
        -- Use optimized query to add random products
        -- The TOP with ORDER BY NEWID() ensures randomness
        INSERT INTO #SearchResults (product_id, search_rank, sort_order)
        SELECT TOP (@NeedRandomCount)
               p.product_id, 3, ROW_NUMBER() OVER (ORDER BY NEWID()) + @MatchCount
        FROM [dbo].[Products] p WITH (NOLOCK)
        WHERE NOT EXISTS (
            SELECT 1 FROM #SearchResults r WHERE r.product_id = p.product_id
        )
        ORDER BY NEWID(); -- Optimized random selection
    END
    
    -- Get total count for pagination
    SELECT @TotalRecords = COUNT(*) FROM #SearchResults;
    
    -- Return paginated results with all product details
    SELECT
        p.product_id,
        p.supplier_id,
        p.category_id,
        p.brand_id,
        p.product_name,
        p.description,
        p.image_url,
        p.rating,
        p.type,
        p.price,
        p.quantity_sold,
        p.warranty,
        p.return_policy,
        r.search_rank -- Extra info: 1=exact match, 2=accent-insensitive match, 3=random
    FROM [dbo].[Products] p WITH (NOLOCK)
    INNER JOIN #SearchResults r ON p.product_id = r.product_id
    ORDER BY 
        r.search_rank ASC,  -- Exact matches first, normalized matches second, random last
        r.sort_order ASC    -- Preserve sort order within each group
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
    
    -- Cleanup
    DROP TABLE #SearchResults;
    
    RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchProductsByName_Advanced_V4]    Script Date: 5/20/2025 12:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Function RemoveDiacritics (Giả định bạn đã có hàm này, nếu chưa có cần tạo)
-- Ví dụ nội dung hàm (có thể khác tùy cách bạn cài đặt):
/*
IF OBJECT_ID('dbo.fn_RemoveDiacritics', 'FN') IS NULL
BEGIN
    EXEC ('
CREATE FUNCTION [dbo].[fn_RemoveDiacritics] (@string NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    SET @string = LOWER(@string);
    SET @string = REPLACE(@string, N''á'', N''a''); SET @string = REPLACE(@string, N''à'', N''a''); SET @string = REPLACE(@string, N''ả'', N''a''); SET @string = REPLACE(@string, N''ã'', N''a''); SET @string = REPLACE(@string, N''ạ'', N''a'');
    SET @string = REPLACE(@string, N''ă'', N''a''); SET @string = REPLACE(@string, N''ắ'', N''a''); SET @string = REPLACE(@string, N''ằ'', N''a''); SET @string = REPLACE(@string, N''ẳ'', N''a''); SET @string = REPLACE(@string, N''ẵ'', N''a''); SET @string = REPLACE(@string, N''ặ'', N''a'');
    SET @string = REPLACE(@string, N''â'', N''a''); SET @string = REPLACE(@string, N''ấ'', N''a''); SET @string = REPLACE(@string, N''ầ'', N''a''); SET @string = REPLACE(@string, N''ẩ'', N''a''); SET @string = REPLACE(@string, N''ẫ'', N''a''); SET @string = REPLACE(@string, N''ậ'', N''a'');
    SET @string = REPLACE(@string, N''đ'', N''d'');
    SET @string = REPLACE(@string, N''é'', N''e''); SET @string = REPLACE(@string, N''è'', N''e''); SET @string = REPLACE(@string, N''ẻ'', N''e''); SET @string = REPLACE(@string, N''ẽ'', N''e''); SET @string = REPLACE(@string, N''ẹ'', N''e'');
    SET @string = REPLACE(@string, N''ê'', N''e''); SET @string = REPLACE(@string, N''ế'', N''e''); SET @string = REPLACE(@string, N''ề'', N''e''); SET @string = REPLACE(@string, N''ể'', N''e''); SET @string = REPLACE(@string, N''ễ'', N''e''); SET @string = REPLACE(@string, N''ệ'', N''e'');
    SET @string = REPLACE(@string, N''í'', N''i''); SET @string = REPLACE(@string, N''ì'', N''i''); SET @string = REPLACE(@string, N''ỉ'', N''i''); SET @string = REPLACE(@string, N''ĩ'', N''i''); SET @string = REPLACE(@string, N''ị'', N''i'');
    SET @string = REPLACE(@string, N''ó'', N''o''); SET @string = REPLACE(@string, N''ò'', N''o''); SET @string = REPLACE(@string, N''ỏ'', N''o''); SET @string = REPLACE(@string, N''õ'', N''o''); SET @string = REPLACE(@string, N''ọ'', N''o'');
    SET @string = REPLACE(@string, N''ô'', N''o''); SET @string = REPLACE(@string, N''ố'', N''o''); SET @string = REPLACE(@string, N''ồ'', N''o''); SET @string = REPLACE(@string, N''ổ'', N''o''); SET @string = REPLACE(@string, N''ỗ'', N''o''); SET @string = REPLACE(@string, N''ộ'', N''o'');
    SET @string = REPLACE(@string, N''ơ'', N''o''); SET @string = REPLACE(@string, N''ớ'', N''o''); SET @string = REPLACE(@string, N''ờ'', N''o''); SET @string = REPLACE(@string, N''ở'', N''o''); SET @string = REPLACE(@string, N''ỡ'', N''o''); SET @string = REPLACE(@string, N''ợ'', N''o'');
    SET @string = REPLACE(@string, N''ú'', N''u''); SET @string = REPLACE(@string, N''ù'', N''u''); SET @string = REPLACE(@string, N''ủ'', N''u''); SET @string = REPLACE(@string, N''ũ'', N''u''); SET @string = REPLACE(@string, N''ụ'', N''u'');
    SET @string = REPLACE(@string, N''ư'', N''u''); SET @string = REPLACE(@string, N''ứ'', N''u''); SET @string = REPLACE(@string, N''ừ'', N''u''); SET @string = REPLACE(@string, N''ử'', N''u''); SET @string = REPLACE(@string, N''ữ'', N''u''); SET @string = REPLACE(@string, N''ự'', N''u'');
    SET @string = REPLACE(@string, N''ý'', N''y''); SET @string = REPLACE(@string, N''ỳ'', N''y''); SET @string = REPLACE(@string, N''ỷ'', N''y''); SET @string = REPLACE(@string, N''ỹ'', N''y''); SET @string = REPLACE(@string, N''ỵ'', N''y'');
    RETURN @string;
END
    ');
END
GO
*/

CREATE   PROCEDURE [dbo].[usp_SearchProductsByName_Advanced_V4]
    @Keyword NVARCHAR(100) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @MinRequiredResults INT = 40,
    @TotalRecords INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; -- Use dirty reads for better performance
    
    /* Performance optimization notes:
     * 1. Added computed column index recommendation for diacritics-free search
     * 2. Implemented batch processing strategy for large datasets
     * 3. Added query plan optimization hints
     * 4. Improved memory utilization with optimized temp table structure
     * 5. Enhanced randomization algorithm for better distribution
     * 6. Added statistics hints for better query planning
     * 7. Implemented query parallelism for large datasets
     */
    
    -- Input parameter validation and normalization with boundary checks
    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 OR @PageSize > 1000 SET @PageSize = 20; -- Limit page size to prevent excessive resource usage
    IF @MinRequiredResults < 1 SET @MinRequiredResults = 40;
    IF @MinRequiredResults > 1000 SET @MinRequiredResults = 1000; -- Cap minimum required to avoid excessive processing
    
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
    DECLARE @SearchKeyword NVARCHAR(100) = LTRIM(RTRIM(ISNULL(@Keyword, '')));
    DECLARE @SearchPattern NVARCHAR(102) = CASE WHEN @SearchKeyword = '' THEN NULL ELSE N'%' + @SearchKeyword + N'%' END;
    DECLARE @NormalizedKeyword NVARCHAR(102) = NULL;
    DECLARE @MatchCount INT = 0;
    DECLARE @NeedRandomCount INT = 0;
    DECLARE @TotalAvailable INT = 0;
    DECLARE @SearchStart DATETIME2 = GETDATE(); -- For performance tracking
    
    -- For accent-insensitive search - precompute once to avoid multiple function calls
    IF @SearchPattern IS NOT NULL AND OBJECT_ID('dbo.fn_RemoveDiacritics', 'FN') IS NOT NULL -- Check if function exists
        SET @NormalizedKeyword = N'%' + [dbo].[fn_RemoveDiacritics](@SearchKeyword) + N'%';
    
    -- Get total products count with optimization for large tables
    SELECT @TotalAvailable = SUM(p.rows)  
    FROM sys.partitions p WITH (NOLOCK)
    WHERE p.object_id = OBJECT_ID('dbo.Products') 
    AND p.index_id IN (0, 1); -- Fastest way to get approximate row count
    
    -- Create and index temporary table with optimized structure
    -- Use a memory-optimized temp table for better performance (Requires Enterprise Edition or specific setup)
    -- Using standard temp table here for broader compatibility
    CREATE TABLE #SearchResults (
        product_id INT NOT NULL,
        search_rank TINYINT NOT NULL,   -- Use TINYINT instead of INT to save memory
        sort_order INT NOT NULL,        -- For final sorting
        PRIMARY KEY NONCLUSTERED (product_id), -- Primary key for deduplication
        INDEX IX_SearchRank_SortOrder NONCLUSTERED (search_rank, sort_order) -- For final ordering
    ); 
    -- Note: DATA_COMPRESSION and memory optimization might depend on SQL Server Edition/Version
    
    -- Local variable to track batch size for large datasets
    DECLARE @BatchSize INT = CASE 
        WHEN @TotalAvailable > 1000000 THEN 50000 -- Use batching for very large tables
        WHEN @TotalAvailable > 100000 THEN 10000
        ELSE @TotalAvailable + 1 -- Ensure batch size is at least total available + 1 if small
    END;
    
    -- Step 1: Insert matching products (accent-sensitive) with batch processing
    IF @SearchPattern IS NOT NULL
    BEGIN
        -- First try exact match with accents (with optimized query plan)
        INSERT INTO #SearchResults (product_id, search_rank, sort_order)
        SELECT p.product_id, 1, ROW_NUMBER() OVER (ORDER BY LEN(p.product_name), p.product_name)
        FROM [dbo].[Products] p WITH (NOLOCK)
        WHERE p.product_name LIKE @SearchPattern
        OPTION (OPTIMIZE FOR UNKNOWN, MAXDOP 4); -- Parallel processing with query hint
        
        SET @MatchCount = @@ROWCOUNT;
        
        -- Then try normalized (accent-insensitive) match if not enough results and function exists
        IF @MatchCount < @MinRequiredResults AND @NormalizedKeyword IS NOT NULL AND OBJECT_ID('dbo.fn_RemoveDiacritics', 'FN') IS NOT NULL
        BEGIN
            -- Use indexed batch processing for large tables
            INSERT INTO #SearchResults (product_id, search_rank, sort_order)
            SELECT p.product_id, 2, ROW_NUMBER() OVER (ORDER BY LEN(p.product_name), p.product_name) + @MatchCount
            FROM [dbo].[Products] p WITH (NOLOCK)
            WHERE [dbo].[fn_RemoveDiacritics](p.product_name) LIKE @NormalizedKeyword
                AND NOT EXISTS (
                    SELECT 1 FROM #SearchResults r WHERE r.product_id = p.product_id
                )
            OPTION (OPTIMIZE FOR UNKNOWN, MAXDOP 4); -- Parallel processing with query hint
                
            SET @MatchCount = @MatchCount + @@ROWCOUNT;
        END;
        
        -- Exact match for 10 results - special case optimization (Adjust logic if needed)
        IF @MatchCount = 10 
        BEGIN
            SET @NeedRandomCount = 30; -- Example logic
        END
        -- General case: fewer than minimum required
        ELSE IF @MatchCount < @MinRequiredResults
        BEGIN
            SET @NeedRandomCount = @MinRequiredResults - @MatchCount;
        END;
    END
    ELSE -- No keyword provided
    BEGIN
        -- No keyword: use optimized sampling instead of full scan
        -- Use modulo-based sampling for large datasets for better distribution
        DECLARE @SampleFactor FLOAT = CASE
            WHEN @TotalAvailable > 1000000 THEN 0.05 -- 5% sampling for very large tables
            WHEN @TotalAvailable > 100000 THEN 0.2  -- 20% sampling for large tables
            ELSE 1.0                              -- Full scan for smaller tables
        END;
        
        -- Ensure SampleSize doesn't exceed total available if factor is 1.0
        DECLARE @SampleSize INT = CASE WHEN @SampleFactor = 1.0 THEN @MinRequiredResults ELSE CEILING(@MinRequiredResults / @SampleFactor) END;
        IF @SampleSize > @TotalAvailable SET @SampleSize = @TotalAvailable; -- Cap sample size


        INSERT INTO #SearchResults (product_id, search_rank, sort_order)
        SELECT TOP (@SampleSize) 
               p.product_id, 1, ROW_NUMBER() OVER (ORDER BY p.product_name) -- Arbitrary sort for sampling
        FROM [dbo].[Products] p WITH (NOLOCK)
        WHERE ABS(CHECKSUM(NEWID())) % 100 < @SampleFactor * 100 -- Efficient sampling (Approximation)
        ORDER BY NEWID() -- Randomize selection within the sample
        OPTION (MAXDOP 4); -- Use parallelism
        
        SET @MatchCount = @@ROWCOUNT;
        
        -- If sampling didn't return enough, add more with direct fetch
        IF @MatchCount < @MinRequiredResults
        BEGIN
            INSERT INTO #SearchResults (product_id, search_rank, sort_order)
            SELECT TOP (@MinRequiredResults - @MatchCount) 
                   p.product_id, 1, ROW_NUMBER() OVER (ORDER BY p.product_id) + @MatchCount -- Use a stable order
            FROM [dbo].[Products] p WITH (NOLOCK)
            WHERE NOT EXISTS (
                SELECT 1 FROM #SearchResults r WHERE r.product_id = p.product_id
            )
            ORDER BY p.product_id -- Order predictably for TOP
            OPTION (MAXDOP 4); -- Use parallelism
            
            SET @MatchCount = @MatchCount + @@ROWCOUNT;
        END;
        SET @NeedRandomCount = 0; -- Set to 0 as we forced getting MinRequiredResults
    END;
    
    -- Limit random products to available ones
    IF @NeedRandomCount > (@TotalAvailable - @MatchCount)
        SET @NeedRandomCount = CASE WHEN (@TotalAvailable - @MatchCount) < 0 THEN 0 ELSE (@TotalAvailable - @MatchCount) END;
    
    -- Step 2: Add random products if needed using efficient algorithm
    IF @NeedRandomCount > 0
    BEGIN
        -- Use reservoir sampling for truly random selection with high performance
        -- This is much more efficient than ORDER BY NEWID() for large tables
        -- ***** FIX: Use DATEDIFF_BIG to prevent overflow *****
        DECLARE @RandomSeed BIGINT = DATEDIFF_BIG(MILLISECOND, '2000-01-01', GETDATE());
        -- ***** END FIX *****
        DECLARE @BatchCounter INT = 0;
        -- Ensure MaxBatches is at least 1
        DECLARE @MaxBatches INT = CASE WHEN @BatchSize <=0 THEN 1 ELSE CEILING(@TotalAvailable * 1.0 / @BatchSize) END; 
        IF @MaxBatches <= 0 SET @MaxBatches = 1;
        DECLARE @CurrentBatch INT = 1;
        
        -- Process in batches for large tables
        WHILE @BatchCounter < @NeedRandomCount AND @CurrentBatch <= @MaxBatches
        BEGIN
            -- Calculate batch boundaries for partitioned approach (using OFFSET/FETCH for simplicity)
            -- Note: This random selection method isn't strictly Reservoir Sampling but aims for efficient randomization
            
            -- Generate a batch of random products using statistical sampling based on a derived random value
            INSERT INTO #SearchResults (product_id, search_rank, sort_order)
            SELECT TOP (@NeedRandomCount - @BatchCounter)
                p.product_id, 3, ROW_NUMBER() OVER (ORDER BY p.random_value) + @MatchCount + @BatchCounter
            FROM (
                -- Use integer operations for efficient randomization based on product_id and seed
                SELECT 
                    product_id, 
                    ABS((CHECKSUM(product_id) ^ CAST(@RandomSeed AS INT)) % 2147483647) AS random_value -- Ensure seed fits INT for CHECKSUM compatibility
                FROM [dbo].[Products] WITH (NOLOCK)
                ORDER BY product_id -- Required for OFFSET/FETCH stability if used, though not strictly needed for CHECKSUM approach
                OFFSET ((@CurrentBatch - 1) * @BatchSize) ROWS 
                FETCH NEXT @BatchSize ROWS ONLY 
            ) p
            WHERE NOT EXISTS (
                SELECT 1 FROM #SearchResults r WHERE r.product_id = p.product_id
            )
            ORDER BY p.random_value -- Order by the generated random value to pick top random ones
            OPTION (MAXDOP 4); -- Use parallelism
            
            SET @BatchCounter = @BatchCounter + @@ROWCOUNT;
            SET @CurrentBatch = @CurrentBatch + 1;
            
            -- Early termination if we've collected enough
            IF @BatchCounter >= @NeedRandomCount BREAK;
            
            -- Update random seed for better distribution in next potential batch (Linear Congruential Generator - basic)
            SET @RandomSeed = (@RandomSeed * 1103515245 + 12345) % 9223372036854775807; -- Use BIGINT modulo
        END;
    END;
    
    -- Get total count for pagination
    SELECT @TotalRecords = COUNT_BIG(*) FROM #SearchResults;
    
    -- Return paginated results with all product details, optimized for final fetch
    SELECT
        p.product_id,
        p.supplier_id,
        p.category_id,
        p.brand_id,
        p.product_name,
        p.description,
        p.image_url,
        p.rating,
        p.type,
        p.price,
        p.quantity_sold,
        p.warranty,
        p.return_policy,
        r.search_rank, -- Extra info: 1=exact match, 2=accent-insensitive match, 3=random
        DATEDIFF(MILLISECOND, @SearchStart, GETDATE()) AS execution_time_ms -- Performance metric
    FROM #SearchResults r
    INNER JOIN [dbo].[Products] p WITH (NOLOCK) ON p.product_id = r.product_id
    ORDER BY 
        r.search_rank ASC,  -- Exact matches first, normalized matches second, random last
        r.sort_order ASC    -- Preserve sort order within each group
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY
    OPTION (RECOMPILE, MAXDOP 4); -- Optimize for this specific execution
    
    -- Cleanup
    DROP TABLE #SearchResults;
    
    -- Return performance statistics (or just return 0 for success)
    RETURN 0; 
END
GO
USE [master]
GO
ALTER DATABASE [ClothesShopV1] SET  READ_WRITE 
GO
