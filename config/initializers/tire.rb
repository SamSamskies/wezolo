if Rails.env.test?
  prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
  Tire::Model::Search.index_prefix(prefix)
end
