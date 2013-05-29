class Post < ActiveRecord::Base
  belongs_to :blog
  attr_accessible :body, :published_at, :title

  def self.find_posts(query_type, filter_choice)
    if query_type == "all"
      self.all
    elsif query_type == "sector"
      self.by_sector(filter_choice)
    elsif query_type == "status"
      self.by_status(filter_choice)
    elsif query_type == "country"
      self.by_country(filter_choice)
    end
  end

  def self.by_sector(filter_choice)
    self.includes({:blog => {:user => [:profile, :involvements]}}).where("involvements.sector" => filter_choice)
  end

  def self.by_country(filter_choice)
    self.includes({:blog => {:user => [:profile, :involvements]}}).where("involvements.country_id" => filter_choice)
  end

  def self.by_status(filter_choice)
    self.includes({:blog => {:user => :profile}}).where("users.status" => filter_choice)
  end

end

