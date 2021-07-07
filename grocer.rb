require 'pry'

def find_item_by_name_in_collection(name, collection)
 d = 0 
 while d < collection.length do
   item = collection[d][:item]
   if name === item
     return collection[d]
 end
   d += 1
 end
end

def consolidate_cart(cart)
new_cart = []
d = 0 
while d < cart.length do
  new_cart_item = find_item_by_name_in_collection(cart[d][:item], new_cart)
  if new_cart_item
    new_cart_item[:count] += 1 
  else 
    new_cart_item = {
      item: cart[d][:item],
      price: cart[d][:price],
      clearance: cart[d][:clearance],
      count: 1
    }
    new_cart << new_cart_item
  end
  d += 1 
end
new_cart
end

def apply_coupons(cart, coupons)
d = 0 
while d < coupons.length do 
  cart_item = find_item_by_name_in_collection(coupons[d][:item], cart)
  couponed_item_name = "#{coupons[d][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
  if cart_item && cart_item[:count] >= coupons[d][:num]
  if cart_item_with_coupon
    cart_item_with_coupon[:count] += coupons[d][:num]
    cart_item[:count] -= coupons[d][:num]
  else
    cart_item_with_coupon = {
      item: couponed_item_name,
      price: coupons[d][:cost] / coupons[d][:num],
      count: coupons[d][:num],
      clearance: cart_item[:clearance]
    }
    cart << cart_item_with_coupon
    cart_item[:count] -= coupons[d][:num]
  end
end
d += 1 
end
cart
end

def apply_clearance(cart)
d = 0 
while d < cart.length do
  if cart[d][:clearance]
    cart[d][:price] = (cart[d][:price] - (cart[d][:price] * 0.2)).round(2)
  end
  d += 1 
end
cart
end

def checkout(cart, coupons)
checkout_cart = consolidate_cart(cart)
coupon_cart = apply_coupons(checkout_cart, coupons)
final_cart = apply_clearance(coupon_cart)

d = 0 
total = 0
while d < final_cart.length do
  total += final_cart[d][:price] * final_cart[d][:count]
  d += 1
end
if total > 100
  total -= (total * 0.10)
end
total
end
