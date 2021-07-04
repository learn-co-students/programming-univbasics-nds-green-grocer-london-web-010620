def find_item_by_name_in_collection(name, collection)
  i = 0 
  
  while i < collection.length do 
    if name == collection[i][:item]
      return collection[i]
    end
    i += 1 
  end
  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  nu_cart = []
  i = 0 
  
  while i < cart.length do
    new_item = find_item_by_name_in_collection(cart[i][:item], nu_cart)
    if new_item != nil 
      new_item[:count] += 1 
    else new_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1 
      }
      nu_cart << new_item
    end
    i += 1 
  end
  nu_cart


  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  i = 0 
  
  while i <coupons.count do
    item_name = find_item_by_name_in_collection(coupons[i][:item], cart)
    coupon_name = "#{coupons[i][:item]} W/COUPON"
    item_coupon = find_item_by_name_in_collection(coupon_name, cart)
    if item_name && item_name[:count] >= coupons[i][:num]
      if item_coupon
        item_coupon [:count] += coupons[i][:num]
        item_name[:count] -= coupons[i][:num]
      else
        item_coupon = {
          :item => coupon_name, 
          :price => coupons[i][:cost] / coupons[i][:num],
          :count => coupons[i][:num],
          :clearance => item_name[:clearance] 
          }
          cart << item_coupon
          item_name[:count] -= coupons[i][:num]
        end
      end
      i += 1 
    end
    cart
    
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  i = 0 
  
  while i< cart.count do 
    if cart[i][:clearance] 
      cart[i][:price] = (cart[i][:price] - cart[i][:price] * 0.2)
    end
    i += 1 
  end
  cart
  
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  i = 0 
  total = 0 
  consolidated_cart = consolidate_cart(cart)
  coupon_applied_cart = apply_coupons(consolidated_cart, coupons)
  clearance_applied_cart = apply_clearance(coupon_applied_cart)
  
  while i < clearance_applied_cart.length do
    total += clearance_applied_cart[i][:price] * clearance_applied_cart[i][:count]
    i += 1 
  end
  if total > 100
    total -= total * 0.1 
  end
  total
    
  
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
