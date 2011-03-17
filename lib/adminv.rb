module Adminv
  module Components
    autoload :Container, 'adminv/components/container'
    autoload :Content, 'adminv/components/content'
    autoload :Header, 'adminv/components/header'
  end
  module Helpers
    autoload :ViewHelper, 'adminv/helpers/view_helper'
  end
  require 'adminv/engine'
end
