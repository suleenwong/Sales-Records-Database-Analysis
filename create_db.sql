DROP TABLE products;

CREATE TABLE products
(
  productCode VARCHAR(15) NOT NULL PRIMARY KEY,
  productName VARCHAR(70) NOT NULL,
  productLine VARCHAR(50) NOT NULL,
  productScale VARCHAR(10) NOT NULL,
  productVendor VARCHAR(50) NOT NULL,
  productDescription VARCHAR(700) NOT NULL,
  quantityInStock SMALLINT NOT NULL,
  buyPrice NUMERIC(10,2) NOT NULL,
  MSRP NUMERIC(10,2) NOT NULL
);

DROP TABLE productlines;

CREATE TABLE productlines (
  productLine VARCHAR(50) NOT NULL,
  textDescription VARCHAR(4000) DEFAULT NULL,
  htmlDescription VARCHAR(50),
  image VARCHAR(50)
);

DROP TABLE payments;

CREATE TABLE payments (
  customerNumber BIGINT NOT NULL,
  checkNumber VARCHAR(50) NOT NULL,
  paymentDate DATE NOT NULL,
  amount NUMERIC(10,2) NOT NULL
);

DROP TABLE orders;

CREATE TABLE orders (
  orderNumber BIGINT NOT NULL PRIMARY KEY,
  orderDate DATE NOT NULL,
  requiredDate DATE NOT NULL,
  shippedDate DATE DEFAULT NULL,
  status VARCHAR(15) NOT NULL,
  comments VARCHAR(255),
  customerNumber BIGINT NOT NULL
);

DROP TABLE orderdetails;

CREATE TABLE orderdetails (
  orderNumber BIGINT NOT NULL,
  productCode VARCHAR(15) NOT NULL,
  quantityOrdered SMALLINT NOT NULL,
  priceEach NUMERIC(10,2) NOT NULL,
  orderLineNumber SMALLINT NOT NULL
);

DROP TABLE offices;

CREATE TABLE offices (
  officeCode VARCHAR(10) NOT NULL PRIMARY KEY,
  city VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  addressLine1 VARCHAR(50) NOT NULL,
  addressLine2 VARCHAR(50) DEFAULT NULL,
  state VARCHAR(50) DEFAULT NULL,
  country VARCHAR(50) NOT NULL,
  postalCode VARCHAR(15) NOT NULL,
  territory VARCHAR(10) NOT NULL
);

DROP TABLE employees;

CREATE TABLE employees (
  employeeNumber SMALLINT NOT NULL PRIMARY KEY,
  lastName VARCHAR(50) NOT NULL,
  firstName VARCHAR(50) NOT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  officeCode VARCHAR(10) NOT NULL,
  reportsTo SMALLINT DEFAULT NULL,
  jobTitle VARCHAR(50) NOT NULL
);

DROP TABLE customers;

CREATE TABLE customers (
  customerNumber BIGINT NOT NULL PRIMARY KEY,
  customerName VARCHAR(50) NOT NULL,
  contactLastName VARCHAR(50) NOT NULL,
  contactFirstName VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  addressLine1 VARCHAR(50) NOT NULL,
  addressLine2 VARCHAR(50) DEFAULT NULL,
  city VARCHAR(50) NOT NULL,
  state VARCHAR(50) DEFAULT NULL,
  postalCode VARCHAR(15) DEFAULT NULL,
  country VARCHAR(50) NOT NULL,
  salesRepEmployeeNumber SMALLINT DEFAULT NULL,
  creditLimit NUMERIC(10,2) DEFAULT NULL
);

copy products FROM 'data/products.csv' DELIMITER ',' CSV HEADER;
copy productlines FROM 'data/productlines.csv' DELIMITER ',' CSV HEADER;
copy payments FROM 'data/payments.csv' DELIMITER ',' CSV HEADER;
copy orders FROM 'data/orders.csv' DELIMITER ',' CSV HEADER;
copy orderdetails FROM 'data/orderdetails.csv' DELIMITER ',' CSV HEADER;
copy offices FROM 'data/offices.csv' DELIMITER ',' CSV HEADER;
copy employees FROM 'data/employees.csv' DELIMITER ',' CSV HEADER;
copy customers FROM 'data/customers.csv' DELIMITER ',' CSV HEADER;
