class UsersController < ApplicationController
  def show
    @instance = User.find(params[:id])
  end

end
