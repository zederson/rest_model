$:.push 'examples'; require 'helper'

class Customer < RestModel
  property :login, field: 'hidden.login'
end

@root = Customer.new(login: 'jackiechan2010')
inspect_rest_model(@root)
