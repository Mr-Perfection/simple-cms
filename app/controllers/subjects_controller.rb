class SubjectsController < ApplicationController

  
  # layout false
  layout 'admin'

  before_action :confirm_logged_in
  
  def index
  	@subjects = Subject.sorted
  end

  def show
  	@subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Hello World!"})
    @subject_count = Subject.count + 1
  end

  def create
    #instantiate a new object with form parameters
    @subject = Subject.new(subject_params)
    #save the object
    if @subject.save
    #If save succeeds, redirect to the index action
      flash[:notice] = "Subject created successfully!"
      redirect_to(:action => 'index')

    else
    #If save fails, redisplay the form so the user can fix the problems
      @subject_count = Subject.count + 1
      render('new')

    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    #Find an existing object using form parameters
    @subject = Subject.find(params[:id])
    #update the object
    if @subject.update_attributes(subject_params)
    #If update succeeds, redirect to the index action
      flash[:notice] = "Subject updated successfully!"
      redirect_to(:action => 'show', :id => @subject.id)
    else
    #If update fails, redisplay the form so the user can fix the problems
      @subject_count = Subject.count
      render('edit')
    end
  end
  def delete
    @subject = Subject.find(params[:id])
  end
  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully!"
    redirect_to(:action => 'index')
  end

  private

    def subject_params
      #same as using params[:subject], exept that it:
      # - raises an error if :subject is not present
      # - allows listen attributes to be mass-assigned
      params.require(:subject).permit(:name, :position, :visible)
    end

end

