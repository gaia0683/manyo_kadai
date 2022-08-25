# README

model Users
t.string name
t.string email
t.text password_digest

model Tasks
t.string name
t.text content
t.datetime end_time
t.integer rank
t.string status

model Labels
t.stirng class
