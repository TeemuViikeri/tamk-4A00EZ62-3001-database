CREATE TABLE user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  `password` CHAR(192),
  email VARCHAR(255),
  user_level INT,
  CONSTRAINT fk_user_level FOREIGN KEY (user_level)
    REFERENCES user_level(id)
);
CREATE TABLE post (
  id INT AUTO_INCREMENT PRIMARY KEY,
  headline VARCHAR(255),
  `description` VARCHAR(255),
  content TEXT,
  posted TIMESTAMP,
  last_edited TIMESTAMP,
  author INT,
  CONSTRAINT fk_author_post FOREIGN KEY (author)
    REFERENCES user(id)
);
CREATE TABLE comment (
  id INT AUTO_INCREMENT PRIMARY KEY,
  headline VARCHAR(255),
  `description` VARCHAR(255),
  content TEXT,
  posted TIMESTAMP,
  last_edited TIMESTAMP,
  author INT,
  post INT,
  CONSTRAINT fk_author_comment FOREIGN KEY (author)
    REFERENCES user(id),
  CONSTRAINT fk_post FOREIGN KEY (post)
    REFERENCES post(id)
);
CREATE TABLE user_level (
  id INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  can_post BOOLEAN,
  can_comment BOOLEAN
);