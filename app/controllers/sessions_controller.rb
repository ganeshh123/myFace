class SessionsController < Devise::SessionsController

    private
    
        def sign_in_params
            params.require(:sign_in).permit(:username,  :password)
        end
    
    end
    