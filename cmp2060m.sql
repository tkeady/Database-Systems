/*create the database*/
CREATE DATABASE cmp2060m;
/*selects the database to operate on*/
USE
    cmp2060m;
    /*table creation, arranged alphabetically beginning with
table to store customer details*/
CREATE TABLE Customer(
    CustomerID INT NOT NULL AUTO_INCREMENT,
    -- Primary Key
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Email VARCHAR(60),
    DateOfBirth DATE,
    HouseNumber VARCHAR(8),
    Street VARCHAR(30),
    City VARCHAR(30),
    County VARCHAR(30),
    Postcode VARCHAR(8),
    PhoneNumber VARCHAR(13),
    PRIMARY KEY(CustomerID),
    UNIQUE(CustomerID, Email)
);
/*details of the order placed by customer, includes default value*/
CREATE TABLE Customer_Order(
    OrderID INT NOT NULL AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    PaymentDate DATE,
    DispatchDate DATE,
    DeliveryDate DATE,
    HouseNumber VARCHAR(8),
    Street VARCHAR(30),
    City VARCHAR(30),
    County VARCHAR(30),
    Postcode VARCHAR(8),
    OrderStatus VARCHAR(20) DEFAULT 'PROCESSING',
    FulfilledBy INT NOT NULL,
    PRIMARY KEY(OrderID),
    UNIQUE(OrderID)
);
/*details of item ordered by customer, has partial primary keys*/
CREATE TABLE Customer_Order_Item(
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY(OrderID, ItemID)
);
/*supplier details*/
CREATE TABLE Supplier(
    SupplierID INT NOT NULL AUTO_INCREMENT,
    SupplierName VARCHAR(60),
    HouseNumber VARCHAR(8),
    Street VARCHAR(50),
    City VARCHAR(30),
    County VARCHAR(30),
    Postcode VARCHAR(8),
    PhoneNumber VARCHAR(13),
    PRIMARY KEY(SupplierID),
    UNIQUE(SupplierID)
);
/*details of orders given to suppliers*/
CREATE TABLE Purchase_Order(
    OrderID INT NOT NULL AUTO_INCREMENT,
    PaymentDate DATE,
    PRIMARY KEY(OrderID),
    UNIQUE(OrderID)
);
/*details of item requested from the supplier in purchase order, has partial keys*/
CREATE TABLE Purchase_Order_Item(
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY(OrderID, ItemID)
);
/*staff details*/
CREATE TABLE Staff(
    StaffId INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    DateOfBirth DATE,
    Email VARCHAR(60),
    PRIMARY KEY(StaffId),
    UNIQUE(StaffId)
);
/*details of stock held, has foreign key from supplier*/
CREATE TABLE Stock_Item(
    StockID INT NOT NULL AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    StockName VARCHAR(100),
    StockPrice DECIMAL(6, 2),
    PRIMARY KEY(StockID),
    UNIQUE(StockID)
);
/*set increment starting point*/
ALTER TABLE
    Customer AUTO_INCREMENT = 1000;
ALTER TABLE
    Customer_Order AUTO_INCREMENT = 1000;
ALTER TABLE
    Purchase_Order AUTO_INCREMENT = 1000;
ALTER TABLE
    Stock_Item AUTO_INCREMENT = 1000;
ALTER TABLE
    Supplier AUTO_INCREMENT = 1000;
    /*foreign key and constraints*/
ALTER TABLE
    Customer_Order ADD CONSTRAINT fk_customer_id_customer_order FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE
    Stock_Item ADD CONSTRAINT fk_supplier_id_stock_item FOREIGN KEY(SupplierID) REFERENCES Supplier(SupplierID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE
    Customer_Order_Item ADD CONSTRAINT fk_order_id_customer_order_item FOREIGN KEY(OrderID) REFERENCES Customer_Order(OrderID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE
    Customer_Order_Item ADD CONSTRAINT fk_item_id_customer_order_item FOREIGN KEY(ItemID) REFERENCES Stock_Item(StockID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE
    Purchase_Order_Item ADD CONSTRAINT fk_order_id_purchase_order_item FOREIGN KEY(OrderID) REFERENCES Purchase_Order(OrderID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE
    Purchase_Order_Item ADD CONSTRAINT fk_item_id_purchase_order_item FOREIGN KEY(ItemID) REFERENCES Stock_Item(StockID) ON UPDATE CASCADE ON DELETE CASCADE;
    /*no delete cascade because we want this data still*/
ALTER TABLE
    Customer_Order ADD CONSTRAINT fk_staff_id_customer_order FOREIGN KEY(FulfilledBy) REFERENCES Staff(StaffID) ON UPDATE CASCADE;
/*insert data into tables, proceeding alphabetically*/
INSERT INTO Customer(
    FirstName,
    LastName,
    Email,
    DateOfBirth,
    HouseNumber,
    Street,
    City,
    County,
    Postcode,
    PhoneNumber
)
VALUES(
    'Mert',
    'Woodard',
    'mwoodard@gmail.com',
    '1989-12-18',
    '8',
    'Silverbridge',
    'Lincoln',
    'Lincolnshire',
    'LN2 4RS',
    '07769001463'
),(
    'Paul',
    'Stevens',
    'pstevens@gmail.com',
    '1962-05-30',
    '49',
    'Orange Valley',
    'Norwich',
    'Norfolk',
    'NR12 8TR',
    '07223876387'
),(
    'Fern',
    'Gabriel',
    'fgabriel@gmail.com',
    '1970-01-03',
    '117',
    'Eleven Court',
    'Chelmsford',
    'Essex',
    'CH10 9BB',
    '07090558264'
);
/* insert customer order data */
INSERT INTO Customer_Order(
    CustomerID,
    PaymentDate,
    DispatchDate,
    DeliveryDate,
    HouseNumber,
    Street,
    City,
    County,
    Postcode,
    FulfilledBy
)
VALUES(
    1001,
    '2017-04-12',
    '2017-04-15',
    '2017-04-18',
    '710',
    'Daisy Meadow',
    'Exeter',
    'Devon',
    'EX8 3SZ',
    3
),(
    1000,
    '2018-12-27',
    '2018-12-30',
    '2019-01-02',
    '67',
    'Pike Avenue',
    'Peterborough',
    'Cambridgeshire',
    'PE1 4EC',
    2
),(
    1002,
    '2018-02-10',
    '2018-02-13',
    '2018-02-16',
    '9',
    'Spanner Drive',
    'Lincoln',
    'Lincolnshire',
    'LN6 6VJ',
    2
),(
    1000,
    '2016-07-29',
    '2016-08-01',
    '2016-08-04',
    '67',
    'Pike Avenue',
    'Peterborough',
    'Cambridgeshire',
    'PE1 4EC',
    3
);
/* insert customer order item data */
INSERT INTO Customer_Order_Item
VALUES(1000, 100, 1),(1000, 1001, 2),(1002, 1003, 10);
/*  insert purchase order data*/
INSERT INTO Purchase_Order(PaymentDate)
VALUES('2018-06-19'),('2018-03-31'),('2018-10-12');
/* insert purchase order item data */
INSERT INTO Purchase_Order_Item
VALUES(1000, 1000, 2),(1001, 1001, 3),(1002, 1002, 6),(1002, 1003, 1);
/* insert staff data */
INSERT INTO Staff(
    FirstName,
    LastName,
    DateOfBirth,
    Email
)
VALUES(
    'Jenny',
    'Watson',
    '1994-12-28',
    'jwatson@gmail.com'
),(
    'Laura',
    'Drake',
    '1984-02-16',
    'ldrake@gmail.com'
),(
    'Henry',
    'White',
    '1956-06-07',
    'hwhite@gmail.com'
);
/* insert stock data */
INSERT INTO Stock_Item(
    SupplierID,
    StockName,
    StockPrice
)
VALUES(1, 'Battery', 9.99),(1, 'Light Bulb', 4.99),(2, 'Desk Fan', 19.99),(3, 'Hard Drive', 49.99);
/* insert supplier data*/
INSERT INTO Supplier(
    SupplierName,
    HouseNumber,
    Street,
    City,
    County,
    Postcode,
    PhoneNumber
)
VALUES(
    'Leopard Energy',
    '72',
    'Galaxy Lane',
    'Sheffield',
    'Yorkshire',
    'S15 6XS',
    '07755920743'
),(
    'Everything Warehouse',
    '48',
    'Bakery Way',
    'Leicester',
    'Leicestershire',
    'LE2 3LK',
    '07176653911'
),(
    'Loadsa Goods',
    '17',
    'Sand Road',
    'Swansea',
    'Swansea',
    'SA1 9WA',
    '07408212987'
);/*update,set commands to overwrite default 'processing' data entry*/
UPDATE
    Customer_Order
SET
    OrderStatus = 'CONFIRMED'
WHERE
    OrderId = 1000;
UPDATE
    Customer_Order
SET
    OrderStatus = 'DELIVERED'
WHERE
    OrderId = 1002;
    /* Altering table to add customer order information and adding a default value of none. */
ALTER TABLE
    Customer_Order ADD OrderInformation VARCHAR(255) DEFAULT "None";
UPDATE
    Customer_Order
SET
    OrderInformation = "Leave with neighbour"
WHERE
    Postcode = 'EX8 3SZ';
    /*delete command to remove whole entry from staff table*/
DELETE
FROM
    Staff
WHERE
    Email = 'hwhite@gmail.com';
    /*join statements*/
    /*left join provides staff who carried out the order and the item dispatch date*/
SELECT
    customer_order.OrderID AS `Order Number`,
    customer_order.DispatchDate AS `Day Dispatched`,
    CONCAT(
        staff.FirstName,
        ' ',
        staff.LastName
    ) AS `Served By`
FROM
    customer_order
LEFT JOIN staff ON customer_order.FulfilledBy = staff.StaffID;
    /*right join provides how much the item total costs were and shows 
the original information, truncate is for the total cost of the items*/
SELECT
    customer_order_item.OrderID AS `Order Number`,
    customer_order_item.Quantity AS `Item Quantity`,
    stock_item.StockName AS `Item Name`,
    stock_item.StockPrice AS `Item Price`,
TRUNCATE
    (
        (
            customer_order_item.Quantity * stock_item.StockPrice
        ),
        2
    ) AS `Total Price`
FROM
    customer_order_item
RIGHT JOIN stock_item ON customer_order_item.ItemID = stock_item.StockID
WHERE
    customer_order_item.OrderID IS NOT NULL;
    /* union to provide all supplier and customer addresses with corresponding name*/
SELECT
    CustomerID AS `ID Number`,
    CONCAT(FirstName, " ", LastName) AS NAME,
    CONCAT(
        HouseNumber,
        ", ",
        Street,
        ", ",
        City,
        ", ",
        County,
        ", ",
        Postcode
    ) AS `Full Address`
FROM
    customer
UNION
SELECT
    SupplierID AS `ID Number`,
    SupplierName AS NAME,
    CONCAT(
        HouseNumber,
        ", ",
        Street,
        ", ",
        City,
        ", ",
        County,
        ", ",
        Postcode
    ) AS `Full Address`
FROM
    supplier
ORDER BY
    `ID Number` ASC;
    /*inner join to provide stock info and who the supplier is,
 creates a variable to be used in execute statement*/
PREPARE
    inner_join
FROM
    'SELECT * FROM stock_item INNER JOIN supplier ON stock_item.SupplierID = ?';
SET
    @supplier_id = 'supplier.SupplierID';
EXECUTE
    inner_join USING @supplier_id;
DEALLOCATE
PREPARE
    inner_join;
    /*create stored procedure which backs up database and creates copies using copy command,
delimiter used because semi colons will be misinterpreted otherwise*/
DELIMITER
    //
CREATE PROCEDURE DatabaseBackup()
BEGIN
        /* error handling will revert changes made and halt procedure*/
        DECLARE EXIT
    HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK
        ;
    SELECT
        'Error encountered, database rollbacked and procedure terminated' ;
END ;
/* copy customer table */
CREATE TABLE IF NOT EXISTS copy_of_customer LIKE customer ; INSERT
    copy_of_customer SELECT
        *
    FROM
        customer ;
        /* copy customer_order table */
    CREATE TABLE IF NOT EXISTS copy_of_customer_order LIKE customer_order ; INSERT
        copy_of_customer_order SELECT
            *
        FROM
            customer_order ;
            /* copy customer_order_item table */
        CREATE TABLE IF NOT EXISTS copy_of_customer_order_item LIKE customer_order_item ; INSERT
            copy_of_customer_order_item SELECT
                *
            FROM
                customer_order_item ;
                /* copy supplier table */
            CREATE TABLE IF NOT EXISTS copy_of_supplier LIKE supplier ; INSERT
                copy_of_supplier SELECT
                    *
                FROM
                    supplier ;
                    /* copy purchase_order table */
                CREATE TABLE IF NOT EXISTS copy_of_purchase_order LIKE purchase_order ; INSERT
                    copy_of_purchase_order SELECT
                        *
                    FROM
                        purchase_order ;
                        /* Copy purchase_order_item table */
                    CREATE TABLE IF NOT EXISTS copy_of_purchase_order_item LIKE purchase_order_item ; INSERT
                        copy_of_purchase_order_item SELECT
                            *
                        FROM
                            purchase_order_item ;
                            /* copy staff table */
                        CREATE TABLE IF NOT EXISTS copy_of_staff LIKE staff ; INSERT
                            copy_of_staff SELECT
                                *
                            FROM
                                staff ;
                                /* copy stock_item table */
                            CREATE TABLE IF NOT EXISTS copy_of_stock_item LIKE stock_item ; INSERT
                                copy_of_stock_item SELECT
                                    *
                                FROM
                                    stock_item ;
    END //
DELIMITER
    ;
    /* call stored procedure, copying the existing tables */
CALL
    DatabaseBackup();
    /*create new user with no drop privilege */
CREATE USER IF NOT EXISTS 'default'@'localhost' IDENTIFIED BY 'nodrop'; GRANT
SELECT
    ,
INSERT
    , UPDATE
        ,
    DELETE
        , INDEX,
    CREATE, ALTER
ON
    assignment TO 'default'@'localhost';
    /* shows privileges*/
SHOW GRANTS FOR
    'default'@'localhost';