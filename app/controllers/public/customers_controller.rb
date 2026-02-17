#class UsersController < ApplicationController
  # サインアップ（new, create）はログイン前に行うため
  #allow_unauthenticated_access only: [:new, :create]

  #before_action :set_user, only: [:show]

  def show
    @customer  = Current.session.user   # 左（顧客）

  end

  def edit; end
  def update; end
  def unsubscribe; end
  def withdraw; end

#end