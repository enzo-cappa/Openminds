class InfosController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @infos = Info.paginate :page => params[:page]
  end

  def new
    @info = Info.new
  end

  def create
    @info = Info.new(:nombre=>params[:info][:nombre], :desc => params[:info][:desc])
    @info.adjunto = params[:info][:archivo] if params[:info][:archivo]
    if @info.save
      flash[:notice] = 'Se agrego la informacion a la base de conocimiento'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @info = Info.find(params[:id])
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
    Info.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

	def get_archivo
		@info_dato = Info.find(params[:id])
		@info = @info_dato.datos_binarios
		send_data (@info, :filename => @info_dato.archivo, :type => @info_dato.tipo)
	end
  
  protected

  def permiso_requerido(accion)
    1
  end
end
