
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE destinations (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE attractions (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    destination_id INT,
    FOREIGN KEY (destination_id) REFERENCES destinations(id)
);

CREATE TABLE national_parks (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE tours (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE tour_bookings (
    id INT PRIMARY KEY,
    tour_id INT,
    user_id INT,
    FOREIGN KEY (tour_id) REFERENCES tours(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
