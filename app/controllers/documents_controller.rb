require 'Nokogiri'
require 'open-uri'

class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    user_url_input = params[:document][:crawl_url]
    user_text_input = params[:document][:user_text]
    user_pdf_input = params[:document][:pdf]
    
    if not user_url_input.length == 0
      if user_url_input.start_with?('http://')
        page = Nokogiri::HTML(open(user_url_input))
        body_tag = page.css('body')
        @document = Document.new(:crawl_url => "#{body_tag.css('a')}", :user_text => nil, :pdf => nil)
      else
        @document = Document.new(:crawl_url => "#{user_url_input}", :user_text => nil, :pdf => nil)
      end
    elsif not user_text_input.length == 0
      @document = Document.new(:user_text => "#{user_text_input}", :crawl_url => nil , :pdf => nil)
    elsif not user_pdf_input.nil?
      @document = Document.new(:user_text => nil, :crawl_url => nil, :pdf => user_pdf_input) 
    end

    #body_tag.css('h2').css('a').each { |link| puts link.text }
    #params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end
end
