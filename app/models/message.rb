class Message < ActiveRecord::Base
  belongs_to :user

  def self.send_message(params)
    conn = Faraday.new(:url => 'http://wezolo-twillio.herokuapp.com/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.post '/send_message', {:to => params[:to], :body => params[:body]}
    response.status == 200
  end

end
