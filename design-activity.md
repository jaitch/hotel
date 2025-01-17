--Implementation A's classes:
  CartEntry
  ShoppingCart
  Order
Implementation B's classes:
  CartEntry
  ShoppingCart
  Order
Yes, they are the same.

--CartEntry handles each item put into the shopping cart. It is concerned with the unit price of each item and how many items are put into the cart.

ShoppingCart is concerned with the whole collection of items in the cart.

Order handles the cost of the entire order, including sales tax.

--Order has a ShoppingCart, and ShoppingCart has many Cart Entry objects.

--CartEntry stores unit_price and quantity.
ShoppingCart stores an array of entries.
Order calculate and stores the sum in Implementation A; this happens in ShoppingCart in Implementation B. In Implementation B, Order handles the variable 'subtotal'.

--A: Order is responsible for all of the behavior in this implementation (beyond instantiation). Its method 'total_price' calls in and manipulates data from the other two classes.
B: Order has a method to calculate price by multiplying unit price by quantity. ShoppingCart has a method to calculate price by adding up each individual entry to find the total of the cart. Order has a method to calculate and add the sales tax.

--In Implementation A, logic is NOT delegated to lower-level classes and is retained in the Order class. In Implementation B, it IS delegated to lower-level classes.
--'total_price' does directly manipulate the instance variables of other classes in Implementation A, but not in Implementation B.

--Implementation B is easier to modify because of its separation of concerns. The unit price and quantity would need to be adjusted, and the changes would trickle through the code. Implementation A, which has too many dots of glue, a la Sandi Metz, would be harder to untangle to make the modification.

--Implementation B better adheres to the single responsibility principle.

--Implementation B is more loosely coupled.

*******************

Reading everything over, I'm struck by how closely Becca's feedback overlaps with my notes-to-self--apparently I was keenly aware of what areas to improve.

My Hotel class takes on too many roles for sure.

I would like to make a Reservation class to take on a lot of the behavior that is currently being taken on by Hotel. The resulting design would make for less coupling among the classes. I may make a Block class, too, because there ended up being a lot more behavior involved with blocks than I'd anticipated when I decided to put them in the Hotel class.

I should rename the module or class, so that they aren't both "Hotel."

I should add helper methods to DRY out code.

Some local variables are made instance variables unnecessarily.

Raise exception if room not available instead of sending error message.

Make more consistent where I parse the dates.

I should be storing an array of reservations for each room, not occupied dates.

Right now front desk class is changing variables of room class--available rooms, occupied rooms. move into room class.
