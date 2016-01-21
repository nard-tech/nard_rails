# 標準的なアクションのテンプレートを格納するモジュール
module Nard::Rails::ControllerExt::Master

  def create( item )
    respond_to do |format|
      if item.save
        format.html { redirect_to( item, flash: { status: 'created' } ) }
        format.json { render( :show, status: :created, location: item ) }
      else
        format.html { render( :new ) }
        format.json { render( json: item.errors, status: :unprocessable_entity ) }
      end
    end
  end

  def update( item , _params )
    respond_to do |format|
      if item.update( _params )
        format.html { redirect_to( item, flash: { status: 'updated' } ) }
        format.json { render( :show, status: :ok, location: item ) }
      else
        format.html { render( :edit ) }
        format.json { render( json: item.errors, status: :unprocessable_entity ) }
      end
    end
  end

  def destroy( item , path_for_html )
    item.destroy
    respond_to do |format|
      format.html {
        redirect_to( path_for_html, flash: { status: 'deleted' , msg: item.decorate.msg_after_deleted } )
      }
      format.json { head( :no_content ) }
    end
  end

end
