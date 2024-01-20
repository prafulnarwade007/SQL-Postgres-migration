-- ------------ Write DROP-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE northwind_dbo."Order Details" DROP CONSTRAINT fk_order_details_orders_1461580245;

ALTER TABLE northwind_dbo."Order Details" DROP CONSTRAINT fk_order_details_products_1477580302;

ALTER TABLE northwind_dbo.customercustomerdemo DROP CONSTRAINT fk_customercustomerdemo_2021582240;

ALTER TABLE northwind_dbo.customercustomerdemo DROP CONSTRAINT fk_customercustomerdemo_customers_2037582297;

ALTER TABLE northwind_dbo.employees DROP CONSTRAINT fk_employees_employees_917578307;

ALTER TABLE northwind_dbo.employeeterritories DROP CONSTRAINT fk_employeeterritories_employees_2117582582;

ALTER TABLE northwind_dbo.employeeterritories DROP CONSTRAINT fk_employeeterritories_territories_2133582639;

ALTER TABLE northwind_dbo.orders DROP CONSTRAINT fk_orders_customers_1125579048;

ALTER TABLE northwind_dbo.orders DROP CONSTRAINT fk_orders_employees_1141579105;

ALTER TABLE northwind_dbo.orders DROP CONSTRAINT fk_orders_shippers_1157579162;

ALTER TABLE northwind_dbo.products DROP CONSTRAINT fk_products_categories_1285579618;

ALTER TABLE northwind_dbo.products DROP CONSTRAINT fk_products_suppliers_1301579675;

ALTER TABLE northwind_dbo.territories DROP CONSTRAINT fk_territories_region_2085582468;

-- ------------ Write DROP-CONSTRAINT-stage scripts -----------

ALTER TABLE northwind_dbo."Order Details" DROP CONSTRAINT ck_discount_1493580359;

ALTER TABLE northwind_dbo."Order Details" DROP CONSTRAINT ck_quantity_1509580416;

ALTER TABLE northwind_dbo."Order Details" DROP CONSTRAINT ck_unitprice_1525580473;

ALTER TABLE northwind_dbo."Order Details" DROP CONSTRAINT pk_order_details_1397580017;

ALTER TABLE northwind_dbo.categories DROP CONSTRAINT pk_categories_965578478;

ALTER TABLE northwind_dbo.customercustomerdemo DROP CONSTRAINT pk_customercustomerdemo_1989582126;

ALTER TABLE northwind_dbo.customerdemographics DROP CONSTRAINT pk_customerdemographics_2005582183;

ALTER TABLE northwind_dbo.customers DROP CONSTRAINT pk_customers_997578592;

ALTER TABLE northwind_dbo.employees DROP CONSTRAINT ck_birthdate_933578364;

ALTER TABLE northwind_dbo.employees DROP CONSTRAINT pk_employees_901578250;

ALTER TABLE northwind_dbo.employeeterritories DROP CONSTRAINT pk_employeeterritories_2101582525;

ALTER TABLE northwind_dbo.orders DROP CONSTRAINT pk_orders_1093578934;

ALTER TABLE northwind_dbo.products DROP CONSTRAINT ck_products_unitprice_1317579732;

ALTER TABLE northwind_dbo.products DROP CONSTRAINT ck_reorderlevel_1333579789;

ALTER TABLE northwind_dbo.products DROP CONSTRAINT ck_unitsinstock_1349579846;

ALTER TABLE northwind_dbo.products DROP CONSTRAINT ck_unitsonorder_1365579903;

ALTER TABLE northwind_dbo.products DROP CONSTRAINT pk_products_1189579276;

ALTER TABLE northwind_dbo.region DROP CONSTRAINT pk_region_2053582354;

ALTER TABLE northwind_dbo.shippers DROP CONSTRAINT pk_shippers_1029578706;

ALTER TABLE northwind_dbo.suppliers DROP CONSTRAINT pk_suppliers_1061578820;

ALTER TABLE northwind_dbo.territories DROP CONSTRAINT pk_territories_2069582411;

-- ------------ Write DROP-INDEX-stage scripts -----------

DROP INDEX IF EXISTS northwind_dbo."IX_Order Details_OrderID";

DROP INDEX IF EXISTS northwind_dbo."IX_Order Details_OrdersOrder_Details";

DROP INDEX IF EXISTS northwind_dbo."IX_Order Details_ProductID";

DROP INDEX IF EXISTS northwind_dbo."IX_Order Details_ProductsOrder_Details";

DROP INDEX IF EXISTS northwind_dbo.ix_categories_categoryname;

DROP INDEX IF EXISTS northwind_dbo.ix_customers_city;

DROP INDEX IF EXISTS northwind_dbo.ix_customers_companyname;

DROP INDEX IF EXISTS northwind_dbo.ix_customers_postalcode;

DROP INDEX IF EXISTS northwind_dbo.ix_customers_region;

DROP INDEX IF EXISTS northwind_dbo.ix_employees_lastname;

DROP INDEX IF EXISTS northwind_dbo.ix_employees_postalcode;

DROP INDEX IF EXISTS northwind_dbo.ix_orders_customerid;

DROP INDEX IF EXISTS northwind_dbo.ix_orders_customersorders;

DROP INDEX IF EXISTS northwind_dbo.ix_orders_employeeid;

DROP INDEX IF EXISTS northwind_dbo.ix_orders_employeesorders;

DROP INDEX IF EXISTS northwind_dbo.ix_orders_orderdate;

DROP INDEX IF EXISTS northwind_dbo.ix_orders_shippeddate;

DROP INDEX IF EXISTS northwind_dbo.ix_orders_shippersorders;

DROP INDEX IF EXISTS northwind_dbo.ix_orders_shippostalcode;

DROP INDEX IF EXISTS northwind_dbo.ix_products_categoriesproducts;

DROP INDEX IF EXISTS northwind_dbo.ix_products_categoryid;

DROP INDEX IF EXISTS northwind_dbo.ix_products_productname;

DROP INDEX IF EXISTS northwind_dbo.ix_products_supplierid;

DROP INDEX IF EXISTS northwind_dbo.ix_products_suppliersproducts;

DROP INDEX IF EXISTS northwind_dbo.ix_suppliers_companyname;

DROP INDEX IF EXISTS northwind_dbo.ix_suppliers_postalcode;

-- ------------ Write DROP-TABLE-stage scripts -----------

DROP TABLE IF EXISTS northwind_dbo."Order Details";

DROP TABLE IF EXISTS northwind_dbo.categories;

DROP TABLE IF EXISTS northwind_dbo.customercustomerdemo;

DROP TABLE IF EXISTS northwind_dbo.customerdemographics;

DROP TABLE IF EXISTS northwind_dbo.customers;

DROP TABLE IF EXISTS northwind_dbo.employees;

DROP TABLE IF EXISTS northwind_dbo.employeeterritories;

DROP TABLE IF EXISTS northwind_dbo.orders;

DROP TABLE IF EXISTS northwind_dbo.products;

DROP TABLE IF EXISTS northwind_dbo.region;

DROP TABLE IF EXISTS northwind_dbo.shippers;

DROP TABLE IF EXISTS northwind_dbo.suppliers;

DROP TABLE IF EXISTS northwind_dbo.territories;

-- ------------ Write CREATE-DATABASE-stage scripts -----------

CREATE SCHEMA IF NOT EXISTS northwind_dbo;

-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE northwind_dbo."Order Details"(
    orderid INTEGER NOT NULL,
    productid INTEGER NOT NULL,
    unitprice NUMERIC(19,4) NOT NULL DEFAULT (0),
    quantity SMALLINT NOT NULL DEFAULT (1),
    discount DOUBLE PRECISION NOT NULL DEFAULT (0)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.categories(
    categoryid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    categoryname VARCHAR(15) NOT NULL,
    description TEXT,
    picture BYTEA
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.customercustomerdemo(
    customerid CHAR(5) NOT NULL,
    customertypeid CHAR(10) NOT NULL
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.customerdemographics(
    customertypeid CHAR(10) NOT NULL,
    customerdesc TEXT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.customers(
    customerid CHAR(5) NOT NULL,
    companyname VARCHAR(40) NOT NULL,
    contactname VARCHAR(30),
    contacttitle VARCHAR(30),
    address VARCHAR(60),
    city VARCHAR(15),
    region VARCHAR(15),
    postalcode VARCHAR(10),
    country VARCHAR(15),
    phone VARCHAR(24),
    fax VARCHAR(24)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.employees(
    employeeid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    lastname VARCHAR(20) NOT NULL,
    firstname VARCHAR(10) NOT NULL,
    title VARCHAR(30),
    titleofcourtesy VARCHAR(25),
    birthdate TIMESTAMP WITHOUT TIME ZONE,
    hiredate TIMESTAMP WITHOUT TIME ZONE,
    address VARCHAR(60),
    city VARCHAR(15),
    region VARCHAR(15),
    postalcode VARCHAR(10),
    country VARCHAR(15),
    homephone VARCHAR(24),
    extension VARCHAR(4),
    photo BYTEA,
    notes TEXT,
    reportsto INTEGER,
    photopath VARCHAR(255)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.employeeterritories(
    employeeid INTEGER NOT NULL,
    territoryid VARCHAR(20) NOT NULL
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.orders(
    orderid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    customerid CHAR(5),
    employeeid INTEGER,
    orderdate TIMESTAMP WITHOUT TIME ZONE,
    requireddate TIMESTAMP WITHOUT TIME ZONE,
    shippeddate TIMESTAMP WITHOUT TIME ZONE,
    shipvia INTEGER,
    freight NUMERIC(19,4) DEFAULT (0),
    shipname VARCHAR(40),
    shipaddress VARCHAR(60),
    shipcity VARCHAR(15),
    shipregion VARCHAR(15),
    shippostalcode VARCHAR(10),
    shipcountry VARCHAR(15)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.products(
    productid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    productname VARCHAR(40) NOT NULL,
    supplierid INTEGER,
    categoryid INTEGER,
    quantityperunit VARCHAR(20),
    unitprice NUMERIC(19,4) DEFAULT (0),
    unitsinstock SMALLINT DEFAULT (0),
    unitsonorder SMALLINT DEFAULT (0),
    reorderlevel SMALLINT DEFAULT (0),
    discontinued NUMERIC(1,0) NOT NULL DEFAULT (0)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.region(
    regionid INTEGER NOT NULL,
    regiondescription CHAR(50) NOT NULL
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.shippers(
    shipperid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    companyname VARCHAR(40) NOT NULL,
    phone VARCHAR(24)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.suppliers(
    supplierid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    companyname VARCHAR(40) NOT NULL,
    contactname VARCHAR(30),
    contacttitle VARCHAR(30),
    address VARCHAR(60),
    city VARCHAR(15),
    region VARCHAR(15),
    postalcode VARCHAR(10),
    country VARCHAR(15),
    phone VARCHAR(24),
    fax VARCHAR(24),
    homepage TEXT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE northwind_dbo.territories(
    territoryid VARCHAR(20) NOT NULL,
    territorydescription CHAR(50) NOT NULL,
    regionid INTEGER NOT NULL
)
        WITH (
        OIDS=FALSE
        );

-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX "IX_Order Details_OrderID"
ON northwind_dbo."Order Details"
USING BTREE (orderid ASC);

CREATE INDEX "IX_Order Details_OrdersOrder_Details"
ON northwind_dbo."Order Details"
USING BTREE (orderid ASC);

CREATE INDEX "IX_Order Details_ProductID"
ON northwind_dbo."Order Details"
USING BTREE (productid ASC);

CREATE INDEX "IX_Order Details_ProductsOrder_Details"
ON northwind_dbo."Order Details"
USING BTREE (productid ASC);

CREATE INDEX ix_categories_categoryname
ON northwind_dbo.categories
USING BTREE (categoryname ASC);

CREATE INDEX ix_customers_city
ON northwind_dbo.customers
USING BTREE (city ASC);

CREATE INDEX ix_customers_companyname
ON northwind_dbo.customers
USING BTREE (companyname ASC);

CREATE INDEX ix_customers_postalcode
ON northwind_dbo.customers
USING BTREE (postalcode ASC);

CREATE INDEX ix_customers_region
ON northwind_dbo.customers
USING BTREE (region ASC);

CREATE INDEX ix_employees_lastname
ON northwind_dbo.employees
USING BTREE (lastname ASC);

CREATE INDEX ix_employees_postalcode
ON northwind_dbo.employees
USING BTREE (postalcode ASC);

CREATE INDEX ix_orders_customerid
ON northwind_dbo.orders
USING BTREE (customerid ASC);

CREATE INDEX ix_orders_customersorders
ON northwind_dbo.orders
USING BTREE (customerid ASC);

CREATE INDEX ix_orders_employeeid
ON northwind_dbo.orders
USING BTREE (employeeid ASC);

CREATE INDEX ix_orders_employeesorders
ON northwind_dbo.orders
USING BTREE (employeeid ASC);

CREATE INDEX ix_orders_orderdate
ON northwind_dbo.orders
USING BTREE (orderdate ASC);

CREATE INDEX ix_orders_shippeddate
ON northwind_dbo.orders
USING BTREE (shippeddate ASC);

CREATE INDEX ix_orders_shippersorders
ON northwind_dbo.orders
USING BTREE (shipvia ASC);

CREATE INDEX ix_orders_shippostalcode
ON northwind_dbo.orders
USING BTREE (shippostalcode ASC);

CREATE INDEX ix_products_categoriesproducts
ON northwind_dbo.products
USING BTREE (categoryid ASC);

CREATE INDEX ix_products_categoryid
ON northwind_dbo.products
USING BTREE (categoryid ASC);

CREATE INDEX ix_products_productname
ON northwind_dbo.products
USING BTREE (productname ASC);

CREATE INDEX ix_products_supplierid
ON northwind_dbo.products
USING BTREE (supplierid ASC);

CREATE INDEX ix_products_suppliersproducts
ON northwind_dbo.products
USING BTREE (supplierid ASC);

CREATE INDEX ix_suppliers_companyname
ON northwind_dbo.suppliers
USING BTREE (companyname ASC);

CREATE INDEX ix_suppliers_postalcode
ON northwind_dbo.suppliers
USING BTREE (postalcode ASC);

-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE northwind_dbo."Order Details"
ADD CONSTRAINT ck_discount_1493580359 CHECK (
(discount >= (0) AND discount <= (1)));

ALTER TABLE northwind_dbo."Order Details"
ADD CONSTRAINT ck_quantity_1509580416 CHECK (
(quantity > (0)));

ALTER TABLE northwind_dbo."Order Details"
ADD CONSTRAINT ck_unitprice_1525580473 CHECK (
(unitprice >= (0)));

ALTER TABLE northwind_dbo."Order Details"
ADD CONSTRAINT pk_order_details_1397580017 PRIMARY KEY (orderid, productid);

ALTER TABLE northwind_dbo.categories
ADD CONSTRAINT pk_categories_965578478 PRIMARY KEY (categoryid);

ALTER TABLE northwind_dbo.customercustomerdemo
ADD CONSTRAINT pk_customercustomerdemo_1989582126 PRIMARY KEY (customerid, customertypeid);

ALTER TABLE northwind_dbo.customerdemographics
ADD CONSTRAINT pk_customerdemographics_2005582183 PRIMARY KEY (customertypeid);

ALTER TABLE northwind_dbo.customers
ADD CONSTRAINT pk_customers_997578592 PRIMARY KEY (customerid);

ALTER TABLE northwind_dbo.employees
ADD CONSTRAINT ck_birthdate_933578364 CHECK (
(birthdate < clock_timestamp()));

ALTER TABLE northwind_dbo.employees
ADD CONSTRAINT pk_employees_901578250 PRIMARY KEY (employeeid);

ALTER TABLE northwind_dbo.employeeterritories
ADD CONSTRAINT pk_employeeterritories_2101582525 PRIMARY KEY (employeeid, territoryid);

ALTER TABLE northwind_dbo.orders
ADD CONSTRAINT pk_orders_1093578934 PRIMARY KEY (orderid);

ALTER TABLE northwind_dbo.products
ADD CONSTRAINT ck_products_unitprice_1317579732 CHECK (
(unitprice >= (0)));

ALTER TABLE northwind_dbo.products
ADD CONSTRAINT ck_reorderlevel_1333579789 CHECK (
(reorderlevel >= (0)));

ALTER TABLE northwind_dbo.products
ADD CONSTRAINT ck_unitsinstock_1349579846 CHECK (
(unitsinstock >= (0)));

ALTER TABLE northwind_dbo.products
ADD CONSTRAINT ck_unitsonorder_1365579903 CHECK (
(unitsonorder >= (0)));

ALTER TABLE northwind_dbo.products
ADD CONSTRAINT pk_products_1189579276 PRIMARY KEY (productid);

ALTER TABLE northwind_dbo.region
ADD CONSTRAINT pk_region_2053582354 PRIMARY KEY (regionid);

ALTER TABLE northwind_dbo.shippers
ADD CONSTRAINT pk_shippers_1029578706 PRIMARY KEY (shipperid);

ALTER TABLE northwind_dbo.suppliers
ADD CONSTRAINT pk_suppliers_1061578820 PRIMARY KEY (supplierid);

ALTER TABLE northwind_dbo.territories
ADD CONSTRAINT pk_territories_2069582411 PRIMARY KEY (territoryid);

-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE northwind_dbo."Order Details"
ADD CONSTRAINT fk_order_details_orders_1461580245 FOREIGN KEY (orderid) 
REFERENCES northwind_dbo.orders (orderid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo."Order Details"
ADD CONSTRAINT fk_order_details_products_1477580302 FOREIGN KEY (productid) 
REFERENCES northwind_dbo.products (productid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.customercustomerdemo
ADD CONSTRAINT fk_customercustomerdemo_2021582240 FOREIGN KEY (customertypeid) 
REFERENCES northwind_dbo.customerdemographics (customertypeid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.customercustomerdemo
ADD CONSTRAINT fk_customercustomerdemo_customers_2037582297 FOREIGN KEY (customerid) 
REFERENCES northwind_dbo.customers (customerid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.employees
ADD CONSTRAINT fk_employees_employees_917578307 FOREIGN KEY (reportsto) 
REFERENCES northwind_dbo.employees (employeeid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.employeeterritories
ADD CONSTRAINT fk_employeeterritories_employees_2117582582 FOREIGN KEY (employeeid) 
REFERENCES northwind_dbo.employees (employeeid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.employeeterritories
ADD CONSTRAINT fk_employeeterritories_territories_2133582639 FOREIGN KEY (territoryid) 
REFERENCES northwind_dbo.territories (territoryid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.orders
ADD CONSTRAINT fk_orders_customers_1125579048 FOREIGN KEY (customerid) 
REFERENCES northwind_dbo.customers (customerid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.orders
ADD CONSTRAINT fk_orders_employees_1141579105 FOREIGN KEY (employeeid) 
REFERENCES northwind_dbo.employees (employeeid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.orders
ADD CONSTRAINT fk_orders_shippers_1157579162 FOREIGN KEY (shipvia) 
REFERENCES northwind_dbo.shippers (shipperid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.products
ADD CONSTRAINT fk_products_categories_1285579618 FOREIGN KEY (categoryid) 
REFERENCES northwind_dbo.categories (categoryid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.products
ADD CONSTRAINT fk_products_suppliers_1301579675 FOREIGN KEY (supplierid) 
REFERENCES northwind_dbo.suppliers (supplierid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE northwind_dbo.territories
ADD CONSTRAINT fk_territories_region_2085582468 FOREIGN KEY (regionid) 
REFERENCES northwind_dbo.region (regionid)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

