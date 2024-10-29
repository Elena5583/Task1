-- Скрипт для создания структуры базы данных для виртуального магазина

-- Создание таблицы 'Products' (Продукты)
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL
);

-- Создание таблицы 'Users' (Пользователи)
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    UserName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы 'Orders' (Заказы)
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    UserID INT REFERENCES Users(UserID),
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50) NOT NULL
);

-- Создание таблицы 'OrderDetails' (Детали заказа)
CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID),
    ProductID INT REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    TotalCost DECIMAL(10, 2) NOT NULL
);

-- Скрипт для запросов к базе данных виртуального магазина

-- 1. Добавление нового продукта
INSERT INTO Products (ProductName, Description, Price, QuantityInStock) 
VALUES ('Product A', 'Description of Product A', 19.99, 50);

-- 2. Обновление цены продукта
UPDATE Products 
SET Price = 24.99 
WHERE ProductID = 1;

-- 3. Выбор всех заказов определенного пользователя
SELECT * FROM Orders
WHERE UserID = 1;

-- 4. Расчет общей стоимости заказа
SELECT SUM(TotalCost) AS TotalOrderCost 
FROM OrderDetails
WHERE OrderID = 1;

-- 5. Подсчет общего количества товаров на складе
SELECT SUM(QuantityInStock) AS TotalStock 
FROM Products;

-- 6. Получение 5 самых дорогих товаров
SELECT * FROM Products
ORDER BY Price DESC
LIMIT 5;

-- 7. Список товаров с низким запасом (менее 5 штук)
SELECT * FROM Products
WHERE QuantityInStock < 5;
