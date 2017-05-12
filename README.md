[Jump to Solution](#examples) | [Task](#task) | [Approach](#approach) | [Usage](#usage) | [Examples](#examples)

# Honeycomb Engineering Test - Makers Edition

## Task

Extend Honeycomb's system for delivering ad materials to broadcasters by introducing a mechanism for applying discounts to orders.

Ad materials are identified by a clock number:

* `WNP/SWCL001/010`
* `ZDW/EOWW005/010`

### Broadcasters:

* Viacom
* Disney
* Discovery
* ITV
* Channel 4
* Bike Channel
* Horse and Country

### Delivery types:

* Standard Delivery: $10
* Express Delivery: $20

### Discounts

* Send 2 or more materials via express delivery and the price for express delivery drops to $15
* Spend over $30 to get 10% off

## Approach

### User Stories
```
As a user
So that I can offer the best price
I would like to create promotional discounts

As a user
So that I can check the order is correct
I would like to see a sub-total before any discounts are applied

As a user
So that I can update my offers seasonally
I would like to be able to easily amend promotions in the future
```

Using a TDD approach, the design of the additional functionality evolved starting with the creation of a Promo class - which in turn led to two very distinct promotional classes which differ in the way they calculate how an order qualifies for discount.

## Usage

To create new discounts, create a new instance of each promo class:

```
2.3.3 :004 > express_promo = PromoMultiBuy.new('Express MultiBuy Offer', 5)
 => #<PromoMultiBuy:0x007fba0b2d3468 @description="Express MultiBuy Offer", @multibuy_discount=5>
2.3.3 :005 > discount_promo = PromoDiscount.new('10 off 30 spend', 30, 10)
 => #<PromoDiscount:0x007fba0b2ab918 @description="10 off 30 spend", @min_spend=30, @pct_discount=10>
```

These promos can then be added when instantiating a new Order:
```
2.3.3 :006 > my_order = Order.new(express_promo, discount_promo)
 => #<Order:0x007fba0b929fd8 @promo_one=#<PromoMultiBuy:0x007fba0b2d3468 @description="Express MultiBuy Offer", @multibuy_discount=5>, @promo_two=#<PromoDiscount:0x007fba0b2ab918 @description="10 off 30 spend", @min_spend=30, @pct_discount=10>, @items={}>
```

I have amended Order to account for numerous clock numbers in any one class instance, and materials can now be inputted via the class's *add* method, along with broadcaster and delivery type:

```
2.3.3 :007 > clock_number_one = Material.new 'WNP/SWCL001/010'
 => #<Material:0x007fba0b9208e8 @identifier="WNP/SWCL001/010">
2.3.3 :008 > viacom = Broadcaster.new(1, 'Viacom')
 => #<Broadcaster:0x007fba0b28b488 @id=1, @name="Viacom">
2.3.3 :009 > standard_delivery = Delivery.new(:standard, 10.0)
 => #<Delivery:0x007fba0b8f1a98 @name=:standard, @price=10.0>
2.3.3 :010 > my_order.add clock_number_one, viacom, standard_delivery
 => [#<Item:0x007fba0b8e83a8 @broadcaster=#<Broadcaster:0x007fba0b28b488 @id=1, @name="Viacom">, @delivery=#<Delivery:0x007fba0b8f1a98 @name=:standard, @price=10.0>>]
```

Each order stores the details as values in a hash grouped by clock number (keys). These can be accessed by calling the class's *items* property:

```
2.3.3 :040 > order.items
 => {#<Material:0x007fba0b13d7e8 @identifier="WNP/SWCL001/010">=>[#<Item:0x007fba0b17ac60 @broadcaster=#<Broadcaster:0x007fba0b865980 @id=2, @name="Disney">, @delivery=#<Delivery:0x007fba0b1f24b8 @name=:standard, @price=10.0>>], #<Material:0x007fba0b82e048 @identifier="ZDW/EOWW005/010">=>[#<Item:0x007fba0b132dc0 @broadcaster=#<Broadcaster:0x007fba0b875650 @id=1, @name="Viacom">, @delivery=#<Delivery:0x007fba0b88ec68 @name=:express, @price=20.0>>]}
```

Finally, to see the order summary and check the calculated amounts, print the Order class's *output* method:
```
Order summary:
material             | broadcaster          | delivery | price
-------------------- | -------------------- | -------- | --------
WNP/SWCL001/010      | Disney               | standard | $10.0
ZDW/EOWW005/010      | Disney               | express  | $20.0
ZDW/EOWW005/010      | Discovery            | express  | $20.0
-------------------- | -------------------- | -------- | --------
Sub-total: $50.0
Total: $36.0
```
The price column and sub-total indicates the price before discounts have been applied. The total amount includes all promotions included in the Order. The printed table has also been updated to display multiple clock numbers in one order.

## Examples

The following examples are both valid:

* send `WNP/SWCL001/010` to Disney, Discovery, Viacom via Standard Delivery and Horse and Country via Express Delivery - based on the defined Discounts the total should be $45.00:
```
Order summary:
material             | broadcaster          | delivery | price
-------------------- | -------------------- | -------- | --------
WNP/SWCL001/010      | Disney               | standard | $10.0
WNP/SWCL001/010      | Discovery            | standard | $10.0
WNP/SWCL001/010      | Viacom               | standard | $10.0
WNP/SWCL001/010      | Horse and Country    | express  | $20.0
-------------------- | -------------------- | -------- | --------
Sub-total: $50.0
Total: $45.0
```  

* send `ZDW/EOWW005/010` to Disney, Discovery, Viacom via Express Delivery - based on the defined Discounts the total should be $40.50:
```
Order summary:
material             | broadcaster          | delivery | price
-------------------- | -------------------- | -------- | --------
ZDW/EOWW005/010      | Disney               | express  | $20.0
ZDW/EOWW005/010      | Discovery            | express  | $20.0
ZDW/EOWW005/010      | Viacom               | express  | $20.0
-------------------- | -------------------- | -------- | --------
Sub-total: $60.0
Total: $40.5
```
