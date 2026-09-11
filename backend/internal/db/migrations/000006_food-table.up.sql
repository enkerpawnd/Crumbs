BEGIN;

CREATE TABLE food_taxonomy (
  food_type_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER food_taxonomy_set_updated_at
BEFORE UPDATE ON food_taxonomy
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

INSERT INTO food_taxonomy (name) VALUES
  ('Pizza'),
  ('Burgers'),
  ('Sushi'),
  ('Coffee & Tea'),
  ('Chinese'),
  ('Mexican'),
  ('Indian'),
  ('Thai'),
  ('Italian'),
  ('Japanese'),
  ('Fast Food'),
  ('Breakfast & Brunch'),
  ('Sandwiches'),
  ('Chicken'),
  ('Seafood'),
  ('Healthy'),
  ('Vegetarian'),
  ('Bakery'),
  ('Desserts'),
  ('Drinks');

-- link posts to the taxonomy.
ALTER TABLE posts RENAME COLUMN food_type TO food_type_id;

ALTER TABLE posts
  ALTER COLUMN food_type_id TYPE BIGINT USING food_type_id::bigint,
  ADD CONSTRAINT posts_food_type_id_FK
    FOREIGN KEY (food_type_id) REFERENCES food_taxonomy(food_type_id);

CREATE INDEX posts_food_type_id_idx ON posts (food_type_id);

COMMIT;