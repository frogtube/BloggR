# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  content          :text
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  banner_image_url :string
#  author_id        :integer
#  published        :boolean          default("f")
#  published_at     :datetime
#

class Post < ApplicationRecord

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_votable

  PER_PAGE = 6

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :author
  belongs_to :category

  scope :most_recent, -> { order(published_at: :desc)}
  scope :published, -> { where(published: true) }

  def should_generate_new_friendly_id?
    title_changed?
  end

  def was_published_at
    if published_at.present?
      "Published #{published_at.strftime('%-b %-d, %Y')}"
    else
      "Not published yet"
    end
  end

end
