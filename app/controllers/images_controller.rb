# encoding: utf-8

class ImagesController < ApplicationController
  protect_from_forgery :except => :rate

  # GET /images
  # GET /images.xml
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create
    if(params[:file])
      params[:image][:photo] = params[:file]
    end
    @image = Image.new(params[:image])
    @image.user = current_user

    respond_to do |format|
      if @image.save
        format.html { redirect_to(@image, :notice => 'Image was successfully created.') }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(@image, :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end

  def rate
    @car = Image.find(params[:id])
    p '#####'
    p @car
    p current_user
    p params[:stars]
    p params[:dimension]
    p '#####'
    @car.rate(params[:stars], current_user, params[:dimension])
    average = @car.rate_average(true, params[:dimension])
    width = (average / @car.class.max_stars.to_f) * 100
    render :json => {:id => @car.wrapper_dom_id(params), :average => average, :width => width}
  end

  def guidelines
    @image = Image.find(params[:id])
    @image.guidelines = params[:guidelines]

    @image.save
    
    redirect_to(@image.text, :notice => 'הוראות ההדפסה נשמרו בהצלחה.')
  end

  def hidden_switch
    @image = Image.find(params[:id])
    if @image.user != current_user
      return redirect_to("/", :notice => 'מה זה פה, שוק?')
    end
    @image.hidden = !@image.hidden
    @image.save
    redirect_to(@image.text, :notice => 'זמינות הקובץ שונתה בהצלחה.')
    
  end

end
