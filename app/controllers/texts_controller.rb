# coding: utf-8
class TextsController < ApplicationController

  before_filter :authenticate_user!

  # GET /texts
  # GET /texts.xml
  def index
    @texts = Text.find(:all, :limit => 10, :order=> 'created_at desc')
    @authors = Text.tag_counts_on(:author).limit(50).order('count desc').sort_by { |t| t.name }
    @kinds = Text.tag_counts_on(:kind).limit(50).order('count desc').sort_by { |t| t.name }
    @years = Text.tag_counts_on(:year)
    @tags = Text.tag_counts_on(:tags).limit(50).order('count desc').sort_by { |t| t.name }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @texts }
    end
  end

  def all_tags
    @tags = Text.tag_counts_on(params[:tag]).order(:name)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @texts }
    end
  end

  def search
    @texts = Text.search "*#{params[:q]}*"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @texts }
    end
  end

  # GET /texts/1
  # GET /texts/1.xml
  def show
    @text = Text.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @text }
    end
  end

  # GET /texts/new
  # GET /texts/new.xml
  def new
    @text = Text.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @text }
    end
  end

  # GET /texts/1/edit
  def edit
    @text = Text.find(params[:id])
  end

  # POST /texts
  # POST /texts.xml
  def create
    @text = current_user.texts.build(params[:text])
    names = []
    params.each do |para|
      if para[0].starts_with? 'uploader_' and para[0].ends_with? '_name'
        names << para[1]
      end
    end
    respond_to do |format|
      if @text.save
        names.each do |name|
          @image = Image.find(:first, :conditions => ["photo_file_name = ? and text_id = ?", name, 0])
          @image[:text_id] = @text.id
          @image.save
        end
        format.html { redirect_to(@text, :notice => 'הקטע נוצר בהצלחה.') }
        format.xml  { render :xml => @text, :status => :created, :location => @text }
      else
        names.each do |name|
          @image = Image.find(:first, :conditions => ["photo_file_name = ? and text_id = ?", name, 0])
          @image[:text_id] = @text.id
          @image.save
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /texts/1
  # PUT /texts/1.xml
  def update
    @text = Text.find(params[:id])
    names = []
    params.each do |para|
      if para[0].starts_with? 'uploader_' and para[0].ends_with? '_name'
        names << para[1]
      end
    end

    respond_to do |format|
      if @text.update_attributes(params[:text])
        names.each do |name|
          @image = Image.find(:first, :conditions => ["photo_file_name = ? and text_id = ?", name, 0])
          @image[:text_id] = @text.id
          @image.save
        end
        format.html { redirect_to(@text, :notice => 'הקטע עודכן בהצלחה.') }
        format.xml  { head :ok }
      else
        names.each do |name|
          @image = Image.find(:first, :conditions => ["photo_file_name = ? and text_id = ?", name, 0])
          @image[:text_id] = @text.id
          @image.save
        end
        format.html { render :action => "edit" }
        format.xml  { render :xml => @text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.xml
  def destroy
    @text = Text.find(params[:id])
    @text.destroy

    respond_to do |format|
      format.html { redirect_to(texts_url) }
      format.xml  { head :ok }
    end
  end

  def tagged
    @texts = Text.tagged_with(params[:id])
    @tag = params[:id]

    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end

  end

  def tags_json
    print params[:search]
    print params[:c]
    @tags = eval("Text."+params[:c]+"_counts")
    @mytags = []
    @tags.each { |tag|
      if tag['name'].match(params[:search])
        @mytags << [tag['name'], tag['name'], nil, tag['name']]
      end
    }
    render :json => @mytags

  end

  def my_texts
    @texts = Text.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end

  end

end
