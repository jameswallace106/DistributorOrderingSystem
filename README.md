# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Test Account Passwords

ADMIN : "Beans"

Have decided that admins page is unnecessary, becuase admins can just create new users. Also every admin will know every other admin, so configuring who is and isn't admin it outside of the scope of this app. 
I was going to have email be a field of admin, but again, there will be so few admins that a name is a good enough identifier.
Removing ability to remove due to foreign key error (it doesn't make sense because you want to store orders even after parting ways with a distributor. To remove access, you delete all of a distributors users.)
Removed ability to delete SKUs and Products

Idea: Logging (any changes are logged with the user that made them), make navbar into object