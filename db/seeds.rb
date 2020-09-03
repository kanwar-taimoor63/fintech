# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
admin = User
          .where(email: "admin@fintech.com")
          .first_or_create(firstname: "Muhammad", lastname: "Haroon",
            password: "Password123!@#", role: User::ROLES[:admin])

client = User
           .where(email: "client1@fintech.com")
           .first_or_create(firstname: "Moeed", lastname: "Raza", password: "password12")

client = User
           .where(email: "client2@fintech.com")
           .first_or_create(firstname: "Bazaid", lastname: "Khan", password: "password12")

client= User
          .where(email: "client3@fintech.com")
          .first_or_create(firstname: "Abdul", lastname: "Wasey", password: "password12")

client = User
           .where(email: "client4@fintech.com")
           .first_or_create(firstname: "Taha", lastname: "Kibria", password: "password12")



