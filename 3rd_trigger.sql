CREATE TRIGGER no_update
BEFORE UPDATE
ON user
FOR EACH ROW 
BEGIN

IF (role != admin)
THEN

set switchvar = 0;
if (role = manager) then set switchvar = switchvar + 0; end if;
if (role = evaluator) then set switchvar = switchvar + 1; end if;
if (role = employee) then set switchvar = switchvar + 10; end if;

case (switchvar)

when 0 then 
IF (role = manager) THEN
set NEW.username = OLD.username;
set NEW.name = OLD.name;
set NEW.surname = OLD.surname;
set NEW.reg_date = OLD.reg_date;
END IF;

when 1 then 
IF (role = evaluator) THEN
set NEW.username = OLD.username;
END IF;

when 10 then 
IF (role = manager) THEN
set NEW.username = OLD.username;
set NEW.name = OLD.name;
set NEW.surname = OLD.surname;
set NEW.reg_date = OLD.reg_date;
set NEW.email = OLD.email;
END IF;

END IF;

END$