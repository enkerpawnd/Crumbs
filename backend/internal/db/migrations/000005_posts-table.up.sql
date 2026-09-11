BEGIN;

CREATE TABLE posts (
  post_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  posted_by BIGINT NOT NULL,
  title TEXT NOT NULL,
  description TEXT DEFAULT NULL,
  food_type TEXT NOT NULL,
  price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT posts_posted_by_FK
    FOREIGN KEY (posted_by) REFERENCES users(user_id),
  CONSTRAINT posts_posted_by_title_unique UNIQUE (posted_by, title)
);

CREATE TRIGGER posts_set_updated_at
BEFORE UPDATE ON posts
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

COMMIT;
