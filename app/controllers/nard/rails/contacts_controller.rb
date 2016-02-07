class Nard::Rails::ContactsController < Nard::Rails::AppController

  respond_to :html

  # GET /contacts/new
  def new
    @contact = contact_class.new
    session_handler.delegate_attributes( of: :contact , to: @contact )
  end

  # POST /contacts/confirm
  def confirm
    @contact = contact_class.new(contact_params)

    if @contact.valid?
      session_handler.set( :contact , contact_params )
      render 'confirm'
    else
      render 'new'
    end
  end

  # POST /contacts/done
  def done
    @contact = contact_class.new(contact_params)
    session_handler.delete!( :contact  )

    if @contact.save
      ::Thread.start( @contact ) do | contact |
        ::Mailer::ToAdministrator.as_to_contact(contact).deliver_later
      end
      render 'done'
    else
      @contact.errors[ :base ] << t( 'helpers.errors.submit' )
      render 'new'
    end
  end

  private

  def contact_class
    Contact
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact)
  end

end
