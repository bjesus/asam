# coding: utf-8

class TextsController < ApplicationController

  before_filter :authenticate_user!

  # GET /texts
  # GET /texts.xml
  def index

    # Show the welcome page for new users
    if current_user.sign_in_count < 3 and request.request_uri != "/texts"
      return redirect_to('/help')
    end

    # Get the data for the index page
    @comments = Comment.unscoped.order('created_at desc').limit(5)
    @texts = Text.recent.with_files.limit(20)
    @hots = []
    @authors = Text.tag_counts_on(:author).limit(100).order('count desc').sort_by { |t| t.name }
    @kinds = Text.tag_counts_on(:kind).limit(100).order('count desc').sort_by { |t| t.name }
    @tags = Text.tag_counts_on(:tags).limit(100).order('count desc').sort_by { |t| t.name }
    hot_files = Image.order('rating_average_quality DESC').limit(30)
    hot_files.each do |hot_file|
      if not @hots.include? hot_file.text and hot_file.text != nil and @hots.length < 7
        @hots << hot_file.text
      end
    end

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
    @query = params[:q]
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

    respond_to do |format|
      if @text.update_attributes(params[:text])
        format.html { redirect_to(@text, :notice => 'הקטע עודכן בהצלחה.') }
        format.xml  { head :ok }
      else
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
    
    # Remove tag filter
    if params[:without]
      ids.delete(params[:without])
      url = ""
      ids.each do |id|
        url = url + "id[]="+URI.escape(id)+"&"
      end
      return redirect_to("/list?"+url)
    end

    # Get relevant results
    @texts = Text.with_files.tagged_with(ids).paginate(:page => params[:page], :per_page => 10)
    @count = Text.tagged_with(ids).count()

    # Create tag clouds for further flitering
    @tags = Text.tagged_with(ids).tag_counts_on(:tags).sort_by { |t| t.name }
    @tags_kind = Text.tagged_with(ids).tag_counts_on(:kind).sort_by { |t| t.name }
    @tags_author = Text.tagged_with(ids).tag_counts_on(:author).sort_by { |t| t.name }
    @tags_year = Text.tagged_with(ids).tag_counts_on(:year).sort_by { |t| t.name }
    
    @tag = [*ids]

    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end
  end

  def tags_json
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
