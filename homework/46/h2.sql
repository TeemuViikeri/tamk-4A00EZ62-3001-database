CREATE ROLE 'author_role', 'commenter_role';
GRANT INSERT, UPDATE, SELECT ON homework.post TO 'author_role';
GRANT INSERT, UPDATE, SELECT ON homework.comment TO 'author_role';
GRANT INSERT, UPDATE, SELECT ON homework.comment TO 'commenter_role';

CREATE USER 'author_app'@'localhost' IDENTIFIED BY 'new_password';
CREATE USER 'commenter_app'@'localhost' IDENTIFIED BY 'new_password';

GRANT author_role TO 'author_app'@'localhost';
GRANT commenter_role TO 'commenter_app'@'localhost';