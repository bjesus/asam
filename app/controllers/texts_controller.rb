# coding: utf-8

class TextsController < ApplicationController

  before_filter :authenticate_user!

  # GET /texts
  # GET /texts.xml
  def index
    if current_user.sign_in_count < 3 and request.request_uri != "/texts"
      redirect_to('/help') and return
    end
    @comments = Comment.unscoped.order('created_at desc').limit(5)
    @texts = Text.recent.with_files.limit(20)
    @hots = []
    hot_files = Image.order('rating_average_quality DESC').limit(30)
    hot_files.each do |hot_file|
      if not @hots.include? hot_file.text and hot_file.text != nil
        @hots << hot_file.text
      end
    end
    @hots = @hots.slice(0,7)
    @authors = Text.tag_counts_on(:author).limit(100).order('count desc').sort_by { |t| t.name }
    @kinds = Text.tag_counts_on(:kind).limit(100).order('count desc').sort_by { |t| t.name }
    @years = Text.tag_counts_on(:year)
    @tags = Text.tag_counts_on(:tags).limit(100).order('count desc').sort_by { |t| t.name }
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
    respond_to do |format|
      if @text.save
        format.html { redirect_to(@text, :notice => 'הקטע נוצר בהצלחה.') }
        format.xml  { render :xml => @text, :status => :created, :location => @text }
      else
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
    ids = params[:id].clone
    if params[:without]
      ids.delete(params[:without])
      url = ""
      ids.each do |id|
        url = url + "id[]="+URI.escape(id)+"&"
      end
      return redirect_to("/list?"+url)
    end
    @texts = Text.with_files.tagged_with(ids).paginate(:page => params[:page], :per_page => 10)
    @tags = Text.tagged_with(ids).tag_counts_on(:tags)
    @tags_kind = Text.tagged_with(ids).tag_counts_on(:kind)
    @tags_author = Text.tagged_with(ids).tag_counts_on(:author)
    @tags_year = Text.tagged_with(ids).tag_counts_on(:year)
    @count = Text.tagged_with(ids).count()

    @tag = [*ids]

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

  def snippet
    @text = Text.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @text }
    end
  end

  def comment
    @text = Text.find(params[:id])
    @text.comments.create(:title => params[:title], :comment => params[:comment], :user => current_user)

    redirect_to(@text, :notice => 'התגובה נוספה בהצלחה.')
  end

end
