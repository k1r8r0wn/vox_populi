namespace :db do
  namespace :populate do

    if Kernel.const_defined?('Faker')

      desc "creates admin, problem categories, moderator, user & user's themes(problems)"
      task create_all: [:environment] do

        print 'Creating admin'
        admin = User.create!(
          email: 'admin@mail.com',
          username: 'admin',
          password: 'password',
          confirmed_at: Time.now,
          role: 2
        )
        print ".done!\n"

        print 'Creating problem categories'
        3.times do
          print '.'
          Category.create!(
            name: Faker::Lorem.words(2).join(' '),
            user_id: admin.id
          )
        end
        print "done!\n"

        print 'Creating moderator'
        User.create!(
            email: 'moderator@mail.com',
            username: 'moderator',
            password: 'password',
            confirmed_at: Time.now,
            role: 1
        )
        print ".done!\n"

        print 'Creating user1'
        user1 = User.create!(
            email: 'user1@mail.com',
            username: 'user1',
            password: 'password',
            confirmed_at: Time.now
        )
        print ".done!\n"

        print "Creating user's 1 themes(problems)"
        3.times do
          print '.'
          Theme.create!(
              title: Faker::Lorem.words(2).join(' '),
              content: Faker::Lorem.paragraph(2),
              category_id: rand(1..3),
              user_id: user1.id,
              city_id: 1
          )
        end
        print "done!\n"

        print 'Creating user2'
        user2 = User.create!(
            email: 'user2@mail.com',
            username: 'user2',
            password: 'password',
            confirmed_at: Time.now
        )
        print ".done!\n"

        print "Creating user's 2 themes(problems)"
        3.times do
          print '.'
          Theme.create!(
              title: Faker::Lorem.words(2).join(' '),
              content: Faker::Lorem.paragraph(2),
              category_id: rand(1..3),
              user_id: user2.id,
              city_id: 2
          )
        end
        print "done!\n"

      end

    end

  end
end
