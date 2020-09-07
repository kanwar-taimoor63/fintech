# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
user_attributes = [ { email: "admin@fintech.com", password: "Password123!@#", firstname: "Muhammad", lastname: "Haroon",
             role: User::ROLES[ :admin ], confirmed_at: Time.now },
           { firstname: "Moeed", lastname: "Raza", password: "Password123!@#", email: "client1@fintech.com", confirmed_at: Time.now },
           { firstname: "Bazaid", lastname: "Khan", password: "Password123!@#", email: "client2@fintech.com", confirmed_at: Time.now },
           { firstname: "Abdul", lastname: "Wasey", password: "Password123!@#", email: "client3@fintech.com", confirmed_at: Time.now },
           { firstname: "Taha", lastname: "Kibria", password: "Password123!@#", email: "cleint4@fintech.com", confirmed_at: Time.now },
           { firstname: "Hamza", lastname: "Iqbal", password: "Password123!@#", email: "client5@fintech.com", confirmed_at: Time.now }
         ]
user_attributes.length().times do |user|
  User.where(user_attributes[user][:email]).create(user_attributes[user])
end
