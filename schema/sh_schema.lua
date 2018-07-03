SCHEMA.name = "World War II Roleplay"
SCHEMA.author = "Bimo"
SCHEMA.desc = "Invasion of Poznań September 3rd,1939"
SCHEMA.uniqueID = "ww2" -- Schema will be a unique identifier stored in the database.
-- Using a uniqueID will allow for renaming the schema folder.

-- Configure some stuff specific to this schema.
nut.currency.set("RM", "Reichmark", "Reichmarks")
nut.config.menuMusic = "https://www.youtube.com/watch?v=6dKAHq9icPg&index=3&list=PLA86C2DA5F0C1DB7E"

nut.util.include("sv_hooks.lua")