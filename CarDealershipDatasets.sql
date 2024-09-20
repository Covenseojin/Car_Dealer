-- Vehicle Table
CREATE TABLE Vehicle (
    VehicleID INTEGER PRIMARY KEY,
    ModelName TEXT,
    VehicleType TEXT,
    Price REAL,
    FuelType TEXT
);

-- Salesperson Table
CREATE TABLE Salesperson (
    SalespersonID INTEGER PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT
);

-- Sales Transaction Table
CREATE TABLE SalesTransaction (
    TransactionID INTEGER PRIMARY KEY,
    VehicleID INTEGER,
    SalespersonID INTEGER,
    SaleDate DATE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
    FOREIGN KEY (SalespersonID) REFERENCES Salesperson(SalespersonID)
);

-- Data for Vehicle Table
INSERT INTO Vehicle (ModelName, VehicleType, Price, FuelType) VALUES
('Sedan A', 'Sedan', 1200000, 'Petrol'),
('SUV X', 'SUV', 1500000, 'Electric'),
('Hatchback B', 'Hatchback', 800000, 'Petrol'),
('Sedan C', 'Sedan', 900000, 'Electric'),
('Truck Y', 'Truck', 2000000, 'Diesel'),
('SUV A', 'SUV', 1700000, 'Electric'),
('SUV Y', 'SUV', 1800000, 'Electric'),
('SUV Z', 'SUV', 1700000, 'Electric'),
('Hatchback C', 'Hatchback', 2100000, 'Petrol'),
('Sedan X', 'Sedan', 1500000, 'Petrol'),
('SUV B', 'SUV', 1300000, 'Electric');

-- Data for Salesperson Table
INSERT INTO Salesperson (FirstName, LastName) VALUES
('John', 'Doe'),
('Jane', 'Smith'),
('Bob', 'Johnson');

-- Data for Sales Transaction Table
INSERT INTO SalesTransaction (VehicleID, SalespersonID, SaleDate) VALUES
(1, 1, '2023-03-01'),
(2, 2, '2023-03-02'),
(3, 1, '2023-03-03'),
(4, 3, '2023-03-03'),
(5, 2, '2023-03-04'),
(6, 2, '2023-03-04'),
(7, 2, '2024-03-04'),
(8, 3, '2024-03-04'),
(9, 3, '2024-03-04'),
(10, 2, '2024-03-04'),
(11, 1, '2024-03-04'),
(12, 2, '2024-03-04');

-- RUN PREVIEW
.print #######################
.print #### SQL Challenge ####
.print #######################

.print \n Vehicle table
.mode box
select * from Vehicle limit 5;

.print \n Salesperson table
.mode box
select * from Salesperson limit 5;

.print \n SalesTransaction table
.mode box
select * from SalesTransaction limit 5;


select Vehicle.VehicleType , COUNT(SalesTransaction.TransactionID) AS TotalSales
from Vehicle
join SalesTransaction on Vehicle.VehicleID = SalesTransaction.VehicleID
group by Vehicle.VehicleType
order by TotalSales desc;

select  Salesperson.FirstName, Salesperson.LastName ,COUNT(SalesTransaction.TransactionID) AS TotalTransactions
from Salesperson
join SalesTransaction on Salesperson.SalespersonID = SalesTransaction.SalespersonID
group by Salesperson.FirstName, Salesperson.LastName;

select Salesperson.FirstName, Salesperson.LastName, SUM(Vehicle.Price) as TotalRevenue
From Salesperson
join SalesTransaction on Salesperson.SalespersonID = Salestransaction.SalespersonID
join Vehicle on Salestransaction.VehicleID = SalesTransaction.VehicleID
Group by Salesperson. SalespersonID
Order by TotalRevenue desc;

select Vehicle.FuelType , COUNT(SalesTransaction.TransactionID) AS TotalSales
from Vehicle
join SalesTransaction on Vehicle.VehicleID = SalesTransaction.VehicleID
where strftime('%Y' , SalesTransaction.SaleDate) = '2023' AND Vehicle.FuelType IN ('Petrol' , 'Electric')
group by Vehicle.FuelType;

select  Vehicle.ModelName  , sum(Vehicle.Price) as Price,
    CASE 
        when Price >= 1000000 then 'Flagship Model'
        ELSE 'Normal Model'
    end as ModelLabel
from Vehicle
join SalesTransaction on Vehicle.VehicleID = SalesTransaction.VehicleID
group by Vehicle.ModelName
order by Vehicle.ModelName Asc;
