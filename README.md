# README

The repository is used as R&D to proof of concept with Valkyrie:
Create a collection, a work, and a subwork, and they can all be related to each other and metadata (basic) attached.

## Local Development
1. Install docker and docker-compose
1. Start docker machine `docker-machine start default`
1. Build `docker-compose build`
1. Run docker-compose file `docker-compose up`
1. In a separate tab, setup the db `docker-compose exec -e RAILS_ENV=development web bundle exec rake db:migrate`

The application is available at:
http://192.168.99.100:3000

## Create the models from the top menu
1. Create Agent (Creator, publisher)
1. Create child collection with publisher
1. Create collection with with child collection
1. Create component object
1. Create object with creator, component, and collection.
