namespace :db do
  desc 'Fill database with dummy data'

  task dummy: :environment do
    # create dummy tags
    names = Faker::Lorem.words(50, true)

    names.each do |name|
      Tag.create!({name: name})
    end

    all_tags = Tag.all

    extension = 10.times.map {Faker::Lorem.characters(rand(2..3))}

    # create dummy files
    150.times do
      tags = all_tags.sample(rand(1..5))

      relative_path = "/#{Faker::Lorem.words(rand(1..3), true).join('/')}.#{extension.sample}"

      Item.create!({
        relative_path: relative_path,
        description: Faker::Lorem.sentences(5),
        digest: Faker::Lorem.characters(50),
        tags: tags
      })
    end
  end
end