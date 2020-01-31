/*
Практическое задание № 2

Перед началом работы необходимо создать и заполнить таблицы в соответствии  с 
1. Напишите запрос, полностью показывающий таблицу purchase.
2. Напишите запрос, выбирающий столбцы product_name и quantity из таблицы Purchase.
3. Напишите запрос, выбирающий эти столбцы в обратном порядке.
4. Напишите запрос, выводящий для каждой строки таблицы person следующий текст:
<first_name> <last_name> started work <hiredate>*. Получаемому столбцу присвоить псевдоним "Started Work”.
5. Напишите запрос,выводящий наименование продуктов product_name (таблица product), для которых цена не определена (NULL).
6. Напишите запрос, выводящий наименование продуктов product_name (таблица purchase), которых продали от 3 до 23 штук.
* MSSQL не поддерживает объединение столбцов с типами данных varchar и date. Используйте оператор конветации:  CONVERT(VARCHAR, hiredate)
7. Напишите запрос, выводящий фамилии сотрудников, которых
приняли на работу 1го, 15го и 28го февраля 2010 года.
8. Напишите запрос, выводящий наименование продуктов
product_name (таблица purchase), проданных сотрудниками, фамилии которых начинаются на "B”.
9. Напишите запрос, выводящий наименование продуктов
product_name (таблица purchase), проданных сотрудниками, фамилии которых не начинаются на "B”.
10. Напишите запрос, выводящий фамилии и дату приема на работу
сотрудников, фамилии которых начинаются на "B” и которых приняли
на работу раньше 1 марта 2010 года.

11. Напишите запрос, выводящий наименование продуктов
product_name и дату последней поставки laststockdate (таблица
product), наименование которых Small Widget, Medium Widget и Large
Widget или те, для которых не указана дата последней поставки.
Отсортируйте по убыванию даты последней поставки.
*/
--Перед началом работы необходимо создать и заполнить таблицы
CREATE DATABASE DB_HW;

CREATE TABLE PERSON
(
	PERSON_CODE VARCHAR(3)PRIMARY KEY NOT NULL,
	FIRST_NAME VARCHAR(20),
	LAST_NAME VARCHAR(20),
	HIREDATE DATE
);

CREATE TABLE PRODUCT
(
	PRODUCT_NAME VARCHAR(25)PRIMARY KEY NOT NULL,
	PRODUCT_PRICE NUMERIC(8,2),
	QUANTITY_ON_HAND NUMERIC(5,0),
	LASTSTOCKDATE DATE
);

CREATE TABLE PURCHASE
(
	PRODUCT_NAME VARCHAR(25),
	PERSON_CODE VARCHAR(25),
	PURCHASE_DATE DATE,
	QUANTITY NUMERIC(4,2),
    FOREIGN KEY (PRODUCT_NAME) REFERENCES PRODUCT(PRODUCT_NAME),
    FOREIGN KEY (PERSON_CODE) REFERENCES PERSON(PERSON_CODE)
);

CREATE TABLE PURCHASE_ARCHIVE SELECT * FROM PURCHASE; --В PURCHASE_ARCHIVE вместо наименования столбца SALESPERSON используется PERSON_CODE, как в таблице PURCHASE

CREATE TABLE OLD_ITEM
(
	ITEM_ID CHAR(20) NOT NULL,
	ITEM_DESC CHAR(20) NOT NULL,
	PRIMARY KEY (ITEM_ID, ITEM_DESC)
);

INSERT INTO PERSON (PERSON_CODE, FIRST_NAME, LAST_NAME, HIREDATE) 
VALUES 
	('BB', 'Bobby', 'Barkenhagen', 20100208),
	('CA', 'Charlene', 'Atlas', 20100201),
	('DS', 'Dany', 'Smith', 20020215),
	('GA', 'Gary', 'Anderson', 20100215),
	('JS', 'John', 'Smith', 20020215),
	('LB', 'Laren', 'Baxter', 20100301);

INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, QUANTITY_ON_HAND, LASTSTOCKDATE) 
VALUES 
	('Chrome Phoobar', 50.00, 100, 20110115),
	('Extra Huge Mega Phoobar +', 9.5, 1234, 20120115),
	('Large Widget', NULL, 5, 20110111),
	('Medium Widget', 75.00, 1000, 20100115),
	('Round Chrome Snaphoo', 25.00, 10000, NULL),
	('Small Widget', 99.00, 1, 20110115),
	('Square Zinculator', 45.00, 1, 20101231);
	
INSERT INTO PURCHASE (PRODUCT_NAME, PERSON_CODE, PURCHASE_DATE, QUANTITY) 
VALUES
	('Small Widget', 'CA', 20110714, 1.00),
	('Medium Widget', 'BB', 20110714, 75.00),
	('Chrome Phoobar', 'GA', 20110714, 2.00),
	('Small Widget', 'GA', 20110715, 8.00),
	('Medium Widget', 'LB', 20110715, 20.00),
	('Round Chrome Snaphoo', 'CA', 20110716, 5.00);
	
INSERT INTO PURCHASE_ARCHIVE (PRODUCT_NAME, PERSON_CODE, PURCHASE_DATE, QUANTITY) 
VALUES
	('Round Snaphoo', 'BB', 20010621, 10.00),
	('Large Harf linger', 'GA', 20010622, 50.00),
	('Medium Wodget', 'LB', 20010623, 20.00),
	('Small Widget', 'ZZ', 20010624, 80.00),
	('Chrome Phoobar', 'CA', 20010625, 2.00),
	('Small Widget', 'JT', 20010626, 50.00);

--1. Напишите запрос, полностью показывающий таблицу purchase.
SELECT * FROM PURCHASE;

--2. Напишите запрос, выбирающий столбцы product_name и quantity из таблицы Purchase.
SELECT PRODUCT_NAME, QUANTITY 
FROM PURCHASE;

--3. Напишите запрос, выбирающий эти столбцы в обратном порядке.
SELECT QUANTITY, PRODUCT_NAME 
FROM PURCHASE;

--4. Напишите запрос, выводящий для каждой строки таблицы person следующий текст: <first_name> <last_name> started work <hiredate>*. Получаемому столбцу присвоить псевдоним "Started Work”.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME, ' started work ', HIREDATE, '*') AS 'Started Work' 
FROM PERSON;

--5. Напишите запрос,выводящий наименование продуктов product_name (таблица product), для которых цена не определена (NULL).
SELECT PRODUCT_NAME 
FROM PRODUCT
WHERE PRODUCT_PRICE IS NULL;

--6. Напишите запрос, выводящий наименование продуктов product_name (таблица purchase), которых продали от 3 до 23 штук.
SELECT PRODUCT_NAME
FROM PURCHASE
WHERE QUANTITY BETWEEN 3 AND 23;

--7. Напишите запрос, выводящий фамилии сотрудников, которых приняли на работу 1го, 15го и 28го февраля 2010 года.
SELECT LAST_NAME
FROM PERSON
WHERE HIREDATE IN (20100201, 20100215, 20100228);

--8. Напишите запрос, выводящий наименование продуктов product_name (таблица purchase), проданных сотрудниками, фамилии которых начинаются на "B”.
SELECT DISTINCT PRODUCT_NAME
FROM PURCHASE LEFT JOIN PERSON ON PURCHASE.PERSON_CODE = PERSON.PERSON_CODE
WHERE LAST_NAME LIKE 'B%';

--9. Напишите запрос, выводящий наименование продуктов product_name (таблица purchase), проданных сотрудниками, фамилии которых не начинаются на "B”.
SELECT DISTINCT PRODUCT_NAME
FROM PURCHASE LEFT JOIN PERSON ON PURCHASE.PERSON_CODE = PERSON.PERSON_CODE
WHERE LAST_NAME NOT LIKE 'B%'

--10. Напишите запрос, выводящий фамилии и дату приема на работу сотрудников, фамилии которых начинаются на "B” и которых приняли на работу раньше 1 марта 2010 года.
SELECT LAST_NAME, HIREDATE
FROM PERSON
WHERE LAST_NAME LIKE 'B%' AND HIREDATE<20100301;

--11. Напишите запрос, выводящий наименование продуктов product_name и дату последней поставки laststockdate (таблица product), наименование которых Small Widget, Medium Widget и Large Widget или те, для которых не указана дата последней поставки. Отсортируйте по убыванию даты последней поставки.
SELECT PRODUCT_NAME, LASTSTOCKDATE
FROM PRODUCT
WHERE PRODUCT_NAME IN ('Small Widget', 'Medium Widget', 'Large Widget') OR LASTSTOCKDATE IS NULL
ORDER BY LASTSTOCKDATE DESC;