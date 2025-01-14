USE `IBA_3` ;

-- Р’С‹Р±РѕСЂРєР° РѕРїР»Р°С‡РµРЅРЅС‹С… Р·Р°РєР°Р·РѕРІ РЅР° РєРѕРЅРєСЂРµС‚РЅСѓСЋ РґР°С‚Сѓ
SELECT * 
FROM client_order
WHERE client_cart_status_id = 6 
AND DATE(update_time) = '2024-11-06';

-- РІС‹Р±РѕСЂРєР° РѕРїР»Р°С‡РµРЅРЅС‹С… Р·Р°РєР°Р·РѕРІ РЅР° РґР°С‚С‹ РІ РїСЂРѕРјРµР¶СѓС‚РєРµ
SELECT * 
FROM client_order
WHERE client_cart_status_id = 6 
AND DATE(update_time) BETWEEN '2024-11-01' AND '2024-11-10';

-- Р’С‹Р±РѕСЂРєР° РѕРїР»Р°С‡РµРЅРЅС‹С… Р·Р°РєР°Р·РѕРІ РЅР° РїСЂРµРґС‹РґСѓС‰СѓСЋ РЅРµРґРµР»СЋ 
SELECT * 
FROM client_order
WHERE client_cart_status_id = 6 
AND update_time >= CURDATE() - INTERVAL 7 DAY;

-- Р’С‹Р±РѕСЂРєР° РѕРїР»Р°С‡РµРЅРЅС‹С… Р·Р°РєР°Р·РѕРІ Р·Р° РїСЂРµРґС‹РґСѓС‰РёР№ РјРµСЃСЏС†
SELECT * 
FROM client_order
WHERE client_cart_status_id = 6 
AND create_time >= CURDATE() - INTERVAL 1 MONTH;

-- Р’С‹Р±РѕСЂРєР° РѕРїР»Р°С‡РµРЅРЅС‹С… Р·Р°РєР°Р·РѕРІ Р·Р° РїСЂРµРґС‹РґСѓС‰РёР№ РіРѕРґ 
SELECT * 
FROM client_order
WHERE client_cart_status_id = 6 
AND create_time >= CURDATE() - INTERVAL 1 YEAR;

-- Р’С‹Р±РѕСЂРєР° РїРѕ СЃСѓРјРјР°Рј РєРѕСЂР·РёРЅ РєР»РёРµРЅС‚РѕРІ Р±РѕР»СЊС€Рµ СЃСЂРµРґРЅРµРіРѕ Р·РЅР°С‡РµРЅРёСЏ СЃСѓРјРј РєРѕСЂР·РёРЅ РєР»РёРµРЅС‚РѕРІ
SELECT 
    COUNT(*) AS total_count,  
    SUM(amount_product_sum) AS total_sum  
FROM 
    client_order_detail
WHERE 
    amount_product_sum > (
    SELECT AVG(amount_product_sum) 
    FROM client_order_detail);

--  Р’С‹Р±РѕСЂРєР° РїРѕ СЃСѓРјРјР°Рј Рё РєРѕР»РёС‡РµСЃС‚РІСѓ РѕРїР»Р°С‡РµРЅРЅС‹С… Р·Р°РєР°Р·РѕРІ Р±РѕР»СЊС€Рµ СЃСЂРµРґРЅРµРіРѕ Р·РЅР°С‡РµРЅРёСЏ РїРѕ РѕРїР»Р°С‡РµРЅРЅС‹Рј Р·Р°РєР°Р·Р°Рј 
SELECT 
    COUNT(*) AS total_count,
    SUM(amount_product_sum) AS total_sum  
FROM 
    client_order_detail AS cod
JOIN 
    client_order AS co 
    ON cod.client_cart_id = co.client_cart_id  
WHERE 
    cod.amount_product_sum > (
      SELECT AVG(amount_product_sum) 
      FROM client_order_detail)
    AND co.client_cart_status_id = 6;

-- РЎСЂРµРґРЅСЏСЏ СЃСѓРјРјР° РїСЂРѕРґР°Р¶ РґР»СЏ РѕРїСЂРµРґРµР»РµРЅРЅРѕР№ РєР°С‚РµРіРѕСЂРёРё С‚РѕРІР°СЂРѕРІ Р·Р° СѓРєР°Р·Р°РЅРЅС‹Р№ РїРµСЂРёРѕРґ 
SELECT 
    AVG(cod.amount_product_sum) AS avg_sale_amount  -- РЎСЂРµРґРЅСЏСЏ СЃСѓРјРјР° РїСЂРѕРґР°Р¶Рё
FROM 
    client_order_detail AS cod
JOIN 
    client_order AS co 
    ON cod.client_cart_id = co.client_cart_id  -- РџСЂРёСЃРѕРµРґРёРЅРµРЅРёРµ С‚Р°Р±Р»РёС†С‹ СЃ Р·Р°РєР°Р·Р°РјРё
JOIN 
    product p 
    ON cod.product_id = p.product_id  -- РџСЂРёСЃРѕРµРґРёРЅРµРЅРёРµ С‚Р°Р±Р»РёС†С‹ СЃ С‚РѕРІР°СЂР°РјРё
WHERE 
    p.product_group_id = 1  
    AND co.client_cart_status_id = 6
    AND co.update_time BETWEEN '2024-01-01' AND '2024-11-11'; 

--  РЎСЂРµРґРЅСЏСЏ СЃСѓРјРјР° РїСЂРѕРґР°Р¶ РґР»СЏ РѕРїСЂРµРґРµР»РµРЅРЅРѕР№ РєР°С‚РµРіРѕСЂРёРё С‚РѕРІР°СЂРѕРІ Р·Р° СѓРєР°Р·Р°РЅРЅС‹Р№ РїРµСЂРёРѕРґ
SELECT 
    pg.group_name, 
    AVG(cod.amount_product_sum) AS avg_sale_amount 
FROM 
    client_order_detail AS cod
JOIN 
    client_order AS co 
    ON cod.client_cart_id = co.client_cart_id  
JOIN 
    product p 
    ON cod.product_id = p.product_id  
JOIN 
    product_group AS pg
    ON p.product_group_id = pg.product_group_id  
WHERE 
    p.product_group_id = 1  
    AND co.client_cart_status_id = 6  
    AND co.update_time BETWEEN '2024-01-01' AND '2024-11-11'  
GROUP BY 
    pg.group_name;  

-- РЎСЂРµРґРЅСЏСЏ СЃСѓРјРјР° РїСЂРѕРґР°Р¶ РѕРїСЂРµРґРµР»РµРЅРЅРѕРіРѕ С‚РѕРІР°СЂР° Р·Р° СѓРєР°Р·Р°РЅРЅС‹Р№ РїРµСЂРёРѕРґ 
SELECT 
    p.product_name, AVG(cod.amount_product_sum) AS avg_sale_amount  
FROM 
    client_order_detail AS cod
JOIN 
    client_order AS co 
    ON cod.client_cart_id = co.client_cart_id  
JOIN 
    product p 
    ON cod.product_id = p.product_id  
WHERE 
    p.product_id = 1  
    AND co.client_cart_status_id = 6
    AND co.update_time BETWEEN '2024-01-01' AND '2024-11-11'
GROUP BY 
    p.product_name; 

-- РљРѕР»РёС‡РµСЃС‚РІРѕ С‚РѕРІР°СЂРЅС‹С… РЅР°РёРјРµРЅРѕРІР°РЅРёР№ РІ РєР°Р¶РґРѕР№ РіСЂСѓРїРїРµ 
SELECT 
    pg.group_name,    
    COUNT(p.product_id) AS product_count 
FROM 
    product_group AS pg
LEFT JOIN 
    product AS p
    ON pg.product_group_id = p.product_group_id  
GROUP BY 
    pg.group_name; 

-- Р’С‹Р±РѕСЂРєР° РіСЂСѓРїРї С‚РѕРІР°СЂРѕРІ, Сѓ РєРѕС‚РѕСЂС‹С… РЅРµС‚ С‚РѕРІР°СЂРѕРІ 
SELECT 
    pg.product_group_id,      
    pg.group_name             
FROM 
    product_group AS pg
LEFT JOIN 
    product AS p
    ON pg.product_group_id = p.product_group_id  
WHERE 
    p.product_id IS NULL; 

-- Р’Р°СЂРёР°РЅС‚ 2 
SELECT 
    pg.product_group_id,      
    pg.group_name            
FROM 
    product_group AS pg
WHERE 
     NOT EXISTS (         -- РїСЂРѕРІРµСЂСЏРµС‚, С‡С‚Рѕ РІ РїРѕРґР·Р°РїСЂРѕСЃРµ РќР•Рў РЅРё РѕРґРЅРѕР№ СЃС‚СЂРѕРєРё
        SELECT 1
        FROM product AS p
        WHERE p.product_group_id = pg.product_group_id
    );

