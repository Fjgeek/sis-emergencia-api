DROP PROCEDURE IF EXISTS insertNurse;
DELIMITER $$
CREATE PROCEDURE insertNurse(
	IN _rfid VARCHAR(11),
	IN _firstName VARCHAR(100),
	IN _lastName VARCHAR(100),
	IN _ci VARCHAR(20),
	IN _cellphone VARCHAR(50)
)
BEGIN

    DECLARE error INT DEFAULT 0;
    DECLARE msg TEXT DEFAULT '';
    DECLARE failed BOOLEAN DEFAULT false;
    DECLARE idRepeat INT;
    DECLARE idInsert INT;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET error=1;
		SELECT "HANDLER FOR SQLEXCEPTION" error,"Transacción no completada: insertUser." msg,'false' status;
	END;

    START TRANSACTION;

    -- CHECK REPEAT
    SET idRepeat = (SELECT id_nurse FROM nurse WHERE ci = _ci OR rfid = _rfid ORDER BY id_nurse DESC LIMIT 1);
    
	if !isnull(idRepeat) THEN
        -- INSERT USER
        INSERT INTO user VALUES(
            null,
            _rfid,
            _firstName, 
            _lastName, 
            _ci,	
            _cellphone, 
            CURRENT_TIMESTAMP, 
            CURRENT_TIMESTAMP,
            1
        );
        SET msg = "Insertado con exito";
        SET idInsert = @@identity;
    ELSE
        SET msg = "Ya fue registrado";
        SET idInsert = idRepeat;
        SET failed = true;

	END if;

    IF (error = 1) THEN
		ROLLBACK;
	ELSE
		SELECT idInsert, msg, failed;
		COMMIT;
	END IF;
END
$$