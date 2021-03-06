USE [Shopper]
GO
/****** Object:  Table [dbo].[ProductDetails]    Script Date: 7/10/2021 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetails](
	[ProductId] [int] NULL,
	[CategoryId] [int] NULL,
	[ProductDescription] [nvarchar](50) NULL,
	[Price] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 7/10/2021 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[CategoryId] [int] NOT NULL,
	[ParentId] [int] NULL,
	[CategoryDescription] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetProductCount]    Script Date: 7/10/2021 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetProductCount] 
(
    @CategoryId INT
)
RETURNS TABLE
AS
RETURN  
(
	WITH sub_category AS (
		SELECT CategoryId, CategoryDescription
		FROM ProductCategory
		WHERE CategoryId = @CategoryId
			UNION ALL
		SELECT PC.CategoryId, PC.CategoryDescription
		FROM ProductCategory PC, sub_category SC
		WHERE PC.ParentId = SC.CategoryId
	)
	SELECT COUNT(PD.ProductId) AS TotalCount
	FROM ProductDetails PD
	JOIN sub_category SC
		ON PD.CategoryId = SC.CategoryId
)
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (0, NULL, N'Categories')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (1, 0, N'Mobiles, Computers')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (2, 0, N'TV, Appliances, Electronics')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (3, 0, N'Mens Fashion')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (4, 1, N'All Mobile Phones')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (5, 1, N'All Mobile Accessories')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (6, 1, N'Cases & Covers')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (7, 4, N'Smart Phones')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (8, 4, N'Basic Phones')
INSERT [dbo].[ProductCategory] ([CategoryId], [ParentId], [CategoryDescription]) VALUES (9, 4, N'Android')
GO
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (1, 7, N'Apple iPhone', 1000.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (2, 7, N'Samsung S20', 900.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (3, 8, N'Nokia 3100', 50.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (4, 9, N'OnePlus 9', 999.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (5, 9, N'Mi 10 Pro', 499.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (6, 2, N'LG TV 32', 300.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (7, 2, N'SONY Sound Bar', 350.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (8, 2, N'DELL Laptop 14', 899.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (9, 3, N'Levis Shirt', 30.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (10, 3, N'NIKE AIR', 150.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (11, 5, N'Mi Power Bank', 15.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (12, 5, N'JBL Buds', 50.0000)
INSERT [dbo].[ProductDetails] ([ProductId], [CategoryId], [ProductDescription], [Price]) VALUES (13, 6, N'CoverUp Silicone case', 5.0000)
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [category_parent_fk] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[ProductCategory] ([CategoryId])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [category_parent_fk]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetProductDetails_sel]    Script Date: 7/10/2021 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================================================================================
-- Date Created	:	2021-07-10
-- Description	:	This procedure fetches product details based on categoryId
--==============================================================================================================================
CREATE PROC [dbo].[usp_GetProductDetails_sel] (
	@categoryId INT = 0
)
AS
BEGIN
	;WITH sub_tree AS (
		SELECT CategoryId, CategoryDescription, 1 AS Relative_depth
		FROM ProductCategory
		WHERE CategoryId = @categoryId

		UNION ALL

		SELECT cat.CategoryId, cat.CategoryDescription, st.relative_depth + 1
		FROM ProductCategory cat, sub_tree st
		WHERE cat.ParentId = st.CategoryId
	)

	SELECT PD.*
	FROM ProductDetails PD
		JOIN sub_tree ST
			ON PD.CategoryId = ST.CategoryId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetSubCategoryDetails_sel]    Script Date: 7/10/2021 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================================================================================
-- Date Created	:	2021-07-10
-- Description	:	This procedure fetches sub category details based on categoryId
--==============================================================================================================================
CREATE PROC [dbo].[usp_GetSubCategoryDetails_sel] (
	@categoryId INT = 0
)
AS
BEGIN
	SELECT *
	FROM ProductCategory PC
		CROSS APPLY dbo.GetProductCount(PC.CategoryId)
	WHERE PC.ParentId = @categoryId
END
GO
