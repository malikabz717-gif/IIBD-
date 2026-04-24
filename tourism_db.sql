CREATE DATABASE IF NOT EXISTS tourism_db;
USE tourism_db;

CREATE TABLE clients (
    client_id INT NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    PRIMARY KEY (client_id)
);

CREATE TABLE tours (
    tour_id INT NOT NULL AUTO_INCREMENT,
    tour_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    duration_days INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (tour_id)
);

CREATE TABLE services (
    service_id INT NOT NULL AUTO_INCREMENT,
    service_name VARCHAR(100) NOT NULL,
    service_cost DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (service_id)
);

CREATE TABLE payment_methods (
    payment_method_id INT NOT NULL AUTO_INCREMENT,
    method_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (payment_method_id)
);

CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    client_id INT NOT NULL,
    tour_id INT NOT NULL,
    service_id INT,
    payment_method_id INT NOT NULL,
    order_date DATE NOT NULL,
    persons_count INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id),

    CONSTRAINT fk_orders_clients
        FOREIGN KEY (client_id)
        REFERENCES clients(client_id),

    CONSTRAINT fk_orders_tours
        FOREIGN KEY (tour_id)
        REFERENCES tours(tour_id),

    CONSTRAINT fk_orders_services
        FOREIGN KEY (service_id)
        REFERENCES services(service_id),

    CONSTRAINT fk_orders_payment_methods
        FOREIGN KEY (payment_method_id)
        REFERENCES payment_methods(payment_method_id)
);