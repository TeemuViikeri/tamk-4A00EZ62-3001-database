CREATE USER 'spectator' IDENTIFIED BY '0000';
GRANT SELECT ON homework.post TO 'spectator';
GRANT SELECT ON homework.comment TO 'spectator';
GRANT EXECUTE ON PROCEDURE homework.CreateComment TO 'spectator';