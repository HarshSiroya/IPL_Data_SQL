--INDEPENDENT
CREATE TABLE IF NOT EXISTS countries (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL COLLATE NOCASE, 
  
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS toss_decisions (
    "id" INTEGER NOT NULL, 
    "type" TEXT NOT NULL COLLATE NOCASE CHECK("type" IN ('field', 'bat')), 
    
    PRIMARY KEY ("id")
); 

CREATE TABLE IF NOT EXISTS teams (
    "id" INTEGER NOT NULL,
    "team_name" TEXT NOT NULL COLLATE NOCASE,
    
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS batting_styles (
	"id" INTEGER NOT NULL,
	"batting_hand" TEXT NOT NULL,
    
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS bowling_styles (
	"id" INTEGER NOT NULL,
	"bowling_skill" TEXT NOT NULL,
    
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS win_margins (
	"id" INTEGER NOT NULL,
	"win_type"	TEXT NOT NULL CHECK("win_type" IN ('by runs', 'by wickets', 'No Result', 'Tie')),
    
    PRIMARY KEY ("id")
);

-- Foreign Key TABLES
--1
CREATE TABLE IF NOT EXISTS umpires (
  "id" INTEGER NOT NULL, 
  "name" TEXT NOT NULL COLLATE NOCASE, 
  "country_id" INTEGER NOT NULL,
  
  PRIMARY KEY ("id"), 
  
  FOREIGN KEY ("country_id") REFERENCES "countries"("id")
);

--1
CREATE TABLE IF NOT EXISTS cities (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL COLLATE NOCASE,
    "country_id" INTEGER NOT NULL, 
    
    PRIMARY KEY ("id"), 
    
    FOREIGN KEY ("country_id") REFERENCES "countries"("id")
);

--1
CREATE TABLE IF NOT EXISTS venues (
    "id" INTEGER NOT NULL, 
    "name" TEXT NOT NULL COLLATE NOCASE, 
    "city_id" INTEGER, 
    
    PRIMARY KEY ("id"), 
    
    FOREIGN KEY ("city_id") REFERENCES "cities"("id")
);

--3
CREATE TABLE IF NOT EXISTS players (
	"id"	INTEGER NOT NULL,
	"name" TEXT NOT NULL COLLATE NOCASE,
	"dob"	DATETIME COLLATE NOCASE,
	"batting_hand_id"	INTEGER NOT NULL,
	"bowling_skill_id"	INTEGER,
	"country_id"	INTEGER NOT NULL,
   
    PRIMARY KEY ("id"), 
   
    FOREIGN KEY ("batting_hand_id") REFERENCES "batting_styles"("id"),
    FOREIGN KEY ("bowling_skill_id") REFERENCES "bowling_styles"("id"), 
    FOREIGN KEY ("country_id") REFERENCES "countries"("id")
); 

--3
CREATE TABLE IF NOT EXISTS seasons (
	"id" INTEGER NOT NULL,
	"man_of_the_series"	INTEGER NOT NULL,
	"orange_cap" INTEGER NOT NULL,
	"purple_cap" INTEGER NOT NULL,
	"season_year" INTEGER,
    
    PRIMARY KEY ("id"),
    
    FOREIGN KEY ("man_of_the_series") REFERENCES "players"("id"),
    FOREIGN KEY ("orange_cap") REFERENCES "players"("id"),
    FOREIGN KEY ("purple_cap") REFERENCES "players"("id")
);

--10
CREATE TABLE IF NOT EXISTS matches (
    "match_id" INTEGER NOT NULL,
    "team_1" INTEGER NOT NULL,
    "team_2" INTEGER NOT NULL,
    
    "match_date" DATETIME NOT NULL COLLATE NOCASE, --
    "season_id" INTEGER NOT NULL,
    "venue_id" INTEGER NOT NULL,
    
    "toss_winner" INTEGER NOT NULL,
    "toss_decide" INTEGER NOT NULL,
    "win_type" INTEGER NOT NULL,
    
    "win_margin" INTEGER,  --
    "match_winner" INTEGER,    
    "man_of_the_match" INTEGER,
    
    PRIMARY KEY ("match_id"),

    FOREIGN KEY ("man_of_the_match") REFERENCES "players"("id"),

    FOREIGN KEY ("season_id") REFERENCES "seasons"("id"),

    FOREIGN KEY ("team_1") REFERENCES "teams"("id"),
    FOREIGN KEY ("team_2") REFERENCES "teams"("id"),
    FOREIGN KEY ("toss_winner") REFERENCES "teams"("id"),
    FOREIGN KEY ("match_winner") REFERENCES "teams"("id"),

    FOREIGN KEY ("toss_decide") REFERENCES "toss_decisions"("id"),

    FOREIGN KEY ("venue_id") REFERENCES "venues"("id"),

    FOREIGN KEY ("win_type") REFERENCES "win_margins"("id") --to be changed to win_by
);