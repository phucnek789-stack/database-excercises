--Cau1
SELECT *
FROM Customers, Orders

--Cau2
SELECT *
FROM Customers, Orders
WHERE Customers.CustomerID=Orders.CustomerID;

--Cau3
SELECT CustomerID, CompanyName, ContactName, Address, Country, City
FROM Customers
WHERE City=N'London' OR Country=N'France'
ORDER BY Country

--Cau4
SELECT CustomerID, CompanyName, ContactName, Address, Country, City, ContactTitle 
FROM Customers
WHERE
(ContactTitle=N'Sales Manager' AND Country=N'USA')
OR 
(ContactTitle=N'Owner' AND Country=N'Mexico')
ORDER BY Country DESC

--Cau5
SELECT CustomerID, CompanyName, ContactName, Address, Country, City, ContactTitle 
FROM Customers
WHERE
(ContactTitle Like N'%Manager%' AND Country=N'USA')
OR 
(ContactTitle <> N'Owner' AND Country=N'Mexico')
ORDER BY Country DESC

--Cau6
SELECT OrderID, OrderDate, CompanyName, LastName
FROM Orders, Customers, Employees
WHERE Customers.CustomerID = Orders.CustomerID
AND Orders.EmployeeID = Employees.EmployeeID
--AND OrderDate BETWEEN '19970101' AND '19970630'
AND (MONTH(OrderDate) BETWEEN 1 AND 6) AND YEAR(OrderDate) = 1997
ORDER BY OrderDate

--cau7
SELECT OrderID, OrderDate, CompanyName, LastName
FROM Orders, Customers, Employees
WHERE Customers.CustomerID = orders.CustomerID
AND Orders.EmployeeID = Employees.EmployeeID
--AND (OrderDate>='19970201' AND OrderDate<'19970301')
AND (MONTH(OrderDate) = 2 AND YEAR(OrderDate) = 1997)
ORDER BY OrderDate

--cau8
SELECT OrderID, OrderDate, CompanyName, LastName
FROM Orders, Customers, Employees
WHERE Customers.CustomerID = orders.CustomerID
AND Orders.EmployeeID = Employees.EmployeeID
AND MONTH(OrderDate) = 4
ORDER BY OrderDate

--cau9
SELECT OrderID, OrderDate, CompanyName, LastName
FROM Orders, Customers, Employees
WHERE Customers.CustomerID = orders.CustomerID
AND Orders.EmployeeID = Employees.EmployeeID
AND YEAR(OrderDate) % 2 = 0
ORDER BY OrderDate

--cau10
SELECT OrderID, OrderDate, CompanyName, LastName
FROM Orders, Customers, Employees
WHERE Customers.CustomerID = orders.CustomerID
AND Orders.EmployeeID = Employees.EmployeeID
AND DAY(OrderDate) IN (5,13,14,23)
ORDER BY OrderDate

--cau11
SELECT OrderID, OrderDate,
CONVERT(varchar, OrderDate, 103) AS NgayKieuVN1,
CONVERT(varchar, OrderDate, 105) AS NgayKieuVN2,
CompanyName, Freight
FROM Orders, Customers
WHERE Customers.CustomerID = orders.CustomerID
AND (ShipCountry = N'UK'
AND EmployeeID = 2
AND YEAR(OrderDate) = 1997)
ORDER BY OrderDate

--cau12
SELECT ProductID, ProductName, CompanyName, CategoryName
FROM Products, Suppliers, Categories
WHERE Suppliers.SupplierID = Products.SupplierID
AND Products.CategoryID = Categories.CategoryID
AND ProductName LIKE N'Ch%'

--cau13
SELECT ProductID, CompanyName, UnitPrice, UnitsInStock
FROM Products, Suppliers
WHERE Suppliers.SupplierID = Products.SupplierID
AND Discontinued = 1
AND UnitsInStock > 0

--cau14
SELECT CompanyName, ContactName, Country, Phone, Fax
FROM Customers
WHERE Country <> N'USA'
ORDER BY Country DESC 

--cau15
SELECT CompanyName, ContactName, Country, Phone, Fax
FROM Customers
WHERE Country NOT IN ('Brazil', 'Italy','Spain', 'Venezuela', 'UK')  
ORDER BY Country

--cau16
SELECT OrderID, CompanyName, LastName, OrderDate, ShipCountry, ShippedDate, Freight
FROM Orders, Customers, Employees
WHERE Customers.CustomerID = Orders.CustomerID
AND Orders.EmployeeID = Employees.EmployeeID
AND(
(ShipCountry = N'USA' AND Freight > 300) OR (ShipCountry = N'Argentina' AND Freight < 5)
)
ORDER BY ShipCountry

--cau17
SELECT OrderID, CompanyName, LastName, OrderDate, RequiredDate, ShipCountry, Freight
FROM Orders, Customers, Employees
WHERE Customers.CustomerID = Orders.CustomerID
AND Orders.EmployeeID = Employees.EmployeeID
AND (
CAST(OrderDate AS date) = CAST(GETDATE() AS date)
OR
CAST(RequiredDate AS date) = CAST(GETDATE() AS date)
)
ORDER BY ShipCountry
--Xoa 2 hang nhap lieu de test
DELETE FROM Orders
WHERE OrderID IN (11080, 11081)

--cau18
SELECT OrderID, CONVERT(varchar, OrderDate, 105), CompanyName, LastName, Freight, Freight*1.1 AS NewFreight
FROM Orders, Customers, Employees
WHERE Customers.CustomerID = Orders.CustomerID
AND Orders.EmployeeID = Employees.EmployeeID
AND (MONTH(OrderDate) = 4 AND YEAR(OrderDate) = 1997)
ORDER BY OrderDate

--cau19
SELECT orders.OrderID, ProductName, [Order Details].UnitPrice, Quantity,
[Order Details].UnitPrice * Quantity AS ThanhTien, Discount,
[Order Details].UnitPrice * Quantity * Discount AS TienGiamGia,
[Order Details].UnitPrice * Quantity - [Order Details].UnitPrice * Quantity * Discount AS TienPhaiTra
FROM [Order Details], Products, Orders
WHERE Products.ProductID = [Order Details].ProductID
AND [Order Details].OrderID = Orders.OrderID
AND YEAR(OrderDate) = 1997
ORDER BY TienPhaiTra DESC

--cau20
SELECT orders.OrderID, ProductName, [Order Details].UnitPrice, Quantity,
[Order Details].UnitPrice * Quantity AS ThanhTien, Discount,
[Order Details].UnitPrice * Quantity * Discount AS TienGiamGia,
[Order Details].UnitPrice * Quantity - [Order Details].UnitPrice * Quantity * Discount AS TienPhaiTra
FROM [Order Details], Products, Orders
WHERE Products.ProductID = [Order Details].ProductID
AND [Order Details].OrderID = Orders.OrderID
AND YEAR(OrderDate) = 1997
AND Discount > 0
AND ([Order Details].UnitPrice * Quantity - [Order Details].UnitPrice * Quantity * Discount) < 50
ORDER BY TienPhaiTra DESC

--cau21
SELECT ProductID, ProductName, CompanyName, UnitPrice, UnitsInStock, UnitPrice * UnitsInStock AS TriGia
FROM Products, Suppliers
WHERE Suppliers.SupplierID = Products.SupplierID
AND Discontinued = 1
AND UnitsInStock > 0
ORDER BY TriGia DESC

--Cau22
SELECT TitleOfCourtesy + ' ' + LEFT(LastName, 1) + '.' + FirstName AS HoTen,
CONVERT(varchar, HireDate, 105) AS NgayVaoLam, Title,
CONVERT(varchar, BirthDate, 103) AS NamSinh, HomePhone
FROM Employees
WHERE HireDate <= '19931231'
ORDER BY HireDate

--Cau23
SELECT COUNT(productID) AS SoSanPham,
MAX(unitPrice) AS DonGiaCaoNhat,
MIN(unitPrice) AS DonGiaThapNhat,
AVG(unitPrice) AS DonGiaTrungBinh
FROM Products

--Cau24
SELECT
COUNT(productID) AS SoSanPham,
MAX(unitPrice) AS DonGiaCaoNhat,
MIN(unitPrice) AS DonGiaThapNhat,
AVG(unitPrice) AS DonGiaTrungBinh
FROM Products
GROUP BY CategoryID
--mo rong: hien them ma va ten loai san pham
SELECT Products.CategoryID,
CategoryName,
COUNT(productID) AS SoSanPham,
MAX(unitPrice) AS DonGiaCaoNhat,
MIN(unitPrice) AS DonGiaThapNhat,
AVG(unitPrice) AS DonGiaTrungBinh
FROM Products, Categories
WHERE Products.CategoryID = Categories.CategoryID
GROUP BY Products.CategoryID, CategoryName

--cau25
SELECT COUNT(OrderID) AS SoDonHang
FROM Orders
WHERE ShipCountry IN (N'Belgium', N'Canada', N'UK')

--cau26
SELECT ShipCountry, COUNT(OrderID) AS SoDonHang
FROM Orders
WHERE ShipCountry IN (N'Belgium', N'Canada', N'UK')
GROUP BY ShipCountry 

--cau27: Lap danh sach cac loai sp co don gia tb > 30
SELECT Categories.CategoryID, CategoryName, AVG(UnitPrice) AS DonGiaTrungBinh
FROM Categories, Products
WHERE Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryID, CategoryName
HAVING AVG(UnitPrice) > 30
--doi tuong bi loc: ca 1 nhom (categories)
--thoi diem loc: sau khi da tinh toan xong (AVG)
--So luong sp: Tinh tren toan bo sp cua loai do

--Cau28: Tinh đon gia tb cua moi loai sp, chi thong ke tren cac sp co don gia > 30
SELECT Categories.CategoryID, CategoryName, AVG(UnitPrice) AS DonGiaTrungBinh
FROM Categories, Products
WHERE Categories.CategoryID = Products.CategoryID
AND UnitPrice > 30
GROUP BY Categories.CategoryID, CategoryName
--doi tuong bi loc: tung dong du lieu (Product)
--thoi diem loc: Truoc khi dua vao tinh toan
--so luong sp: Chi tinh tren cac sp thoa dieu kien > 30

--cau29
SELECT CategoryName, SUM([Order Details].UnitPrice*Quantity*(1-Discount)) AS DoanhSo
FROM Categories, Products, [Order Details], Orders
WHERE Categories.CategoryID = Products.CategoryID
AND Products.ProductID = [Order Details].ProductID
AND [Order Details].OrderID = Orders.OrderID
AND YEAR(OrderDate) = 1996
GROUP BY CategoryName

--cau30
SELECT CompanyName, (SUM(freight)/SUM(UnitPrice*Quantity*(1-Discount))) AS TiLeCuoc
FROM Customers, Orders, [Order Details]
WHERE Customers.CustomerID = Orders.CustomerID
AND Orders.OrderID = [Order Details].OrderID
AND YEAR(OrderDate) = 1997
GROUP BY CompanyName

--Cau31
SELECT TOP 39 ProductID, ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--Cau32
SELECT TOP 50 PERCENT ProductID, ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--Cau33
SELECT TOP 10 Customers.CustomerID, CompanyName, COUNT(OrderID) AS SoLuongDonHang
FROM Customers, Orders
WHERE Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, CompanyName
ORDER BY COUNT(OrderID) DESC

--Cau34
SELECT CustomerID, CompanyName, Country
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders)

--Cau35
SELECT CustomerID, CompanyName, Country
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders)