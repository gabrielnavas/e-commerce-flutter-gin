CREATE SCHEMA IF NOT EXISTS users;
ALTER SCHEMA users OWNER TO postgres;

CREATE TABLE IF NOT EXISTS users.users (
	id uuid NOT NULL,
	full_name varchar(100) NOT NULL,
	email varchar(255) NOT NULL,
	password_hash varchar(255) NOT NULL,
	profile_image_url varchar(500),
	phone_number varchar(20),
	birth_day timestamptz,
	CONSTRAINT users_pk PRIMARY KEY (id)
);
ALTER TABLE users.users OWNER TO postgres;

