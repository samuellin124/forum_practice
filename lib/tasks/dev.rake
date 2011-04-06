require 'faker'

namespace :dev do

  desc "Generate fake data"
  task :fake => :environment do

    puts "create a fake forum...."
    f = Forum.create(
        :name => Faker::Company.catch_phrase,
        :description => Faker::Lorem.sentence,
        :created_at => Time.now - 51.days
    )
    puts f.inspect
    puts "A new fake Forum is created!"
    puts "Now to create fake posts...."
    31.times do |n|
      p = Post.create(
          :title => Faker::Company.catch_phrase,
          :author => Faker::Name.name,
          :content => Faker::Lorem.paragraph,
          :forum_id => f.id,
#          :forum_id => 1,
          :created_at => Time.now - (n+1).day,
          :user_id => 1
      )
      puts p.inspect
    end
    puts "Fake posts completed!"
  end

end