


-- Database creation and selection
CREATE DATABASE RestaurantOrderDB;
GO

USE RestaurantOrderDB;
GO

-- Table 1: Menus (Product List - PRIMARY KEY)
CREATE TABLE Menus (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Price DECIMAL(10, 2)
);
GO

-- Table 2: OrderDetails (Transaction table - FOREIGN KEY)
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    Quantity INT,
    -- FK links to Menus(ProductID)
    ProductID INT FOREIGN KEY REFERENCES Menus(ProductID)
);
GO
USE RestaurantOrderDB;
GO

-- Inserting data into Menus
INSERT INTO Menus (ProductID, ProductName, Category, Price) VALUES
(1, 'Grilled Chicken', 'Main Course', 350.00),
(2, 'Lentil Soup', 'Soup', 75.00),
(3, 'Coke', 'Beverage', 50.00),
(4, 'Souffle', 'Dessert', 120.00),
(5, 'Salad', 'Extra', 80.00);
GO

-- Inserting data into OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, Quantity, ProductID) VALUES
(100, 1, 2, 1),
(101, 1, 3, 3),
(102, 2, 5, 3),
(103, 3, 1, 4),
(104, 4, 4, 2),
(105, 4, 1, 5),
(106, 5, 2, 1);
GO
USE RestaurantOrderDB;
GO

SELECT
    M.ProductName AS [Menu Item],
    SUM(OD.Quantity) AS [Total Orders],
    SUM(OD.Quantity) * M.Price AS [Estimated Total Revenue]
FROM
    Menus AS M
INNER JOIN
    OrderDetails AS OD ON M.ProductID = OD.ProductID
GROUP BY
    M.ProductName, M.Price
ORDER BY
    [Total Orders] DESC;
GO