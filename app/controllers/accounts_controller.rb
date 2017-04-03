class AccountsController < ApplicationController

  def edit
  end

  def update_info
    current_author.update(author_params)
  end

  def change_password
  end

  private

  def author_params
    params.require(:author).permit(:name, :email, :bio, :current_password, :new_password, :new_password_confirmation)
  end

end