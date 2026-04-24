CREATE DATABASE TourismOrdersDB;
GO

USE TourismOrdersDB;
GO

CREATE TABLE Clients (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20),
    Email NVARCHAR(100)
);
GO

CREATE TABLE Tours (
    TourID INT IDENTITY(1,1) PRIMARY KEY,
    TourName NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    DurationDays INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE Services (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName NVARCHAR(100) NOT NULL,
    ServiceCost DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE PaymentMethods (
    PaymentMethodID INT IDENTITY(1,1) PRIMARY KEY,
    MethodName NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    TourID INT NOT NULL,
    ServiceID INT NULL,
    PaymentMethodID INT NOT NULL,
    OrderDate DATE NOT NULL,
    PersonsCount INT NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_Orders_Clients
        FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),

    CONSTRAINT FK_Orders_Tours
        FOREIGN KEY (TourID) REFERENCES Tours(TourID),

    CONSTRAINT FK_Orders_Services
        FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),

    CONSTRAINT FK_Orders_PaymentMethods
        FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID)
);
GO

INSERT INTO Clients (FullName, Phone, Email)
VALUES 
(N'Иванов Иван Иванович', N'+79000000001', N'ivanov@example.com'),
(N'Петрова Анна Сергеевна', N'+79000000002', N'petrova@example.com');

INSERT INTO Tours (TourName, Country, DurationDays, Price)
VALUES
(N'Отдых в Анталии', N'Турция', 7, 75000.00),
(N'Экскурсионный тур в Рим', N'Италия', 5, 95000.00);

INSERT INTO Services (ServiceName, ServiceCost)
VALUES
(N'Трансфер из аэропорта', 5000.00),
(N'Медицинская страховка', 3000.00);

INSERT INTO PaymentMethods (MethodName)
VALUES
(N'Банковская карта'),
(N'Наличные');

INSERT INTO Orders (ClientID, TourID, ServiceID, PaymentMethodID, OrderDate, PersonsCount, TotalAmount)
VALUES
(1, 1, 1, 1, '2026-04-20', 2, 155000.00),
(2, 2, 2, 2, '2026-04-21', 1, 98000.00);
GO
