-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.1.2
-- PostgreSQL version: 16.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: ecommerce | type: DATABASE --
-- DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
-- ddl-end --


-- object: products | type: SCHEMA --
-- DROP SCHEMA IF EXISTS products CASCADE;
CREATE SCHEMA products;
-- ddl-end --
ALTER SCHEMA products OWNER TO postgres;
-- ddl-end --

-- object: shopping | type: SCHEMA --
-- DROP SCHEMA IF EXISTS shopping CASCADE;
CREATE SCHEMA shopping;
-- ddl-end --
ALTER SCHEMA shopping OWNER TO postgres;
-- ddl-end --

-- object: users | type: SCHEMA --
-- DROP SCHEMA IF EXISTS users CASCADE;
CREATE SCHEMA users;
-- ddl-end --
ALTER SCHEMA users OWNER TO postgres;
-- ddl-end --

-- object: orders | type: SCHEMA --
-- DROP SCHEMA IF EXISTS orders CASCADE;
CREATE SCHEMA orders;
-- ddl-end --
ALTER SCHEMA orders OWNER TO postgres;
-- ddl-end --

-- object: payment | type: SCHEMA --
-- DROP SCHEMA IF EXISTS payment CASCADE;
CREATE SCHEMA payment;
-- ddl-end --
ALTER SCHEMA payment OWNER TO postgres;
-- ddl-end --

-- object: favorites | type: SCHEMA --
-- DROP SCHEMA IF EXISTS favorites CASCADE;
CREATE SCHEMA favorites;
-- ddl-end --
ALTER SCHEMA favorites OWNER TO postgres;
-- ddl-end --

-- object: bags | type: SCHEMA --
-- DROP SCHEMA IF EXISTS bags CASCADE;
CREATE SCHEMA bags;
-- ddl-end --
ALTER SCHEMA bags OWNER TO postgres;
-- ddl-end --

-- object: notifications | type: SCHEMA --
-- DROP SCHEMA IF EXISTS notifications CASCADE;
CREATE SCHEMA notifications;
-- ddl-end --
ALTER SCHEMA notifications OWNER TO postgres;
-- ddl-end --

-- object: promocodes | type: SCHEMA --
-- DROP SCHEMA IF EXISTS promocodes CASCADE;
CREATE SCHEMA promocodes;
-- ddl-end --
ALTER SCHEMA promocodes OWNER TO postgres;
-- ddl-end --

-- object: delivery | type: SCHEMA --
-- DROP SCHEMA IF EXISTS delivery CASCADE;
CREATE SCHEMA delivery;
-- ddl-end --
ALTER SCHEMA delivery OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,products,shopping,users,orders,payment,favorites,bags,notifications,promocodes,delivery;
-- ddl-end --

-- object: products.products | type: TABLE --
-- DROP TABLE IF EXISTS products.products CASCADE;
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
-- ddl-end --
ALTER TABLE products.products OWNER TO postgres;
-- ddl-end --

-- object: products.sizes | type: TABLE --
-- DROP TABLE IF EXISTS products.sizes CASCADE;
CREATE TABLE products.sizes (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz,
	CONSTRAINT product_size_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE products.sizes OWNER TO postgres;
-- ddl-end --

-- object: products.colors | type: TABLE --
-- DROP TABLE IF EXISTS products.colors CASCADE;
CREATE TABLE products.colors (
	id uuid NOT NULL,
	name varchar(50) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz,
	CONSTRAINT product_color_pk PRIMARY KEY (id),
	CONSTRAINT colors_name UNIQUE (name)
);
-- ddl-end --
ALTER TABLE products.colors OWNER TO postgres;
-- ddl-end --

-- object: users.users | type: TABLE --
-- DROP TABLE IF EXISTS users.users CASCADE;
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
-- ddl-end --
ALTER TABLE users.users OWNER TO postgres;
-- ddl-end --

-- object: orders.reviews | type: TABLE --
-- DROP TABLE IF EXISTS orders.reviews CASCADE;
CREATE TABLE orders.reviews (
	id uuid NOT NULL,
	description varchar(255) NOT NULL,
	stars smallint NOT NULL,
	created_at timestamptz NOT NULL,
	orders_id uuid NOT NULL,
	order_items_id uuid NOT NULL,
	CONSTRAINT reviews_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE orders.reviews OWNER TO postgres;
-- ddl-end --

-- object: products.categories | type: TABLE --
-- DROP TABLE IF EXISTS products.categories CASCADE;
CREATE TABLE products.categories (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz,
	CONSTRAINT categories_pk PRIMARY KEY (id),
	CONSTRAINT categories_name UNIQUE (name)
);
-- ddl-end --
ALTER TABLE products.categories OWNER TO postgres;
-- ddl-end --

-- object: products.brands | type: TABLE --
-- DROP TABLE IF EXISTS products.brands CASCADE;
CREATE TABLE products.brands (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz,
	CONSTRAINT brand_pk PRIMARY KEY (id),
	CONSTRAINT brands_name UNIQUE (name)
);
-- ddl-end --
ALTER TABLE products.brands OWNER TO postgres;
-- ddl-end --

-- object: fk_brands | type: CONSTRAINT --
-- ALTER TABLE products.products DROP CONSTRAINT IF EXISTS fk_brands CASCADE;
ALTER TABLE products.products ADD CONSTRAINT fk_brands FOREIGN KEY (brands_id)
REFERENCES products.brands (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_categories | type: CONSTRAINT --
-- ALTER TABLE products.products DROP CONSTRAINT IF EXISTS fk_categories CASCADE;
ALTER TABLE products.products ADD CONSTRAINT fk_categories FOREIGN KEY (categories_id)
REFERENCES products.categories (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: orders.orders | type: TABLE --
-- DROP TABLE IF EXISTS orders.orders CASCADE;
CREATE TABLE orders.orders (
	id uuid NOT NULL,
	created_at timestamptz NOT NULL,
	total decimal(12,2) NOT NULL,
	states_id uuid NOT NULL,
	users_id uuid NOT NULL,
	cards_id uuid NOT NULL,
	method_id uuid NOT NULL,
	promocodes_id uuid NOT NULL,
	CONSTRAINT orders_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE orders.orders OWNER TO postgres;
-- ddl-end --

-- object: fk_orders | type: CONSTRAINT --
-- ALTER TABLE orders.reviews DROP CONSTRAINT IF EXISTS fk_orders CASCADE;
ALTER TABLE orders.reviews ADD CONSTRAINT fk_orders FOREIGN KEY (orders_id)
REFERENCES orders.orders (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: orders.states | type: TABLE --
-- DROP TABLE IF EXISTS orders.states CASCADE;
CREATE TABLE orders.states (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	CONSTRAINT states_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE orders.states OWNER TO postgres;
-- ddl-end --

-- object: fk_states | type: CONSTRAINT --
-- ALTER TABLE orders.orders DROP CONSTRAINT IF EXISTS fk_states CASCADE;
ALTER TABLE orders.orders ADD CONSTRAINT fk_states FOREIGN KEY (states_id)
REFERENCES orders.states (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE orders.orders DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE orders.orders ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: orders.order_items | type: TABLE --
-- DROP TABLE IF EXISTS orders.order_items CASCADE;
CREATE TABLE orders.order_items (
	id uuid NOT NULL,
	price decimal(11,2) NOT NULL,
	quantity integer NOT NULL,
	orders_id uuid NOT NULL,
	products_id uuid NOT NULL,
	CONSTRAINT order_items_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE orders.order_items OWNER TO postgres;
-- ddl-end --

-- object: fk_orders | type: CONSTRAINT --
-- ALTER TABLE orders.order_items DROP CONSTRAINT IF EXISTS fk_orders CASCADE;
ALTER TABLE orders.order_items ADD CONSTRAINT fk_orders FOREIGN KEY (orders_id)
REFERENCES orders.orders (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE products.products DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE products.products ADD CONSTRAINT fk_users FOREIGN KEY (owner_created_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: shopping.products | type: TABLE --
-- DROP TABLE IF EXISTS shopping.products CASCADE;
CREATE TABLE shopping.products (
	id uuid NOT NULL,
	price decimal(11,2) NOT NULL,
	quantity integer NOT NULL,
	products_id uuid NOT NULL,
	discount decimal NOT NULL,
	CONSTRAINT products_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE shopping.products OWNER TO postgres;
-- ddl-end --

-- object: fk_products | type: CONSTRAINT --
-- ALTER TABLE shopping.products DROP CONSTRAINT IF EXISTS fk_products CASCADE;
ALTER TABLE shopping.products ADD CONSTRAINT fk_products FOREIGN KEY (products_id)
REFERENCES products.products (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_products | type: CONSTRAINT --
-- ALTER TABLE orders.order_items DROP CONSTRAINT IF EXISTS fk_products CASCADE;
ALTER TABLE orders.order_items ADD CONSTRAINT fk_products FOREIGN KEY (products_id)
REFERENCES shopping.products (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: users.shipping_addresses | type: TABLE --
-- DROP TABLE IF EXISTS users.shipping_addresses CASCADE;
CREATE TABLE users.shipping_addresses (
	id uuid NOT NULL,
	full_name varchar NOT NULL,
	address varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	state_province_region varchar(255) NOT NULL,
	postal_code varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
	is_default boolean NOT NULL,
	updated_at timestamptz,
	created_at timestamptz NOT NULL,
	users_id uuid NOT NULL,
	CONSTRAINT shipping_addresses_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE users.shipping_addresses OWNER TO postgres;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE users.shipping_addresses DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE users.shipping_addresses ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: payment.cards | type: TABLE --
-- DROP TABLE IF EXISTS payment.cards CASCADE;
CREATE TABLE payment.cards (
	id uuid NOT NULL,
	name varchar(40) NOT NULL,
	number varchar(30) NOT NULL,
	expire timestamptz NOT NULL,
	is_default boolean NOT NULL,
	users_id uuid NOT NULL,
	CONSTRAINT cards_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE payment.cards OWNER TO postgres;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE payment.cards DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE payment.cards ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_cards | type: CONSTRAINT --
-- ALTER TABLE orders.orders DROP CONSTRAINT IF EXISTS fk_cards CASCADE;
ALTER TABLE orders.orders ADD CONSTRAINT fk_cards FOREIGN KEY (cards_id)
REFERENCES payment.cards (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: favorites.products | type: TABLE --
-- DROP TABLE IF EXISTS favorites.products CASCADE;
CREATE TABLE favorites.products (
	id uuid NOT NULL,
	products_id uuid NOT NULL,
	users_id uuid NOT NULL,
	CONSTRAINT products_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE favorites.products OWNER TO postgres;
-- ddl-end --

-- object: fk_products | type: CONSTRAINT --
-- ALTER TABLE favorites.products DROP CONSTRAINT IF EXISTS fk_products CASCADE;
ALTER TABLE favorites.products ADD CONSTRAINT fk_products FOREIGN KEY (products_id)
REFERENCES shopping.products (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE favorites.products DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE favorites.products ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: bags.products | type: TABLE --
-- DROP TABLE IF EXISTS bags.products CASCADE;
CREATE TABLE bags.products (
	id uuid NOT NULL,
	created_at timestamptz NOT NULL,
	products_id uuid NOT NULL,
	users_id uuid NOT NULL,
	promocodes_id uuid NOT NULL,
	CONSTRAINT products_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE bags.products OWNER TO postgres;
-- ddl-end --

-- object: fk_products | type: CONSTRAINT --
-- ALTER TABLE bags.products DROP CONSTRAINT IF EXISTS fk_products CASCADE;
ALTER TABLE bags.products ADD CONSTRAINT fk_products FOREIGN KEY (products_id)
REFERENCES shopping.products (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE bags.products DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE bags.products ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_order_items | type: CONSTRAINT --
-- ALTER TABLE orders.reviews DROP CONSTRAINT IF EXISTS fk_order_items CASCADE;
ALTER TABLE orders.reviews ADD CONSTRAINT fk_order_items FOREIGN KEY (order_items_id)
REFERENCES orders.order_items (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: notifications.settings | type: TABLE --
-- DROP TABLE IF EXISTS notifications.settings CASCADE;
CREATE TABLE notifications.settings (
	id uuid NOT NULL,
	sales boolean NOT NULL,
	new_arrivals boolean NOT NULL,
	delivery_status_changes boolean NOT NULL,
	users_id uuid NOT NULL,
	CONSTRAINT settings_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE notifications.settings OWNER TO postgres;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE notifications.settings DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE notifications.settings ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: products.images | type: TABLE --
-- DROP TABLE IF EXISTS products.images CASCADE;
CREATE TABLE products.images (
	id uuid NOT NULL,
	image_url varchar(255) NOT NULL,
	products_id uuid NOT NULL,
	CONSTRAINT images_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE products.images OWNER TO postgres;
-- ddl-end --

-- object: promocodes.promocodes | type: TABLE --
-- DROP TABLE IF EXISTS promocodes.promocodes CASCADE;
CREATE TABLE promocodes.promocodes (
	id uuid NOT NULL,
	image_url varchar(255) NOT NULL,
	title varchar(255) NOT NULL,
	code varchar(50) NOT NULL,
	expire_at timestamptz NOT NULL,
	maximum_use smallint NOT NULL,
	CONSTRAINT promocodes_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE promocodes.promocodes OWNER TO postgres;
-- ddl-end --

-- object: promocodes.applied_promocodes | type: TABLE --
-- DROP TABLE IF EXISTS promocodes.applied_promocodes CASCADE;
CREATE TABLE promocodes.applied_promocodes (
	id uuid NOT NULL,
	created_at smallint,
	quantity_used smallint NOT NULL,
	promocodes_id uuid NOT NULL,
	users_id uuid NOT NULL,
	CONSTRAINT applied_promocodes_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE promocodes.applied_promocodes OWNER TO postgres;
-- ddl-end --

-- object: fk_promocodes | type: CONSTRAINT --
-- ALTER TABLE promocodes.applied_promocodes DROP CONSTRAINT IF EXISTS fk_promocodes CASCADE;
ALTER TABLE promocodes.applied_promocodes ADD CONSTRAINT fk_promocodes FOREIGN KEY (promocodes_id)
REFERENCES promocodes.promocodes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE promocodes.applied_promocodes DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE promocodes.applied_promocodes ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_promocodes | type: CONSTRAINT --
-- ALTER TABLE bags.products DROP CONSTRAINT IF EXISTS fk_promocodes CASCADE;
ALTER TABLE bags.products ADD CONSTRAINT fk_promocodes FOREIGN KEY (promocodes_id)
REFERENCES promocodes.promocodes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_promocodes | type: CONSTRAINT --
-- ALTER TABLE orders.orders DROP CONSTRAINT IF EXISTS fk_promocodes CASCADE;
ALTER TABLE orders.orders ADD CONSTRAINT fk_promocodes FOREIGN KEY (promocodes_id)
REFERENCES promocodes.promocodes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: delivery.method | type: TABLE --
-- DROP TABLE IF EXISTS delivery.method CASCADE;
CREATE TABLE delivery.method (
	id uuid NOT NULL,
	name varchar(255) NOT NULL,
	CONSTRAINT method_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE delivery.method OWNER TO postgres;
-- ddl-end --

-- object: fk_method | type: CONSTRAINT --
-- ALTER TABLE orders.orders DROP CONSTRAINT IF EXISTS fk_method CASCADE;
ALTER TABLE orders.orders ADD CONSTRAINT fk_method FOREIGN KEY (method_id)
REFERENCES delivery.method (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: users.forgot_password_codes | type: TABLE --
-- DROP TABLE IF EXISTS users.forgot_password_codes CASCADE;
CREATE TABLE users.forgot_password_codes (
	id uuid NOT NULL,
	expires_in timestamptz NOT NULL,
	code varchar(6) NOT NULL,
	users_id uuid NOT NULL,
	CONSTRAINT forgot_password_codes_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE users.forgot_password_codes OWNER TO postgres;
-- ddl-end --

-- object: fk_users | type: CONSTRAINT --
-- ALTER TABLE users.forgot_password_codes DROP CONSTRAINT IF EXISTS fk_users CASCADE;
ALTER TABLE users.forgot_password_codes ADD CONSTRAINT fk_users FOREIGN KEY (users_id)
REFERENCES users.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_products | type: CONSTRAINT --
-- ALTER TABLE products.images DROP CONSTRAINT IF EXISTS fk_products CASCADE;
ALTER TABLE products.images ADD CONSTRAINT fk_products FOREIGN KEY (products_id)
REFERENCES products.products (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_colors | type: CONSTRAINT --
-- ALTER TABLE products.products DROP CONSTRAINT IF EXISTS fk_colors CASCADE;
ALTER TABLE products.products ADD CONSTRAINT fk_colors FOREIGN KEY (colors_id)
REFERENCES products.colors (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sizes | type: CONSTRAINT --
-- ALTER TABLE products.products DROP CONSTRAINT IF EXISTS fk_sizes CASCADE;
ALTER TABLE products.products ADD CONSTRAINT fk_sizes FOREIGN KEY (sizes_id)
REFERENCES products.sizes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: products.genders | type: TABLE --
-- DROP TABLE IF EXISTS products.genders CASCADE;
CREATE TABLE products.genders (
	id uuid NOT NULL,
	name varchar(40) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	CONSTRAINT genders_pk PRIMARY KEY (id),
	CONSTRAINT genders_name UNIQUE (name)
);
-- ddl-end --
ALTER TABLE products.genders OWNER TO postgres;
-- ddl-end --

-- object: fk_genders | type: CONSTRAINT --
-- ALTER TABLE products.products DROP CONSTRAINT IF EXISTS fk_genders CASCADE;
ALTER TABLE products.products ADD CONSTRAINT fk_genders FOREIGN KEY (genders_id)
REFERENCES products.genders (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


