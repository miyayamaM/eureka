# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save!
  end

  def edit; end

  def update; end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(article_id: params[:article_id])
  end
end
