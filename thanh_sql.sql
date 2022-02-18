-- 1. create database ---
CREATE DATABASE SellingPoint;

-- 2. Create all tables ---
USE SellingPoint;
CREATE TABLE Categories (
    CateID char(6) NOT NULL PRIMARY KEY,
    CateName nvarchar(100) NOT NULL,
    Description nvarchar(200)
);

CREATE TABLE Parts (
    PartID int primary key identity(1,1),
    PartName nvarchar(100) NOT NULL,
	CateID char(6),
    Description nvarchar(1000),
	Price money NOT NULL DEFAULT 0,
	Quantity int DEFAULT 0,
	Warranty int DEFAULT 1,
	Photo nvarchar(200) DEFAULT 'photo/nophoto.png',
	FOREIGN KEY (CateID) REFERENCES Categories(CateID)
);

-- 3. Insert data for 3 tables

USE [SellingPoint]
GO

INSERT INTO [dbo].[Parts]
           ([PartName]
           ,[CateID]
           ,[Description]
           ,[Price]
           ,[Quantity]
           ,[Warranty]
           ,[Photo])
     VALUES
           (N'Laptop Asus VivoBook TP470EA-EC027T(i3 1115G4/4GB RAM/512GB SSD/14 FHD Touch/Win10/Xoay/Bạc)', '1', N'Laptop Asus VivoBook TP470EA-EC027T(i3 1115G4/4GB RAM/512GB SSD/14 FHD Touch/Win10/Xoay/Bạc)', 10000, 2, 12, 'https://hanoicomputercdn.com/media/product/250_59294_laptop_asus_vivobook_tp470ea_ec027t_bac_5.jpg'),
		(N'VGA Card nVidia Quadro P400 2GB GDDR5', '2', N'VGA Card nVidia Quadro P400 2GB GDDR5', 10000, 2, 12, 'https://hanoicomputercdn.com/media/product/250_35355_leadtek_nvidia_quadro_p400_01.jpg'),
		   (N'Tai nghe Gaming Rapoo VH160', '3', N'Tai nghe Gaming Rapoo VH160', 10000, 2, 12, 'https://hanoicomputercdn.com/media/product/250_59294_laptop_asus_vivobook_tp470ea_ec027t_bac_5.jpg')
GO


USE [SellingPoint]
GO
INSERT INTO Categories (CateID, CateName, Description)
VALUES 
	('1', N'CPU', N'Phụ Kiện Laptop, PC, Khác'),
	('2', N'Linh Kiện Máy Tính', N'Linh Kiện Máy Tính'),
	('3', N'Loa, Tai Nghe, Mic, Webcam', N'Loa, Tai Nghe, Mic, Webcam');
GO

-- 4. List all parts in the store with price > 100$.

USE [SellingPoint]
GO

SELECT [PartID]
      ,[PartName]
      ,[CateID]
      ,[Description]
      ,[Price]
      ,[Quantity]
      ,[Warranty]
      ,[Photo]
  FROM [dbo].[Parts]
  WHERE Price > 100
GO

-- 5. List all parts of the category ‘CPU’.
USE [SellingPoint]
GO

SELECT *
  FROM [dbo].[Parts] as p
  JOIN Categories as c ON c.CateID = p.CateID
  WHERE c.CateName = 'CPU'
GO

-- 6. 
CREATE VIEW V_PARTS AS
SELECT PARTID, PARTNAME, CATENAME, PRICE, QUANTITY FROM PARTS 
INNER JOIN CATEGORIES ON PARTS.CATEID=CATEGORIES.CATEID;
SELECT * FROM V_PARTS;

-- 7. Create a view v_TopParts about 5 parts with the most expensive price.
CREATE VIEW V_TOPPARTS  AS
SELECT TOP 5  * FROM PARTS ORDER BY PRICE DESC;
SELECT *FROM V_PARTS
