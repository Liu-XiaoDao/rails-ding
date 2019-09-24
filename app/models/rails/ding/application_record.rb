module Rails
  module Ding
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
