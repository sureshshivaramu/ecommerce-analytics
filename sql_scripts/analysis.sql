SELECT first_name 
FROM customers 
WHERE city = 'Bangalore';

SELECT product_name, unit_price 
FROM products 
WHERE category = 'Electronics';



select p.product_name,sum(o.quantity) as total_quantity_sold
from orders o join products p on 
o.product_id = p.product_id
group by p.product_name;

