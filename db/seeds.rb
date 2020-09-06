# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
hashes = [ { email: "admin@fintech.com", password: "Password123!@#", firstname: "Muhammad", lastname: "Haroon",
             role: User::ROLES[ :admin ] },
           { firstname: "Moeed", lastname: "Raza", password: "password12", email: "client1@fintech.com" },
           { firstname: "Bazaid", lastname: "Khan", password: "password12", email: "client2@fintech.com" },
           { firstname: "Abdul", lastname: "Wasey", password: "password12", email: "client3@fintech.com" },
           { firstname: "Taha", lastname: "Kibria", password: "password12", email: "cleint4@fintech.com" },
           { firstname: "Hamza", lastname: "Iqbal", password: "password12", email: "client5@fintech.com" }
         ]
hashes.length().times do |x|
  User.where(hashes[x][:email]).create(hashes[x])
end



