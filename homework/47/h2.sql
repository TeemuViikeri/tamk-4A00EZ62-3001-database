DELIMITER $$

CREATE PROCEDURE TransferMoney(
		source_account_id INT, 
        destination_account_id INT, 
        transfer_amount INT
)

BEGIN
        DECLARE prev_amount_src DEC(10,2) DEFAULT 0;
        DECLARE prev_amount_dest DEC(10,2) DEFAULT 0;
        SET prev_amount_src = (SELECT `amount` FROM `account` WHERE id = source_account_id);
        SET prev_amount_dest = (SELECT `amount` FROM `account` WHERE id = destination_account_id);

        UPDATE account
        SET `amount` = `amount` - transfer_amount
        WHERE id = source_account_id;
            
        IF prev_amount_src = (SELECT `amount` FROM `account` WHERE id = source_account_id) THEN 
            SELECT 'ERROR: No money was sent';
            ROLLBACK;
        END IF;
            
        IF (SELECT `amount` FROM `account` WHERE id = source_account_id) < 0.00 THEN
            SELECT 'ERROR: Source account amount would be lower than 0';
            ROLLBACK;
        END IF;

        UPDATE account
        SET amount = amount + transfer_amount
        WHERE id = destination_account_id;
END $$

DELIMITER ;

--

SET @savings_id = (SELECT id FROM `account` WHERE `name` = 'Savings');
SET @checking_id = (SELECT id FROM `account` WHERE `name` = 'Checking');

SET @src_id = @checking_id;
SET @dest_id = @savings_id;

SET @amount = 500.00;

CALL `shop`.`TransferMoney`(@src_id, @dest_id, @amount);

SELECT * FROM `account`;

SET @amount = 2000.00;

CALL `shop`.`TransferMoney`(@src_id, @dest_id, @amount);

SELECT * FROM `account`;