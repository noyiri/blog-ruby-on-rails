class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:show,:index]
  before_action :set_article, only: [:show,:edit,:update,:destroy]

  #GET /articles
  def index
    @articles = Article.all
  end

  #GET /articles/:id
  def show
    @article.update_visits_count
    @comment = Comment.new
    #Encontrar un registro por ID
    #WHERE
    #Article.where.not("id = ?",params[:id])
  end

  #GET /articles/new
  def new
    @article = Article.new
    @categories = Category.all
  end

  #POST /articles
  def create
    #INSERT INTO
    @article = current_user.articles.new(article_params)
    @article.categories = pabrams[:categories]
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  #DELETE /articles/:id
  def destroy
    #DELETE FROM articles
    @article.destroy #Destroy elimina el objeto de la BD
    redirect_to articles_path
  end

  #PUT /articles/:id
  def update
    #@article.update_attributes({title: 'Nuevo titulo'})
    if @article.update(article_params)
      redirect_to @article
    else
       render :edit
    end

  end

  def edit

  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:body,:cover,:categories)
  end

end
