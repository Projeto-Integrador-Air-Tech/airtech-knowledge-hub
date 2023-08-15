CREATE SCHEMA "authorization";

CREATE SCHEMA "management";

CREATE SCHEMA "storage";

CREATE TYPE "status_enum" AS ENUM (
  'to do',
  'in progress',
  'done',
  'canceled'
);

CREATE TYPE "maintenance_enum" AS ENUM (
  'corrective maintenance',
  'preventive maintenance',
  'predictive maintenance',
  'emergency maintenance'
);

CREATE TABLE "authorization"."profiles" (
  "profile_id" SERIAL PRIMARY KEY,
  "profile_name" VARCHAR(100) NOT NULL
);

CREATE TABLE "authorization"."permissions" (
  "permission_id" SERIAL PRIMARY KEY,
  "permission_name" VARCHAR(100) NOT NULL
);

CREATE TABLE "authorization"."access_profiles" (
  "access_profiles_id" SERIAL PRIMARY KEY,
  "profile_id" INT,
  "permission_id" INT,
  "access_profiles_name" VARCHAR(100),
  "access_profiles_description" VARCHAR(150),
  "access_profile_group_name" VARCHAR(100)
);

CREATE TABLE "authorization"."access_user" (
  "access_user_id" SERIAL PRIMARY KEY,
  "user_id" INT,
  "access_profiles_id" INT,
  "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "authorization"."api_token" (
  "token" VARCHAR(255),
  "user_id" INT,
  "username" VARCHAR(100),
  "email" VARCHAR(100)
);

CREATE TABLE "authorization"."users" (
  "user_id" SERIAL PRIMARY KEY,
  "username" VARCHAR(100) NOT NULL,
  "email" VARCHAR(100) NOT NULL,
  "password_hash" VARCHAR(100) NOT NULL,
  "full_name" VARCHAR(200),
  "date_of_birth" DATE,
  "registration_date" timestamp DEFAULT (CURRENT_TIMESTAMP),
  "users_status" VARCHAR(20) DEFAULT 'active'
);

CREATE TABLE "management"."task" (
  "task_id" SERIAL PRIMARY KEY,
  "user_id" INT,
  "aircraft_id" INT,
  "creation_date" timestamp DEFAULT (CURRENT_TIMESTAMP),
  "completion_date" DATE,
  "status" status_enum DEFAULT 'to do'
);

CREATE TABLE "management"."aircrafts_model" (
  "aircraft_model_id" SERIAL PRIMARY KEY,
  "model" VARCHAR(50) NOT NULL,
  "manufacturer" VARCHAR(50) NOT NULL,
  "manufacturing_year" VARCHAR(50) NOT NULL,
  "aircraft_type" VARCHAR(50) NOT NULL,
  "passenger_capacity" VARCHAR(50) NOT NULL,
  "cargo_capacity" VARCHAR(50) NOT NULL,
  "range" VARCHAR(50) NOT NULL,
  "maximum_speed" VARCHAR(50) NOT NULL,
  "service_ceiling" VARCHAR(50) NOT NULL,
  "engine_type" VARCHAR(50) NOT NULL,
  "number_of_engines" INT NOT NULL,
  "maximum_takeoff_weight" VARCHAR(50) NOT NULL,
  "fuel_system" VARCHAR(50) NOT NULL,
  "electrical_system" VARCHAR(50) NOT NULL,
  "hydraulic_system" VARCHAR(50) NOT NULL,
  "landing_gear" VARCHAR(50) NOT NULL,
  "avionics_system" VARCHAR(50) NOT NULL,
  "certifications" TEXT,
  "documentation" TEXT,
  "leasing_history" TEXT,
  "image" TEXT
);

CREATE TABLE "management"."aircrafts" (
  "aircraft_id" SERIAL PRIMARY KEY,
  "aircraft_model_id" INT NOT NULL,
  "registration" VARCHAR(10) NOT NULL,
  "aircraft_serial_number" VARCHAR(50) NOT NULL,
  "aircraft_flight_hours" INT NOT NULL,
  "aircraft_landing_takeoff_cycles" INT NOT NULL,
  "aircraft_routes_flown" TEXT,
  "aircraft_flight_logs" TEXT,
  "aircraft_current_owner" VARCHAR(50),
  "aircraft_owner_history" TEXT,
  "aircraft_notes" TEXT
);

CREATE TABLE "management"."work_order" (
  "work_order_id" SERIAL PRIMARY KEY,
  "aircraft_id" INT NOT NULL,
  "title" VARCHAR(255) NOT NULL,
  "maintenance" maintenance_enum NOT NULL,
  "start_date" DATE NOT NULL,
  "end_date" DATE
);

CREATE TABLE "storage"."parts" (
  "parts_id" SERIAL PRIMARY KEY,
  "parts_name" VARCHAR(100),
  "parts_description" TEXT,
  "aircraft_id" INT,
  "price" "DECIMAL(10, 2)",
  "supplier" VARCHAR(150),
  "quantity" INT
);

CREATE TABLE "storage"."serial_parts" (
  "serial_parts_id" SERIAL PRIMARY KEY,
  "parts_id" INT,
  "serial_number" VARCHAR(100),
  "parts_weight" "DECIMAL(10, 2)"
);

CREATE TABLE "storage"."parts_allocation" (
  "task_id" INT,
  "serial_parts_id" INT,
  "quantity" INT
);

ALTER TABLE "authorization"."access_profiles" ADD FOREIGN KEY ("profile_id") REFERENCES "authorization"."profiles" ("profile_id");

ALTER TABLE "authorization"."access_profiles" ADD FOREIGN KEY ("permission_id") REFERENCES "authorization"."permissions" ("permission_id");

ALTER TABLE "authorization"."access_user" ADD FOREIGN KEY ("access_profiles_id") REFERENCES "authorization"."access_profiles" ("access_profiles_id");

ALTER TABLE "authorization"."access_user" ADD FOREIGN KEY ("user_id") REFERENCES "authorization"."users" ("user_id");

ALTER TABLE "authorization"."api_token" ADD FOREIGN KEY ("user_id") REFERENCES "authorization"."users" ("user_id");

ALTER TABLE "management"."task" ADD FOREIGN KEY ("user_id") REFERENCES "authorization"."users" ("user_id");

ALTER TABLE "storage"."parts" ADD FOREIGN KEY ("aircraft_id") REFERENCES "management"."aircrafts" ("aircraft_id");

ALTER TABLE "management"."task" ADD FOREIGN KEY ("aircraft_id") REFERENCES "management"."aircrafts" ("aircraft_id");

ALTER TABLE "management"."aircrafts" ADD FOREIGN KEY ("aircraft_model_id") REFERENCES "management"."aircrafts_model" ("aircraft_model_id");

ALTER TABLE "management"."work_order" ADD FOREIGN KEY ("aircraft_id") REFERENCES "management"."aircrafts" ("aircraft_id");

ALTER TABLE "storage"."parts_allocation" ADD FOREIGN KEY ("task_id") REFERENCES "management"."task" ("task_id");

ALTER TABLE "storage"."serial_parts" ADD FOREIGN KEY ("parts_id") REFERENCES "storage"."parts" ("parts_id");

ALTER TABLE "storage"."parts_allocation" ADD FOREIGN KEY ("serial_parts_id") REFERENCES "storage"."serial_parts" ("serial_parts_id");