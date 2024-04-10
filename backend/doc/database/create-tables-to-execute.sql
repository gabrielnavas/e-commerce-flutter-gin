CREATE SCHEMA users;
ALTER SCHEMA users OWNER TO postgres;

CREATE TABLE users.users (
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

CREATE TABLE users.forgot_password_codes (
	id uuid NOT NULL,
	expires_in timestamptz NOT NULL,
	code varchar(6) NOT NULL,
	users_id uuid NOT NULL,
	CONSTRAINT forgot_password_codes_pk PRIMARY KEY (id)
);
ALTER TABLE users.forgot_password_codes OWNER TO postgres;

ALTER TABLE users.forgot_password_codes ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
