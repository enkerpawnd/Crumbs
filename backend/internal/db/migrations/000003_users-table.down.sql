BEGIN;

ALTER TABLE saved_addresses
DROP CONSTRAINT IF EXISTS saved_addresses_user_id_fk;

ALTER TABLE saved_addresses
RENAME COLUMN saved_address_id TO id;

DROP TABLE IF EXISTS users;

DROP TRIGGER IF EXISTS roles_set_updated_at ON roles;

ALTER TABLE roles
DROP COLUMN created_at,
DROP COLUMN updated_at;

ALTER TABLE roles
RENAME COLUMN role_id TO id;

COMMIT;
