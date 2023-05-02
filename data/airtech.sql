CREATE DATABASE airtech;


SELECT DATABASE airtech;

CREATE TABLE aircraft_model(
  id_aircraft_model INT NOT NULL AUTO_INCREMENT,
  model VARCHAR(50) NOT NULL,
  manufacturer VARCHAR(50) NOT NULL,
  manufacturing_year VARCHAR(50) NOT NULL,
  aircraft_type VARCHAR(50) NOT NULL,
  passenger_capacity VARCHAR(50) NOT NULL,
  cargo_capacity VARCHAR(50) NOT NULL,
  range VARCHAR(50) NOT NULL,
  maximum_speed VARCHAR(50) NOT NULL,
  service_ceiling VARCHAR(50) NOT NULL,
  engine_type VARCHAR(50) NOT NULL,
  number_of_engines INT NOT NULL,
  maximum_takeoff_weight VARCHAR(50) NOT NULL,
  fuel_system VARCHAR(50) NOT NULL,
  electrical_system VARCHAR(50) NOT NULL,
  hydraulic_system VARCHAR(50) NOT NULL,
  landing_gear VARCHAR(50) NOT NULL,
  avionics_system VARCHAR(50) NOT NULL,
  certifications TEXT,
  documentation TEXT,
  current_market_value DECIMAL(20,2),
  sales_price_history TEXT,
  insurance_value DECIMAL(10,2),
  leasing_history TEXT,
  image TEXT,
  PRIMARY KEY (id_aircraft_model)
);

CREATE TABLE aircraft (
    id_aircraft INT NOT NULL AUTO_INCREMENT,
    model_id INT NOT NULL,
    registration VARCHAR(10) NOT NULL,
    serial_number VARCHAR(50) NOT NULL,
    flight_hours INT NOT NULL,
    landing_takeoff_cycles INT NOT NULL,
    routes_flown TEXT,
    flight_logs TEXT,
    current_owner VARCHAR(50),
    owner_history TEXT,
    notes TEXT,
    PRIMARY KEY (id_aircraft),
    FOREIGN KEY (model_id) REFERENCES aircraft_model(id_aircraft_model)
);

CREATE TABLE part_categories (
    id_part_categories INT NOT NULL AUTO_INCREMENT,
    category VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (id_part_categories)
);


CREATE TABLE parts (
  id_parts INT NOT NULL AUTO_INCREMENT,
  category_id INT,
  name VARCHAR(255),
  part_number VARCHAR(255),
  serial_number VARCHAR(255),
  description TEXT,
  entry_date DATE,
  price DECIMAL(10, 2),
  supplier VARCHAR(255),
  condition VARCHAR(255),
  quantity INT,
  PRIMARY KEY (id_parts),
  FOREIGN KEY (category_id) REFERENCES part_categories(id_part_categories)
);


CREATE TABLE  part_location (
  id_part_location INT NOT NULL AUTO_INCREMENT,
  part_id INT,
  shelf_id INT,
  corridor VARCHAR(255),
  height VARCHAR(255),
  PRIMARY KEY (id_stock_location),
  FOREIGN KEY (part_id) REFERENCES parts(id_parts)
); 

CREATE TABLE person (
    id_person INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(50),
    cpf VARCHAR(14),
    PRIMARY KEY (id_person)
);

CREATE TABLE position (
    id_position INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (id_position)
);

CREATE TABLE employees (
id_employee INT NOT NULL AUTO_INCREMENT,
id_person INT,
id_job INT,
employee_email VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
PRIMARY KEY (id_employee),
FOREIGN KEY (id_person) REFERENCES person (id_person),
FOREIGN KEY (id_job) REFERENCES job (id_job)
);

CREATE TABLE external_employees (
id_external_employee INT NOT NULL AUTO_INCREMENT,
id_person INT,
id_job_title INT,
email VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
external_company VARCHAR(255) NOT NULL,
PRIMARY KEY (id_external_employee),
FOREIGN KEY (id_person) REFERENCES person (id_person),
FOREIGN KEY (id_job_title) REFERENCES job_title (id_job_title)
);

CREATE TABLE accesses (
    id_accesses INT NOT NULL AUTO_INCREMENT,
    id_position,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (id_accesses),
    FOREIGN KEY (id_position) REFERENCES position (id_position)
);


CREATE TABLE tasks (
id_tasks INT NOT NULL AUTO_INCREMENT,
id_task_template INT,
creation_date DATE NOT NULL,
completion_date DATE,
status ENUM('to do','open','in progress','delayed','done') NOT NULL,
responsible_id INT,
additional_parts INT,
PRIMARY KEY (id_tasks),
FOREIGN KEY (responsible_id) REFERENCES employees(id_employees),
FOREIGN KEY (id_task_template) REFERENCES task_templates(id_task_templates),
FOREIGN KEY (additional_parts) REFERENCES parts(id_parts)
);
CREATE TABLE task_templates(
  id_task_template INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  part_id INT,
  PRIMARY KEY (id_task_template),
  FOREIGN KEY (part_id) REFERENCES parts(id_parts)
);

CREATE TABLE work_order (
id_work_order INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
description TEXT,
start_date DATE NOT NULL,
end_date DATE,
status ENUM('to do','open', 'in progress', 'delayed' ,'completed') NOT NULL,
aircraft_id INT NOT NULL,
responsible_id INT NOT NULL,
task_ids VARCHAR(255),
FOREIGN KEY (aircraft_id) REFERENCES aircraft(id_aircraft),
FOREIGN KEY (responsible_id) REFERENCES employees(id_employees)
);

CREATE TABLE token_api (
    id_funcionarios INT,
    nome_usuario VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    token_api VARCHAR(255) NOT NULL,
    descricao VARCHAR(255)
    FOREIGN KEY (id_funcionarios) REFERENCES funcionarios(id_funcionarios)
);
