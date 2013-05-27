class MessagesController < ApplicationController
  def index
    @incomings = Incoming.includes(:user, :outgoings).all
  end

  def create
    p params
  end
end
