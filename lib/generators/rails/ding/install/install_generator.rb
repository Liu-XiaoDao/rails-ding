module Rails
  module Ding
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def copy_initializer_file
        copy_file "rails_ding.rb", "config/initializers/rails_ding.rb"
       end
    end
  end
end
