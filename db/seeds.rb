# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

admin = User.create(email: 'admin@example.com', password: 'password', role: :admin, name: 'Default Admin User')

Page.create(slug: 'home', title: "Home Page", body: "<h1>Home Page</h1>", user: admin)

Group.create(name: 'Barony of Cynnabar')
Group.create(name: 'Middle Kingdom')

kingdoms = ['Kingdom of Æthelmearc',
            'Kingdom of An Tir',
            'Kingdom of Ansteorra',
            'Kingdom of Artemisia',
            'Kingdom of Atenveldt',
            'Kingdom of Atlantia',
            'Kingdom of Avacal',
            'Kingdom of Caid',
            'Kingdom of Calontir',
            'Kingdom of Drachenwald',
            'Kingdom of Ealdormere',
            'East Kingdom',
            'Kingdom of Gleann Abhann',
            'Kingdom of Lochac',
            'Kingdom of Meridies',
            'Kingdom of Northshield',
            'Kingdom of the Outlands',
            'Kingdom of Trimaris',
            'Kingdom of the West']

kingdoms.each do |kingdom|
  Group.create(name: kingdom)
end
