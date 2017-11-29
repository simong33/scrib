class Book < ApplicationRecord
  belongs_to :user
  has_many :chapters
  has_many :characters
  has_many :places

  def signs
    signs = 0
    self.chapters.each do |chapter|
      signs += chapter.signs unless chapter.content.nil?
    end
    signs
  end

  def wordcount
    words = 0
    self.chapters.each do |chapter|
      words += chapter.wordcount unless chapter.content.nil?
    end
    words
  end

  def word_goal_ratio
    if self.word_goal != nil && self.word_goal > 0
      self.wordcount.to_f / self.word_goal
    else
      0
    end
  end

  def average_daily_wordcount
    self.wordcount / self.age_in_days
  end

  def age_in_days
    ((Time.current - self.created_at) / (60*60*24)).floor
  end
end
