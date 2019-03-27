CREATE DATABASE QuanLyQuanCafe
GO

USE QuanLyQuanCafe
GO

-- Food
-- Table
-- FoodCategory
-- Account
-- Bill
-- BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống'	-- Trống || Có người
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,	
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Kter',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL  DEFAULT 0 -- 1: admin && 0: staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1: đã thanh toán && 0: chưa thanh toán
	
	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO

INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'K9' , -- UserName - nvarchar(100)
          N'RongK9' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          1  -- Type - int
        )
INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'staff' , -- UserName - nvarchar(100)
          N'staff' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          0  -- Type - int
        )
GO

CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'k9' -- nvarchar(100)

GO

CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO

-- thêm bàn
DECLARE @i INT = 0

WHILE @i <= 10
BEGIN
	INSERT dbo.TableFood ( name)VALUES  ( N'Bàn ' + CAST(@i AS nvarchar(100)))
	SET @i = @i + 1
END
GO

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO

UPDATE dbo.TableFood SET STATUS = N'Có người' WHERE id = 9

EXEC dbo.USP_GetTableList
GO

-- thêm category
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Hải sản'  -- name - nvarchar(100)
          )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Nông sản' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Lâm sản' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Sản sản' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Nước' )

-- thêm món ăn
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Mực một nắng nước sa tế', -- name - nvarchar(100)
          1, -- idCategory - int
          120000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Nghêu hấp xả', 1, 50000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Dú dê nướng sữa', 2, 60000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Heo rừng nướng muối ớt', 3, 75000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Cơm chiên mushi', 4, 999999)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'7Up', 5, 15000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Cafe', 5, 12000)

-- thêm bill
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          3 , -- idTable - int
          0  -- status - int
        )
        
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          4, -- idTable - int
          0  -- status - int
        )
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          GETDATE() , -- DateCheckOut - date
          5 , -- idTable - int
          1  -- status - int
        )

-- thêm bill info
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 5, -- idBill - int
          1, -- idFood - int
          2  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 5, -- idBill - int
          3, -- idFood - int
          4  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 5, -- idBill - int
          5, -- idFood - int
          1  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 6, -- idBill - int
          1, -- idFood - int
          2  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 6, -- idBill - int
          6, -- idFood - int
          2  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 7, -- idBill - int
          5, -- idFood - int
          2  -- count - int
          )         
          
GO
SELECT f.name, bi.count, f.price, f.price*bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.idTable =3

SELECT * FROM dbo.Bill