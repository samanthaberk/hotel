1- What classes does each implementation include? Are the lists the same?

| Both implementations include CartEntry,ShoppingCart, and Order classes. |

2- Write down a sentence to describe each class.

| The CartEntry class initializes a new entry into the online shopping cart using information about the unit price and quantity of the item being added. Implementation B includes a method that calculates the total price based on the unit_price and quantity.

The ShoppingCart class initializes a new list of entries for the shopping cart, starting with an empty array. Implementation B includes a method to calculate the total cost of the cart by summing the price of each entry. Note: I _DO NOT UNDERSTAND_ how CartEntry instances are added to the ShoppingCart. I see that an empty array of entries is initialized with the ShoppingCart, but I don't see a method to add entry instances to this array as they are created.

The Order class initializes a new shopping cart and calculates the total price of the order by summing each entry in the cart and adding sales tax. |

3- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

| The Order class initializes a new ShoppingCart instance, which contains 0 or more CartEntry instances. |

4- What data does each class store? How (if at all) does this differ between the two implementations?

| The CartEntry class stores the unit_price and quantity of an item. The ShoppingCart stores an array of CartEntry instances. The Order class stores a new ShoppingCart instance and the total price of the ShoppingCart instance. The only difference I can see is that implementation B also has a method to calculate the price of an individual CartEntry instance and ShoppingCart instance. For CartEntry, the program does not store this in an instance or local variable. For ShoppingCart, it stores the price in the local variable _sum_.|

5- What methods does each class have? How (if at all) does this differ between the two implementations?

| CartEntry, ShoppingCart, and Order can all be initialized. The Order class can calculate the total price of the order in both implementations. The CartEntry and ShoppingCart classes also calculate the price in Implementation B.  |

6- Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
| I don't understand this question. In implementation B there is logic to compute the price in lower levels and the high level Order. In implementation A, it is only present in Order.|

Does total_price directly manipulate the instance variables of other classes?

| Again, I don't fully understand your wording. In implementation A it uses the ShoppingCart instance to iterate over each Entry instance in the array and add up the total price, but it doesn't change those instances. In instance B it calls the price method on the ShoppingCart instance to calculate a subtotal and then add the tax to find the price, but again, it does not change the variable.|

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Which implementation better adheres to the single responsibility principle?

| It would make sense to add logic in the CartEntry class to account for this. We could add a conditional or case statement that determines whether a certain quantity minimum is met, and if so, adjust the price accordingly. This would be easier to modify in implementation B, because it already has a method to calculate the price of the individual entries as well as a method to calculate the price of all items in a shopping cart using that method, and because the Order class calls the price method in its method to calculate the total price with tax of an order. |

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
