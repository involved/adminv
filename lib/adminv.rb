module Adminv
  module Components
    autoload :Container, 'adminv/components/container'
    autoload :Content, 'adminv/components/content'
    autoload :Header, 'adminv/components/header'
    autoload :Table, 'adminv/components/table'
    autoload :TableRow, 'adminv/components/table_row'
  end
  module Helpers
    autoload :ViewHelper, 'adminv/helpers/view_helper'
    autoload :FormHelper, 'adminv/helpers/form_helper'
  end
  require 'adminv/engine'
end
