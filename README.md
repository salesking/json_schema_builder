# JSON Schema Builder

[![Build Status](https://travis-ci.org/salesking/json_schema_builder.svg)](https://travis-ci.org/salesking/json_schema_builder)

Build a JSON schema for your ActiveRecord models. STOP your API pains!

The created schema.json files are meant as stubs and need to be enriched with
field descriptions and names. You might also want to remove or add object
properties, since the gem only uses the available ActiveRecord database fields.

## Usage

Hook the gem into your rails app and create the schema files.

  gem 'json_schema_builder'
  rake schema:build

Your Models and their fields are written into JSON files which you can
pimp further.

## Supports

* ruby 1.9, 2.2
* active_record > 4 (use gem version < 0.1.0 for older versions)

## Test

  bundle install
  bundle exec rake spec

## Contribute 

Feel free to fork and add features or fixes for other ActiveRecord versions

Copyright Georg Leciejewski, MIT License
