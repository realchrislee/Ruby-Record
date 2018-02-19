# Ruby Record

## Object Relational Mapping Inspired by [Active Record](https://github.com/rails/rails/blob/master/activerecord/README.rdoc)

Uses Ruby to generate SQL queries to interact with the database and create associations via metaprogramming

## Features

  * Creates SQL Object classes in relation to database tables as long as naming conventions are followed.

  * Uses Ruby methods to translate user action into SQL queries that interact with the database with the specified action

  * Allows searching of objects through an extension of the SQL Object class with the #where method

  * Included methods are
    * Class::find(id)
    * Class::all()
    * #insert
    * #update
    * #save

  * Ruby Record provides single as well as multi-level associations ex. has_one_through
