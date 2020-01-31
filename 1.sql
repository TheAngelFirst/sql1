/*
1. Создать БД, изображенную на рисунке (создать таблицы и внешний ключ)
2. Внести в таблицы следующие данные.
Dept:    (1, 'Marketing'), (2, 'RD')
Emp:    (1, 1, 'James', 1000), (2, 2, 'Smith', 2000)
3. Создать таблицу dept_arch с такой же структурой, как и у таблицы dept.
4. Вставить в таблицу dept_arch все данные из таблицы dept.
5. Увеличьте на 15% зарплату сотруднику Smith.
6. Убедитесь, что в таблицу dept нельзя вставить такую запись: (2, 'Sales'). Почему?
7. Убедитесь, что в таблицу emp нельзя вставить такую запись: (3, 4, 'Black', 3000, 'Active'). Почему?
8. Измените название отдела RD на RandD (таблица dept).
9. Удалите из таблицы emp запись с emp_id = 1.
10. Удалите из таблицы emp все записи.
11. Удалите таблицу emp.
*/
--1. Создать БД, изображенную на рисунке (создать таблицы и внешний ключ)
CREATE DATABASE DB_HW;

CREATE TABLE DEPT
(
	DEPT_ID INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	DNAME VARCHAR(20)
);

CREATE TABLE EMP
(
	EMP_ID INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	DEPT_ID INTEGER REFERENCES DEPT (DEPT_ID),
	ENAME VARCHAR(15),
	SALARY NUMERIC(6,2)
);

--2. Внести в таблицы следующие данные. Dept:    (1, 'Marketing'), (2, 'RD'); Emp:    (1, 1, 'James', 1000), (2, 2, 'Smith', 2000)
INSERT INTO DEPT (DEPT_ID, DNAME) 
VALUES 
        (1, 'Marketing'),
        (2, 'RD');
		
INSERT INTO EMP (EMP_ID, DEPT_ID, ENAME, SALARY) 
VALUES 
        (1, 1, 'James', 1000),
        (2, 2, 'Smith', 2000);

--3. Создать таблицу dept_arch с такой же структурой, как и у таблицы dept.
--4. Вставить в таблицу dept_arch все данные из таблицы dept.
CREATE TABLE DEPT_ARCH SELECT * FROM DEPT;

--5. Увеличьте на 15% зарплату сотруднику Smith.
UPDATE EMP
SET SALARY=SALARY*(1+15/100)
WHERE ENAME='Smith';

--6. Убедитесь, что в таблицу dept нельзя вставить такую запись: (2, 'Sales'). Почему?
INSERT INTO DEPT (DEPT_ID, DNAME) 
VALUES 
        (2, 'Sales'); --Ошибка. Дублирующаяся запись '2' по ключу 'PRIMARY'

--7. Убедитесь, что в таблицу emp нельзя вставить такую запись: (3, 4, 'Black', 3000, 'Active'). Почему?
INSERT INTO EMP
VALUES 
        (3, 4, 'Black', 2000, 'Active'); --Ошибка. Количество столбцов не совпадает с количеством значений в записи 1

--8. Измените название отдела RD на RandD (таблица dept).
UPDATE DEPT
SET DNAME='RandD'
WHERE DEPT_ID=2;

--9. Удалите из таблицы emp запись с emp_id = 1.
DELETE FROM EMP WHERE EMP_ID=1;

--10. Удалите из таблицы emp все записи.
TRUNCATE TABLE EMP;

--11. Удалите таблицу emp.
DROP TABLE EMP;