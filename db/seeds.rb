# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users
user = User.create(name: 'Sergey Nazarov', email: 'fake@yandex.ru')
User.create(name: 'Admin', email: 'admin@tguru.net')

#Categories
simple_category = Category.create(title: 'Простые')
normal_category = Category.create(title: 'Нормальные')
hard_category = Category.create(title: 'Сложные')

#Tests
car_test = Test.create(title: 'тест про машины', category: simple_category)
beast_test = Test.create(title: 'тест про животных', category: normal_category)
pc_test = Test.create(title: 'тест про компьютеры', level: 2, category: normal_category)
chemistry_test = Test.create(title: 'тест по химии', level: 3, category: hard_category)
math_test = Test.create(title: 'тест по математике', level: 3, category: hard_category)

#Questions
car_question = Question.create(body: 'Выберите японскую машину', test: car_test)
beast_question = Question.create(body: 'Самое большое животное', test: beast_test)
pc_question = Question.create(body: 'Назовите производителей процессоров', test: pc_test)
chemistry_question = Question.create(body: 'Формула воды', test: chemistry_test)
math_question = Question.create(body: '2 + 2 = ?', test: math_test)

#Answers
Answer.create([{variant: 'bmw', question: car_question},
               {variant: 'kia', question: car_question},
               {variant: 'mazda', correct: true, question: car_question},
               {variant: 'медведь', correct: true, question: beast_question},
               {variant: 'волк', question: beast_question},
               {variant: 'заяц', question: beast_question},
               {variant: 'siberia', question: pc_question},
               {variant: 'ibm', question: pc_question},
               {variant: 'amd', correct: true, question: pc_question},
               {variant: 'CO2', question: chemistry_question},
               {variant: 'H2O', correct: true, question: chemistry_question},
               {variant: 'H3O', question: chemistry_question},
               {variant: '4', correct: true, question: math_question},
               {variant: '2', question: math_question},
               {variant: '0', question: math_question}])

#UserProgress

car_test_questions_count = Question.where(test_id: car_test.id).count
math_test_questions_count = Question.where(test_id: math_test.id).count

UserProgress.create!([{user_id: user.id, test_id: car_question.id, total_passed_questions: car_test_questions_count, is_completed: true},
                      {user_id: user.id, test_id: chemistry_question.id},
                      {user_id: user.id, test_id: math_test.id, total_passed_questions: math_test_questions_count, is_completed: true}])
