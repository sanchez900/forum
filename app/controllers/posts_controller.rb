class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@post = Post.all.order("created_at DESC")
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)		

		respond_to do |format|	
			if @post.save
				flash[:success] = 'Post was successfully created.'
	 			format.html { redirect_to @post }
	 			format.json { render :show, status: :created, location: @post }
			else
				flash[:danger] = 'Post not created.'
				format.html { render 'new' }
				format.json { render json: @post.erros, status: :unprocessable_entiy }
			end
		end
	end

	def edit
	end

	def update

		respond_to do |format|
			if @post.update(post_params)
				flash[:success] = 'Post was successfully updated.'
				format.html { redirect_to @post }
				format.json { render :show, status: :ok, location: @post }
			else
				flash[:danger] = 'there was a problem updating the post'
				format.html { render 'edit' }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	def delete
	end

	def destroy
		@post.destroy
		flash[:success] = 'Post was successfully destroyed.'
  		redirect_to root_path	
	end

	def show
	end

	private

		def find_post
			@post = Post.find(params[:id])
		end

		def post_params
			params.require(:post).permit(:title, :content)
		end
end
