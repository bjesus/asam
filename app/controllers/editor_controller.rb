# coding: utf-8
class EditorController < ApplicationController

  before_filter :authenticate_user!

  def index
    if params.has_key? 'order'
      order = params[:order]    
    else
      order = 'name'
    end

    @texts = case params[:display]
      when "no-tags" then Text.paginate :page => params[:page], :order => order, :per_page => params[:show]
      when "all-tags" then Text.paginate :page => params[:page], :order => order, :per_page => params[:show]
      else Text.paginate :page => params[:page], :order => order, :per_page => params[:show]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @texts }
    end
  end


  def update
    @texts = params[:texts][:text]
    @texts.each do |text|
      @text = Text.find(text[0])
      @text.update_attributes(text[1])
      @text.save()
    end
    
    redirect_to "/texts/editor"
  end

end
