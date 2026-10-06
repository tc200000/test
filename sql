DROP TABLE IF EXISTS ride;
DROP TABLE IF EXISTS house;
DROP TABLE IF EXISTS rating;
DROP TABLE IF EXISTS passenger;
DROP TABLE IF EXISTS driver;
DROP TABLE IF EXISTS streets;


CREATE TABLE streets (
id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
name VARCHAR(30) UNIQUE NOT NULL);


CREATE TABLE house  (
id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
street INTEGER NOT NULL,
house_number  VARCHAR(30) NOT NULL,
FOREIGN KEY(street) REFERENCES streets(id),
UNIQUE (street, house_number));


CREATE TABLE passenger (
id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
name VARCHAR(30));


CREATE TABLE driver (
id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
name VARCHAR(30));


CREATE TABLE rating (
id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
passenger_id INTEGER NOT NULL,
score INTEGER NOT NULL,
FOREIGN KEY (passenger_id) REFERENCES passenger(id));


CREATE TABLE ride  (
id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
passenger INTEGER NOT NULL,
driver INTEGER NOT NULL,     
Destination_address INTEGER,
Shipping_addresses INTEGER,
FOREIGN KEY(passenger) REFERENCES passenger (id),
FOREIGN KEY(driver) REFERENCES driver (id),    
FOREIGN KEY(Destination_address) REFERENCES house (id),
FOREIGN KEY(Shipping_addresses) REFERENCES house (id));







INSERT INTO streets (name)
VALUES
    ('Nezalegnosti'),
    ('Shevchenka'),
    ('Soborna'),
    ('Khreshchatyk'),
    ('Franko'),
    ('Lesi Ukrainky'),
    ('Hrushevskoho'),
    ('Bogdana Khmelnytskoho'),
    ('Peremohy'),
    ('Tsentralna');


INSERT INTO house (street, house_number)
VALUES
    -- Nezalegnosti (id = 1)
    (1, '1'),
    (1, '2'),
    (1, '3'),
    (1, '4'),

    -- Shevchenka (id = 2)
    (2, '1'),
    (2, '2'),
    (2, '3'),
    (2, '4'),
    (2, '5'),

    -- Soborna (id = 3)
    (3, '1'),
    (3, '2'),
    (3, '3'),

    -- Khreshchatyk (id = 4)
    (4, '1'),
    (4, '2'),
    (4, '3'),
    (4, '4'),
    (4, '5'),
    (4, '6'),

    -- Franko (id = 5)
    (5, '1'),
    (5, '2'),
    (5, '3'),
    (5, '4'),

    -- Lesi Ukrainky (id = 6)
    (6, '1'),
    (6, '2'),
    (6, '3'),

    -- Hrushevskoho (id = 7)
    (7, '1'),
    (7, '2'),
    (7, '3'),
    (7, '4'),
    (7, '5'),

    -- Bogdana Khmelnytskoho (id = 8)
    (8, '1'),
    (8, '2'),
    (8, '3'),
    (8, '4'),

    -- Peremohy (id = 9)
    (9, '1'),
    (9, '2'),
    (9, '3'),

    -- Tsentralna (id = 10)
    (10, '1'),
    (10, '2'),
    (10, '3'),
    (10, '4'),
    (10, '5');



-- 2 пасажири
INSERT INTO passenger (name)
VALUES
    ('Ivan Petrenko'),
    ('Oksana Kovalenko');


-- 2 водії
INSERT INTO driver (name)
VALUES
    ('Andrii Shevchenko'),
    ('Olena Bondarenko');


-- Рейтинги пасажирів
INSERT INTO rating (passenger_id, score)
VALUES
    (1, 5),
    (2, 4);


-- 4 поїздки
INSERT INTO ride (
    passenger,
    driver,
    Destination_address,
    Shipping_addresses
)
VALUES
    (1, 1, 5, 10),
    (2, 2, 15, 20),
    (1, 2, 25, 30),
    (2, 1, 35, 40);


SELECT 
  streets.name, 
    COUNT(house.id) 
FROM house
JOIN streets ON house.street = streets.id
  GROUP BY 
streets.name 
ORDER BY COUNT(id) DESC
LIMIT 1;