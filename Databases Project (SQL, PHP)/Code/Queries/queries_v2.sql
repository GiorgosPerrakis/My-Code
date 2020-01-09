Examples in PostgreSQL. You can Use SQL Fiddle (http://sqlfiddle.com) for testing 

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


/* ALTER TABLE */
ALTER TABLE employee ADD COLUMN age INTEGER;
ALTER TABLE distributors DROP COLUMN age;
ALTER TABLE distributors RENAME COLUMN age TO empage;
ALTER TABLE employee RENAME TO employees;

/* Update */
UPDATE employee SET age=40 WHERE id IN (1,2);
UPDATE employee SET age=30 WHERE id =3;
UPDATE employee SET age=35 WHERE id =4;

/* DELETE */
DELETE FROM employee WHERE id=5;

/* Drop */
/* First command will not execute due to foreign keys */
DROP TABLE employee;
/* SOS. Do not run */
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS employee CASCADE;

/* TRUNCATE */
/* SOS. Do not run */
TRUNCATE employee;
TRUNCATE employee CASCADE;
TRUNCATE employee RESTART IDENTITY;

/* Constraints */
ALTER TABLE employee
  ADD CONSTRAINT check_age
  CHECK (age>30);

/* Do not run */
ALTER TABLE employee DROP CONSTRAINT check_age;
ALTER TABLE employee ALTER COLUMN age SET NOT NULL;
ALTER [ COLUMN ] column DROP DEFAULT
ALTER [ COLUMN ] column { SET | DROP } NOT NULL


/* Setting DEFAULT VALUES */
ALTER TABLE employee ALTER COLUMN age SET DEFAULT 45;

INSERT INTO employee(lname,fname)
VALUES('Grivas','Fotis');

/* Setting UNIQUE Constraints */
ALTER TABLE employee ADD COLUMN id2 UNIQUE;
ALTER TABLE employee DROP CONSTRAINT employee_id2_key;

UPDATE employee SET id2=10 WHERE id=1; 
UPDATE employee SET id2=10 WHERE id IN (1,2); 

/* Triggers */
http://www.postgresqltutorial.com/creating-first-trigger-postgresql/

/* Table required for 1st trigger */
CREATE TABLE employee_audits (
   id SERIAL PRIMARY KEY,
   emp_id INTEGER NOT NULL,
   lname_before TEXT NOT NULL,
   lname_after TEXT NOT NULL,
   changed_on timestamp NOT NULL DEFAULT now()
);

/* 1st Trigger */
CREATE OR REPLACE FUNCTION log_lname_changes()
  RETURNS trigger AS
$BODY$
BEGIN
 IF NEW.lname <> OLD.lname THEN
 INSERT INTO employee_audits(emp_id,lname_before,lname_after)
 VALUES(OLD.id,OLD.lname,NEW.lname);
 END IF;
 
 RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

--DROP TRIGGER lname_changes ON employee;

CREATE TRIGGER lname_changes
  AFTER UPDATE ON employee 
  FOR EACH ROW
  EXECUTE PROCEDURE log_lname_changes();

UPDATE employee SET lname='Vasileiou' WHERE id=1;


/* Table required for 2nd trigger */
CREATE TABLE employee_inserts (
   emp_id INTEGER,
   lname TEXT,
   fname TEXT,
   inserted_on timestamp NOT NULL DEFAULT now()
);


/* 2nd Trigger */
CREATE OR REPLACE FUNCTION log_emp_inserts()
  RETURNS trigger AS
$BODY$
BEGIN
 INSERT INTO employee_inserts(emp_id,lname,fname)
 VALUES(NEW.id,NEW.lname,NEW.fname);
 
 RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE TRIGGER emp_inserts
  AFTER INSERT ON employee 
  FOR EACH ROW
  EXECUTE PROCEDURE log_emp_inserts();

INSERT INTO employee(lname,fname)  VALUES('Vasileiou', 'Yannis');

/* Views */
CREATE VIEW v_employee AS
SELECT * FROM employee;