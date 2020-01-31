/*
Практическое задание № 4
1. Напишите запрос, показывающий, какой будет цена продукта product_price после увеличения на 15%. 
2. Напишите запрос, показывающий, сколько всего имеется товаров в таблице product. 
3. Напишите запрос, показывающий, для какого количества товаров (таблица product) не указана цена. 
4. Напишите запрос, выводящий минимальную и максимальную цену товаров product_price. 
5. Напишите запрос, показывающий, какая сумма была выручена с продаж товаров каждого наименования. 
6. Напишите запрос, показывающий, какая сумма была выручена с продаж товаров каждого наименования. Вывести только те записи, для которых сумма продаж больше 125.
*/
--1. Напишите запрос, показывающий, какой будет цена продукта product_price после увеличения на 15%. 
SELECT PRODUCT_NAME, PRODUCT_PRICE * (1 + 15 / 100) 'PRODUCT_PRICE + 15%'
FROM PRODUCT;

--2. Напишите запрос, показывающий, сколько всего имеется товаров в таблице product. 
SELECT COUNT(PRODUCT_NAME) 'NUMBER_OF_PRODUCTS'
FROM PRODUCT;

--3. Напишите запрос, показывающий, для какого количества товаров (таблица product) не указана цена. 
SELECT COUNT(PRODUCT_NAME) 'NUMBER_OF_PRODUCTS_WITHOUT_PRICE'
FROM PRODUCT
WHERE PRODUCT_PRICE IS NULL;

--4. Напишите запрос, выводящий минимальную и максимальную цену товаров product_price. 
SELECT MIN(PRODUCT_PRICE) 'MIN_PRICE', MAX(PRODUCT_PRICE) 'MAX_PRICE'
FROM PRODUCT;

--5. Напишите запрос, показывающий, какая сумма была выручена с продаж товаров каждого наименования. 
SELECT TA.PRODUCT_NAME, SUM(TA.QUANTITY * PR.PRODUCT_PRICE) 'SALES_IN_RUB'
FROM PRODUCT AS PR JOIN (SELECT PRODUCT_NAME, QUANTITY FROM PURCHASE 
						UNION ALL
						SELECT PRODUCT_NAME, QUANTITY FROM PURCHASE_ARCHIVE) AS TA ON TA.PRODUCT_NAME = PR.PRODUCT_NAME
WHERE PR.PRODUCT_PRICE IS NOT NULL
GROUP BY TA.PRODUCT_NAME;

--6. Напишите запрос, показывающий, какая сумма была выручена с продаж товаров каждого наименования. Вывести только те записи, для которых сумма продаж больше 125.
SELECT TA.PRODUCT_NAME, SUM(TA.QUANTITY * PR.PRODUCT_PRICE) 'SALES_IN_RUB'
FROM PRODUCT AS PR JOIN (SELECT PRODUCT_NAME, QUANTITY FROM PURCHASE 
						UNION ALL
						SELECT PRODUCT_NAME, QUANTITY FROM PURCHASE_ARCHIVE) AS TA ON TA.PRODUCT_NAME = PR.PRODUCT_NAME
WHERE PR.PRODUCT_PRICE IS NOT NULL
GROUP BY TA.PRODUCT_NAME
HAVING SUM(TA.QUANTITY * PR.PRODUCT_PRICE) > 125;