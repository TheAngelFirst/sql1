/*
Практическое задание № 5
1. Напишите запрос, который возвращает всех сотрудников, которых взяли на работу в то же день, что и сотрудника John Smith.
2. Напишите запрос, который возвращает все товары, цена которых ниже средней цены.
3. Напишите запрос, который возвращает все товары, которые продавались более одного раза.
4. Выведите увеличенную на 15% цену товаров, которые продавались более одного раза.
5. Используя условие EXISTS, напишите запрос, который возвращает всех сотрудников, которые хотя бы один раз что-либо продали.
6. Напишите запрос, который возвращает все товары из таблицы product, цена которых меньше цены любого товара, проданного сотрудником с кодом 'GA'.
7. напишите запрос, который вернет все товары из таблицы product, цена которых меньше цены хотя бы одного товара, проданного сотрудником с кодом 'GA'. Убедитесь, что операторы SOME и ANY взаимозаменяемы.
*/
--1. Напишите запрос, который возвращает всех сотрудников, которых взяли на работу в то же день, что и сотрудника John Smith.
SELECT *
FROM PERSON
WHERE HIREDATE = (SELECT HIREDATE
                  FROM PERSON
                  WHERE FIRST_NAME = 'John' AND LAST_NAME = 'Smith');

--2. Напишите запрос, который возвращает все товары, цена которых ниже средней цены.
SELECT *
FROM PRODUCT
WHERE PRODUCT_PRICE < (SELECT AVG(PRODUCT_PRICE)
                       FROM PRODUCT);

--3. Напишите запрос, который возвращает все товары, которые продавались более одного раза.
SELECT TA2.PRODUCT_NAME
FROM (SELECT TA.PRODUCT_NAME, COUNT(*) 'CNT'
      FROM (SELECT PRODUCT_NAME 
            FROM PURCHASE 
			UNION ALL
			SELECT PRODUCT_NAME FROM PURCHASE_ARCHIVE) AS TA
      GROUP BY TA.PRODUCT_NAME) AS TA2
WHERE TA2.CNT > 1;

--4. Выведите увеличенную на 15% цену товаров, которые продавались более одного раза.
SELECT TA2.PRODUCT_NAME, PRODUCT_PRICE * (1 + 15 / 100) 'PRODUCT_PRICE + 15%'
FROM (SELECT TA.PRODUCT_NAME, COUNT(*) 'CNT'
      FROM (SELECT PRODUCT_NAME 
            FROM PURCHASE 
			UNION ALL
			SELECT PRODUCT_NAME 
			FROM PURCHASE_ARCHIVE
           ) AS TA
      GROUP BY TA.PRODUCT_NAME
     ) AS TA2 JOIN PRODUCT ON TA2.PRODUCT_NAME = PRODUCT.PRODUCT_NAME
WHERE TA2.CNT > 1;
--ИЛИ
SELECT PRODUCT_NAME, PRODUCT_PRICE * (1 + 15 / 100) 'PRODUCT_PRICE + 15%'
FROM PRODUCT
WHERE PRODUCT_NAME IN (SELECT TA2.PRODUCT_NAME 
                       FROM (SELECT TA.PRODUCT_NAME, COUNT(*) 'CNT'
                             FROM (SELECT PRODUCT_NAME 
                                   FROM PURCHASE 
								   UNION ALL
                                   SELECT PRODUCT_NAME 
								   FROM PURCHASE_ARCHIVE) AS TA
                             GROUP BY TA.PRODUCT_NAME) AS TA2
                       WHERE TA2.CNT > 1);

--5. Используя условие EXISTS, напишите запрос, который возвращает всех сотрудников, которые хотя бы один раз что-либо продали.
SELECT *
FROM PERSON AS PE 
WHERE EXISTS(SELECT * 
            FROM PURCHASE AS PU
            WHERE PE.PERSON_CODE = PU.PERSON_CODE);

--6. Напишите запрос, который возвращает все товары из таблицы product, цена которых меньше цены любого товара, проданного сотрудником с кодом 'GA'.
SELECT *
FROM PRODUCT 
WHERE PRODUCT_PRICE < ALL (SELECT PRODUCT_PRICE 
                           FROM PRODUCT AS PR JOIN (SELECT PRODUCT_NAME, PERSON_CODE 
                                                    FROM PURCHASE 
                                                    UNION ALL  
                                                    SELECT PRODUCT_NAME, PERSON_CODE  
                                                    FROM PURCHASE_ARCHIVE
                                                   ) AS TA ON PR.PRODUCT_NAME = TA.PRODUCT_NAME 
                           WHERE PERSON_CODE = 'GA');

--7. напишите запрос, который вернет все товары из таблицы product, цена которых меньше цены хотя бы одного товара, проданного сотрудником с кодом 'GA'. Убедитесь, что операторы SOME и ANY взаимозаменяемы.
SELECT *
FROM PRODUCT 
WHERE PRODUCT_PRICE < ANY (SELECT PRODUCT_PRICE 
                           FROM PRODUCT AS PR JOIN (SELECT PRODUCT_NAME, PERSON_CODE 
                                                    FROM PURCHASE 
                                                    UNION ALL  
                                                    SELECT PRODUCT_NAME, PERSON_CODE  
                                                    FROM PURCHASE_ARCHIVE
                                                   ) AS TA ON PR.PRODUCT_NAME = TA.PRODUCT_NAME 
                           WHERE PERSON_CODE = 'GA');
--ИЛИ
SELECT *
FROM PRODUCT 
WHERE PRODUCT_PRICE < SOME (SELECT PRODUCT_PRICE 
                            FROM PRODUCT AS PR JOIN (SELECT PRODUCT_NAME, PERSON_CODE 
                                                     FROM PURCHASE 
                                                     UNION ALL  
                                                     SELECT PRODUCT_NAME, PERSON_CODE  
                                                     FROM PURCHASE_ARCHIVE
                                                    ) AS TA ON PR.PRODUCT_NAME = TA.PRODUCT_NAME 
                            WHERE PERSON_CODE = 'GA');