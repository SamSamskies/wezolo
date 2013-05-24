require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
  context "followed posts" do
    it "#followed_posts should not return any duplicate posts"

    it "#followed_posts should?/shouldnot? return any posts written by the current user if the user is in the country that he/she is in"

    it "#heroes_posts returns all the posts written by people that a user is following"

    it "#countries_posts returns all the posts written by people in a country that a user is following"

    it "#published_at should return array of posts ordered by published_at"    
  end

end
