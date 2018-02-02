module ApplicationHelper

    def current_active(current)
        return "active" if session[:current_path].index(current) == 1
    end

end
