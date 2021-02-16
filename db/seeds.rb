# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users

@user = User.find_by(email: 'badger.lock@yandex.ru') ||
        User.create!(name: 'Sergey Nazarov',
                     email: 'badger.lock@yandex.ru',
                     password: '111111')

@admin = User.find_by(email: 'heroku.test.guru@yandex.ru') ||
         Admin.create!(name: 'Admin',
                       first_name: 'Sergey',
                       last_name: 'Nazarov',
                       email: 'heroku.test.guru@yandex.ru',
                       password: '111111')

# Categories
simple_category = Category.find_or_create_by!(title: 'Простые')
normal_category = Category.find_or_create_by!(title: 'Нормальные')
hard_category = Category.find_or_create_by!(title: 'Сложные')

# Tests
car_test = Test.find_or_create_by!(title: 'тест про машины', category: simple_category, user_id: @user.id)
beast_test = Test.find_or_create_by!(title: 'тест про животных', category: normal_category, user_id: @admin.id)
pc_test = Test.find_or_create_by!(title: 'тест про компьютеры', level: 2, category: normal_category, user_id: @user.id)
chemistry_test = Test.find_or_create_by!(title: 'тест по химии', level: 3, category: hard_category, user_id: @admin.id)
math_test = Test.find_or_create_by!(title: 'тест по математике', level: 5, category: hard_category, user_id: @admin.id)

# Questions
car_question = Question.find_or_create_by!(body: 'Выберите японскую машину', test: car_test)
car_question2 = Question.find_or_create_by!(body: 'Выберите немецкую машину', test: car_test)
car_question3 = Question.find_or_create_by!(body: 'Bugatti - какая страна', test: car_test)
car_question4 = Question.find_or_create_by!(body: 'Bugatti принадлежит Volksvaggen', test: car_test)
beast_question = Question.find_or_create_by!(body: 'Самое большое животное', test: beast_test)
pc_question = Question.find_or_create_by!(body: 'Назовите производителей процессоров', test: pc_test)
chemistry_question = Question.find_or_create_by!(body: 'Формула воды', test: chemistry_test)
math_question = Question.find_or_create_by!(body: '2 + 2 = ?', test: math_test)
math_question2 = Question.find_or_create_by!(body: '2 + 4 = ?', test: math_test)
math_question3 = Question.find_or_create_by!(body: '2 + 6 = ?', test: math_test)

# Answers
answers = [{ variant: 'bmw', question: car_question },
           { variant: 'kia', question: car_question },
           { variant: 'mazda', correct: true, question: car_question },
           { variant: 'bmw', correct: true, question: car_question2 },
           { variant: 'kia', question: car_question2 },
           { variant: 'mazda', question: car_question2 },
           { variant: 'Франция', correct: true, question: car_question3 },
           { variant: 'Германия', question: car_question3 },
           { variant: 'Италия', question: car_question3 },
           { variant: 'Да', correct: true, question: car_question4 },
           { variant: 'Нет', question: car_question4 },
           { variant: 'медведь', correct: true, question: beast_question },
           { variant: 'волк', question: beast_question },
           { variant: 'заяц', question: beast_question },
           { variant: 'siberia', question: pc_question },
           { variant: 'ibm', question: pc_question },
           { variant: 'amd', correct: true, question: pc_question },
           { variant: 'CO2', question: chemistry_question },
           { variant: 'H2O', correct: true, question: chemistry_question },
           { variant: 'H3O', question: chemistry_question },
           { variant: '4', correct: true, question: math_question },
           { variant: '2', question: math_question },
           { variant: '0', question: math_question },
           { variant: '6', correct: true, question: math_question2 },
           { variant: '-6', question: math_question2 },
           { variant: '8', correct: true, question: math_question3 },
           { variant: '0.8', question: math_question3 },
           { variant: '8.0', correct: true, question: math_question3 }]

answers.each do |answer|
  Answer.find_or_create_by! answer
end

# badges
badges = [{ name: 'Прохождение теста с первой попытки',
            image_url: 'https://ultimatecup.ru/images/achievements/5yjlxSOA.png',
            rule_type: :successful_by_first_time,
            description: 'Проверяется, что тест пройден успешно с первого раза. Повторно за тот же тест получить награду нельзя' },
          { name: 'Прохождение теста определенного уровня(scope)',
            image_url: 'https://ultimatecup.ru/images/achievements/QgsZUTBW.png',
            rule_type: :successful_by_level,
            description: 'Проверяется, что тест входит в указанную группу(scope) сложности. Можно повторно за тот же тест получить бадж',
            value: 'hard' },
          { name: 'Прохождение теста определенной категории',
            image_url: 'https://ultimatecup.ru/images/achievements/wKHHNKog.png',
            rule_type: :successful_by_category,
            description: 'Проверяется, что пройдены все тесты указанной категории. Повторно получить нельзя',
            value: simple_category.id }]

badges.each do |badge|
  Badge.find_or_create_by! badge
end
