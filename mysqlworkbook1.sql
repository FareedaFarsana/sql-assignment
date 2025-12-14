USERS & DATABASES (5 Exercises)

1)Create users user1, user2, user3 with password test123#, accessible from localhost.
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'test123#';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'test123#';
CREATE USER 'user3'@'localhost' IDENTIFIED BY 'test123#';

2)Remove the user user2 from the MySQL server.
DROP USER 'user2'@'localhost';

3)Create a two databases named: training_db1,training_db2.
CREATE DATABASE training_db1;
CREATE DATABASE training_db2;

4)Drop database training_db2;
DROP DATABASE training_db2;

5)Create permission for the user1 to access database training_db1
GRANT all PRIVILEGES ON training_db1.* to 'user1'@'localhost';

6)Create a database training_db3
CREATE DATABASE training_db3;

7)Create permission for the user1 to access database training_db3
GRANT all PRIVILEGES ON training_db3.* TO 'user1'@'localhost';

8)Create permission for the user3 to access database training_db3
GRANT all PRIVILEGES ON training_db3.* TO 'user3'@'localhost';

9)revoke the permission of user1 for accessing the database training_db3
REVOKE all PRIVILEGES ON training_db3.* FROM 'user1'@'localhost';

10)Basic Inventory Management System (Database Design)
Design and create a database for an Inventory System using MySQL

Tables Need to create 
10.a)
	TableName: items
	Stores all products in inventory.
	
	Requirements / Hints:

	->Item must have a unique ID

	->Each item must have a name

	->Should store purchase price and selling price

	->Should store the category name

	->Should not allow empty fields for name or category

	->Price fields must allow decimals

CREATE table items(
	id INT PRIMARY KEY UNIQUE,
	name VARCHAR(100) NOT NULL,
	purchase_price DECIMAL(10,5), 
	selling_price decimal(10,5),
	category_name VARCHAR(100) NOT NULL
);

10.b)
	Table: stock

	Maintains current quantity of each item.
	
	Requirements / Hints:

	->Each stock row must refer to an item (foreign key)

	->Must store current quantity

	->Quantity must not be negative

	->Should store the date when stock was last updated

		(Hint: Use foreign key(item_id) referencing items(item_id))


	CREATE TABLE stock(
		item_id INT, FOREIGN KEY(item_id) REFERENCES items(id),
		quantity INT CHECK(quantity >= 0),
		last_updated date
	);


10.c)
	Table: transactions

	Stores all stock movements.

	Requirements / Hints:

	->Each transaction must have an ID

	->Must refer to which item was added/removed (foreign key)

	->Must store:

		->quantity

		->transaction type (IN or OUT) → Hint: Use ENUM

		->date

	->Quantity must be positive

	->Students should think about setting default date using now()

CREATE TABLE transactions(
	transaction_id INT AUTO_INCREMENT PRIMARY KEY,
	item_id int, FOREIGN KEY(item_id) REFERENCES items(id),
	quantity int CHECK(quantity > 0),
	transaction_type ENUM('IN', 'OUT'),
	transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

11)Insert Sample Data 20 records for each table

INSERT INTO items (id, name, purchase_price, selling_price, category_name) VALUES
(1, 'Samsung Smart TV 43"', 25000, 30000, 'Electronics'),
(2, 'LG Refrigerator 260L', 38000, 45000, 'Electronics'),
(3, 'Sony Bluetooth Headphones', 1500, 2000, 'Electronics'),
(4, 'Dell Inspiron Laptop', 55000, 65000, 'Electronics'),
(5, 'Mi Power Bank 20000mAh', 1200, 1500, 'Electronics'),
(6, 'HP Pavilion Laptop', 60000, 72000, 'Electronics'),
(7, 'JBL Bluetooth Speaker', 2500, 3500, 'Electronics'),
(8, 'Canon Printer', 7000, 8500, 'Electronics'),
(9, 'Lenovo Tablet', 12000, 15000, 'Electronics'),
(10, 'Boat Earbuds', 1000, 1500, 'Electronics'),
(11, 'Apple iPhone 14', 65000, 80000, 'Electronics'),
(12, 'Apple Watch Series 8', 25000, 30000, 'Electronics'),
(13, 'Samsung Galaxy A55', 20000, 25000, 'Electronics'),
(14, 'ADATA 1TB SSD', 3500, 4800, 'Electronics'),
(15, 'Logitech Keyboard', 600, 900, 'Electronics'),
(16, 'LG Monitor 24"', 9000, 11500, 'Electronics'),
(17, 'Panasonic Mixer Grinder', 2500, 3200, 'Electronics'),
(18, 'Philips LED Bulb', 50, 80, 'Electronics'),
(19, 'Samsung Washing Machine', 35000, 42000, 'Electronics'),
(20, 'Micromax Air Conditioner', 27000, 33000, 'Electronics');



INSERT INTO stock (item_id, quantity, last_updated) VALUES
(1, 10, '2025-12-04'),
(2, 5, '2025-12-04'),
(3, 25, '2025-12-04'),
(4, 7, '2025-12-04'),
(5, 50, '2025-12-04'),
(6, 8, '2025-12-04'),
(7, 20, '2025-12-04'),
(8, 12, '2025-12-04'),
(9, 15, '2025-12-04'),
(10, 30, '2025-12-04'),
(11, 6, '2025-12-04'),
(12, 10, '2025-12-04'),
(13, 14, '2025-12-04'),
(14, 18, '2025-12-04'),
(15, 40, '2025-12-04'),
(16, 9, '2025-12-04'),
(17, 7, '2025-12-04'),
(18, 100, '2025-12-04'),
(19, 4, '2025-12-04'),
(20, 3, '2025-12-04');



12)Perform Select Operations
	->Select all items

	->Select items with selling price > 1000

	->Select items belonging to category “Electronics”

SELECT * FROM items;

SELECT * FROM items WHERE selling_price > 1000;

SELECT * FROM items WHERE category_name = 'Electronics';



13)Join Queries

	->Show each item with its current stock

	->Show each transaction with item name

	(Hint: Use inner join stock on items.item_id = stock.item_id)

SELECT 
	stock.quantity, 
	items.name AS item_name
FROM stock
INNER JOIN items ON items.id = stock.item_id;

14)Aggregate Queries

	->Find total stock value
	Hint: sum(quantity * purchase_price)
	
	SELECT SUM(stock.quantity * items.purchase_price) AS total_stock_value
	FROM stock
	JOIN items ON stock.item_id = items.id;

	->Find total items in category-wise grouping
	Hint: Use group by

	SELECT items.category_name, SUM(stock.quantity) AS total_items
	FROM items
	JOIN stock ON items.id = stock.item_id
	GROUP BY items.category_name;

	->Show items that have stock less than 10
	
	SELECT items.name, stock.quantity
	FROM items
	JOIN stock ON items.id = stock.item_id
	where stock.quantity < 10;


15)Views
Task 7 — Create a view

	Create a view named item_overview that shows:

		->item name

		->category

		->purchase price

		->selling price

		->current stock quantity

CREATE VIEW item_overview AS
SELECT
	items.name, 
	items.category_name, 
	items.purchase_price, 
	items.selling_price, 
	stock.quantity AS current_stock_quantity
FROM items
JOIN stock ON items.id = stock.item_id;


16)PART 6: Stored Procedure
	Task 8 — Write a procedure add_stock(item_id, qty)

	The procedure must:

		->insert a new IN transaction

		->increase the stock quantity

		(Hint: Use update stock set quantity = quantity + qty where item_id = ...)

->
DELIMITER /
CREATE PROCEDURE add_stock(IN p_item_id INT, IN p_qty INT)
BEGIN
	INSERT INTO transactions(item_id, quantity, transaction_type)
	VALUES(p_item_id, p_qty, 'IN');

	UPDATE stock 
	SET quantity = quantity + p_qty 
	WHERE item_id = p_item_id;
END /
DELIMITER ;

CALL add_stock(20, 4);


































