class AccountsController < ApplicationController

  def edit
  end

  def update_info
    if current_author.update(author_params)
      flash[:success] = "Good job! -- Your basic infos have been successfully saved"
    else
      flash[:danger] = current_author.errors.full_messages.join('  --  ')
    end
    redirect_to account_path
  end

  def change_password
    if current_author.valid_password?(author_params[:current_password])
      if current_author.update(
        password: author_params[:new_password],
        password_confirmation: author_params[:new_password_confirmation]
      )
        sign_in(current_author, bypass: true)
        flash[:success] = "Password changed successfully"
      else
        flash[:danger] = current_author.errors.full_messages.join('  --  ')
      end
    else
      flash[:danger] = "Current password is incorrect"
    end
      redirect_to account_path
  end

  private

  def author_params
    params.require(:author).permit(:name, :email, :website, :bio, :current_password, :new_password, :new_password_confirmation)
  end

end