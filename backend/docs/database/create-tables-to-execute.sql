-- users schema --
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

-- product schema --
CREATE SCHEMA products;
ALTER SCHEMA products OWNER TO postgres;

CREATE TABLE products.products (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	description varchar(255) NOT NULL,
	created_at timestamptz NOT NULL,
	categories_id uuid NOT NULL,
	updated_at timestamptz,
	brands_id uuid NOT NULL,
	sizes_id uuid NOT NULL,
	colors_id uuid NOT NULL,
	owner_created_id uuid NOT NULL,
	genders_id uuid NOT NULL,
	CONSTRAINT products_pk PRIMARY KEY (id)
);
ALTER TABLE products.products OWNER TO postgres;

CREATE TABLE products.sizes (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz,
	CONSTRAINT product_size_pk PRIMARY KEY (id)
);
ALTER TABLE products.sizes OWNER TO postgres;

CREATE TABLE products.colors (
	id uuid NOT NULL,
	name varchar(50) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz,
	CONSTRAINT product_color_pk PRIMARY KEY (id),
	CONSTRAINT colors_name UNIQUE (name)
);
ALTER TABLE products.colors OWNER TO postgres;


CREATE TABLE products.categories (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz,
	CONSTRAINT categories_pk PRIMARY KEY (id),
	CONSTRAINT categories_name UNIQUE (name)
);
ALTER TABLE products.categories OWNER TO postgres;

CREATE TABLE products.brands (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz,
	CONSTRAINT brand_pk PRIMARY KEY (id),
	CONSTRAINT brands_name UNIQUE (name)
);
ALTER TABLE products.brands OWNER TO postgres;

CREATE TABLE products.images (
	id uuid NOT NULL,
	image_url varchar(255) NOT NULL,
	products_id uuid NOT NULL,
	CONSTRAINT images_pk PRIMARY KEY (id)
);
ALTER TABLE products.images OWNER TO postgres;

CREATE TABLE products.genders (
	id uuid NOT NULL,
	name varchar(40) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	CONSTRAINT genders_pk PRIMARY KEY (id),
	CONSTRAINT genders_name UNIQUE (name)
);
ALTER TABLE products.genders OWNER TO postgres;
