DROP DATABASE IF EXISTS LongTorales_ACMEOnline;
CREATE DATABASE LongTorales_ACMEOnline;
USE LongTorales_ACMEOnline;

CREATE TABLE item(
	itemNumber SMALLINT UNSIGNED AUTO_INCREMENT,
    itemName VARCHAR(35) NOT NULL,
    descriptor VARCHAR(255),
    model VARCHAR(50) NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    CONSTRAINT item_pk PRIMARY KEY (itemNumber)
);

CREATE TABLE customer(
	customerID SMALLINT UNSIGNED AUTO_INCREMENT,
    customerName VARCHAR(50) NOT NULL,
    address VARCHAR(150) NOT NULL,
    email VARCHAR(80),
    customerType ENUM("Business", "Home"),
    CONSTRAINT customer_pk PRIMARY KEY (customerID)
);

CREATE TABLE home(
	customerID SMALLINT UNSIGNED,
    creditCardNum CHAR(16) NOT NULL,
    cardExpirationDate CHAR(6) NOT NULL,
    CONSTRAINT home_pk PRIMARY KEY (customerID),
    CONSTRAINT home_customerID_fk FOREIGN KEY (customerID)
		REFERENCES customer(customerID) ON UPDATE CASCADE
);

CREATE TABLE business(
	customerID SMALLINT UNSIGNED,
    paymentTerms VARCHAR(50) NOT NULL,
    CONSTRAINT business_pk PRIMARY KEY (customerID),
    CONSTRAINT business_customerID_fk FOREIGN KEY (customerID)
		REFERENCES customer(customerID) ON UPDATE CASCADE
);

CREATE TABLE ordered(
	orderID SMALLINT UNSIGNED AUTO_INCREMENT,
    totalCost DECIMAL(10, 2),
    customerID SMALLINT UNSIGNED,
	CONSTRAINT ordered_pk PRIMARY KEY (orderID),
    CONSTRAINT ordered_customerID_fk FOREIGN KEY (customerID)
		REFERENCES customer(customerID) ON UPDATE CASCADE
);

CREATE TABLE line_item(
	itemNumber SMALLINT UNSIGNED,
    orderID SMALLINT UNSIGNED,
    quantity TINYINT UNSIGNED,
    CONSTRAINT line_item_pk PRIMARY KEY (itemNumber, orderID),
    CONSTRAINT line_item_itemNumber_fk FOREIGN KEY (itemNumber) 
		REFERENCES item(itemNumber) ON UPDATE CASCADE,
	CONSTRAINT line_item_orderID_fk FOREIGN KEY (orderID)
		REFERENCES ordered(orderID) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO item (itemName, descriptor, model, price)
	VALUES ("Cabbage Patch Doll", "Baby boy doll", "Boy", 39.95),
		("The Last Lecture", NULL, "Hardcover", 9.95),
        ("Keurig Beverage Maker", "Keurig Platinum Ediction Beverage Maker in Red", "Platinum Edition", 299.95);
        
ALTER TABLE customer
	CHANGE address address VARCHAR(100),
    ADD city VARCHAR(60),
    ADD state CHAR(2),
    ADD zipcode1 CHAR(5),
    ADD zipcode2 CHAR(4);
    
DELETE FROM item
	WHERE itemName = "Keurig Beverage Maker";
    
UPDATE item
	SET descriptor = "Written by Randy Pausch"
    WHERE itemName = "The Last Lecture";
    
START TRANSACTION;
	INSERT INTO customer (customerName, address, city, state, zipcode1, email, customerType)
		VALUES ("Janine Jeffers", "152 Lomb Memorial Dr.", "Rochester", "NY", "14623", "jxj1234@rit.edu", "home");
    INSERT INTO home (customerID, creditCardNum, cardExpirationDate)
		SELECT customerID, 1234567890123456, 012014
		FROM customer
        WHERE customerName = "Janine Jeffers";
	INSERT INTO ordered
		SELECT 1, 113.74, customerID
        FROM customer
        WHERE customerName = "Janine Jeffers";
	INSERT INTO line_item
		VALUES (1, 1, 2),
			(2, 1, 3);
COMMIT;