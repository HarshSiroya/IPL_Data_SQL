# IPL_Data_SQL
## Indian Premiere League Dataset - SQL Project 

# Design Document

Harsh Siroya, Arman Ghosh, Vandita Lodha

## Scope

The purpose of this database is to store and manage data related to cricket matches, particularly Indian Premier League (IPL) matches. It provides a structured way to store information about teams, players, venues, umpires, match details, and various statistics associated with IPL matches.

The database includes the following entities within its scope:
  1. Players (name, date of birth, batting hand, bowling skill, country)
  2. Teams taking part in all seasons of the IPL
  3. Umpires and the countries they are from
  4. Countries of participants including players and umpires
  5. Cities in which the IPL matches took place
  6. Venues (stadium names)
  7. Seasons contains information about (year, man of the series, orange cap winner, purple cap winner)
  8. Matches contains information about (date, venue, teams involved, toss details, result, man of the match)
  9. Toss Decisions of every match
  10. Batting Styles of Players
  11. Bowling Styles of Players
  12. Win Margins for how did a team win a match (e.g. X Runs /  Y Wickets)


The database does not cover the following entities:
Coach and support staff information, Ticket sales and other financial data, Broadcasting and media information, Detailed venue infrastructure and facilities, Functional Requirements, 'Extras' in the matches, team name of the each individual player.


## Functional Requirements

- A user should be able to perform the following tasks with this database:
  - View and search for information about players, teams, umpires, venues, and matches
  - Add, update, and delete data related to players, teams, umpires, venues, and matches
  - Track and update match details, including toss decisions, and match results
  - Retrieve statistics and information related to a specific season, such as man of the series, orange cap, and purple cap winners
  - Query and analyze data to generate insights, such as team performance, player statistics, and venue history


- The following tasks are beyond the scope of what a user should be able to do with this database:
Manage ticket sales or financial transactions, Handle broadcasting or media rights, Cannot get live data related to the current ipl matches, Manage venue infrastructure or facilities, Cannot get the data for extras, team of the player.


## Representation
Entities are captured in SQLite tables with the following schema.


### Entities

The database includes the following entities:

#### 1. Countries (`id: INTEGER`, `name: TEXT`) 
Stores information about countries participating in the IPL.

#### 2. Toss Decisions (`id: INTEGER`, `type: TEXT`)
Contains types of toss decisions (field and bat).

#### 3. Teams (`id: INTEGER`, `team_name: TEXT`)
Holds data about IPL teams.

#### 4. Batting Styles (`id: INTEGER`, `batting_hand: TEXT`)
Stores batting styles of players.

#### 5. Bowling Styles (`id: INTEGER`, `bowling_skill: TEXT`)
Stores bowling styles of players.

#### 6. Win Margins (`id: INTEGER`, `win_type: TEXT`)
 Stores types of win in matches ('by runs', 'by wickets', 'No Result', 'Tie')

#### 7. Umpires (`id: INTEGER`, `name: TEXT`, `country_id: INTEGER`)
Records umpires with their respective countries.

#### 8. Cities (`id: INTEGER`, `name: TEXT`, `country_id: INTEGER`)
Stores city data along with associated countries.

#### 9. Venues (`id: INTEGER`, `name: TEXT`, `city_id: INTEGER`)
Contains venue information with corresponding cities.

#### 10. Players (`id: INTEGER`, `name: TEXT`, `dob: DATETIME`, `batting_hand_id: INTEGER`, `bowling_skill_id: INTEGER`, `country_id: INTEGER`)
Holds player details including their batting and bowling styles, and country.

#### 11. Seasons (`id: INTEGER`, `man_of_the_series: INTEGER`, `orange_cap: INTEGER,` `purple_cap: INTEGER`, `season_year: INTEGER`)
Stores IPL season data including notable player IDs.

#### 12. Matches (`match_id: INTEGER`, `team_1: INTEGER`, `team_2: INTEGER`, `match_date: DATETIME`, `season_id: INTEGER`, `venue_id: INTEGER`, `toss_winner: INTEGER`, `toss_decide: INTEGER`, `win_type: INTEGER`, `win_margin: INTEGER`, `match_winner: INTEGER`, `man_of_the_match: INTEGER`)
Records match details such as teams playing, the match date, toss result (winning team and what they decided to do), and match outcomes (the type of win and by what margin).


### Schema Design Considerations
**Data Relationships**: Foreign key constraints establish relationships between entities, ensuring referential integrity.

**Integer Types**: Attributes like id columns across various entities were chosen as INTEGER types because they represent unique identifiers or primary keys. Integer data types are efficient for indexing and querying, and they also allow for automatic incrementation, making them suitable for primary key fields.

**Text Types**: Attributes like name, team_name, batting_hand, bowling_skill, and win_type were chosen as TEXT types because they represent textual data that can vary in length. The COLLATE NOCASE clause was added to ensure case-insensitive sorting and comparisons for these attributes, which is useful when dealing with names or descriptive text.

**Date/Time Types**: The dob (date of birth) attribute for the players table was chosen as the DATETIME type to store both date and time information accurately. The match_date attribute in the matches table was also set as DATETIME to capture the exact date and time of a match.

**Foreign Key Types**: Foreign key attributes, such as country_id, batting_hand_id, bowling_skill_id, city_id, venue_id, team_id, and others, were chosen to be of the same data type as the corresponding primary key columns they reference. This ensures consistency and facilitates proper referential integrity constraints.

The choice of constraints was driven by the need to maintain data integrity, enforce relationships between entities, and ensure data consistency. Here are the main considerations:

**Primary Key Constraints**: The `PRIMARY KEY` constraint was applied to the id columns of various entities to ensure that each record in those tables has a unique identifier. This constraint prevents duplicate records and provides a reliable way to reference and join data across tables.

**Foreign Key Constraints**: `FOREIGN KEY` constraints, such as `FOREIGN KEY ("country_id") REFERENCES "countries"("id")`, were used to establish relationships between entities and maintain referential integrity. These constraints ensure that foreign key values in a table correspond to existing primary key values in the referenced table, preventing orphaned or inconsistent data.

**NOT NULL Constraints**: The `NOT NULL` constraint was applied to columns like name, team_name and others to prevent inserting null values into those fields. This constraint ensures that critical data is always present and avoids potential issues with null values in operations or queries.

**CHECK Constraints**: Check constraints is added to certain columns to enforce specific value ranges or data patterns. For example, a check constraint could ensure to restrict the kinds of  palyer roles.



### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

#### DO THIS ONLINE
![ER Diagram](https://plakshauniversity1-my.sharepoint.com/:i:/g/personal/harsh_siroya_plaksha_edu_in/EUC85wVKiBRJskM5PPbqicQBSWfdxOrzstp6s8hzqMYqag?e=TNP1yl)

As detailed by the diagram:
##
* One country can have 0 to many cities associated with it, but a city belongs to one and only one country.

* Each city can have 1 to many venues, while a venue is located in one and only one city in our tables.

* A team can have 0 to many players, but a player belongs to one and only one team.

* Players have only 1 batting and bowling style, while each style can be associated with 1 to many players in our tables.

* Umpires are associated with one and only one country, but a country can have 0 to many umpires.

* Each player belongs to one and only one country, but a country can have 0 to many players.

* Each match has two teams playing (team_1 and team_2), a single venue, one winning team (match_winner), and one winning margin (win_margin). However, a team can participate in 1 to many matches, and a venue can host 1 to many matches in our tables.

* A player can win the man of the match 0 to many times, but man of the match will only be given to one player.

* A team can win a match 0 to many times over matches/seasons.

* Matches are part of one season, but a season can have 0 to many matches.

* Each match has one toss winner (toss_winner) and one toss decision (toss_decide). A team can win 0 to many tosses and make 0 to many toss decisions.

* Matches have one and only one win type (win_type), which specifies how the match was won. However, a win type can be associated with 0 to many matches.

* There can only be one player receiving man of the series/ orange cap/ purple cap in one season, however players can receive 0 to multiple of these awards across seasons.

* A  player will have only one role, however a role can only be occupied by one to many players.

## Optimizations NOT DONE

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

Partial Indexes for Player Identification:

To expedite player identification based on their bowling skill, partial indexes are established on the player name. These indexes are optimized to cater specifically to queries related to bowling skills, improving the efficiency of retrieving player information in scenarios where bowling skills are the primary criteria for selection or analysis.

Covering Index for Match Information:

A covering index is implemented on the match_date and man_of_the_match columns within the matches table. This index efficiently covers common queries that involve retrieving match information based on date and identifying the player awarded the title of "Man of the Match." By encompassing these columns, the covering index enhances query performance by minimizing disk I/O operations and speeding up data retrieval.

Venue Details View:

To simplify access to venue information, a view named places is created. This view provides a structured table presenting the corresponding city and country of each venue. By abstracting the complexities of venue data retrieval into a single view, querying for venue details becomes more intuitive and efficient for users interacting with the database.

Stadium Count View:

A view named stadium_count is introduced to offer insights into the distribution of stadiums across different cities. This view presents the number of stadiums available in each city, facilitating quick analysis of stadium distribution patterns. By precomputing and aggregating stadium counts, this view streamlines queries related to stadium statistics, enabling users to gain valuable insights into stadium infrastructure across various locations.



## Limitations

Some limitations of the current database design are:

- Limited Player Statistics: The database does not maintain detailed statistics of the player. It does not maintain detailed career statistics.
- No Financial or Ticket Data: The database does not include any information related to ticket sales, broadcasting rights, or financial transactions associated with IPL matches.
- No Detailed Venue Information: While the database stores basic venue information, it does not include detailed data about venue infrastructure, facilities, or seating capacities.
- No Media and Broadcasting Details: The database does not capture any information related to media rights, broadcasting schedules, or commentary details.
- No Data on Extras of any match
- Team name of each individual player

The database might not handle complex statistical analysis or real-time data updates efficiently.
