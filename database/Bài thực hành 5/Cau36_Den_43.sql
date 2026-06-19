--Cau 36: Tao bang Cutstomers1 la copy cua bang Customers
USE [Northwind]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customers1](
	[CustomerID] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL, 
	[ContactTitle] [nvarchar](30) NULL, 
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
CONSTRAINT [PK_Customers1] PRIMARY KEY CLUSTERED
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--Cau 37: Them nhieu hang vao bang Customers1 (20 hang la cac KH o nuoc USA va UK)
USE Northwind
GO

INSERT INTO Customers1
	SELECT * FROM Customers WHERE Country = N'USA' OR Country = N'UK'
GO
--Xem du lieu sau khi them (20 hang)
SELECT *
FROM Customers1
ORDER BY Country

--Cau 38: Xoa cac KH nuoc USA
DELETE FROM Customers1
WHERE Country = N'USA'
--Xem du lieu sau khi xoa (xoa 13 hang, con 7 hang)
SELECT *
FROM Customers1
ORDER BY Country

--Cau 39: Them 1 hang vao bang Customers1
USE Northwind
GO

INSERT INTO Customers1
			([CustomerID],
			[CompanyName],
			[ContactName],
			[ContactTitle],
			[Address],
			[City],
			[Region],
			[PostalCode],
			[Country],
			[Phone],
			[Fax])
		VALUES
		(N'KH001',
		N'Catan company',
		N'Pham Ngoc Huy Phuc',
		N'Game Master',
		N'232/3A, Gia Kiem ward',
		N'Dong Nai',
		N'Southeast Asia',
		N'810000',
		N'Viet Nam',
		N'0383759335',
		N'0383759335')
GO
--Xem du lieu sau khi them (7 them 1 hang thanh 8 hang)
SELECT *
FROM Customers1
ORDER BY Country

--Cau 40: Sua sdt thanh '0111222333', ten thanh 'Le Thanh Binh', tp thanh 'Ha Noi' cho KH ma KH001
UPDATE Customers1
	SET Phone = N'0111222333',
		ContactName = N'Le Thanh Binh',
		City = N'Ha Noi',
		CompanyName = N'Cyberpunk Edgerunners'
WHERE CustomerID = N'KH001'
--Xem du lieu sau khi sua du lieu
SELECT *
FROM Customers1
ORDER BY Country

--Cau 41: Sua ten Country 'UK' thanh 'Anh'
UPDATE Customers1
	SET Country = N'Anh'
WHERE Country = N'UK'
--Xem du lieu sau khi sua Country
SELECT *
FROM Customers1
ORDER BY Country

--Cau 42: Xoa tat ca cac hang cua bang Customers1
DELETE FROM Customers1
--Xem du lieu sau khi xoa tat ca cac hang
SELECT *
FROM Customers1
ORDER BY Country

--Cau 43: Xoa bang Customers1
DROP TABLE Customers1