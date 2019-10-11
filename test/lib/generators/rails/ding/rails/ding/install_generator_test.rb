require 'test_helper'
require 'generators/rails/ding/install/install_generator'

module Rails::Ding
  class Rails::Ding::InstallGeneratorTest < Rails::Generators::TestCase
    tests Rails::Ding::InstallGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
