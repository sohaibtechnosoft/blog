class CommentsController < ApplicationController

  before_action :find_commentable, only: :create

  def new
    @comment = Comment.new
  end

  def create

    Comment.create(comment_params.merge(:commentable => @commentable))

# @comment_user=comments.build(comment_params)
# @comment_user.save
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:message,:user_id)

  end

  def find_commentable


    if params.require(:comment)[:post_id]
      @commentable = Post.find_by(id: params.require(:comment)[:post_id])
    elsif params.require(:comment)[:comment_id]
      @commentable = Comment.find_by(id: params.require(:comment)[:comment_id])
    end
  end
end
