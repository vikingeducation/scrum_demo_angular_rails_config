# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning Database'

if Rails.env == 'development'
  Rake::Task['db:migrate:reset'].invoke
end


puts 'Creating Messages'

messages = []
10.times { |i| messages << { :body => ['Hello', i].join(' ') } }

Message.create(messages)


puts 'Done.'






