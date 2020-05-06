class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  enum status: {
    doing :0,
    done :1,
  }

end
