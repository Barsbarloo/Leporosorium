#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'Leporosorium' 
end
before do
	init_db
end

configure do
	init_db
	@db.execute 'CREATE TABLE IF NOT EXISTS "Posts" (
		"Id"	INTEGER,
		"created_date"	TEXT,
		"content"	TEXT,
		PRIMARY KEY("Id" AUTOINCREMENT)
	);'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end
get '/new' do
	erb :new
end
post '/new' do
	content = params[:content]
	erb "You typed #{content}"
end
