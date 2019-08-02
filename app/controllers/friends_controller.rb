class FriendsController < ApplicationController

    def index
        @user = User.find(params[:id])
        @friends = @user.friends.all
    end

    def send_friend_request
        @user = current_user
        @newfriend = User.find(params[:id])
        current_user.friend_request(@newfriend)
        redirect_to @newfriend, flash: {notice: "Friend Request Sent to " + @newfriend.name}
    end


    def delete_friend
        @user = current_user
        @newfriend = User.find(params[:id])
        current_user.remove_friend(@newfriend)
        redirect_to @newfriend, flash: {notice:  @newfriend.name + " has been removed from your friends."}
    end

    def accept_friend_request
        @user = current_user
        @newfriend = User.find(params[:id])
        current_user.accept_request(@newfriend)
        redirect_to @newfriend, flash: {notice: @newfriend.name + " has been added to your friends"}
    end

    def reject_friend_request
        @user = current_user
        @newfriend = User.find(params[:id])
        current_user.decline_request(@newfriend)
        redirect_to @newfriend, flash: {notice: @newfriend.name + "'s Friend Request has been declined."}
    end

    def block_user
        @user = current_user
        @newfriend = User.find(params[:id])
        current_user.block_friend(@newfriend)
        redirect_to @newfriend, flash: {notice: @newfriend.name + "has been blocked."}
    end

    def unblock_user
        @user = current_user
        @newfriend = User.find(params[:id])
        current_user.unblock_friend(@newfriend)
        redirect_to @newfriend, flash: {notice: @newfriend.name + "has been unblocked."}
    end

    def cancel_request
        @user = current_user
        @newfriend
        @newfriend = User.find(params[:id])
        @newfriend.decline_request(current_user)
        redirect_to @newfriend, flash: {notice: "Your friend request to " + @newfriend.name + " has been cancelled"}
    end
end