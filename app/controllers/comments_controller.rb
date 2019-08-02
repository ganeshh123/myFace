class CommentsController < ApplicationController
    
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_commentable, except: [:destroy]

    def create
        @comment = @commentable.comments.new comment_params
        @comment.user = current_user
        @comment.save
        @commentable.create_activity key: 'commented', owner: current_user, comment_id: @comment.id
        redirect_to @commentable, notice: "Comment Posted!"
    end

    def index
        @comments = @commentable.comments.all.order("created_at DESC")
        @comment = @commentable.comments.new comment_params
    end

    def destroy
        @comment = Comment.find(params[:id])
        if @comment.user == current_user || @comment.commentable.user == current_user
            @comment.destroy
            @activity = Activity.find_by(trackable_type: 'Post', trackable_id: comment.post.id, owner_type: 'User', owner_id: current_user.id, key: 'commented')
            if !@activity.nil?
                @activity.destroy
            end            
            respond_to do |format|
            format.html { redirect_to posts_url, notice: 'Comment Deleted!' }
            format.json { head :no_content }
            end
        end
    end



    private
    
        def comment_params
            params.require(:comment).permit(:body)
        end

        def set_commentable
            @commentable = Post.find(params[:post_id])
        end
        

end
