CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  email VARCHAR(100) UNIQUE
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  order_date DATE,
  status VARCHAR(20),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  price DECIMAL(10,2), 
  category VARCHAR(20)
);

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  product_id INT,
  quantity INT,
  price_at_purchase DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (name, email) VALUES
('John Smith', 'john.smith@example.com'),
('Sarah Johnson', 'sarahj@example.com'),
('Mike Chen', 'mike.chen@example.com'),
('Emma Wilson', 'emma_w@example.com'),
('David Brown', 'dbrown@example.com');

INSERT INTO products (name, price, category) VALUES
('Laptop Pro 15"', 1299.99, 'Electronics'),
('Wireless Headphones', 89.50, 'Electronics'),
('Desk Lamp', 24.99, 'Home'),
('Coffee Maker', 49.95, 'Kitchen'),
('Yoga Mat', 19.99, 'Fitness'),
('Water Bottle', 12.49, 'Fitness'),
('Novel - The Silent Forest', 14.99, 'Books');

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2023-10-05', 'Delivered'),
(2, '2023-10-06', 'Shipped'),
(3, '2023-10-07', 'Pending'),
(1, '2023-10-08', 'Pending'),
(4, '2023-10-09', 'Delivered'),
(5, '2023-10-10', 'Cancelled');

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES 

-- Order 1: John Smith 
(1, 1, 1, 1299.99), -- Laptop 
(1, 2, 1, 89.50), -- Headphones

-- Order 2: Sarah Johnson 
(2, 4, 1, 49.95), -- Coffee Maker 
(2, 5, 2, 19.99), -- 2 Yoga Mats

-- Order 3: Mike Chen 
(3, 3, 3, 24.99), -- 3 Desk Lamps 
(3, 7, 1, 14.99), -- Book

-- Order 4: John Smith (second order) 
(4, 6, 4, 12.49), -- 4 Water Bottles

-- Order 5: Emma Wilson
 (5, 1, 1, 1299.99), -- Laptop 
(5, 2, 1, 89.50), -- Headphones 
(5, 4, 1, 49.95), -- Coffee Maker

-- Order 6: David Brown (cancelled) 
(6, 5, 1, 19.99); -- Yoga Mat

--Exercise
--order history for active customers to track shipping and delivery timelines.
SELECT c.name, o.order_date 
FROM customers c 
INNER JOIN orders o 
ON c.customer_id = o.customer_id;

--rank customers by order volume to target "VIPs" with perks or identify inactive users for win-back campaigns.
SELECT c.name, COUNT(o.order_id) AS order_count 
FROM customers c 
LEFT JOIN orders o 
ON c.customer_id = o.customer_id 
GROUP BY c.customer_id;

--show the exact product manifest and quantities per customer
SELECT c.name, p.name AS product, oi.quantity 
FROM orders o 
JOIN order_items oi ON o.order_id = oi.order_id 
JOIN products p ON oi.product_id = p.product_id 
JOIN customers c ON o.customer_id = c.customer_id;


--show customers who spent more than £1000 in a single order.
SELECT c.name, o.order_id, 
SUM(oi.quantity * p.price) AS total 
FROM orders o 
JOIN order_items oi ON o.order_id = oi.order_id 
JOIN products p ON oi.product_id = p.product_id 
JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY o.order_id 
HAVING total > 1000;