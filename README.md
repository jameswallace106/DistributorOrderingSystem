# README

This file contains information necessary to get the application running on a localhost environment, as well as some information on the features implemented.

Ruby version: 3.3.6
Rails version: 8.0.4
Sqlite3 version: 3.45.3
Node version: v22.19.0

# Setup Instructions
### Step 1: Installation
Make sure you have the above tools installed. You can verify this by the following command in an ubuntu window
```bash
ruby -v
rails -v
sqlite3 --version
node -v
```
If you have any issues here, please refer to "Windows Rails Setup Guide.pdf"

### Step 2: Run

1. Install dependencies:
```bash
   bundle install
```

2. Setup database:
```bash
   rails db:setup
```

3. Start the server:
```bash
   rails server
```
Access at : 'http://[::1]:3000/'

### Passwords
Account Username and Passwords (Admin users may create more)
Username: Password

ADMIN : "Beans"
DIST : "Beans"


# Application Overview

This app uses a simple MVC structure

Models - The app's objects
Views - The webpage structure and logic
Controller - Backend logic/db interaction

Database - The connected db is a sqlite3 file, stored locally. Can be interacted with through rails console.
Rails migrations used for schema changes


Have decided that admins page is unnecessary, becuase admins can just create new users. Also every admin will know every other admin, so configuring who is and isn't admin it outside of the scope of this app. 
Removing ability to remove due to foreign key error (it doesn't make sense because you want to store orders even after parting ways with a distributor. To remove access, you delete all of a distributors users.)
Removed ability to delete SKUs and Products

### Addional features

Along with all of the features in the project specification, the following help to comeplete the app.

- Added ability to save an order for later as a distributor (similar to a cart feature)
- Admin can view submitted orders and view items
- Admin can create, configure, view, and delete users
- Product names can be changed
- Testing done on login and controllers

### Notes

Have decided that admins page is unnecessary, becuase admins can just create new users. Also every admin will know every other admin, so configuring who is and isn't admin it outside of the scope of this app. 
Removing ability to remove due to foreign key error (it doesn't make sense because you want to store orders even after parting ways with a distributor. To remove access, you delete all of a distributors users.)
Removed ability to delete SKUs and Products
Before submission


# 2. Test that the seed file works
rails db:reset

# 3. Verify everything loaded correctly
rails console
# Check: User.count, Order.count, etc.

# 4. Clear the database for shipping
rails db:drop

# 5. Delete database files (if using SQLite)
rm -f db/*.sqlite3