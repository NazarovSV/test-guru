# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users
user = User.find_or_create_by!(name: 'Sergey Nazarov', email: 'fake@yandex.ru')
admin = User.find_or_create_by!(name: 'Admin', email: 'admin@tguru.net')


#Categories
simple_category = Category.find_or_create_by!(title: 'Простые')
normal_category = Category.find_or_create_by!(title: 'Нормальные')
hard_category = Category.find_or_create_by!(title: 'Сложные')

#Tests
car_test = Test.find_or_create_by!(title: 'тест про машины', category: simple_category, user_id: user.id)
beast_test = Test.find_or_create_by!(title: 'тест про животных', category: normal_category, user_id: admin.id)
pc_test = Test.find_or_create_by!(title: 'тест про компьютеры', level: 2, category: normal_category, user_id: user.id)
chemistry_test = Test.find_or_create_by!(title: 'тест по химии', level: 3, category: hard_category, user_id: admin.id)
math_test = Test.find_or_create_by!(title: 'тест по математике', level: 5, category: hard_category, user_id: admin.id)

#Questions
car_question = Question.find_or_create_by!(body: 'Выберите японскую машину', test: car_test)
beast_question = Question.find_or_create_by!(body: 'Самое большое животное', test: beast_test)
pc_question = Question.find_or_create_by!(body: 'Назовите производителей процессоров', test: pc_test)
chemistry_question = Question.find_or_create_by!(body: 'Формула воды', test: chemistry_test)
math_question = Question.find_or_create_by!(body: '2 + 2 = ?', test: math_test)

#Answers
answers = [{variant: 'bmw', question: car_question},
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
           {variant: '0', question: math_question}]

answers.each do |answer|
  Answer.find_or_create_by! answer
end

#UserProgress
car_test_questions_count = Question.where(test_id: car_test.id).count
math_test_questions_count = Question.where(test_id: math_test.id).count

user_progresses =  [{user_id: user.id, test_id: car_question.id, total_passed_questions: car_test_questions_count, is_completed: true},
                    {user_id: user.id, test_id: chemistry_question.id},
                    {user_id: user.id, test_id: math_test.id, total_passed_questions: math_test_questions_count, is_completed: true}]


user_progresses.each do |user_progress|
  UserProgress.find_or_create_by! user_progress
end
