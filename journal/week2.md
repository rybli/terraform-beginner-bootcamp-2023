# Terraform Beginner Bootcamp 2023 - Week 2

## Table of Contents

## Working with Ruby

### Bundler

Bundler is a package manager for ruby.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

Need to create a Gemfile and define gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then, run `bundle install` command.

This will install the gems on the system globally (unlike nodejs which installs packages in place in a folder called node_modules).

A Gemfile.lock will be created to lock down the gem versions used in the project.

#### Executing Ruby Scripts in the Context of Bundler

Have to use `bundle exec` to tell future ruby scripts to use the gems install. This is the way to set context.

### Sinatra

SSinatra is a micro-web framework for ruby to build web-apps.

Good for mock or development servers or for very simple projects.

Can create a webserver in a single file.

[Sinatra Ruby Framework](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the Web Server

Can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for the web server is stored in the `server.rb` file.