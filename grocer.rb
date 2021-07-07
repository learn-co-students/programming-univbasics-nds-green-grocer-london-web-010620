def find_item_by_name_in_collection(name, collection)
  collection.length.times do |index|
    if collection[index][:item] == name
      return collection[index]
    end 
  end
  return nil
end

def return_index(name, collection)
  collection.length.times do |index|
    if collection[index][:item] == name
      return index 
    end 
  end
end 

def consolidate_cart(cart)
  #create empty cart, which will be returned
  fixed_cart = []
  cart.length.times do |index| #iterate through the argument
    #call the find_item method and atrib the return to a var 
    item = find_item_by_name_in_collection(cart[index][:item], fixed_cart)
    if !item #if the returned value is nil means that we don't have the item yet
      #create a new entry and add a value of 1 to :count
      fixed_cart.push(cart[index])
      fixed_cart[-1][:count] = 1
    else #which means that the item is already in the cart 
      #call method return_index to find out in what index the item is 
      index_where_item_is = return_index(cart[index][:item], fixed_cart)
      #add 1 to count
      fixed_cart[index_where_item_is][:count] += 1
    end
  end 
  fixed_cart
end

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
  #cart.delete_if{|item| item[:count] == 0} #delete 0-count items after applied coupon and original item was 0
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  discount = 0.8
  cart.length.times do |index|
    if cart[index][:clearance]
      cart[index][:price] = (cart[index][:price] * discount).round(2)
    end 
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  final_cart = consolidate_cart(cart)
  final_cart = apply_coupons(final_cart, coupons)
  final_cart = apply_clearance(final_cart)
  
  checkout_price = 0 
  
  final_cart.length.times do |index|
    checkout_price += final_cart[index][:price] * final_cart[index][:count]
  end 
  if checkout_price >= 100
    checkout_price *= 0.9
  end 
  checkout_price
end
