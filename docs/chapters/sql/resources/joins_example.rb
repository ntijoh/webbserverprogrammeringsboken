require 'sqlite3'

db = SQLite3::Database.new('joins-example.sqlite')

db.execute('DROP TABLE IF EXISTS fruits')
db.execute('DROP TABLE IF EXISTS ratings')

db.execute('
    CREATE TABLE fruits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
    )
')

db.execute('
    CREATE TABLE ratings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        score INTEGER NOT NULL,
        fruit_id INTEGER,
        FOREIGN KEY(fruit_id) REFERENCES fruits(id)
    )
')

db.execute('INSERT INTO fruits (name) VALUES (?)', 'apple')
db.execute('INSERT INTO fruits (name) VALUES (?)', 'banana')
db.execute('INSERT INTO fruits (name) VALUES (?)', 'pear')
db.execute('INSERT INTO fruits (name) VALUES (?)', 'orange')

db.execute('INSERT INTO ratings (score, fruit_id) VALUES (?,?)', 3, 1)
db.execute('INSERT INTO ratings (score, fruit_id) VALUES (?,?)', 3, 2)
db.execute('INSERT INTO ratings (score, fruit_id) VALUES (?,?)', 3, 1)
db.execute('INSERT INTO ratings (score, fruit_id) VALUES (?,?)', 4, 2)
db.execute('INSERT INTO ratings (score, fruit_id) VALUES (?,?)', 5, 1)
db.execute('INSERT INTO ratings (score, fruit_id) VALUES (?,?)', 7, 1)
db.execute('INSERT INTO ratings (score, fruit_id) VALUES (?,?)', 8, 1)
db.execute('INSERT INTO ratings (score, fruit_id) VALUES (?,?)', 10, 3)


p db.execute('
        SELECT * 
        FROM fruits'
    )

p db.execute('SELECT * FROM RATINGS')

puts "SELECT * FROM fruits INNER JOIN ratings"
p db.execute('
    SELECT * 
    FROM fruits
    INNER JOIN ratings'
)
puts "---------------------"

puts "SELECT * FROM fruits INNER JOIN ratings ON ratings.fruit_id = fruits.id"
p db.execute('
    SELECT * 
    FROM fruits
    INNER JOIN ratings
    ON ratings.fruit_id = fruits.id'
)
puts "---------------------"


puts "SELECT * FROM fruits INNER JOIN ratings ON ratings.fruit_id = fruits.id WHERE fruits.id = 2"
p db.execute('
    SELECT * 
    FROM fruits
    INNER JOIN ratings
    ON ratings.fruit_id = fruits.id
    WHERE fruits.id = ?',
    2
)
puts "---------------------"

require 'debug'
binding.break