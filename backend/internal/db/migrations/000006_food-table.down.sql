BEGIN;

DROP INDEX IF EXISTS posts_food_type_id_idx;

ALTER TABLE posts
  DROP CONSTRAINT IF EXISTS posts_food_type_id_FK,
  ALTER COLUMN food_type_id TYPE TEXT USING food_type_id::text;

ALTER TABLE posts RENAME COLUMN food_type_id TO food_type;

DROP TABLE IF EXISTS food_taxonomy;

COMMIT;