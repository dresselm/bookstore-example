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

- Create, migrate and seed the development database:
```
rake db:setup
```

- Test that the seeds were loaded as expected:
```
$ rails c
> puts "Books: #{Book.count}" # Books: 51
> puts "Authors: #{Author.count}" # Authors: 46
> puts "Subjects: #{Subject.count}" # Subjects: 97
```

Run the Application
---
- rails s

Import new books
---
- Enter the OLID into the search box
