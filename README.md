# Sales Records Database Analysis

The goal of this project is to analyze data from a sales records database for a business selling scale model cars and extract information for decision-making. The Tableau dashboard for this project can be found [here](https://public.tableau.com/app/profile/suleenwong/viz/SalesRecordsAnalysisDashboard/Story).

The database contains eight tables:

- customers: customer data
- employees: all employee information
- offices: sales office information
- orders: customers' sales orders
- orderdetails: sales order line for each sales order
- payments: customers' payment records
- products: a list of scale model cars
- productlines: a list of product line categories

The database schema is shown as follows:

![](images/db.png)


<br>

# Business insights


### **1. Which products should we order more of or less of?**

The aim is to optimize the supply and the user experience by preventing the best-selling products from going out-of-stock.

The low stock represents the quantity of each product sold divided by the quantity of product in stock. We can consider the ten lowest rates. These will be the top ten products that are (almost) out-of-stock.

The product performance represents the sum of sales per product.

Priority products for restocking are those with high product performance that are on the brink of being out of stock.

Classic cars are the priority for restocking. They sell frequently, and they are the highest-performance products.

<br>

### **2. How should we tailor marketing and communication strategies to customer behaviors?**

This involves categorizing customers: finding the VIP (very important person) customers and those who are less engaged.

VIP customers bring in the most profit for the store Less-engaged customers bring in less profit.

For example, we could organize some events to drive loyalty for the VIPs and launch a campaign for the less engaged.

<br>

### **3. How much can we spend on acquiring new customers?**

The number of clients has been decreasing since 2003, and in 2004, we had the lowest values. The year 2005, which is present in the database as well, isn't present in the table above, this means that the store has not had any new customers since September of 2004. This means it makes sense to spend money acquiring new customers.

To determine how much money we can spend acquiring new customers, we can compute the Customer Lifetime Value (LTV), which represents the average amount of money a customer generates. We can then determine how much we can spend on marketing.

The customer Lifetime Value (LTV) tells us how much profit an average customer generates during their lifetime with our store. We can use it to predict our future profit. So, if we get ten new customers next month, we'll earn 390,395 dollars, and we can decide based on this prediction how much we can spend on acquiring new customers.


<br>

# Tools: 
- PostgreSQL 
- pgadmin 4
- Tableau

<br>

# Relevant files/links:
- [create_db.sql](create_db.sql)
- [queries.sql](queries.sql)
- [Tableau dashboard](https://public.tableau.com/app/profile/suleenwong/viz/SalesRecordsAnalysisDashboard/Story)
