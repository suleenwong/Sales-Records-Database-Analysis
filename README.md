# Sales Database

Scale model cars sales database. A business selling scale model cars.



Question 1: Which products should we order more of or less of?
Question 2: How should we tailor marketing and communication strategies to customer behaviors?
Question 3: How much can we spend on acquiring new customers?

First, we'll explore the database.

The scale model cars database schema is as follows.



It contains eight tables:

Customers: customer data
Employees: all employee information
Offices: sales office information
Orders: customers' sales orders
OrderDetails: sales order line for each sales order
Payments: customers' payment records
Products: a list of scale model cars
ProductLines: a list of product line categories

# Question 1.

Now that we know the database a little better, we can answer the first question: which products should we order more of or less of? This question refers to inventory reports, including low stock and product performance. This will optimize the supply and the user experience by preventing the best-selling products from going out-of-stock.

The low stock represents the quantity of each product sold divided by the quantity of product in stock. We can consider the ten lowest rates. These will be the top ten products that are (almost) out-of-stock.

The product performance represents the sum of sales per product.

Priority products for restocking are those with high product performance that are on the brink of being out of stock.

Classic cars are the priority for restocking. They sell frequently, and they are the highest-performance products.



# Question 2.

In the first part of this project, we explored products. Now we'll explore customer information by answering the second question: how should we match marketing and communication strategies to customer behaviors? This involves categorizing customers: finding the VIP (very important person) customers and those who are less engaged.

VIP customers bring in the most profit for the store.

Less-engaged customers bring in less profit.

For example, we could organize some events to drive loyalty for the VIPs and launch a campaign for the less engaged.

Before we begin, let's compute how much profit each customer generates.

We'll need these tables:

# Question 3.

Before answering this question, let's find the number of new customers arriving each month. That way we can check if it's worth spending money on acquiring new customers. This query helps to find these numbers.

As you can see, the number of clients has been decreasing since 2003, and in 2004, we had the lowest values. The year 2005, which is present in the database as well, isn't present in the table above, this means that the store has not had any new customers since September of 2004. This means it makes sense to spend money acquiring new customers.

To determine how much money we can spend acquiring new customers, we can compute the Customer Lifetime Value (LTV), which represents the average amount of money a customer generates. We can then determine how much we can spend on marketing.

LTV tells us how much profit an average customer generates during their lifetime with our store. We can use it to predict our future profit. So, if we get ten new customers next month, we'll earn 390,395 dollars, and we can decide based on this prediction how much we can spend on acquiring new customers.


