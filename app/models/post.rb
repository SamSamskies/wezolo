class Post < ActiveRecord::Base
  belongs_to :blog
  attr_accessible :body, :published_at, :title

  def self.find_posts(query_type, filter_choice, pagination = {})
    if query_type == "all"
      query = self.all
    elsif query_type == "sector"
      query = self.by_sector(filter_choice)
    elsif query_type == "status"
      query = self.by_status(filter_choice)
    elsif query_type == "country"
      query = self.by_country(filter_choice)
    end
    return query.order("published_at DESC").paginate(:page => pagination[:page], :per_page => pagination[:per_page]) if pagination.present?
    query.order("published_at DESC")
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

