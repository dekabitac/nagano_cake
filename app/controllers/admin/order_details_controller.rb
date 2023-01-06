class Admin::OrderDetailsController < ApplicationController
before_action :authenticate_admin!, except: [:top, :about,:sign_in]
def update
  
end 

end
