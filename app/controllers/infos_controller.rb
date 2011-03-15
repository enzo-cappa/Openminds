class InfosController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
		if session[:usuario]
      @infos = Info.paginate :page => params[:page]
#    	@info_pages, @infos = paginate :infos, :per_page => 10
		end
  end

  def new
    if session[:usuario].privilegio > 1
			@info = Info.new
		else
			redirect_to :action => 'list'
		end
  end

  def create
		if session[:usuario].privilegio > 1
    	@info = Info.new(:nombre=>params[:info][:nombre], :desc => params[:info][:desc])
			@info.adjunto = params[:info][:archivo]
    	if @info.save
      	flash[:notice] = 'Se agrego la informacion a la base de conocimiento'
      		redirect_to :action => 'list'
    		else
      	render :action => 'new'
    	end
		else
			redirect_to :action => 'list'
		end
  end

  def edit
		if session[:usuario].privilegio > 1
    	@info = Info.find(params[:id])
		else
			redirect_to :action => 'list'
		end
  end

  def update
    @info = Info.find(params[:id])
    if @info.update_attributes(params[:info])
      flash[:notice] = 'Info was successfully updated.'
      redirect_to :action => 'show', :id => @info
    else
      render :action => 'edit'
    end
  end

  def destroy
    if session[:usuario].privilegio > 1
			Info.find(params[:id]).destroy
    	redirect_to :action => 'list'
		else
			redirect_to :action => 'list'
		end
  end

	def get_archivo
		@info_dato = Info.find(params[:id])
		@info = @info_dato.datos_binarios
		send_data (@info, :filename => @info_dato.archivo, :type => @info_dato.tipo)
	end
end
