use fisa_ott;


-- Create the COUPON table
CREATE TABLE COUPON (
    coupon_id VARCHAR(10) PRIMARY KEY,
    coupon_type VARCHAR(20) NOT NULL
);


-- Create the RANK table
CREATE TABLE RANKS (
    membership_rank VARCHAR(10) PRIMARY KEY,
    point_percent FLOAT NOT NULL,
    benefit VARCHAR(20),
    total_benefit VARCHAR(20) NOT NULL,
    coupon_id VARCHAR(10),
    FOREIGN KEY (coupon_id) REFERENCES COUPON(coupon_id)
);

-- Create the CUSTOMERS table
CREATE TABLE CUSTOMERS (
    customer_id VARCHAR(30) PRIMARY KEY,
    customer_name VARCHAR(20) NOT NULL,
    address VARCHAR(20) NOT NULL,
    phone_num VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL,
    total_spending VARCHAR(20) NOT NULL,
    membership_rank VARCHAR(10),
    FOREIGN KEY (membership_rank) REFERENCES RANKS(membership_rank)
);

-- Create the PRODUCT table
CREATE TABLE PRODUCT (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(20) NOT NULL,
    price INT NOT NULL,
    quantity INT NOT NULL
);

-- Create the Payment table
CREATE TABLE Payment (
    payments_id VARCHAR(20) PRIMARY KEY,
    created_date DATE NOT NULL,
    payment_method VARCHAR(255),
    total_price INT NOT NULL,
    coupon_id varchar(10),
    FOREIGN KEY (coupon_id) REFERENCES coupon(coupon_id)
);

-- Create the ORDER table
CREATE TABLE ORDERS (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    product_id VARCHAR(10),
    payments_id VARCHAR(20),
    order_date DATE NOT NULL,
    product_num INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id),
    FOREIGN KEY (payments_id) REFERENCES Payment(payments_id)
);

-- Create the Delivery table
CREATE TABLE Delivery (
    delivery_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(20),
    payments_id VARCHAR(20),
    Type VARCHAR(20) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Departure DATE,
    Arrival DATE,
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (payments_id) REFERENCES Payment(payments_id)
);


-- Insert data into COUPON table
INSERT INTO COUPON (coupon_id, coupon_type)
VALUES
('C001', 'Discount'),
('C002', 'Free Shipping'),
('C003', 'Buy One Get One'),
('C004', '10% Off'),
('C005', '20% Off'),
('C006', 'Black Friday'),
('C007', 'Cyber Monday'),
('C008', 'Christmas Special'),
('C009', 'New Year Sale'),
('C010', 'Valentine Special');

-- Insert data into RANKS table
INSERT INTO RANKS (membership_rank, point_percent, benefit, total_benefit, coupon_id)
VALUES
('R1', 0.05, 'Free Shipping', '10000', 'C001'),
('R2', 0.07, 'Early Access', '15000', 'C002'),
('R3', 0.10, 'Extra Discount', '20000', 'C003'),
('R4', 0.12, 'Priority Support', '25000', 'C004'),
('R5', 0.15, 'Special Offers', '30000', 'C005'),
('R6', 0.17, 'VIP Access', '35000', 'C006'),
('R7', 0.20, 'Free Returns', '40000', 'C007'),
('R8', 0.22, 'Birthday Gift', '45000', 'C008'),
('R9', 0.25, 'Anniversary Gift', '50000', 'C009'),
('R10', 0.30, 'Loyalty Reward', '60000', 'C010');

-- Insert data into CUSTOMERS table
INSERT INTO CUSTOMERS (customer_id, customer_name, address, phone_num, email, total_spending, membership_rank)
VALUES
('CU001', 'Alice', '123 Main St', '123-456-7890', 'alice@example.com', '15000', 'R1'),
('CU002', 'Bob', '456 Oak St', '234-567-8901', 'bob@example.com', '25000', 'R2'),
('CU003', 'Charlie', '789 Pine St', '345-678-9012', 'charlie@example.com', '35000', 'R3'),
('CU004', 'David', '101 Maple St', '456-789-0123', 'david@example.com', '45000', 'R4'),
('CU005', 'Eve', '202 Birch St', '567-890-1234', 'eve@example.com', '55000', 'R5'),
('CU006', 'Frank', '303 Cedar St', '678-901-2345', 'frank@example.com', '65000', 'R6'),
('CU007', 'Grace', '404 Elm St', '789-012-3456', 'grace@example.com', '75000', 'R7'),
('CU008', 'Hank', '505 Ash St', '890-123-4567', 'hank@example.com', '85000', 'R8'),
('CU009', 'Ivy', '606 Poplar St', '901-234-5678', 'ivy@example.com', '95000', 'R9'),
('CU010', 'Jack', '707 Willow St', '012-345-6789', 'jack@example.com', '105000', 'R10');

-- Insert data into PRODUCT table
INSERT INTO PRODUCT (product_id, product_name, price, quantity)
VALUES
('P001', 'Product A', 100, 50),
('P002', 'Product B', 150, 40),
('P003', 'Product C', 200, 30),
('P004', 'Product D', 250, 20),
('P005', 'Product E', 300, 10),
('P006', 'Product F', 350, 5),
('P007', 'Product G', 400, 8),
('P008', 'Product H', 450, 12),
('P009', 'Product I', 500, 6),
('P010', 'Product J', 550, 4);

-- Insert data into Payment table
INSERT INTO Payment (payments_id, created_date, payment_method, total_price, coupon_id)
VALUES
('PM001', '2024-07-01', 'Credit Card', 150, 'C001'),
('PM002', '2024-07-02', 'PayPal', 300, 'C002'),
('PM003', '2024-07-03', 'Debit Card', 450, 'C003'),
('PM004', '2024-07-04', 'Credit Card', 600, 'C004'),
('PM005', '2024-07-05', 'PayPal', 750, 'C005'),
('PM006', '2024-07-06', 'Debit Card', 900, 'C006'),
('PM007', '2024-07-07', 'Credit Card', 1050, 'C007'),
('PM008', '2024-07-08', 'PayPal', 1200, 'C008'),
('PM009', '2024-07-09', 'Debit Card', 1350, 'C009'),
('PM010', '2024-07-10', 'Credit Card', 1500, 'C010');

-- Insert data into ORDERS table
INSERT INTO ORDERS (order_id, customer_id, product_id, payments_id, order_date, product_num)
VALUES
('O001', 'CU001', 'P001', 'PM001', '2024-07-01', 1),
('O002', 'CU002', 'P002', 'PM002', '2024-07-02', 2),
('O003', 'CU003', 'P003', 'PM003', '2024-07-03', 3),
('O004', 'CU004', 'P004', 'PM004', '2024-07-04', 4),
('O005', 'CU005', 'P005', 'PM005', '2024-07-05', 5),
('O006', 'CU006', 'P006', 'PM006', '2024-07-06', 1),
('O007', 'CU007', 'P007', 'PM007', '2024-07-07', 2),
('O008', 'CU008', 'P008', 'PM008', '2024-07-08', 3),
('O009', 'CU009', 'P009', 'PM009', '2024-07-09', 4),
('O010', 'CU010', 'P010', 'PM010', '2024-07-10', 5);

-- Insert data into Delivery table
INSERT INTO Delivery (delivery_id, order_id, payments_id, Type, Status, Departure, Arrival)
VALUES
('D001', 'O001', 'PM001', 'Standard', 'Shipped', '2024-07-02', '2024-07-04'),
('D002', 'O002', 'PM002', 'Express', 'Delivered', '2024-07-03', '2024-07-05'),
('D003', 'O003', 'PM003', 'Standard', 'Shipped', '2024-07-04', '2024-07-06'),
('D004', 'O004', 'PM004', 'Express', 'Delivered', '2024-07-05', '2024-07-07'),
('D005', 'O005', 'PM005', 'Standard', 'Shipped', '2024-07-06', '2024-07-08'),
('D006', 'O006', 'PM006', 'Express', 'Delivered', '2024-07-07', '2024-07-09'),
('D007', 'O007', 'PM007', 'Standard', 'Shipped', '2024-07-08', '2024-07-10'),
('D008', 'O008', 'PM008', 'Express', 'Delivered', '2024-07-09', '2024-07-11'),
('D009', 'O009', 'PM009', 'Standard', 'Shipped', '2024-07-10', '2024-07-12'),
('D010', 'O010', 'PM010', 'Express', 'Delivered', '2024-07-11', '2024-07-13');

ALTER TABLE ORDERS ADD COLUMN status VARCHAR(20) DEFAULT 'Active';

-- 주문이 취소될 때 해당 상품의 재고를 원래대로 돌려놓습니다.
DELIMITER //

CREATE TRIGGER update_product_stock_after_cancel
AFTER UPDATE ON ORDERS
FOR EACH ROW
BEGIN
    -- Check if the order status is updated to 'Cancelled'
    IF NEW.status = 'Cancelled' AND OLD.status <> 'Cancelled' THEN
        -- Increase the product quantity in the PRODUCT table
        UPDATE PRODUCT
        SET quantity = quantity + OLD.product_num
        WHERE product_id = OLD.product_id;
    END IF;
END //



-- 주문이 확정 될 때 총금액 업데이트

DELIMITER //

CREATE TRIGGER update_total_spending_on_insert
AFTER INSERT ON ORDERS
FOR EACH ROW
BEGIN
    DECLARE product_price INT;
    SELECT price INTO product_price FROM PRODUCT WHERE product_id = NEW.product_id;
    
    UPDATE CUSTOMERS
    SET total_spending = total_spending + (product_price * NEW.product_num)
    WHERE customer_id = NEW.customer_id;
END;

//

DELIMITER ;



-- 주문이 삭제 될 때 총금액 업데이트
DELIMITER //

CREATE TRIGGER update_total_spending_on_delete
AFTER DELETE ON ORDERS
FOR EACH ROW
BEGIN
    DECLARE product_price INT;
    SELECT price INTO product_price FROM PRODUCT WHERE product_id = OLD.product_id;
    
    UPDATE CUSTOMERS
    SET total_spending = total_spending - (product_price * OLD.product_num)
    WHERE customer_id = OLD.customer_id;
END;

//

DELIMITER ;

