class AddCommentRefToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :comment, foreign_key: true
  end
end
