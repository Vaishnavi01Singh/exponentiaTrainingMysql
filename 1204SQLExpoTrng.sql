#https://github.com/AsmaStack/exponentiaTrainingMysql


DROP DATABASE IF EXISTS `rental_db`;
CREATE DATABASE `rental_db`;
USE `rental_db`;
-- Create `vehicles` table
DROP TABLE IF EXISTS `vehicles`;

CREATE TABLE `vehicles` 
(`veh_reg_no` VARCHAR(8) NOT NULL, 
`category` ENUM('car', 'truck') NOT NULL DEFAULT 'car', -- Enumeration of one of the items in the list
`brand` VARCHAR(30) NOT NULL DEFAULT '',  
`desc` VARCHAR(256) NOT NULL DEFAULT '', -- desc is a keyword (for descending) and must be back-quoted 
`photo` BLOB NULL, -- binary large object of up to 64KB -- to be implemented later 
`daily_rate` DECIMAL(6,2) NOT NULL DEFAULT 9999.99, -- set default to max value 
PRIMARY KEY (`veh_reg_no`),
INDEX (`category`)); -- Build index on this column for fast search

SHOW CREATE TABLE `vehicles`;
desc vehicles;
SHOW INDEX FROM `vehicles`;

-- Create `customers` table 
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` ( `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT, -- Always use INT for AUTO_INCREMENT column to avoid run-over 
`name` VARCHAR(30) NOT NULL DEFAULT '',
`address` VARCHAR(80) NOT NULL DEFAULT '',
`phone` VARCHAR(15) NOT NULL DEFAULT '', 
`discount` DOUBLE NOT NULL DEFAULT 0.0,
PRIMARY KEY (`customer_id`), 
UNIQUE INDEX (`phone`), -- Build index on this unique-value column 
INDEX (`name`)); -- Build index on this column
DESC `customers`;
SHOW CREATE TABLE `customers`;
SHOW INDEX FROM `customers`;

-- Create `rental_records` table 
DROP TABLE IF EXISTS `rental_records`; 
CREATE TABLE `rental_records` ( `rental_id` INT UNSIGNED NOT NULL AUTO_INCREMENT, 
`veh_reg_no` VARCHAR(8) NOT NULL, 
`customer_id` INT UNSIGNED NOT NULL, 
`start_date` DATE NOT NULL DEFAULT '2011-01-01', 
`end_date` DATE NOT NULL DEFAULT '2025-12-31',
`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Keep the created and last updated timestamp for auditing and security 
PRIMARY KEY (`rental_id`),
FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE, -- Disallow deletion of parent record if there are matching records here -- If parent record (customer_id) changes, update the matching records here 
FOREIGN KEY (`veh_reg_no`) REFERENCES `vehicles` (`veh_reg_no`) ON DELETE RESTRICT ON UPDATE CASCADE);
DESC `rental_records`;
SHOW CREATE TABLE `rental_records`;
SHOW INDEX FROM `rental_records`;

-- Inserting test records 
INSERT INTO `vehicles` VALUES ('SBA1111A', 'car', 'NISSAN SUNNY 1.6L', '4 Door Saloon, Automatic', NULL, 99.99), 
('SBB2222B', 'car', 'TOYOTA ALTIS 1.6L', '4 Door Saloon, Automatic', NULL, 99.99), 
('SBC3333C', 'car', 'HONDA CIVIC 1.8L', '4 Door Saloon, Automatic', NULL, 119.99), 
('GA5555E', 'truck', 'NISSAN CABSTAR 3.0L', 'Lorry, Manual ', NULL, 89.99), 
('GA6666F', 'truck', 'OPEL COMBO 1.6L', 'Van, Manual', NULL, 69.99); -- No photo yet, set to NULL 

SELECT * FROM `vehicles`;

INSERT INTO `customers` VALUES 
(1001, 'Tan Ah Teck', '8 Happy Ave', '88888888', 0.1), 
(NULL, 'Mohammed Ali', '1 Kg Java', '99999999', 0.15), 
(NULL, 'Kumar', '5 Serangoon Road', '55555555', 0), 
(NULL, 'Kevin Jones', '2 Sunset boulevard', '22222222', 0.2);

SELECT * FROM `customers`;

INSERT INTO `rental_records` (`rental_id`, `veh_reg_no`, `customer_id`, `start_date`, `end_date`) VALUES 
(NULL, 'SBA1111A', 1001, '2012-01-01', '2012-01-21'), 
(NULL, 'SBA1111A', 1001, '2012-02-01', '2012-02-05'), 
(NULL, 'GA5555E', 1003, '2012-01-05', '2012-01-31'), 
(NULL, 'GA6666F', 1004, '2012-01-20', '2012-02-20'); 
SELECT * FROM `rental_records`;

-- 1. Customer 'Tan Ah Teck' has rented 'SBA1111A' from today for 10 days. (Hint: You need to insert a rental record. Use a
-- SELECT subquery to get the customer_id. Use CURDATE() (or NOW()) for today; and DATE_ADD(CURDATE(), INTERVAL x
-- unit) to compute a future date.)(answers given)
INSERT INTO rental_records VALUES
(NULL,'SBA1111A',(SELECT customer_id FROM customers WHERE name='Tan Ah Teck'),CURDATE(),DATE_ADD(CURDATE(), INTERVAL 10 DAY), current_timestamp());
select * from rental_records;

-- 2. Customer 'Kumar' has rented 'GA5555E' from tomorrow for 3 months.
INSERT INTO rental_records VALUES
(NULL,'GA5555E',(SELECT customer_id FROM customers WHERE name='Kumar'),CURDATE(),DATE_ADD(CURDATE(), INTERVAL 3 MONTH), current_timestamp());
select * from rental_records;

-- 3. List all rental records (start date, end date) with vehicle's registration number, brand, and customer name, sorted by vehicle's
-- categories followed by start date.(answers given)
SELECT
r.start_date AS `Start Date`,
r.end_date AS `End Date`,
r.veh_reg_no AS `Vehicle No`,
v.brand AS `Vehicle Brand`,
c.name AS `Customer Name`
FROM rental_records AS r
INNER JOIN vehicles AS v USING (veh_reg_no)
INNER JOIN customers AS c USING (customer_id)
ORDER BY v.category, start_date;


-- 4. List all the expired rental records (end_date before CURDATE()).
SELECT
r.start_date AS `Start Date`,
r.end_date AS `End Date`,
r.veh_reg_no AS `Vehicle No`,
v.brand AS `Vehicle Brand`,
c.name AS `Customer Name`
FROM rental_records AS r
INNER JOIN vehicles AS v USING (veh_reg_no)
INNER JOIN customers AS c USING (customer_id)
where r.end_date < current_date()
ORDER BY v.category, start_date;

 
-- 5. List the vehicles rented out on '2012-01-10' (not available for rental), in columns of vehicle registration no, customer name,
-- start date and end date. (Hint: the given date is in between the start_date and end_date.)
SELECT
r.veh_reg_no AS `Vehicle No`,
c.name AS `Customer Name`,
r.start_date AS `Start Date`,
r.end_date AS `End Date`
FROM rental_records AS r
INNER JOIN customers AS c USING (customer_id)
where r.start_date > '2012-01-10' and end_date < current_date();




