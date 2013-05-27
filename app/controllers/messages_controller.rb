class MessagesController < ApplicationController
  def index
    @incomings = Incoming.includes(:user, :outgoings).all
  end

  def create
    p params
    conn = Faraday.new(:url => 'http://localhost:9393/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn.post '/send_message', params
    redirect_to messages_path
  end
end
