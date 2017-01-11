# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: "mh152235@fh-muenster.de", username: "Matthias", password: 123456, password_confirmation: 123456, role: "product_owner")
user2 = User.create(email: "muh@kuh.de", username: "MuhKuh", password: 123456, password_confirmation: 123456, role: "scrum_team")
user3 = User.create(email: "papa@schlumpf.de", username: "Papa Schlumpf", password: 123456, password_confirmation: 123456, role: "scrum_team")
User.create(email: "jake@at.de", username: "Jake the dog", password: 123456, password_confirmation: 123456)
User.create(email: "finn@at.de", username: "Finn the human", password: 123456, password_confirmation: 123456)
User.create(username: "admin", email: "a@b.de", password: 123456, password_confirmation: 123456, role: "product_owner")

project = Project.new(title: "Produkt 1")

project.build_dashboard
project.dashboard.boards.build(title: "Product Backlog")
project.dashboard.boards.build(title: "Aktueller Sprint")
project.dashboard.sprints.build(active: true, started: false, finished: false, sprint_number: 1)
project.dashboard.sprints.last.sprint_boards.build(title: "Sprint Backlog")
sprint_b = project.dashboard.sprints.last.sprint_boards.build(title: "Planned")
project.dashboard.sprints.last.sprint_boards.build(title: "In Work")
project.dashboard.sprints.last.sprint_boards.build(title: "Code Review")
project.dashboard.sprints.last.sprint_boards.build(title: "Done")
project.save
user.projects << project

project.users << user2
project.users << user3

c1 = project.dashboard.sprints.last.cards.create(title: "Aufgabe 1", board_id: 2, sprint_id: 1, color: "lightcoral", html_id: "draggable")
c2 = project.dashboard.sprints.last.cards.create(title: "Aufgabe 2", board_id: 2, sprint_id: 1, color: "lightcoral", html_id: "draggable")
c3 =project.dashboard.sprints.last.cards.create(title: "Aufgabe 3", board_id: 2, sprint_id: 1, color: "lightcoral", html_id: "draggable")
c1.estimation_rounds.create(active: true, round_number: 1)
c2.estimation_rounds.create(active: true, round_number: 1)
c3.estimation_rounds.create(active: true, round_number: 1)
sc1 = SprintCard.create(title: "Task 1",sprint_board_id: sprint_b.id, color: "lightcoral",
                  card_id: c1.id, work_done: 0, released: false, position: 1, sprint_id: 1 )
sc1.estimation_rounds.create(round_number: 1, active: true)
sc2 = SprintCard.create(title: "Task 2",sprint_board_id: sprint_b.id, color: "lightcoral",
                  card_id: c1.id, work_done: 0, released: false, position: 1, sprint_id: 1 )
sc2.estimation_rounds.create(round_number: 1, active: true)
sc3 = SprintCard.create(title: "Task 3",sprint_board_id: sprint_b.id, color: "lightcoral",
                  card_id: c2.id, work_done: 0, released: false, position: 1, sprint_id: 1 )
sc3.estimation_rounds.create(round_number: 1, active: true)
sc4 = SprintCard.create(title: "Task 4",sprint_board_id: sprint_b.id, color: "lightcoral",
                  card_id: c2.id, work_done: 0, released: false, position: 1, sprint_id: 1 )
sc4.estimation_rounds.create(round_number: 1, active: true)
sc5 = SprintCard.create(title: "Task 5",sprint_board_id: sprint_b.id, color: "lightcoral",
                  card_id: c3.id, work_done: 0, released: false, position: 1, sprint_id: 1 )
sc5.estimation_rounds.create(round_number: 1, active: true)
sc6 = SprintCard.create(title: "Task 6",sprint_board_id: sprint_b.id, color: "lightcoral",
                  card_id: c3.id, work_done: 0, released: false, position: 1, sprint_id: 1 )
sc6.estimation_rounds.create(round_number: 1, active: true)