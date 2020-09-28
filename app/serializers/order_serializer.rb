class OrderSerializer < ActiveModel::Serializer
   attributes :subtotal, :firstname, :lastname, :email, :address, :payment_method
 end
