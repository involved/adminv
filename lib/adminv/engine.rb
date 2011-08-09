require 'css3buttons'
module Adminv
  class Engine < Rails::Engine
    ActionController::Base.helper(Adminv::Helpers::ViewHelper)
    ActionController::Base.helper(Adminv::Helpers::FormHelper)
  end
end
