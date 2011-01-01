# coding: utf-8
class EditorController < ApplicationController

  before_filter :authenticate_user!

  def index
    if params.has_key? 'order'
      order = params[:order]    
    else
      order = 'name'
    end

    if params.has_key? 'show'
      show = params[:show]    
    else
      show = 10
    end


    @texts = case params[:display]
      when "no-tags" then
        need_to_tag = []
        Text.all.each do |e|
          need_to_tag << e if e.tag_list.blank?
        end
        @texts = need_to_tag.paginate :page => params[:page], :order => order, :per_page => show
      when "no-author" then 
        need_to_tag = []
        Text.all.each do |e|
          need_to_tag << e if e.author_list.blank?
        end
        @texts = need_to_tag.paginate :page => params[:page], :order => order, :per_page => show
      else Text.paginate :page => params[:page], :order => order, :per_page => show
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
    
    redirect_to :back
  end

end
