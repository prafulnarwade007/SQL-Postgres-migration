-- This is demo version of MSSQL-to-PostgreSQL Code Converter.
-- It converts only 5 stored procedures/functions/triggers. To obtain
-- full version please visit: https://www.convert-in.com/m2pcode.htm

CREATE OR REPLACE PROCEDURE northwind_dbo."Employee Sales by Country"(IN par_beginning_date TIMESTAMP AS $$

BEGIN WITHOUT TIME ZONE, IN par_ending_date TIMESTAMP WITHOUT TIME ZONE, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS 
$BODY$
BEGIN
OPEN p_refcur FOR
SELECT
employees.country, employees.lastname, employees.firstname, orders.shippeddate, orders.orderid, "Order Subtotals".subtotal AS saleamount
FROM northwind_dbo.employees
INNER JOIN (northwind_dbo.orders
INNER JOIN northwind_dbo."Order Subtotals"
ON orders.orderid = "Order Subtotals".orderid;)
ON employees.employeeid = orders.ix_orders_employeeid
WHERE orders.ix_orders_shippeddate BETWEEN par_Beginning_Date AND par_Ending_Date;
END;
$BODY$
LANGUAGE plpgsql;
END;
$$ LANGUAGE plpgsql;


--
--
--

CREATE OR REPLACE PROCEDURE northwind_dbo."Sales by Year"(IN par_beginning_date TIMESTAMP AS $$

BEGIN WITHOUT TIME ZONE, IN par_ending_date TIMESTAMP WITHOUT TIME ZONE, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
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
END;
$$ LANGUAGE plpgsql;


--
--
--

CREATE OR REPLACE PROCEDURE northwind_dbo."Ten Most Expensive Products"(INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS $$
BEGIN 
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
ORDER BY products.unitprice DESC; NULLS LAST;
END;
$BODY$
LANGUAGE plpgsql;
END;
$$ LANGUAGE plpgsql;


--
--
--

CREATE OR REPLACE PROCEDURE northwind_dbo.custorderhist(IN par_customerid CHAR, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS $$
BEGIN 
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
END;
$$ LANGUAGE plpgsql;


--
--
--

CREATE OR REPLACE PROCEDURE northwind_dbo.custordersdetail(IN par_orderid INTEGER, INOUT return_code int DEFAULT 0, INOUT p_refcur refcursor DEFAULT NULL)
AS $$
BEGIN 
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
END;
$$ LANGUAGE plpgsql;

