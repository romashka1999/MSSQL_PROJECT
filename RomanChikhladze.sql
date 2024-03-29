USE [R_chikhladze]
GO
/****** Object:  UserDefinedFunction [dbo].[getFullPriceFromBasket]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[getFullPriceFromBasket](@modelid INT)  
RETURNS INT  
BEGIN  
RETURN(SELECT SUM(price)  
        FROM basket 
        WHERE model_id = @modelid )  
END

GO
/****** Object:  Table [dbo].[customers]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[surname] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[gender] [nvarchar](10) NULL,
	[regDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[filterwithgender]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[filterwithgender] (@gender NVARCHAR(10))  
RETURNS TABLE  
AS  
RETURN   
(  
 SELECT *  FROM customers WHERE gender = @gender
);  





GO
/****** Object:  Table [dbo].[pc_components]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pc_components](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[component_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[models]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[models](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[component_id] [int] NULL,
	[name] [nvarchar](50) NULL,
	[price] [int] NULL,
	[Store] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[createviewmodels]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[createviewmodels]
AS
SELECT component_id,name,price,store,component_name FROM models join pc_components
ON models.component_id = pc_components.id
GO
/****** Object:  View [dbo].[getCustomers]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[getCustomers]
AS
SELECT * FROM customers WHERE
username LIKE '%a%';



GO
/****** Object:  View [dbo].[getCountWithGender]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[getCountWithGender]
AS
SELECT COUNT(id)as countedval,gender FROM customers
GROUP BY gender 



GO
/****** Object:  Table [dbo].[basket]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[basket](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[model_id] [int] NULL,
	[price] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customersAudit]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customersAudit](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[auditdata] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[Amount] [int] NULL,
	[order_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ac_email_unique]    Script Date: 07.06.2019 11:33:51 ******/
ALTER TABLE [dbo].[customers] ADD  CONSTRAINT [ac_email_unique] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ad_email_unique]    Script Date: 07.06.2019 11:33:51 ******/
ALTER TABLE [dbo].[customers] ADD  CONSTRAINT [ad_email_unique] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ad_username_unique]    Script Date: 07.06.2019 11:33:51 ******/
ALTER TABLE [dbo].[customers] ADD  CONSTRAINT [ad_username_unique] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[customers] ADD  CONSTRAINT [ad_gender_def]  DEFAULT ('????') FOR [gender]
GO
ALTER TABLE [dbo].[basket]  WITH CHECK ADD FOREIGN KEY([model_id])
REFERENCES [dbo].[models] ([id])
GO
ALTER TABLE [dbo].[basket]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[models]  WITH CHECK ADD FOREIGN KEY([component_id])
REFERENCES [dbo].[pc_components] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([id])
GO
ALTER TABLE [dbo].[customers]  WITH CHECK ADD  CONSTRAINT [ac_password] CHECK  ((len([password])>=(8)))
GO
ALTER TABLE [dbo].[customers] CHECK CONSTRAINT [ac_password]
GO
ALTER TABLE [dbo].[customers]  WITH CHECK ADD  CONSTRAINT [ac_username] CHECK  ((len([username])>=(3)))
GO
ALTER TABLE [dbo].[customers] CHECK CONSTRAINT [ac_username]
GO
/****** Object:  StoredProcedure [dbo].[cp_customers_selectfemale]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cp_customers_selectfemale]
AS 
BEGIN 
 SELECT * FROM customers WHERE gender = 'female';
END





GO
/****** Object:  StoredProcedure [dbo].[cp_customers_selectmale]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cp_customers_selectmale]
AS 
BEGIN 
 SELECT * FROM customers WHERE gender = 'male';
END





GO
/****** Object:  StoredProcedure [dbo].[cp_getmodelcount]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cp_getmodelcount]
@startDate DATE ,
@endDate DATE ,
@model INT ,
@totalcount INT OUTPUT
AS 
BEGIN 
 SELECT @totalcount = COUNT(*) FROM basket join orders ON basket.order_id = orders.id
 WHERE (@model = basket.model_id AND (@startDate <= orders.order_date AND @endDate >= orders.order_date));
END






GO
/****** Object:  StoredProcedure [dbo].[cp_oredrs_gettotalprice]    Script Date: 07.06.2019 11:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cp_oredrs_gettotalprice]
@id INT ,
@totalsum INT OUTPUT
AS 
BEGIN 
 SELECT @totalsum = SUM(amount) FROM orders WHERE @id = customer_id;
END





GO
