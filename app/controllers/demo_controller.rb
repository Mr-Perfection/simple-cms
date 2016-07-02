class DemoController < ApplicationController
  layout 'application'
  def index
  end
  def hello
  	@array = [2,3,4,5,6,1,-5]
  	@id = params['id']
  	@page = params[:page].to_i
  	#render('index');
  end
  def other_hello
  	redirect_to(:controller => 'demo', :action => 'index');
  end
end

def text_helper
  
end
