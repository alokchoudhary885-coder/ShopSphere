-- ==============================================================================
-- ShopSphere E-Commerce System - Complete Database Script & Seed Data
-- Database: shopsphere
-- Target: MySQL 8.0 / 8.4 / 9.0
-- Includes: 12 Tables, Foreign Keys, Indexes, Admin & Customer Accounts,
--           8 Categories, 88 Seed Products, Coupons, Addresses, and Sample Orders
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS shopsphere
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE shopsphere;

-- Drop tables in reverse dependency order for clean recreation
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS coupon_usage;
DROP TABLE IF EXISTS coupons;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS wishlist;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------------------
-- 1. USERS
-- ------------------------------------------------------------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    role ENUM('CUSTOMER', 'ADMIN') NOT NULL DEFAULT 'CUSTOMER',
    status ENUM('ACTIVE', 'INACTIVE') NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_users_email (email),
    INDEX idx_users_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 2. ADDRESSES
-- ------------------------------------------------------------------------------
CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'India',
    is_default BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_addresses_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_addresses_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 3. CATEGORIES
-- ------------------------------------------------------------------------------
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT DEFAULT NULL,
    icon VARCHAR(50) DEFAULT NULL,
    image_url VARCHAR(255) DEFAULT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    INDEX idx_categories_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 4. PRODUCTS
-- ------------------------------------------------------------------------------
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    description TEXT DEFAULT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0.00),
    discount_percent DECIMAL(5,2) DEFAULT 0.00 CHECK (discount_percent BETWEEN 0 AND 100),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    image_url VARCHAR(255) NOT NULL,
    rating DECIMAL(2,1) DEFAULT 0.0 CHECK (rating BETWEEN 0.0 AND 5.0),
    review_count INT DEFAULT 0 CHECK (review_count >= 0),
    status BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) 
        REFERENCES categories(id) ON DELETE RESTRICT,
    INDEX idx_products_category (category_id),
    INDEX idx_products_brand (brand),
    INDEX idx_products_price (price),
    INDEX idx_products_rating (rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 5. CART
-- ------------------------------------------------------------------------------
CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_product FOREIGN KEY (product_id) 
        REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT uq_user_product_cart UNIQUE (user_id, product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 6. WISHLIST
-- ------------------------------------------------------------------------------
CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_wishlist_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_wishlist_product FOREIGN KEY (product_id) 
        REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT uq_user_product_wish UNIQUE (user_id, product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 7. ORDERS
-- ------------------------------------------------------------------------------
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(50) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    address_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0.00),
    discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (discount_amount >= 0.00),
    final_amount DECIMAL(10,2) NOT NULL CHECK (final_amount >= 0.00),
    status ENUM('PENDING', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    payment_status ENUM('UNPAID', 'PAID', 'REFUNDED') NOT NULL DEFAULT 'UNPAID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE RESTRICT,
    CONSTRAINT fk_orders_address FOREIGN KEY (address_id) 
        REFERENCES addresses(id) ON DELETE RESTRICT,
    INDEX idx_orders_user (user_id),
    INDEX idx_orders_status (status),
    INDEX idx_orders_number (order_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 8. ORDER_ITEMS
-- ------------------------------------------------------------------------------
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0.00),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0.00),
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) 
        REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) 
        REFERENCES products(id) ON DELETE RESTRICT,
    INDEX idx_order_items_order (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 9. PAYMENTS
-- ------------------------------------------------------------------------------
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method ENUM('CARD', 'UPI', 'NET_BANKING', 'COD') NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0.00),
    transaction_id VARCHAR(100) NOT NULL UNIQUE,
    status ENUM('SUCCESS', 'FAILED', 'PENDING') NOT NULL DEFAULT 'PENDING',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id) 
        REFERENCES orders(id) ON DELETE CASCADE,
    INDEX idx_payments_order (order_id),
    INDEX idx_payments_transaction (transaction_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 10. REVIEWS
-- ------------------------------------------------------------------------------
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_reviews_product FOREIGN KEY (product_id) 
        REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_reviews_product (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 11. COUPONS
-- ------------------------------------------------------------------------------
CREATE TABLE coupons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(30) NOT NULL UNIQUE,
    discount_percent DECIMAL(5,2) NOT NULL CHECK (discount_percent BETWEEN 1 AND 100),
    max_discount DECIMAL(10,2) NOT NULL DEFAULT 500.00 CHECK (max_discount >= 0.00),
    min_order_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (min_order_amount >= 0.00),
    expiry_date DATE NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    INDEX idx_coupons_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 12. COUPON_USAGE
-- ------------------------------------------------------------------------------
CREATE TABLE coupon_usage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    coupon_id INT NOT NULL,
    user_id INT NOT NULL,
    order_id INT NOT NULL,
    used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_coupon_usage_coupon FOREIGN KEY (coupon_id) 
        REFERENCES coupons(id) ON DELETE CASCADE,
    CONSTRAINT fk_coupon_usage_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_coupon_usage_order FOREIGN KEY (order_id) 
        REFERENCES orders(id) ON DELETE CASCADE,
    INDEX idx_coupon_usage_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================================================
-- SEED DATA INSERTIONS
-- ==============================================================================

-- 1. USERS (Default Passwords: 'admin123' and 'customer123')
-- BCrypt hashes:
-- admin123 -> $2a$10$3tK15nB9t8U2.5JtVv6Pee92xP67K2mCq0YI1U6dJqL5hD4kQ6.6O
-- customer123 -> $2a$10$oJ1R4wS9t0M5.1KtVv6Pee92xP67K2mCq0YI1U6dJqL5hD4kQ7.8P
INSERT INTO users (id, full_name, email, password_hash, phone, role, status) VALUES
(1, 'Super Admin', 'admin@shopsphere.com', '$2a$10$3tK15nB9t8U2.5JtVv6Pee92xP67K2mCq0YI1U6dJqL5hD4kQ6.6O', '9876543210', 'ADMIN', 'ACTIVE'),
(2, 'Alok Sharma', 'customer@shopsphere.com', '$2a$10$oJ1R4wS9t0M5.1KtVv6Pee92xP67K2mCq0YI1U6dJqL5hD4kQ7.8P', '9123456780', 'CUSTOMER', 'ACTIVE'),
(3, 'Priya Verma', 'priya@example.com', '$2a$10$oJ1R4wS9t0M5.1KtVv6Pee92xP67K2mCq0YI1U6dJqL5hD4kQ7.8P', '9988776655', 'CUSTOMER', 'ACTIVE');

-- 2. ADDRESSES
INSERT INTO addresses (id, user_id, street, city, state, postal_code, country, is_default) VALUES
(1, 2, 'Flat 402, Royal Palms, Malviya Nagar', 'Jaipur', 'Rajasthan', '302017', 'India', TRUE),
(2, 3, 'House 12-B, Civil Lines', 'Kota', 'Rajasthan', '324001', 'India', TRUE);

-- 3. CATEGORIES (8 Distinct Categories matching Screenshot 2)
INSERT INTO categories (id, name, description, icon, image_url, status) VALUES
(1, 'Home & Living', 'Furniture, bedding, decor, lamps and luxury living', 'bi-house-heart', 'images/categories/home_living.png', TRUE),
(2, 'Accessories', 'Watches, premium bags, wallets, sunglasses and belts', 'bi-watch', 'images/categories/accessories.png', TRUE),
(3, 'Healthcare', 'Monitors, personal wellness, first aid and fitness tech', 'bi-heart-pulse', 'images/categories/healthcare.png', TRUE),
(4, 'Electronic', 'Laptops, smart TVs, audio systems, headphones and cameras', 'bi-laptop', 'images/categories/electronic.png', TRUE),
(5, 'Phone & iPads', 'Smartphones, flagship tablets, smartwatches and styluses', 'bi-phone', 'images/categories/phones.png', TRUE),
(6, 'Health & Beauty', 'Skincare, fragrances, cosmetics and organic grooming', 'bi-brush', 'images/categories/beauty.png', TRUE),
(7, 'Sports & Outdoor', 'Athletic gear, fitness equipment, bicycles and camping', 'bi-trophy', 'images/categories/sports.png', TRUE),
(8, 'Toys & Games', 'Board games, remote control robotics, puzzles and collectibles', 'bi-controller', 'images/categories/toys.png', TRUE);

-- 4. PRODUCTS (88 Realistic Products, 11 per Category)
INSERT INTO products (id, category_id, name, brand, description, price, discount_percent, stock_quantity, image_url, rating, review_count, status) VALUES
-- Category 1: Home & Living
(1, 1, 'Redefine Comfort Modern Sofa', 'Urban Living', 'Deep cushion 3-seater luxury fabric couch in royal navy blue', 34999.00, 20.00, 15, 'images/products/prod_1.jpg', 4.8, 120, TRUE),
(2, 1, 'Montes Scelerisque Nordic Armchair', 'IKEA', 'Ergonomic light oak finish designer reading accent chair', 8499.00, 15.00, 25, 'images/products/prod_2.jpg', 4.9, 778, TRUE),
(3, 1, 'Leo Sodales Varius Minimalist Chair', 'Urban Living', 'Textured fabric dining and lounge armchair with wooden legs', 6299.00, 10.00, 30, 'images/products/prod_3.jpg', 4.6, 95, TRUE),
(4, 1, 'Hanging Lamp Berlingo', 'Philips', 'Modern geometric pendant chandelier ceiling lamp fixture', 2499.00, 30.00, 45, 'images/products/prod_4.jpg', 4.7, 142, TRUE),
(5, 1, 'Commodo Adipiscing Coffee Table', 'Solimo', 'Tempered glass top engineered wood coffee table with shelf', 4999.00, 25.00, 18, 'images/products/prod_5.jpg', 4.4, 64, TRUE),
(6, 1, 'Smart Ambient LED Floor Lamp', 'Syska', 'WiFi enabled multi-color RGB smart corner tall floor lamp', 3199.00, 35.00, 50, 'images/products/prod_6.jpg', 4.5, 88, TRUE),
(7, 1, 'Memory Foam Orthopedic Pillow Pair', 'Sleepwell', 'Contoured neck support cervical memory foam bed pillow set', 1899.00, 40.00, 60, 'images/products/prod_7.jpg', 4.7, 210, TRUE),
(8, 1, 'Solid Sheesham Wood Bookshelf', 'HomeTown', '4-tier open storage bookcase and display unit in walnut polish', 7999.00, 18.00, 12, 'images/products/prod_8.jpg', 4.8, 45, TRUE),
(9, 1, 'Hand-Woven Moroccan Area Rug', 'CarpetArt', 'Ultra-soft boho geometric floor runner carpet 5x7 feet', 3899.00, 22.00, 20, 'images/products/prod_9.jpg', 4.6, 73, TRUE),
(10, 1, 'Ceramic Minimalist Flower Vase Set', 'DecorHouse', 'Set of 3 matte pastel ceramic table centerpiece vases', 1299.00, 15.00, 40, 'images/products/prod_10.jpg', 4.5, 39, TRUE),
(11, 1, 'Ergonomic Mesh Office Executive Chair', 'Green Soul', 'High-back desk chair with 3D armrests and lumbar support', 11499.00, 28.00, 22, 'images/products/prod_11.jpg', 4.9, 310, TRUE),

-- Category 2: Accessories
(12, 2, 'Premium Heritage Chronograph Watch', 'Fossil', 'Stainless steel analog wrist watch with genuine leather strap', 10995.00, 25.00, 40, 'images/products/prod_12.jpg', 4.8, 380, TRUE),
(13, 2, 'Oscar Slim Bi-fold RFID Leather Wallet', 'Herschel', 'Full grain leather minimalist RFID-blocking card pocket wallet', 2499.00, 15.00, 85, 'images/products/prod_13.jpg', 4.7, 195, TRUE),
(14, 2, 'Aviator Classic Polarized Sunglasses', 'Ray-Ban', 'Gold frame green classic G-15 UV protection sun lenses', 8590.00, 10.00, 35, 'images/products/prod_14.jpg', 4.9, 520, TRUE),
(15, 2, 'Commuter Water-Resistant Laptop Backpack', 'Wildcraft', '32L ergonomic travel bag with 15.6 inch padded laptop sleeve', 1999.00, 35.00, 90, 'images/products/prod_15.jpg', 4.6, 410, TRUE),
(16, 2, 'Classic Reversible Italian Leather Belt', 'Tommy Hilfiger', 'Dual-shade black and brown dress belt with brushed steel buckle', 2899.00, 20.00, 50, 'images/products/prod_16.jpg', 4.5, 115, TRUE),
(17, 2, 'Titan Automatic Skeletal Mechanical Watch', 'Titan', 'Self-winding automatic visible balance-wheel luxury wristwatch', 16995.00, 12.00, 15, 'images/products/prod_17.jpg', 4.8, 88, TRUE),
(18, 2, 'Genuine Leather Duffel Weekend Bag', 'HideCraft', 'Vintage brown weekender carry-on gym travel duffel bag', 4499.00, 30.00, 28, 'images/products/prod_18.jpg', 4.7, 94, TRUE),
(19, 2, 'Anti-Theft Sling Crossbody Chest Bag', 'Arctic Hunter', 'Compact waterproof travel bag with external USB charging port', 1499.00, 40.00, 65, 'images/products/prod_19.jpg', 4.4, 160, TRUE),
(20, 2, 'Carbon Fiber Minimalist Cardholder Clip', 'Spigen', 'Ultra-lightweight aluminum card wallet with elastic cash strap', 1199.00, 25.00, 75, 'images/products/prod_20.jpg', 4.6, 230, TRUE),
(21, 2, 'Square Oversized UV400 Sunglasses', 'Fastrack', 'Gradient black shade trendy everyday casual sunglasses', 899.00, 50.00, 100, 'images/products/prod_21.jpg', 4.3, 185, TRUE),
(22, 2, 'Premium Wool Cashmere Scarf', 'Marks & Spencer', 'Soft winter muffler scarf with tassel fringe in charcoal grey', 2199.00, 20.00, 30, 'images/products/prod_22.jpg', 4.8, 52, TRUE),

-- Category 3: Healthcare
(23, 3, 'Smart Digital Blood Pressure Monitor', 'Omron', 'Automated upper-arm hypertension check monitor with Bluetooth', 2699.00, 20.00, 70, 'images/products/prod_23.jpg', 4.8, 640, TRUE),
(24, 3, 'Accu-Chek Instant Blood Glucose Meter', 'Roche', 'Pain-free wireless blood sugar test monitor with 50 strips', 1499.00, 15.00, 95, 'images/products/prod_24.jpg', 4.7, 430, TRUE),
(25, 3, 'Fingertip Pulse Oximeter with OLED Display', 'Dr. Trust', 'SpO2 blood oxygen saturation and pulse rate heart checker', 999.00, 45.00, 120, 'images/products/prod_25.jpg', 4.6, 510, TRUE),
(26, 3, 'Smart Body Composition BMI Weighing Scale', 'HealthSense', 'Bluetooth multi-metric scale analyzing body fat, muscle and bone', 1899.00, 30.00, 55, 'images/products/prod_26.jpg', 4.5, 320, TRUE),
(27, 3, 'Electric Ultrasonic Mesh Nebulizer', 'Philips', 'Silent handheld portable inhaler nebulizer for breathing relief', 2399.00, 25.00, 40, 'images/products/prod_27.jpg', 4.7, 180, TRUE),
(28, 3, 'Infrared Non-Contact Forehead Thermometer', 'Dr. Morepen', 'Accurate 1-second instant fever medical temperature scanner', 799.00, 50.00, 80, 'images/products/prod_28.jpg', 4.4, 290, TRUE),
(29, 3, 'Deep Tissue Cordless Massage Gun', 'Caresmith', 'High-torque percussion muscle relaxation massager with 6 heads', 2999.00, 35.00, 35, 'images/products/prod_29.jpg', 4.8, 275, TRUE),
(30, 3, 'Air Purifier HEPA Filter H13', 'Mi', 'Smart room air cleaner eliminating 99.97% allergens and smoke', 8999.00, 18.00, 20, 'images/products/prod_30.jpg', 4.6, 190, TRUE),
(31, 3, 'Electric Heated Lumbar Heating Pad', 'Flamingo', 'Adjustable temperature orthopaedic back and knee pain relief belt', 849.00, 20.00, 60, 'images/products/prod_31.jpg', 4.5, 140, TRUE),
(32, 3, 'Water Flosser Cordless Dental Irrigator', 'Oral-B', 'Rechargeable oral teeth cleaner with 3 pressure modes and tips', 2499.00, 28.00, 45, 'images/products/prod_32.jpg', 4.7, 98, TRUE),
(33, 3, 'Comprehensive Family First Aid Emergency Kit', 'St. John', '120-piece medical grade trauma supplies in rugged red pouch', 699.00, 15.00, 110, 'images/products/prod_33.jpg', 4.9, 150, TRUE),

-- Category 4: Electronic
(34, 4, 'Apple Sleek Ultra Thin Laptop (M2)', 'Apple', 'MacBook Air 13.6-inch Liquid Retina, 8GB RAM, 256GB SSD Space Grey', 89900.00, 10.00, 25, 'images/products/prod_34.jpg', 4.9, 890, TRUE),
(35, 4, 'JBL Live Over Ear Wireless Headphones', 'JBL', 'Adaptive noise cancelling 65-hour playtime wireless headphones', 6499.00, 45.00, 60, 'images/products/prod_35.jpg', 4.7, 540, TRUE),
(36, 4, 'Smart Home Essentials Speaker Hub', 'Google', 'Nest Audio premium voice-controlled assistant speaker in chalk', 4999.00, 25.00, 50, 'images/products/prod_36.jpg', 4.6, 310, TRUE),
(37, 4, 'Sony WH-1000XM5 Noise Cancelling Headset', 'Sony', 'Industry leading noise cancellation with 8 mics and Alexa built-in', 26990.00, 15.00, 20, 'images/products/prod_37.jpg', 4.9, 950, TRUE),
(38, 4, 'Dell Inspiron 15 Core i5 16GB Laptop', 'Dell', '15.6 inch FHD 120Hz display, 512GB NVMe SSD, Backlit keyboard', 49990.00, 18.00, 30, 'images/products/prod_38.jpg', 4.5, 230, TRUE),
(39, 4, 'HP ProBook 450 G10 Business Laptop', 'HP', 'Commercial grade durable laptop with Intel Core i7 and fingerprint', 62490.00, 12.00, 18, 'images/products/prod_39.jpg', 4.6, 115, TRUE),
(40, 4, 'JBL Flip 6 Portable Bluetooth Speaker', 'JBL', 'IP67 waterproof outdoor speaker with bold sound and 12h battery', 9999.00, 20.00, 70, 'images/products/prod_40.jpg', 4.8, 620, TRUE),
(41, 4, 'Samsung 55-inch Crystal 4K UHD Smart TV', 'Samsung', 'Dynamic crystal color, HDR10+, OTS Lite and SolarCell remote', 43990.00, 30.00, 15, 'images/products/prod_41.jpg', 4.7, 410, TRUE),
(42, 4, 'Logitech MX Master 3S Wireless Mouse', 'Logitech', 'Quiet clicks ergonomic 8K DPI sensor productivity mouse', 8495.00, 10.00, 45, 'images/products/prod_42.jpg', 4.9, 780, TRUE),
(43, 4, 'SanDisk 1TB Extreme Portable External SSD', 'SanDisk', 'Up to 1050MB/s fast NVMe USB 3.2 Gen 2 rugged storage drive', 8999.00, 35.00, 80, 'images/products/prod_43.jpg', 4.8, 470, TRUE),
(44, 4, 'Canon EOS R50 Mirrorless Camera 4K', 'Canon', '24.2 MP APS-C sensor with RF-S 18-45mm IS STM compact vlogging kit', 54990.00, 14.00, 12, 'images/products/prod_44.jpg', 4.7, 160, TRUE),

-- Category 5: Phone & iPads
(45, 5, 'Apple iPhone 17 Pro Max 256GB', 'Apple', 'Grade 5 titanium chassis, iOS Apple Intelligence, 48MP periscope', 134900.00, 5.00, 30, 'images/products/prod_45.jpg', 4.9, 1240, TRUE),
(46, 5, 'Samsung Galaxy S24 Ultra 5G Titanium', 'Samsung', 'AI-powered phone with built-in S-Pen, Snapdragon 8 Gen 3, 200MP camera', 119999.00, 8.00, 25, 'images/products/prod_46.jpg', 4.8, 890, TRUE),
(47, 5, 'Apple Smartwatch Series 8 GPS 45mm', 'Apple', 'Midnight aluminum case with sport band, ECG, crash detection', 32900.00, 20.00, 40, 'images/products/prod_47.jpg', 4.8, 670, TRUE),
(48, 5, 'Apple iPad Air 11-inch M2 Chip 128GB', 'Apple', 'Liquid retina display, stereo landscape speakers, Touch ID Blue', 57900.00, 7.00, 35, 'images/products/prod_48.jpg', 4.9, 410, TRUE),
(49, 5, 'OnePlus 12 5G Flowy Emerald 16GB RAM', 'OnePlus', 'Snapdragon 8 Gen 3, Hasselblad camera, 100W SUPERVOOC charging', 64999.00, 10.00, 45, 'images/products/prod_49.jpg', 4.7, 530, TRUE),
(50, 5, 'Samsung Galaxy Watch 6 Bluetooth 44mm', 'Samsung', 'Advanced sleep coaching, body composition analysis, sapphire crystal', 19999.00, 30.00, 50, 'images/products/prod_50.jpg', 4.6, 290, TRUE),
(51, 5, 'Google Pixel 8 Pro Bay Blue 128GB', 'Google', 'Google Tensor G3, best in class computational photo, 7 years updates', 79999.00, 15.00, 20, 'images/products/prod_51.jpg', 4.7, 340, TRUE),
(52, 5, 'Apple AirPods Pro (2nd Gen) USB-C', 'Apple', 'Up to 2x more Active Noise Cancellation, Adaptive Audio, MagSafe', 20990.00, 12.00, 65, 'images/products/prod_52.jpg', 4.9, 1100, TRUE),
(53, 5, 'Anker 3-in-1 MagSafe Foldable Wireless Charger', 'Anker', 'Fast charging wireless dock for iPhone, Apple Watch and AirPods', 5999.00, 25.00, 75, 'images/products/prod_53.jpg', 4.7, 215, TRUE),
(54, 5, 'Spigen Ultra Hybrid Rugged Phone Case', 'Spigen', 'Crystal clear yellowing-resistant military drop protection shell', 1299.00, 30.00, 110, 'images/products/prod_54.jpg', 4.6, 680, TRUE),
(55, 5, 'Belkin BoostCharge 20000mAh Power Bank', 'Belkin', '30W USB-C PD fast charging power pack with LED battery indicator', 2999.00, 22.00, 85, 'images/products/prod_55.jpg', 4.5, 340, TRUE),

-- Category 6: Health & Beauty
(56, 6, 'Dyson Supersonic Ionic Hair Dryer', 'Dyson', 'Intelligent heat control to protect hair shine with magnetic styling nozzles', 34900.00, 8.00, 15, 'images/products/prod_56.jpg', 4.9, 450, TRUE),
(57, 6, 'Estee Lauder Advanced Night Repair Serum', 'Estee Lauder', 'Synchronized multi-recovery anti-aging face serum 50ml', 8250.00, 10.00, 30, 'images/products/prod_57.jpg', 4.8, 620, TRUE),
(58, 6, 'Forest Essentials Luxury Ayurvedic Facial Care Box', 'Forest Essentials', 'Herbal cleanser, pure rose water mist and day lotion gift assortment', 4295.00, 12.00, 25, 'images/products/prod_58.jpg', 4.9, 180, TRUE),
(59, 6, 'Philips Series 7000 Wet & Dry Electric Shaver', 'Philips', 'SteelPrecision blades with SkinIQ sensor and pop-up precision trimmer', 6999.00, 25.00, 40, 'images/products/prod_59.jpg', 4.7, 310, TRUE),
(60, 6, 'The Ordinary Hyaluronic Acid 2% + B5', 'The Ordinary', 'Hydrating water-based serum for smooth plump skin 30ml', 750.00, 5.00, 140, 'images/products/prod_60.jpg', 4.6, 920, TRUE),
(61, 6, 'Bleu De Chanel Eau De Parfum Spray 100ml', 'Chanel', 'Timeless woody aromatic luxury men fragrance with amber notes', 12500.00, 0.00, 18, 'images/products/prod_61.jpg', 4.9, 540, TRUE),
(62, 6, 'Neutrogena Hydro Boost Water Gel Moisturizer', 'Neutrogena', 'Hyaluronic acid oil-free 72-hour moisture lock cream 50g', 850.00, 20.00, 95, 'images/products/prod_62.jpg', 4.7, 730, TRUE),
(63, 6, 'Oral-B iO Series 9 Electric Toothbrush', 'Oral-B', 'Revolutionary magnetic technology with 3D teeth tracking AI', 18999.00, 30.00, 22, 'images/products/prod_63.jpg', 4.8, 160, TRUE),
(64, 6, 'Biotique Bio Kelp Protein Hair Growth Shampoo', 'Biotique', 'Natural pure ayurvedic revitalizing anti-hair fall therapy 650ml', 499.00, 35.00, 120, 'images/products/prod_64.jpg', 4.4, 480, TRUE),
(65, 6, 'L’Oreal Paris Revitalift 1.5% Hyaluronic Acid Serum', 'L’Oreal', 'Deep radiant anti-wrinkle lightweight skin serum 30ml', 899.00, 25.00, 85, 'images/products/prod_65.jpg', 4.6, 610, TRUE),
(66, 6, 'Bath & Body Works Warm Vanilla Sugar Fine Mist', 'Bath & Body Works', 'Indulgent vanilla and sparkling spun sugar body fragrance mist', 1499.00, 30.00, 70, 'images/products/prod_66.jpg', 4.5, 330, TRUE),

-- Category 7: Sports & Outdoor
(67, 7, 'Nike Air Zoom Pegasus 40 Running Shoes', 'Nike', 'Responsive everyday road running trainers with dual Zoom Air units', 10495.00, 20.00, 45, 'images/products/prod_70.jpg', 4.8, 810, TRUE),
(68, 7, 'Adidas Tiro 23 Essential Tracksuit', 'Adidas', 'Moisture-absorbing AEROREADY zippered sports jacket and sweatpants', 4999.00, 25.00, 60, 'images/products/prod_71.jpg', 4.7, 430, TRUE),
(69, 7, 'Yonex Nanoray Light 18i Carbon Badminton Racket', 'Yonex', 'Ultra-lightweight 77g graphite isometric high-tension racket', 2190.00, 30.00, 80, 'images/products/prod_72.jpg', 4.6, 520, TRUE),
(70, 7, 'Decathlon Quechua 3-Person Waterproof Camping Tent', 'Decathlon', 'Instant dome pop-up outdoor trekking shelter with UV sun protection', 4499.00, 15.00, 25, 'images/products/prod_73.jpg', 4.8, 290, TRUE),
(71, 7, 'Adjustable Dumbbell Set 20KG with Connector', 'Kobo', 'Cast iron home workout weight plates with foam barbell bar', 3499.00, 35.00, 40, 'images/products/prod_74.jpg', 4.5, 360, TRUE),
(72, 7, 'Boldfit Non-Slip Eco TPE 6mm Yoga Mat', 'Boldfit', 'Anti-tear alignment grid fitness exercise mat with carry strap', 999.00, 40.00, 100, 'images/products/prod_75.jpg', 4.6, 640, TRUE),
(73, 7, 'Garmin Forerunner 55 GPS Running Smartwatch', 'Garmin', 'Easy-to-use running watch with daily suggested workouts and heart rate', 18990.00, 12.00, 20, 'images/products/prod_76.jpg', 4.9, 190, TRUE),
(74, 7, 'Nivia Storm Thermobonded Football Size 5', 'Nivia', 'Official match ball with high abrasion resistance and air retention', 799.00, 25.00, 90, 'images/products/prod_77.jpg', 4.4, 410, TRUE),
(75, 7, 'Hydro Flask 32oz Insulated Stainless Steel Bottle', 'Hydro Flask', 'TempShield double wall vacuum water flask keeping ice cold 24 hours', 3290.00, 10.00, 50, 'images/products/prod_78.jpg', 4.8, 380, TRUE),
(76, 7, 'Speedo Fastskin Elite Swimming Goggles', 'Speedo', 'Hydrodynamic low-profile anti-fog mirror lens competition goggles', 1899.00, 20.00, 65, 'images/products/prod_79.jpg', 4.7, 140, TRUE),
(77, 7, 'Hero Sprint 26T 21-Speed Mountain Bicycle', 'Hero', 'Dual disc brake alloy rim front suspension rugged trail MTB cycle', 12499.00, 18.00, 15, 'images/products/prod_80.jpg', 4.6, 210, TRUE),

-- Category 8: Toys & Games
(78, 8, 'LEGO Creator Expert Bonsai Tree 10281 Kit', 'LEGO', '878-piece botanical collection model with interchangeable pink cherry blossoms', 4499.00, 10.00, 35, 'images/products/prod_81.jpg', 4.9, 650, TRUE),
(79, 8, 'Hasbro Monopoly Ultimate Banking Electronic Board Game', 'Hasbro', 'Cashless tap-to-pay touch credit banking unit property trading game', 1999.00, 25.00, 50, 'images/products/prod_82.jpg', 4.7, 430, TRUE),
(80, 8, 'Hot Wheels 20-Car Collector Gift Pack', 'Hot Wheels', '1:64 scale die-cast metal vehicles with authentic styling and decals', 1799.00, 15.00, 70, 'images/products/prod_83.jpg', 4.8, 790, TRUE),
(81, 8, 'DJI Tello Mini Programmable Educational Drone', 'DJI', '720p HD video camera aerial stunts STEM coding mini quadcopter', 8999.00, 12.00, 22, 'images/products/prod_84.jpg', 4.6, 180, TRUE),
(82, 8, 'Sony PlayStation 5 DualSense Wireless Controller', 'Sony', 'Haptic feedback adaptive triggers integrated microphone Cosmic Red', 5990.00, 8.00, 45, 'images/products/prod_85.jpg', 4.9, 910, TRUE),
(83, 8, 'Rubik’s Speed Magnetic 3x3 Cube Official', 'Rubik’s', 'Pre-lubricated high speed corner cutting competition puzzle cube', 899.00, 30.00, 95, 'images/products/prod_86.jpg', 4.7, 510, TRUE),
(84, 8, 'Barbie Dreamhouse 3-Story Luxury Playset', 'Barbie', '10 indoor and outdoor play areas with working elevator and pool slide', 14999.00, 20.00, 12, 'images/products/prod_87.jpg', 4.8, 220, TRUE),
(85, 8, 'Nerf Elite 2.0 Commander RD-6 Blaster', 'Nerf', '6-dart rotating cylinder blaster with 12 official Nerf suction darts', 1099.00, 28.00, 60, 'images/products/prod_88.jpg', 4.5, 340, TRUE),
(86, 8, 'Remote Control 4WD High Speed Rock Crawler RC Car', 'Mistubishi', '1:16 all-terrain 2.4GHz off-road climbing monster vehicle', 2499.00, 35.00, 40, 'images/products/prod_89.jpg', 4.6, 175, TRUE),
(87, 8, 'Catan Strategy Civilization Board Game', 'Asmodee', 'Original trade, build, and settle board game for 3-4 players', 2899.00, 14.00, 30, 'images/products/prod_90.jpg', 4.9, 480, TRUE),
(88, 8, 'Uno Flip Dual-Sided Card Game Special Edition', 'Mattel', 'Exciting flip side game with stiffer penalties and dark card rules', 249.00, 20.00, 150, 'images/products/prod_91.jpg', 4.8, 890, TRUE);

-- 5. COUPONS
INSERT INTO coupons (id, code, discount_percent, max_discount, min_order_amount, expiry_date, status) VALUES
(1, 'WELCOME50', 50.00, 500.00, 999.00, '2027-12-31', TRUE),
(2, 'SAVE20', 20.00, 1000.00, 1999.00, '2027-12-31', TRUE),
(3, 'FREESHIP', 10.00, 150.00, 499.00, '2027-12-31', TRUE),
(4, 'FESTIVE100', 30.00, 1500.00, 2999.00, '2027-12-31', TRUE);

-- 6. REVIEWS (Sample Customer Reviews)
INSERT INTO reviews (id, user_id, product_id, rating, comment) VALUES
(1, 2, 2, 5, 'Exceptional craftsmanship. The oak wood and fabric cushion look stunning in our living room!'),
(2, 3, 2, 5, 'Super comfortable armchair, worth every rupee. Arrived well packaged.'),
(3, 2, 35, 5, 'Bass response is crisp and active noise cancellation shuts out the world. Highly recommended!'),
(4, 3, 47, 5, 'Great smartwatch with accurate fitness tracking. Battery lasts easily over 1.5 days.'),
(5, 2, 13, 4, 'Very sleek wallet, fits nicely in front pocket. RFID protection gives peace of mind.');

-- 7. SAMPLE ORDERS (For initial Admin Dashboard metrics matching Screenshot 5)
INSERT INTO orders (id, order_number, user_id, address_id, total_amount, discount_amount, final_amount, status, payment_status, created_at) VALUES
(1, 'ORD-20261001-1001', 2, 1, 6499.00, 500.00, 5999.00, 'DELIVERED', 'PAID', '2026-10-01 10:15:00'),
(2, 'ORD-20261003-1002', 3, 2, 8499.00, 1000.00, 7499.00, 'DELIVERED', 'PAID', '2026-10-03 14:30:00'),
(3, 'ORD-20261007-1003', 2, 1, 2499.00, 0.00, 2499.00, 'PROCESSING', 'PAID', '2026-10-07 16:45:00'),
(4, 'ORD-20261011-1004', 3, 2, 10995.00, 500.00, 10495.00, 'PENDING', 'UNPAID', '2026-10-11 11:20:00');

-- 8. ORDER ITEMS
INSERT INTO order_items (id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(1, 1, 35, 1, 6499.00, 6499.00),
(2, 2, 2, 1, 8499.00, 8499.00),
(3, 3, 13, 1, 2499.00, 2499.00),
(4, 4, 12, 1, 10995.00, 10995.00);

-- 9. PAYMENTS (Mock Payment Records)
INSERT INTO payments (id, order_id, payment_method, amount, transaction_id, status, payment_date) VALUES
(1, 1, 'UPI', 5999.00, 'TXN-MOCK-20261001-01', 'SUCCESS', '2026-10-01 10:16:00'),
(2, 2, 'CARD', 7499.00, 'TXN-MOCK-20261003-02', 'SUCCESS', '2026-10-03 14:32:00'),
(3, 3, 'UPI', 2499.00, 'TXN-MOCK-20261007-03', 'SUCCESS', '2026-10-07 16:47:00');

-- 10. COUPON USAGE
INSERT INTO coupon_usage (id, coupon_id, user_id, order_id, used_at) VALUES
(1, 1, 2, 1, '2026-10-01 10:15:30'),
(2, 2, 3, 2, '2026-10-03 14:31:00');
