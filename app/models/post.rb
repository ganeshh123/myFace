class Post < ApplicationRecord

    belongs_to :user
    acts_as_votable
    has_many :comments, dependent: :destroy, as: :commentable
    has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy


    include PublicActivity::Model
    tracked only: [:create, :destroy], owner: Proc.new{ |controller, model| controller.current_user }

end
