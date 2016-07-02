class SectionsController < ApplicationController
  layout 'admin'
  before_action :confirm_logged_in
  before_action :find_page
  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:page_id => params[:page_id],:name => "New Section"})
    # @page = Page.find(params[:page_id])
    @section_count = Section.count + 1
  end

  def create
    # #instantiate the page associated with the section
    # @page = Page.find(params[:page_id])
    #instantiate a new object using form parameters
    @section = Section.new(section_params)
    
    
    #save the object
    if @section.save

    #If save succeeds, redirect to the index action
    flash[:notice] = "Successfully created new section!"
    redirect_to(:controller => 'sections', :page_id => @section.page_id)
    else
      render('new')
    end
      
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    #Find an existing object using form parameters
    @section = Section.find(params[:id])
    #update the object
    if @section.update_attributes(section_params)
      #If update succeeds, redirect to the index action
      flash[:notice] = "Section updated successfully!"
      redirect_to(:action => 'show', :page_id => @section.page_id, :id => @section.id)
    else
      #If update fails, redisplay the form so the user can fix the problems
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Successfully deleted '#{section.name}'"
    redirect_to(:controller => 'sections', :page_id => section.page_id)
  end

  private
  def section_params
    params.require(:section).permit(:page_id,:name, :position, :visible, :content_type, :content)

  end
  def find_page
    if params[:page_id]
      @page = Page.find(params[:page_id])
    end
  end

end


