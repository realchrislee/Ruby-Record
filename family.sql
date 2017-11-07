CREATE TABLE children (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  parent_id INTEGER,

  FOREIGN KEY(parent_id) REFERENCES parent(id)
);

CREATE TABLE parents (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  car_id INTEGER,

  FOREIGN KEY(car_id) REFERENCES car(id)
);

CREATE TABLE cars (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  cars (id, name)
VALUES
  (1, "Ferrari La Ferrari"), (2, "Porsche 911"), (3, "Bentley"), (4, "Benz C300"), (5, "Audi S4"), (6, "Honda Civic"), (7, "Toyota Prius"), (8, "Hyundai Genesis");

INSERT INTO
  parents (id, name, car_id)
VALUES
  (1, "Chris", 1),
  (2, "Cynthia", 2),
  (3, "Charles", 3),
  (4, "Cadniss", 4),
  (5, "Beth", 5),
  (6, "Sue", 6),
  (7, "Charlie", 7),
  (8, "Sam", 8),
  (9, "Bob", 4),
  (10, "Tim", 5),
  (11, "Ben", 6),
  (12, "Grace", 7),
  (13, "Ellie", NULL);

INSERT INTO
  children (id, name, parent_id)
VALUES
  (1, "Kevin", 1),
  (2, "Christina", 2),
  (3, "Blossom", 3),
  (4, "Rain", 4),
  (5, "Alex", 5),
  (6, "Jim", 6),
  (7, "Hanzo", 7),
  (8, "Fiora", 8),
  (9, "Bill", 9),
  (10, "Warren", 10),
  (11, "William", 11),
  (12, "Diana", 12),
  (13, "Bianca", 13),
  (14, "Cindy", NULL);
