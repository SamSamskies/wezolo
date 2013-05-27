class MessagesController < ApplicationController
  def index
    @incomings = Incoming.all
  end

  def create
  end
end
