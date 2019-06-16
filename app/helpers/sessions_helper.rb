module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end
    
    def remember(user)
        user.remember #DBに暗号化したremember_tokenをremember_digesに保存してる
        cookies.permanent.signed[:user_id] = user.id #.signed[:user_id]暗号化してる
        cookies.permanent[:remember_token] = user.remember_token
    end
    
    def forget(user)
        user.forget #DBのremember_digestの値をNilにする
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    def current_user?(user)
        user == current_user
    end
    
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id]) #.signed[:user_id]で暗号化を復元してる
                user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end
    
    def logged_in? #application.html.erbで呼び出されている
        !current_user.nil?
    end
    
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

  # アクセスしようとしたURLを覚えておく
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
end
