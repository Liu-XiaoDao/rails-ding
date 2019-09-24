module Rails
  module Ding
    class Engine < ::Rails::Engine
      isolate_namespace Rails::Ding
    end
  end
end
