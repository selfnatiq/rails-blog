class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
    logger.debug flash[:errors].inspect
  end

  def create
    blog = Blog.new(blogs_params)
    if blog.save
      redirect_to blog_path(blog), notice: "#{blog.title} was successfully created!"
    else
      flash[:errors] = blog.errors.full_messages
      redirect_to new_blog_path
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])

    if blog.update(blogs_params)
      redirect_to blog_path(blog), notice: "#{blog.title} was successfully updated!"
    else 
      flash[:errors] = blog.errors.full_messages
      redirect_to edit_blog_path(blog)
    end
  end

  def destroy
    Blog.destroy(params[:id])
    redirect_to blogs_path
  end


  def previous
    Blog.where(["id < ?", id]).last
  end
  
  def next
    Blog.where(["id > ?", id]).first
  end
  


  private 
  def blogs_params 
    params.require(:blog).permit(:title, :body, :author)
  end
end
