class Ang::WelcomeController < ApplicationController
    def index
        render :file => 'ang/index.html'
    end
end
