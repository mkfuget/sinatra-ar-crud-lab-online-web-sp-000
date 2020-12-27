
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  configure :development do
    set :database, 'sqlite3:db/articles.db'
  end
  
  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all 
    erb :index
  end
  get '/articles/:id' do
    @article = Article.find(params[:id]) 
    erb :show
  end

  
  post '/articles' do 
    new_article = Article.create(params[:article])
    redirect "/articles/#{new_article.id}"
  end
  
  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :edit
  end
  
  patch '/articles/:id' do 
    edit_article = Article.find(params[:id])
    edit_article.update(params[:article])
    redirect "/articles/#{edit_article.id}"

  end
  
  delete '/articles/:id' do 
    delete_article = Article.find(params[:id])
    delete_article.destroy

  end
end
