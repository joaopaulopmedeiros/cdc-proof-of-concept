INSERT INTO sales (order_id, customer_id, product_id, quantity, unit_price, status)
VALUES (gen_random_uuid(), gen_random_uuid(), gen_random_uuid(), 3, 100.00, 'PAID');