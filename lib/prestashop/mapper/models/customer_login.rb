using Prestashop::Mapper::Refinement
module Prestashop
  module Mapper
    class CustomerLogin < Model
      resource :customer_login
      model :customer

      def self.authorize(id, password)
        options = {
          'filter[passwd]' => password,
          display: 'full'
        }
        result = Client.read self.resource, id, options
        result = {self.resource => {self.model => result[self.resource]}} unless result.nil?
        result = handle_result result, options
        auth_user = result ? result.first : nil
        return nil if auth_user.nil? || auth_user[:successful][:val] != 1
        auth_user
      end
    end
  end
end