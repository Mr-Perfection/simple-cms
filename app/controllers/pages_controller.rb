class PagesController < ApplicationController
  layout 'admin'
  before_action :confirm_logged_in
  before_action :find_subject
  
  def index

    # @pages = Page.where(:subject_id => @subject.id).sorted
    @pages = @subject.pages.sorted

  end
  def show
    #Find the page with :id
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => params[:subject_id], :name => "Default"})
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Successfully created new page!"
      redirect_to(:controller => 'pages', :subject_id => @page.subject_id)
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Successfully updated page '#{@page.name}'"
      redirect_to(:action => 'index',:subject_id => @page.subject_id)
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Successfully deleted page [#{page.name}]..."
    redirect_to(:action => 'index', :subject_id => page.subject_id)
  end



  # Actions taken before the controller...
  private
  def page_params
    params.require(:page).permit(:subject_id, :name, :permalink,:position, :visible)
  end

  def find_subject
    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
    end
  end

end
