namespace :db do
  namespace :populate do

    if Kernel.const_defined?('Faker')

      desc 'removes all existing records from db'
      task clear: [:environment] do

        Theme.delete_all
        Category.delete_all
        User.delete_all
        print "done!\n"

      end

      desc 'creates admin, problem categories & themes'
      task create_admin: [:environment] do

        print 'Creating admin'
        admin = User.create!(
          email: 'admin@mail.com',
          username: 'admin',
          password: 'password'
        )
        print ".done!\n"

        print "Creating admin's categories & themes"
        5.times do
          category = Category.create!(
            name: Faker::Lorem.words(2).join(' '),
            user_id: admin.id
          )

          2.times do
            print '.'
            Theme.create!(
              title: Faker::Lorem.words(2).join(' '),
              content: Faker::Lorem.sentence,
              category_id: category.id,
              user_id: admin.id
            )
          end
        end
        print "done!\n"

      end

    end

  end
end
