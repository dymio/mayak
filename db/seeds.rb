# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def time_point_string; Time.now.strftime("%H:%M:%S:%L") end

# def seedfile(fname)
#   File.open File.join(Rails.root, "public/content/seeds/", fname)
# end

# Use code of file 'db/seeds_contents.rb'. This is the way to split big
# seeds.rb file. You can use instance variables (@var) declared in that file.
require_relative 'seeds_contents'

puts "#{time_point_string}: Start seeding"

# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Admin Users"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
AdminUser.create! email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password'

# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
# puts "#{time_point_string}: seed Static Files"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --

# sig = StaticFile.new
# sig.file = seedfile "example_pic.jpg"
# sig.save

# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Pages"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
pages = Page.create!([
  { title: "Новости",        path: "news",     fixed: true, prior: 1 },
  { title: "Обратная связь", path: "feedback", fixed: true, prior: 2 },
  { title: "Демо-страница",
    path: "content-demo",
    body: @seeds_contents[:content_demo_page],
    prior: 3 }
])


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Nav Items"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
NavItem.create!([
  { title: 'Главная', url_type: 0, url_text: '/',         prior: 0 },
  { title: 'Новости', url_type: 0, url_text: '/news',     prior: 3 },
  { title: 'Демо',    url_type: 1, url_page: pages[2],    prior: 5 },
  { title: 'Связь',   url_type: 0, url_text: '/feedback', prior: 7 }
])

puts "#{time_point_string}: Seeding is done!"
