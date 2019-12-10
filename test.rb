def find_item_by_name_in_collection(name, collection)
  collection.length.times do |index|
    if collection[index][:item] == name
      return collection[index]
    end 
  end
  return nil
end

def delete_zero_quantities(cart)
  indexes_to_delete = []
  cart.length.times do |index|
    if cart[index][:count] == 0
      indexes_to_delete.push(index)
    end
  end
  indexes_to_delete.length.times do |index|
    cart.delete_at(index)
  end
  cart
end 

def return_index(name, collection)
  collection.length.times do |index|
    if collection[index][:item] == name
      return index 
    end 
  end
end 

our_cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 4},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 7},
  {:item => "Milk",    :price => 2.00, :clearance => false, :count => 2}
]

coupon = [{:item => "AVOCADO", :num => 2, :cost => 5.00},
          {:item => "KALE", :num => 2, :cost => 5.00}]

def apply_coupons(cart, coupons)
  cart.length.times do |cart_index| #iterate over cart 
    #check if current item is in the coupon collection calling the method  find_item_by_name_in_collection
    item_in_coupon = find_item_by_name_in_collection(cart[cart_index][:item], coupons)
    if item_in_coupon #if the item is in the coupon collection 
    
      #check in which index the item is in the coupom collection 
      item_index_in_coupon = return_index(cart[cart_index][:item], coupons)
      
      #check if the quantity in coupon is met 
      if coupons[item_index_in_coupon][:num] <= cart[cart_index][:count]
        #se a qtde comprada for maior, vamos aplicar o desconto
        #pegamos o valor do desconto e dividimos pela quantidade para 
        #termos um valor individual
        unit_value = coupons[item_index_in_coupon][:cost] / coupons[item_index_in_coupon][:num]
        new_item = cart[cart_index].clone
        new_item[:price] = unit_value
        new_item[:count] = cart[cart_index][:count] - cart[cart_index][:count]%coupons[item_index_in_coupon][:num] 
        cart[cart_index][:count] = cart[cart_index][:count]%coupons[item_index_in_coupon][:num]
        new_item[:item] += " W/COUPON"
        cart.push(new_item)
      end
    end
  end

  puts "imprimindo carrinho"
  puts cart
  puts "excluindo 0 quantidades"
  #cart.delete_if{|item| item[:count] == 0}
  puts cart
end

apply_coupons(our_cart, coupon)

new_array = [
{:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>0},
{:item=>"KALE", :price=>3.0, :clearance=>false, :count=>0},
{:item=>"AVOCADO W/COUPON", :price=>2.5, :clearance=>true, :count=>4},
{:item=>"KALE W/COUPON", :price=>2.5, :clearance=>false, :count=>8}
]
#SPURRRRRRRRRRRRRRRRRRRRRRRSSSSSSSSSSSSS
# new_array.delete_if{|item| item[:count] == 0}

# scores = [ 97, 42, 75 ]
# scores.delete_if {|score| score < 80 } 

#new_array = [34,53,64,23,44,54]
# delete_indexes = [1,2]
#new_array.length.times do |index|
  # if new_array[index][:count] == 0 
  # puts "esse tem 0"
  # puts new_array[index]
  # end 

#end 

# scores = [ 97, 42, 75 ]
# scores.delete_if {|score| score < 80 } 

# puts new_array


