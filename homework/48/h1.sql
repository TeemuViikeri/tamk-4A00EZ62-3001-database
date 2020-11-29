DROP PROCEDURE IF EXISTS CreateComment;

DELIMITER //

  CREATE PROCEDURE CreateComment(
    IN comment TEXT,
    IN userId INT,
    IN postId INT,
    OUT msg VARCHAR(255)
  )

  BEGIN 
    DECLARE success INT DEFAULT 0;
    DECLARE error INT DEFAULT 1;
    DECLARE sqlexc INT DEFAULT 2;
    DECLARE no_privilege INT DEFAULT 3;
    DECLARE user_has_comment_priv BOOLEAN DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
      SET msg = (SELECT CONCAT('(', sqlexc, '): SQL exception encountered.')); 

    SELECT can_comment INTO user_has_comment_priv
    FROM user_level
    INNER JOIN user 
    ON user_level.id = user.user_level
    WHERE user.id = userId;
    
    IF user_has_comment_priv = 0 THEN
      SET msg = (SELECT CONCAT('(', no_privilege, '): User has no access to comment.'));
    ELSEIF (SELECT EXISTS(SELECT * FROM post WHERE id = postId)) THEN 
      INSERT INTO comment (content, posted, post)
      VALUES (comment, now(), postId);
      SET msg = (SELECT CONCAT('(', success, '): Posting was successful.'));
    ELSE
      SET msg = (SELECT CONCAT('(', error, "): Posting was insuccessful. Post wasn't found."));
    END IF;
  END//

DELIMITER ;

CALL `homework`.`CreateComment`('This is a comment', 5, 1, @message);
SELECT @message;
