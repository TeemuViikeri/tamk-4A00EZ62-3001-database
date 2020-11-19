-- First transaction
START TRANSACTION;

  SET autocommit = 0;
  SET @amount = 500.00;

  UPDATE account
  SET amount = amount - @amount
  WHERE `name` = 'Checking';

  UPDATE account
  SET amount = amount + @amount
  WHERE `name` = 'Savings';

COMMIT;

-- Second transaction
START TRANSACTION;

  SET @amount = 2000.00;

  UPDATE account
  SET amount = amount - @amount
  WHERE `name` = 'Checking';

  UPDATE account
  SET amount = amount + @amount
  WHERE `name` = 'Savings';

COMMIT;

-- Toimenpiteet on tärkeä suorittaa transaktioina, jotta voidaan pitää huoli siitä, että muutoksia ei tietokannassa tapahdu, jos tapahtuu virheitä suorituksien aikana
-- Pelkkä transaktion määrittäminen ei yksistään riitä, sillä MySQL:n virheidenhallinta toimii eri tavoin eri tilanteissa. Joskus MySQL vetää takaisin vain yhden koodilauseen muutoksen, joskus kokonaisen transaktion. Näihin voi tulla myös muutoksia myöhemmissä MySQL:n versioissa. Tarvitaan siis ylimääräistä tarkistusta, jotta voimme varmistaa, että tuleeko transaktio suorittaa loppuun (COMMIT) vai palauttaa takaisin transktiota edeltäneeseen tilaan (ROLLBACK).