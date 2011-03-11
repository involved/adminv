module Adminv
  class Engine < Rails::Engine
    ActionController::Base.helper(Adminv::Helpers::ViewHelper)
  end
end
