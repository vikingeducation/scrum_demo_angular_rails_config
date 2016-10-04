class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.all
    respond_to do |format|
      format.json { render :json => @messages, :status => 200 }
    end
  end


  def create
    @message = Message.create(message_params)

    respond_to do |format|
      if @message.save
        format.json { render :json => @message, :status => 201 }
      else
        format.json { render :json => { :error => 'Oops!' } }
      end
    end
  end


  def destroy
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.destroy
        format.json { render :json => @message, :status => 200 }
      else
        format.json { render :json => { :error => 'Oops!' } }
      end
    end
  end




  private
  def message_params
    params.require(:message).permit(:body)
  end
end
