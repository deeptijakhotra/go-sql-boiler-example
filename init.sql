-- CREATE TABLE author(
--   id serial primary key,
--   email varchar not null,
--   name varchar not null
-- );
--
-- CREATE TABLE article(
--   id serial primary key,
--   title varchar not null,
--   body text,
--   created_at timestamp default now(),
--   author_id int not null,
--   constraint fk_author_id foreign key(author_id) references author(id)
-- );

-- +migrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TYPE public.roles AS ENUM ('SUPER_ADMIN', 'SHOP_ADMIN', 'COMPANY_ADMIN');

-- +migrate Down

-- +migrate Up
-- SQL in section 'Up' is executed when this migration is applied
-- create org_type enum with values COMPANY, SHOP
CREATE TYPE public.org_type AS ENUM ('COMPANY', 'SHOP');

-- +migrate Down

-- +migrate Up
-- SQL in section 'Up' is executed when this migration is applied
-- create org table with type from enum org_type
CREATE TABLE public.org
(
    id         uuid PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    enabled    BOOLEAN      NOT NULL,
--     feature_toggles []string NOT NULL,
    total_transaction_count BIGINT NOT NULL,
    org_limits int NOT NULL,
    created_at TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE public.user
(
    user_id  uuid PRIMARY KEY,
    email char(50) NOT NULL,
    password char(50) NOT NULL,
    enabled boolean NOT NULL,
    roles roles NOT NULL,
    id uuid NOT NULL,

    FOREIGN KEY (id)  REFERENCES  org(id)
);
-- +migrate Down

-- +migrate Down

