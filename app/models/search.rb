class Search < ActiveRecord::Base
  include PublishesCallbacks
  has_many :classified_tweets
  has_many :tweets, :through => :classified_tweets
  belongs_to :user
  validates :keywords, :length => {:minimum => 1}

  protected

  after_create do
    publish_callback :after_create, {:keywords => keywords}
  end
  after_save do
    publish_callback :after_save, {:keywords => keywords} if keywords_changed?
  end
  after_destroy do
    publish_callback :after_destroy, {:keywords => keywords}
  end

end
