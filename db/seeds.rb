# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
admin= User
       .where(email: "admin@fintech.com")
       .first_or_create(firstname: "Muhammad", lastname: "Haroon",
        password: "Password123!@#", user_role: User::ROLES[:admin])

client= User
       .where(email: "client@fintech.com")
       .first_or_create(firstname: "Kanwar", lastname: "Taimoor",
        password: "password12")


