{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf830
{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red255\green255\blue255;}
{\*\expandedcolortbl;;\csgray\c0;\csgray\c100000;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs22 \cf2 \cb3 \CocoaLigature0 CREATE TABLE Products(prod_ID CHAR(10), pname VARCHAR(30), price DECIMAL);\
\
ALTER TABLE Products add constraint pk_products primary key (prod_id);\
\
ALTER TABLE Products add constraint ck_products_price check (price > 0);\
\
INSERT INTO Products VALUES('p1', 'tape', 2.5);\
\
INSERT INTO Products VALUES('p2', 'tv', 250);\
\
INSERT INTO Products VALUES('p3', 'vcr', 80);\
\
CREATE TABLE Depots(dep_id CHAR(10), addr VARCHAR(100), volume INTEGER);\
\
ALTER TABLE Depots add constraint pk_depots primary key (dep_id);\
\
ALTER TABLE Depots add constraint ck_depots_volume check (volume>0);\
\
INSERT INTO Depots VALUES('d1', 'New York', 9000);\
\
INSERT INTO Depots VALUES('d2', 'Syracuse', 6000);\
\
INSERT INTO Depots VALUES('d4', 'New York', 2000);\
\
CREATE TABLE Stocks(prod_id CHAR(10), dep_id CHAR(10), quantity INTEGER);\
\
ALTER TABLE Stocks add constraint pk_stocks primary key (prod_id, dep_id);\
\
ALTER TABLE Stocks add constraint fk_stocks_products foreign key (prod_id) references products (prod_id);\
\
ALTER TABLE Stocks add constraint fk_stocks_depots foreign key (dep_id) references depots (dep_id);\
\
INSERT INTO Stocks VALUES('p1', 'd1', 1000);\
\
INSERT INTO Stocks VALUES('p1', 'd2', -100);\
\
INSERT INTO Stocks VALUES('p1', 'd4', 1200);\
\
INSERT INTO Stocks VALUES('p3', 'd1', 3000);\
\
INSERT INTO Stocks VALUES('p3', 'd4', 2000);\
\
INSERT INTO Stocks VALUES('p2', 'd4', 1500);\
\
INSERT INTO Stocks VALUES('p2', 'd1', -400);\
\
INSERT INTO Stocks VALUES('p2', 'd2', 2000);\
\
\
SELECT P.pname FROM Products P WHERE P.pname = 'p';\
 \
\
 --what are the #prods whose name begins with a 'p' and are less than $300.00?\
SELECT P.pname FROM Products P WHERE P.pname = 'p' AND P.price < 300; \
\
\
--names of the products stocked in 'd2'.(a)without in/not in (b)with in/not in\
SELECT P.pname FROM Products P, Stocks S WHERE P.prod_id = S.prod_id AND S.dep_id = 'd2';\
\
--#prod and names of the products that are out of stock.(a)without in/not in (b)with in/not in\
SELECT P.prod_id, P.pname FROM Products P, Stocks S WHERE P.prod_id = S.prod_id AND S.quantity < 0;\
 \
--addresses of the depots where the product 'p1' is stocked.(a)without exists/not exists and without in/not in (b)with in/not in (c)with exists/not exists\
SELECT D.addr FROM Depots D WHERE D.dep_id IN (SELECT S.dep_id FROM Stocks S WHERE S.prod_id = 'p1');\
  \
\
--#prods whose price is between $250.00 and $400.00.(a)using intersect (b)without intersect\
SELECT P.prod_id FROM Products P WHERE P.price >= 250 AND P.price <=400;\
\
--how many products are out of stock?\
SELECT COUNT(S.prod_id) FROM Stocks S WHERE S.quantity < 0;\
 \
\
--average of the prices of the products stocked in the 'd2' depot.\
SELECT AVG(price) FROM Product P, Stock S WHERE P.prod_id = S.prod_id AND dep_id = 'd2';\
         \
--#deps of the depots with the largest capacity(volume).                                           \
SELECT MAX(D.volume) FROM Depots D;\
 \
\
--sum of the stocked quantity of each product.\
SELECT S.prod_id, SUM(S.quantity) FROM Stocks S GROUP BY S.prod_id;\
 \
--products names stocked in at least 3 depots.(a)using count (b)without using count\
SELECT P.pname FROM Products P, Stocks S WHERE P.prod_id = S.prod_id GROUP BY P.pname HAVING COUNT(S.prod_id) >= 3;\
 \
--#prod stocked in all depots.(a)using count (b)using exists/not exists\
SELECT S.prod_id FROM Stocks S GROUP BY S.prod_id HAVING COUNT(S.prod_id) = 3;\
  \
}