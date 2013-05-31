class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_create(post)
    country_ids = post.blog.user.involvements.all.map(&:country_id)
    sector_names = post.blog.user.involvements.map(&:sector)
    status = post.blog.user.status
    
    expire_sectors(sector_names)
    expire_countries(country_ids)
    expire_status(status)

  end

  def expire_sectors(sector_names)
    sector_names.each do |sector_name|
      Rails.cache.delete("views/#{sector_name}_sector")
    end
  end

  def expire_countries(country_ids)
    country_ids.each do |country_id|
      Rails.cache.delete("views/#{country_id}_country")
    end
  end

  def expire_status(status)
    Rails.cache.delete("views/#{status}_status")
  end

end
