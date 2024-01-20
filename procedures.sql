-- ------------ Write CREATE-DATABASE-stage scripts -----------

CREATE SCHEMA IF NOT EXISTS northwind_dbo;

-- ------------ Write CREATE-PROCEDURE-stage scripts -----------

CREATE OR REPLACE PROCEDURE northwind_dbo."Employee Sales by Country"(IN par_beginning_date TIMESTAMP WITHOUT TIME ZONE, IN par_ending_date TIMESTAMP WITHOUT TIME ZONE, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS 
$BODY$
BEGIN
    OPEN p_refcur FOR
    SELECT
        employees.country, employees.lastname, employees.firstname, orders.shippeddate, orders.orderid, "Order Subtotals".subtotal AS saleamount
        FROM northwind_dbo.employees
        INNER JOIN (northwind_dbo.orders
        INNER JOIN northwind_dbo."Order Subtotals"
            ON orders.orderid = "Order Subtotals".orderid)
            ON employees.employeeid = orders.ix_orders_employeeid
        WHERE orders.ix_orders_shippeddate BETWEEN par_Beginning_Date AND par_Ending_Date;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE northwind_dbo."Sales by Year"(IN par_beginning_date TIMESTAMP WITHOUT TIME ZONE, IN par_ending_date TIMESTAMP WITHOUT TIME ZONE, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS 
$BODY$
BEGIN
    OPEN p_refcur FOR
    SELECT
        orders.shippeddate, orders.orderid, "Order Subtotals".subtotal, to_char(shippeddate::DATE, 'YYYY') AS year
        FROM northwind_dbo.orders
        INNER JOIN northwind_dbo."Order Subtotals"
            ON orders.orderid = "Order Subtotals".orderid
        WHERE orders.ix_orders_shippeddate BETWEEN par_Beginning_Date AND par_Ending_Date;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE northwind_dbo."Ten Most Expensive Products"(INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS 
$BODY$
BEGIN
    /*
    [7674 - Severity CRITICAL - DMS SC can't convert the ROWCOUNT clause of the SET statement. Convert your source code manually.]
    SET ROWCOUNT 10
    */
    OPEN p_refcur FOR
    SELECT
        products.productname AS tenmostexpensiveproducts, products.unitprice
        FROM northwind_dbo.products
        ORDER BY products.unitprice DESC NULLS LAST;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE northwind_dbo.custorderhist(IN par_customerid CHAR, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS 
$BODY$
BEGIN
    OPEN p_refcur FOR
    SELECT
        productname, SUM(quantity) AS total
        FROM northwind_dbo.products AS p, northwind_dbo."Order Details" AS od, northwind_dbo.orders AS o, northwind_dbo.customers AS c
        WHERE LOWER(c.customerid) = LOWER(par_CustomerID) AND LOWER(c.customerid) = LOWER(o.customerid) AND o.orderid = od.orderid AND od.productid = p.productid
        GROUP BY productname;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE northwind_dbo.custordersdetail(IN par_orderid INTEGER, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS 
$BODY$
BEGIN
    OPEN p_refcur FOR
    SELECT
        productname, ROUND(od.unitprice, 2) AS unitprice, quantity, CAST (discount * 100 AS INTEGER) AS discount, ROUND(CAST (quantity * (1 - discount) * od.unitprice AS NUMERIC(19, 4)), 2) AS extendedprice
        FROM northwind_dbo.products AS p, northwind_dbo."Order Details" AS od
        WHERE od.productid = p.productid AND od.orderid = par_OrderID;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE northwind_dbo.custordersorders(IN par_customerid CHAR, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS 
$BODY$
BEGIN
    OPEN p_refcur FOR
    SELECT
        orderid, orderdate, requireddate, shippeddate
        FROM northwind_dbo.orders
        WHERE LOWER(customerid) = LOWER(par_CustomerID)
        ORDER BY orderid NULLS FIRST;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE northwind_dbo.salesbycategory(IN par_categoryname VARCHAR, IN par_ordyear VARCHAR DEFAULT '1998', INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS 
$BODY$
BEGIN
    IF LOWER(par_OrdYear) != LOWER('1996') AND LOWER(par_OrdYear) != LOWER('1997') AND LOWER(par_OrdYear) != LOWER('1998') THEN
        SELECT
            '1998'
            INTO par_OrdYear;
    END IF;
    OPEN p_refcur FOR
    SELECT
        productname, ROUND(SUM(CAST (od.quantity * (1 - od.discount) * od.unitprice AS NUMERIC(14, 2))), 0) AS totalpurchase
        FROM northwind_dbo."Order Details" AS od, northwind_dbo.orders AS o, northwind_dbo.products AS p, northwind_dbo.categories AS c
        WHERE od.orderid = o.orderid AND od.productid = p.productid AND p.categoryid = c.categoryid AND LOWER(c.categoryname) = LOWER(par_CategoryName) AND LOWER(SUBSTR(aws_sqlserver_ext.conv_datetime_to_string('NVARCHAR(22)', 'DATETIME', o.orderdate, 111), 1, 4)) = LOWER(par_OrdYear)
        GROUP BY productname
        ORDER BY productname NULLS FIRST;
END;
$BODY$
LANGUAGE plpgsql;

