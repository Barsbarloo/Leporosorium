#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'Leporosorium' 
end
# before вызывается каждый раз при перезагрузке любой страницы
before do
	#иницилиализация БД
	init_db
end
# configure вызывается каждый раз при конфигурации приложения
# когда изменился код прогроммы И перезагрузилась страница
configure do
	#иницилиализация БД
	init_db
	# Создает таблицу если таблица не существует
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
# обработчик get запроса /new
#(браузер получает страницу с сервера)
get '/new' do
	erb :new
end
# обработчик post запроса /new
#(браузер отправляет данные в сервер)
post '/new' do
	#получаем переменную из post-запроса
	content = params[:content]
	if content.length <= 0
		@error = 'Type Post Text'
		return erb :new 
	end
	erb "You typed #{content}"
end
