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
            role: 1
        )
        print ".done!\n"

        print 'Creating user'
        user = User.create!(
            email: 'user@mail.com',
            username: 'user',
            password: 'password'
        )
        print ".done!\n"

        print "Creating user's themes(problems)"
        5.times do
          print '.'
          Theme.create!(
              title: Faker::Lorem.words(2).join(' '),
              content: Faker::Lorem.paragraph(2),
              category_id: rand(1..3),
              user_id: user.id
          )
        end
        print "done!\n"

      end

    end

  end
end
