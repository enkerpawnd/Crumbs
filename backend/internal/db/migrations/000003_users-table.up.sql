BEGIN;

ALTER TABLE roles RENAME COLUMN id TO role_id;

ALTER TABLE roles
ADD COLUMN created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;

CREATE TRIGGER roles_set_updated_at
BEFORE UPDATE ON roles
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- users table migration below

CREATE TABLE users (
  user_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT DEFAULT NULL,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  role_id INT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT users_role_id_FK
  FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE INDEX users_role_id_idx ON users (role_id);

CREATE TRIGGER users_set_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- update saved_addresses for foreign key check to users
ALTER TABLE saved_addresses
RENAME COLUMN id TO saved_address_id;

ALTER TABLE saved_addresses
ADD CONSTRAINT saved_addresses_user_id_FK
FOREIGN KEY (user_id) REFERENCES users(user_id);

COMMIT;
