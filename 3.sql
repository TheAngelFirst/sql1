/*
Практическое задание № 3
1. Напишите запрос, выводящий декартово произведение таблиц product
и purchase.
2. Напишите запрос, выводящий наименование проданного товара
product_name, количество quantity (таблица purchase) и
quantity_on_hand (таблица product).
3.Напишите запрос, выводящий наименование товара product_name
(таблица purchase), дату последней поставки laststockdate (таблица
product) и фамилию продавца last_name (таблица person).
4. Напишите запрос, выводящий столбцы product_name, first_name,
last_name внешнего объединения таблиц purchase и person. Используйте для таблиц короткие псевдонимы.
5.Напишите запрос, который выводит коды продавцов salesperson из таблицы purchase_archive , которые не повторяются в таблице purchase.
6. Напишите запрос, который выводит коды только тех продавцов salesperson из
таблицы purchase, которые так же содержаться в таблице purchase_archive.
7. Напишите запрос, который выводит все (в том числе повторяющиеся) коды
продавцов salesperson из таблиц purchase и purchase_archive.
*/
--1. Напишите запрос, выводящий декартово произведение таблиц product и purchase.
SELECT *
FROM PRODUCT, PURCHASE;

--2. Напишите запрос, выводящий наименование проданного товара product_name, количество quantity (таблица purchase) и quantity_on_hand (таблица product).
SELECT PURCHASE.PRODUCT_NAME, PRODUCT.QUANTITY_ON_HAND
FROM PRODUCT JOIN PURCHASE ON PURCHASE.PRODUCT_NAME = PRODUCT.PRODUCT_NAME;

--3.Напишите запрос, выводящий наименование товара product_name (таблица purchase), дату последней поставки laststockdate (таблица product) и фамилию продавца last_name (таблица person).
SELECT PURCHASE.PRODUCT_NAME, PRODUCT.LASTSTOCKDATE, PERSON.LAST_NAME
FROM PRODUCT JOIN PURCHASE ON PURCHASE.PRODUCT_NAME = PRODUCT.PRODUCT_NAME JOIN PERSON ON PURCHASE.PERSON_CODE = PERSON.PERSON_CODE;

--4. Напишите запрос, выводящий столбцы product_name, first_name, last_name внешнего объединения таблиц purchase и person. Используйте для таблиц короткие псевдонимы.
SELECT PURCHASE.PRODUCT_NAME,  PERSON.FIRST_NAME, PERSON.LAST_NAME
FROM PURCHASE RIGHT OUTER JOIN PERSON ON PURCHASE.PERSON_CODE = PERSON.PERSON_CODE;

--5.Напишите запрос, который выводит коды продавцов salesperson из таблицы purchase_archive , которые не повторяются в таблице purchase.
SELECT PA.PERSON_CODE
FROM PURCHASE_ARCHIVE AS PA LEFT OUTER JOIN PURCHASE AS P ON P.PERSON_CODE = PA.PERSON_CODE
EXCEPT
SELECT PERSON_CODE
FROM PURCHASE;

--6. Напишите запрос, который выводит коды только тех продавцов salesperson из таблицы purchase, которые так же содержаться в таблице purchase_archive.
SELECT P.PERSON_CODE
FROM PURCHASE AS P
INTERSECT
SELECT PA.PERSON_CODE
FROM PURCHASE_ARCHIVE AS PA;

--7. Напишите запрос, который выводит все (в том числе повторяющиеся) коды продавцов salesperson из таблиц purchase и purchase_archive.
SELECT P.PERSON_CODE
FROM PURCHASE AS P
UNION ALL
SELECT PA.PERSON_CODE
FROM PURCHASE_ARCHIVE AS PA;