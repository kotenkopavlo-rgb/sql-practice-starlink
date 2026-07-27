-- starlink_customers definition

CREATE TABLE starlink_customers (
    unique_id VARCHAR(6) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    sex VARCHAR(10),
    country VARCHAR(100),
    city VARCHAR(100),
    phone_number VARCHAR(25),
    email VARCHAR(150),
    sign_contract_date_raw VARCHAR(15), -- Imported temporarily as text due to non-standard format
    gb_downloaded DECIMAL(10, 2),
    gb_uploaded DECIMAL(10, 2)
, loyalty_points INTEGER);

-- subscriptions definition

CREATE TABLE subscriptions (
    subscription_id INTEGER PRIMARY KEY,
    customer_id TEXT NOT NULL,
    plan_name TEXT NOT NULL,
    monthly_fee INTEGER NOT NULL,
    status TEXT NOT NULL,
    start_date DATE, discount_percent INTEGER,
    FOREIGN KEY (customer_id) REFERENCES starlink_customers (unique_id)
);

CREATE INDEX idx_customer_id
ON subscriptions(customer_id);

-- support_tickets definition

CREATE TABLE support_tickets (
    ticket_id INTEGER,
    customer_id VARCHAR(20),
    status VARCHAR(20)
);