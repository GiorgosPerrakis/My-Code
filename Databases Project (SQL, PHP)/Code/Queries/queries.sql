/*Examples in PostgreSQL. You can Use SQL Fiddle (http://sqlfiddle.com) for testing */

/* Creating DB tables and Insertion of values */
CREATE TABLE employee(
id SERIAL, 
lname TEXT,
fname TEXT
);

INSERT INTO employee(lname,fname)
VALUES('Nikolaou','Nikos');

INSERT INTO employee(lname,fname)
VALUES('Georgiou','Tasos');

INSERT INTO employee(lname,fname)
VALUES('Alexiou','Kostas');

INSERT INTO employee(lname,fname)
VALUES('Xristou','Tasos');

ALTER TABLE employee ADD PRIMARY KEY(id);

CREATE TABLE products(
id SERIAL, 
name TEXT, 
price INTEGER
);


INSERT INTO products(name,price)
VALUES('Product1',100);

INSERT INTO products(name,price)
VALUES('Product2',200);

INSERT INTO products(name,price)
VALUES('Product3',300);

INSERT INTO products(name,price)
VALUES('Product4',400);

ALTER TABLE products ADD PRIMARY KEY(id);


CREATE TABLE sales(
id SERIAL, 
emp_id INTEGER REFERENCES employee(id) ON DELETE RESTRICT, 
prod_id INTEGER REFERENCES products(id) ON DELETE RESTRICT, 
pdate TIMESTAMP, 
items SMALLINT
);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(1,1,'2015-01-08',2);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(1,1,'2015-01-09',3);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(1,2,'2015-01-10',2);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(1,2,'2015-01-10',3);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(2,3,'2015-01-08',2);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(2,3,'2015-01-09',3);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(2,2,'2015-01-10',2);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(2,2,'2015-01-10',3);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(3,1,'2015-01-08',2);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(3,1,'2015-01-09',3);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(3,3,'2015-01-11',2);

INSERT INTO sales(emp_id,prod_id,pdate,items)
VALUES(3,3,'2015-01-12',3);

ALTER TABLE sales ADD PRIMARY KEY(id);

/* End of creating DB tables and Insertion of values */

 /* Queries */
SELECT id,
       lname,
       fname
FROM employee
ORDER BY id;

 /* Limit */
SELECT id,
       lname,
       fname
FROM employee
ORDER BY id
LIMIT 2;

/* WHERE */
SELECT id, lname, fname
  FROM employee
WHERE id=2;

/* Like, Upper */
SELECT id, lname, fname
  FROM employee
WHERE UPPER(lname) LIKE 'NIKO%';

/* Like, Lower */
SELECT id, lname, fname
  FROM employee
WHERE LOWER(lname) LIKE 'niko%';

/* Text Concatenation */
SELECT fname || ' ' || lname
  FROM employee
ORDER BY lname,fname;

/* ORDER*/
SELECT * FROM products
ORDER BY price;

/* Comparison operators */
SELECT * FROM products
WHERE price<=300 AND price>=200
ORDER BY price;

SELECT * FROM products
WHERE price<=300 OR price>=200
ORDER BY price;

SELECT * FROM products
WHERE price BETWEEN 100 AND 300
ORDER BY price;

SELECT * FROM sales
WHERE pdate BETWEEN ''2015-01-08' AND ''2015-01-11'
ORDER BY pdate,id;

/* Aggregate functions , DISTINCT*/
SELECT DISTINCT fname
FROM employee
ORDER BY fname;

SELECT COUNT(fname)
FROM employee;

SELECT COUNT(DISTINCT fname)
FROM employee;

SELECT fname, COUNT(fname)
FROM employee
GROUP BY fname
ORDER BY fname;

/* Wrong query */
SELECT fname, COUNT(fname)
FROM employee
GROUP BY fname
ORDER BY lname;

/* Wrong query  - WHERE aggregate function before GROUP BY */
SELECT fname, COUNT(fname)
FROM employee
WHERE COUNT(fname)>1
GROUP BY fname
ORDER BY fname;

/* Wrong query  - WHERE aggregate function after GROUP BY */
SELECT fname, COUNT(fname)
FROM employee
GROUP BY fname
WHERE COUNT(fname)>1
ORDER BY fname;

/* Correct query  - HAVING aggregate function after GROUP BY */
SELECT fname, COUNT(fname)
FROM employee
GROUP BY fname
HAVING COUNT(fname)>1
ORDER BY fname;

/* Joins */
SELECT n1.lname, n1.fname, n2.name, n2.price,
n3.pdate, n3.items
FROM employee n1, products n2, sales n3
WHERE n3.emp_id=n1.id AND n3.prod_id=n2.id
ORDER BY n3.pdate;

SELECT n1.lname, n1.fname, n2.name, n2.price,
n3.pdate, n3.items
FROM employee n1 JOIN sales n3 ON (n3.emp_id=n1.id), products n2
WHERE n3.prod_id=n2.id
ORDER BY n3.pdate;

SELECT n1.lname, n1.fname, n2.name, n2.price,
n3.pdate, n3.items
FROM employee n1 JOIN sales n3 ON (n3.emp_id=n1.id) JOIN products n2 ON (n3.prod_id=n2.id)
ORDER BY n3.pdate;

SELECT n1.lname, n1.fname,
n3.pdate, n3.items
FROM employee n1 LEFT JOIN sales n3 ON (n3.emp_id=n1.id) 
ORDER BY n1.lname, n1.fname;

SELECT n1.lname, n1.fname,n3.id,
n3.pdate, n3.items
FROM employee n1 LEFT JOIN sales n3 ON (n3.emp_id=n1.id) 
WHERE n3.id IS NULL
ORDER BY n1.lname, n1.fname;

SELECT n1.name, n1.price,
n3.pdate, n3.items
FROM products n1 LEFT JOIN sales n3 ON (n3.prod_id=n1.id) 
WHERE n3.id IS NULL
ORDER BY n1.name;

 
SELECT n1.lname, n1.fname, n2.name, n2.price,
n3.pdate, n3.items, n3.items*n2.price AS revenue
FROM employee n1 JOIN sales n3 ON (n3.emp_id=n1.id), products n2
WHERE n3.prod_id=n2.id
ORDER BY n3.pdate;


/* Nested Queries */
SELECT name, SUM(revenue) AS revenue_prod
FROM
(SELECT n1.lname, n1.fname, n2.name, n2.price,
n3.pdate, n3.items, n3.items*n2.price AS revenue
FROM employee n1 JOIN sales n3 ON (n3.emp_id=n1.id), products n2
WHERE n3.prod_id=n2.id
ORDER BY n3.pdate) s1
GROUP BY name
ORDER BY name;



SELECT id, SUM(revenue) AS revenue_prod
FROM
(SELECT n1.id,n1.lname, n1.fname, n2.name, n2.price,
n3.pdate, n3.items, n3.items*n2.price AS revenue
FROM employee n1 JOIN sales n3 ON (n3.emp_id=n1.id), products n2
WHERE n3.prod_id=n2.id
ORDER BY n3.pdate) s1
GROUP BY id
ORDER BY id;

SELECT name, SUM(items) AS revenue_prod
FROM
(SELECT n1.id,n1.lname, n1.fname, n2.name, n2.price,
n3.pdate, n3.items, n3.items*n2.price AS revenue
FROM employee n1 JOIN sales n3 ON (n3.emp_id=n1.id), products n2
WHERE n3.prod_id=n2.id
ORDER BY n3.pdate) s1
GROUP BY name
ORDER BY name;