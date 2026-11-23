
CREATE TABLE creator(
    id NUMBER(10) CONSTRAINT pk_creator PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    birth_date DATE 
);

CREATE TABLE accessibility(
    id NUMBER(10) CONSTRAINT pk_accessibility PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    description VARCHAR2(255)
);


CREATE TABLE address(
    id NUMBER(10) CONSTRAINT pk_address PRIMARY KEY,
    street_number NUMBER(2) NOT NULL,
    street_name VARCHAR2(50) NOT NULL,
    zip_code VARCHAR2(6) NOT NULL,
    state VARCHAR2(2),
    country VARCHAR2(50) NOT NULL,
    coordinate_x NUMBER(3),
    coordinate_y NUMBER(3)
);

CREATE TABLE museum (
    id NUMBER(10) CONSTRAINT pk_museum PRIMARY KEY,
    name VARChAR2(255) NOT NULL,
    address_id NUMBER(10) CONSTRAINT fk_museum_address REFERENCES address (id),
    year_built DATE NOT NULL,
    accessibility_id NUMBER(10) CONSTRAINT fk_museum_accessibility REFERENCES accessibility (id),
    max_capacity NUMBER(6),
    total_room NUMBER(2),
    architectural_style VARCHAR2(50)
);

CREATE TABLE room(
    id NUMBER(7) CONSTRAINT pk_room PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    museum_id NUMBER(10) CONSTRAINT fk_room_museum REFERENCES museum (id),
    total_pieces NUMBER(3),
    room_area NUMBER(3),
    room_height NUMBER(3)
);

CREATE TABLE piece(
    id NUMBER(10) CONSTRAINT pk_piece PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    creator_id NUMBER(10) CONSTRAINT fk_piece_creator REFERENCES creator (id),
    category VARCHAR2(50)NOT NULL,
    description VARCHAR2(255),
    room_id NUMBER(7) CONSTRAINT fk_piece_room REFERENCES room (id),
    archive_status BOOLEAN NOT NULL,
    era VARCHAR2(50)
);


-- 1. accessibility (lookup, 6 rows)
INSERT INTO accessibility VALUES (1, 'Fully Accessible',      'Step-free entry, elevators on every floor, accessible washrooms.');
INSERT INTO accessibility VALUES (2, 'Wheelchair Accessible', 'Step-free main entrance and elevators; wheelchairs on loan at the front desk.');
INSERT INTO accessibility VALUES (3, 'Audio Guide Support',   'Audio guides, large-print labels and tactile tours for visitors with visual or hearing needs.');
INSERT INTO accessibility VALUES (4, 'Sensory-Friendly',      'Quiet hours, sensory maps and low-stimulation spaces.');
INSERT INTO accessibility VALUES (5, 'Partially Accessible',  'Main galleries accessible; some upper floors reachable by stairs only.');
INSERT INTO accessibility VALUES (6, 'Limited Access',        'Historic building with restricted step-free routes; assistance on request.');

-- 2. address (1 row; coordinates rounded to whole numbers because of NUMBER(3))
INSERT INTO address VALUES (1, 99, 'Rue de Rivoli', '75001', NULL, 'France', 49, 2);

-- 3. creator (10 rows)
INSERT INTO creator VALUES (1,  'Leonardo',  'da Vinci',  DATE '1452-04-15');
INSERT INTO creator VALUES (2,  'Paolo',     'Veronese',  DATE '1528-01-01');
INSERT INTO creator VALUES (3,  'Eugene',    'Delacroix', DATE '1798-04-26');
INSERT INTO creator VALUES (4,  'Theodore',  'Gericault', DATE '1791-09-26');
INSERT INTO creator VALUES (5,  'Jacques-Louis', 'David', DATE '1748-08-30');
INSERT INTO creator VALUES (6,  'Jean-Auguste-Dominique', 'Ingres', DATE '1780-08-29');
INSERT INTO creator VALUES (7,  'Johannes',  'Vermeer',   DATE '1632-10-31');
INSERT INTO creator VALUES (8,  'Rembrandt', 'van Rijn',  DATE '1606-07-15');
INSERT INTO creator VALUES (9,  'Georges',   'de La Tour',DATE '1593-03-14');
INSERT INTO creator VALUES (10, 'Michelangelo', 'Caravaggio', DATE '1571-09-29');

-- 4. museum (1 row) - total_room matches the 12 rooms below
INSERT INTO museum VALUES (1, 'Louvre Museum', 1, DATE '1793-01-01', 2, 30000, 12, 'Renaissance / Classical');

-- 5. room (12 rows) - total_pieces matches the pieces below
INSERT INTO room VALUES (1,  'Salle des Etats',              1, 2, 840, 8);
INSERT INTO room VALUES (2,  'Salle Mollien',                1, 2, 600, 9);
INSERT INTO room VALUES (3,  'Salle Daru',                   1, 2, 650, 9);
INSERT INTO room VALUES (4,  'Grande Galerie',               1, 2, 900, 10);
INSERT INTO room VALUES (5,  'Dutch and Flemish Gallery',    1, 3, 450, 6);
INSERT INTO room VALUES (6,  'French 17th Century Gallery',  1, 1, 380, 6);
INSERT INTO room VALUES (7,  'Winged Victory Staircase',     1, 0, 300, 12);
INSERT INTO room VALUES (8,  'Venus de Milo Gallery',        1, 0, 320, 7);
INSERT INTO room VALUES (9,  'Galerie d''Apollon',           1, 0, 500, 11);
INSERT INTO room VALUES (10, 'Egyptian Antiquities Hall',    1, 0, 700, 6);
INSERT INTO room VALUES (11, 'Cour Marly',                   1, 0, 800, 15);
INSERT INTO room VALUES (12, 'Medieval Louvre Moat',         1, 0, 400, 5);

-- 6. piece (12 rows). archive_status: 0 = on display, 1 = archived (NUMBER(1) version)
INSERT INTO piece VALUES (1,  'Mona Lisa',                          1,  'Painting', 'Portrait of Lisa Gherardini painted in the early 1500s.',      1, 0, 'Renaissance');
INSERT INTO piece VALUES (2,  'The Wedding Feast at Cana',          2,  'Painting', 'Enormous banquet scene painted in 1563.',                      1, 0, 'Renaissance');
INSERT INTO piece VALUES (3,  'Liberty Leading the People',         3,  'Painting', 'Allegory of the July Revolution of 1830.',                     2, 0, 'Romanticism');
INSERT INTO piece VALUES (4,  'The Raft of the Medusa',             4,  'Painting', 'Dramatic 1819 painting of shipwreck survivors.',               2, 0, 'Romanticism');
INSERT INTO piece VALUES (5,  'The Coronation of Napoleon',         5,  'Painting', 'Ceremonial painting of the 1804 coronation.',                  3, 0, 'Neoclassicism');
INSERT INTO piece VALUES (6,  'Grande Odalisque',                   6,  'Painting', 'Reclining nude painted in 1814.',                              3, 0, 'Neoclassicism');
INSERT INTO piece VALUES (7,  'The Virgin of the Rocks',            1,  'Painting', 'Altarpiece showing the Virgin, infant Christ and angel.',      4, 0, 'Renaissance');
INSERT INTO piece VALUES (8,  'Death of the Virgin',               10,  'Painting', 'Caravaggio altarpiece, c. 1606.',                              4, 0, 'Baroque');
INSERT INTO piece VALUES (9,  'The Lacemaker',                      7,  'Painting', 'Small intimate scene of a woman making lace, c. 1670.',        5, 0, 'Dutch Golden Age');
INSERT INTO piece VALUES (10, 'The Astronomer',                     7,  'Painting', 'Scholar studying a celestial globe, 1668.',                    5, 0, 'Dutch Golden Age');
INSERT INTO piece VALUES (11, 'Bathsheba at Her Bath',              8,  'Painting', 'Rembrandt''s 1654 painting. Currently in storage.',            5, 1, 'Dutch Golden Age');
INSERT INTO piece VALUES (12, 'The Cheat with the Ace of Diamonds', 9,  'Painting', 'Candlelit card-game scene from the 1630s.',                    6, 0, 'French Baroque');

COMMIT;
