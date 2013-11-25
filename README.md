# README

This is an example app showing how easy it is to add search to your app
using Elasticsearch and Searchkick.

Getting Started
---
- Install Ruby
- Install and Start Postgres
- Install and Start Elastic Search

Setup Database
---
- Create role: `bookstore`
```
CREATE ROLE bookstore SUPERUSER CREATEDB;
```

- Create, migrate and seed the development database: `rake db:create db:migrate db:seed`
- Test that db is ready
```
$ rails r 'puts "Books: #{Book.count}"; puts "Authors: #{Author.count}"; puts "Subjects: #{Subject.count}"'
Books: 51
Authors: 46
Subjects: 97
```

Run the Application
---
- rails s

Import new books
---
- Enter the OLID into the search box




