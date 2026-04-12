
	DROP DATABASE IF EXISTS DyleeSeaFood_shop;
	CREATE DATABASE DyleeSeaFood_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
	USE DyleeSeaFood_shop;

	-- ============================================================
	-- 1. PHÂN QUYỀN
	-- ============================================================
	CREATE TABLE roles (
		id   INT AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(50) NOT NULL
	);

	-- ============================================================
	-- 2. HẠNG KHÁCH HÀNG
	-- ============================================================
	CREATE TABLE customer_tiers (
		id               INT AUTO_INCREMENT PRIMARY KEY,
		name             VARCHAR(50)   NOT NULL,
		discount_percent DECIMAL(5,2)  DEFAULT 0.00,
		min_spent        DECIMAL(12,2) DEFAULT 0.00
	);

	-- ============================================================
	-- 3. DANH MỤC SẢN PHẨM
	-- (thêm icon, image_url, sort_order cho sidebar)
	-- ============================================================
	CREATE TABLE categories (
		id          INT AUTO_INCREMENT PRIMARY KEY,
		name        VARCHAR(100),
		description TEXT,
		icon        VARCHAR(60)  DEFAULT 'bi-fish',
		image_url   TEXT,
		sort_order  INT          DEFAULT 0
	);

	-- ============================================================
	-- 4. NHÀ CUNG CẤP
	-- ============================================================
	CREATE TABLE suppliers (
		id      INT AUTO_INCREMENT PRIMARY KEY,
		name    VARCHAR(100),
		phone   VARCHAR(20),
		email   VARCHAR(100),
		address TEXT
	);

	-- ============================================================
	-- 5. NGƯỜI DÙNG & KHÁCH HÀNG
	-- ============================================================
	CREATE TABLE users (
		id         INT AUTO_INCREMENT PRIMARY KEY,
		username   VARCHAR(100) UNIQUE,
		password   VARCHAR(255),
		role_id    INT,
		is_active  TINYINT(1)  DEFAULT 1,
		created_at DATETIME    DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (role_id) REFERENCES roles(id)
	);

	CREATE TABLE customers (
		id          INT AUTO_INCREMENT PRIMARY KEY,
		name        VARCHAR(100),
		email       VARCHAR(100),
		phone       VARCHAR(20),
		avatar_url  TEXT,
		user_id     INT,
		tier_id     INT          DEFAULT 1,
		total_spent DECIMAL(12,2) DEFAULT 0.00,
		created_at  DATETIME     DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (user_id) REFERENCES users(id),
		FOREIGN KEY (tier_id) REFERENCES customer_tiers(id)
	);

	-- ============================================================
	-- 6. ĐỊA CHỈ GIAO HÀNG
	-- (nhiều địa chỉ / khách hàng)
	-- ============================================================
	CREATE TABLE addresses (
		id          INT AUTO_INCREMENT PRIMARY KEY,
		customer_id INT NOT NULL,
		full_name   VARCHAR(100),
		phone       VARCHAR(20),
		address     VARCHAR(255),
		ward        VARCHAR(100),
		district    VARCHAR(100),
		city        VARCHAR(100),
		is_default  TINYINT(1) DEFAULT 0,
		FOREIGN KEY (customer_id) REFERENCES customers(id)
	);

	-- ============================================================
	-- 7. SẢN PHẨM
	-- (thêm description, slug, is_active, is_featured)
	-- ============================================================
	CREATE TABLE products (
		id          INT AUTO_INCREMENT PRIMARY KEY,
		name        VARCHAR(100),
		description TEXT,
		slug        VARCHAR(150) UNIQUE,
		price       DECIMAL(10,2),
		stock       DECIMAL(10,2),
		unit        VARCHAR(20)  DEFAULT 'kg',
		category_id INT,
		is_active   TINYINT(1)   DEFAULT 1,
		is_featured TINYINT(1)   DEFAULT 0,
		created_at  DATETIME     DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (category_id) REFERENCES categories(id)
	);

	CREATE TABLE product_images (
		id         INT AUTO_INCREMENT PRIMARY KEY,
		product_id INT,
		image_url  TEXT,
		is_primary TINYINT(1) DEFAULT 0,
		sort_order INT        DEFAULT 0,
		FOREIGN KEY (product_id) REFERENCES products(id)
	);

	-- ============================================================
	-- 8. KHO HÀNG
	-- ============================================================
	CREATE TABLE inventory (
		id           INT AUTO_INCREMENT PRIMARY KEY,
		product_id   INT,
		supplier_id  INT,
		quantity     DECIMAL(10,2),
		import_price DECIMAL(10,2),
		note         TEXT,
		last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (product_id)  REFERENCES products(id),
		FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
	);

	-- ============================================================
	-- 9. BANNER / SLIDER TRANG CHỦ
	-- ============================================================
	CREATE TABLE banners (
		id         INT AUTO_INCREMENT PRIMARY KEY,
		title      VARCHAR(200),
		image_url  TEXT         NOT NULL,
		link_url   TEXT,
		sort_order INT          DEFAULT 0,
		is_active  TINYINT(1)  DEFAULT 1,
		created_at DATETIME    DEFAULT CURRENT_TIMESTAMP
	);

	-- ============================================================
	-- 10. GIỎ HÀNG
	-- ============================================================
	CREATE TABLE carts (
		id          INT AUTO_INCREMENT PRIMARY KEY,
		customer_id INT,
		created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (customer_id) REFERENCES customers(id)
	);

	CREATE TABLE cart_items (
		id         INT AUTO_INCREMENT PRIMARY KEY,
		cart_id    INT,
		product_id INT,
		quantity   DECIMAL(10,2),
		FOREIGN KEY (cart_id)    REFERENCES carts(id),
		FOREIGN KEY (product_id) REFERENCES products(id)
	);

	-- ============================================================
	-- 11. ĐƠN HÀNG
	-- (thêm address_id, shipping_fee, note + status ENUM)
	-- ============================================================
	CREATE TABLE orders (
		id           INT AUTO_INCREMENT PRIMARY KEY,
		customer_id  INT,
		address_id   INT,
		order_date   DATETIME DEFAULT CURRENT_TIMESTAMP,
		status       ENUM(
					   'Pending',
					   'Confirmed',
					   'Processing',
					   'Shipping',
					   'Delivered',
					   'Cancelled',
					   'Refunded'
					 ) DEFAULT 'Pending',
		subtotal     DECIMAL(10,2) DEFAULT 0.00,
		shipping_fee DECIMAL(10,2) DEFAULT 0.00,
		total        DECIMAL(10,2) DEFAULT 0.00,
		note         TEXT,
		FOREIGN KEY (customer_id) REFERENCES customers(id),
		FOREIGN KEY (address_id)  REFERENCES addresses(id)
	);

	CREATE TABLE order_items (
		id         INT AUTO_INCREMENT PRIMARY KEY,
		order_id   INT,
		product_id INT,
		quantity   DECIMAL(10,2),
		price      DECIMAL(10,2),
		FOREIGN KEY (order_id)   REFERENCES orders(id),
		FOREIGN KEY (product_id) REFERENCES products(id)
	);

	-- ============================================================
	-- 12. THANH TOÁN
	-- (thêm amount, transaction_id + method/status ENUM)
	-- ============================================================
	CREATE TABLE payments (
		id             INT AUTO_INCREMENT PRIMARY KEY,
		order_id       INT,
		method         ENUM('COD','bank_transfer','momo','vnpay','zalopay') DEFAULT 'COD',
		status         ENUM('Unpaid','Paid','Failed','Refunded')            DEFAULT 'Unpaid',
		amount         DECIMAL(10,2),
		transaction_id VARCHAR(100),
		paid_at        DATETIME,
		FOREIGN KEY (order_id) REFERENCES orders(id)
	);

	-- Roles
	INSERT INTO roles (name) VALUES ('Admin'), ('Staff'), ('Customer');

	-- Hạng khách hàng
	INSERT INTO customer_tiers (name, discount_percent, min_spent) VALUES
	('Thành viên thường', 0.00,      0.00),
	('Khách hàng VIP',    5.00,  5000000.00),
	('Khách hàng VVIP',  10.00, 20000000.00);

	-- Danh mục sản phẩm
	INSERT INTO categories (name, description, icon, sort_order) VALUES
	('Tôm',        'Các loại tôm tươi sống: tôm hùm, tôm sú...',           'bi-bug-fill',    1),
	('Cua & Ghẹ',  'Cua thịt, cua gạch Cà Mau và ghẹ xanh...',            'bi-award-fill',  2),
	('Cá Hải Sản', 'Cá hồi, cá bớp đánh bắt trong ngày...',               'bi-water',       3),
	('Ốc & Ngao',  'Các loại ốc hương, ngao hai cồi...',                   'bi-circle-fill', 4);

	-- Nhà cung cấp
	INSERT INTO suppliers (name, phone, email, address) VALUES
	('Vựa Hải Sản Miền Trung', '02363123456', 'vua@mientrung.vn', 'Đà Nẵng'),
	('Hải Sản Phan Thiết',      '02523123456', 'hs@phanthiet.vn',  'Bình Thuận');

	-- Users (password thực tế phải hash bằng BCrypt)
	INSERT INTO users (username, password, role_id, is_active) VALUES
	('admin_dylee', '$2a$10$placeholder_hash', 1, 1),
	('nv_banhang',  '$2a$10$placeholder_hash', 2, 1),
	('khach_test',  '$2a$10$placeholder_hash', 3, 1);

	-- Customers
	INSERT INTO customers (name, email, phone, user_id, tier_id) VALUES
	('Admin Quản Trị',     'admin@gmail.com', '0999999999', 1, 3),
	('Nhân Viên Bán Hàng', 'staff@gmail.com', '0888888888', 2, 1),
	('Nguyễn Văn Khách',   'khach@gmail.com', '0912345678', 3, 1);

	-- Địa chỉ giao hàng mẫu
	INSERT INTO addresses (customer_id, full_name, phone, address, ward, district, city, is_default) VALUES
	(3, 'Nguyễn Văn Khách', '0912345678', '123 Đường ABC', 'Phường Bến Nghé', 'Quận 1', 'TP. Hồ Chí Minh', 1);

	-- Sản phẩm
	INSERT INTO products (name, description, slug, price, stock, unit, category_id, is_active, is_featured) VALUES
	('Tôm Hùm Bông',
	 'Tôm hùm bông tươi sống, size 600–800g/con, thịt chắc ngọt đậm đà.',
	 'tom-hum-bong', 1500000.00, 20.00, 'kg', 1, 1, 1),

	('Tôm Sú Cọp',
	 'Tôm sú cọp đen, size 20–25 con/kg, tươi đánh bắt hàng ngày từ Miền Trung.',
	 'tom-su-cop', 450000.00, 50.50, 'kg', 1, 1, 1),

	('Cua Gạch Cà Mau',
	 'Cua gạch Cà Mau nhiều gạch son, loại 1 từ 500g/con trở lên.',
	 'cua-gach-ca-mau', 650000.00, 15.00, 'kg', 2, 1, 1),

	('Ghẹ Xanh Loại 1',
	 'Ghẹ xanh tươi sống, thịt chắc, đậm vị biển, đánh bắt tự nhiên.',
	 'ghe-xanh-loai-1', 380000.00, 30.00, 'kg', 2, 1, 0),

	('Cá Hồi Nguyên Con',
	 'Cá hồi Na Uy nguyên con, trọng lượng 3–4kg/con, nhập khẩu.',
	 'ca-hoi-nguyen-con', 420000.00, 10.00, 'con', 3, 1, 1),

	('Ốc Hương Cỡ Lớn',
	 'Ốc hương Phú Quốc cỡ lớn 30–40 con/kg, vỏ đẹp, thịt giòn ngọt.',
	 'oc-huong-co-lon', 550000.00, 25.50, 'kg', 4, 1, 0);
	 

	INSERT INTO product_images (product_id, image_url, is_primary, sort_order) VALUES
	-- Tôm Hùm Bông
	(1, 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Panulirus_ornatus.jpg/800px-Panulirus_ornatus.jpg', 1, 1),

	-- Tôm Sú Cọp
	(2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Penaeus_monodon_-_Peneid_shrimp.jpg/800px-Penaeus_monodon_-_Peneid_shrimp.jpg', 1, 1),

	-- Cua Gạch Cà Mau
	(3, 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Mud_crab_Scylla_serrata.jpg/800px-Mud_crab_Scylla_serrata.jpg', 1, 1),

	-- Ghẹ Xanh
	(4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Portunus_pelagicus.jpg/800px-Portunus_pelagicus.jpg', 1, 1),

	-- Cá Hồi Nguyên Con
	(5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Salmo_salar.jpg/800px-Salmo_salar.jpg', 1, 1),

	-- Ốc Hương
	(6, 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Babylonia_areolata.jpg/800px-Babylonia_areolata.jpg', 1, 1);

	-- Banner trang chủ
	INSERT INTO banners (title, image_url, link_url, sort_order, is_active) VALUES
	('Tôm Hùm Tươi Sống – Giảm 20%', '/uploads/banners/banner1.jpg', '/products?category=1', 1, 1),
	('Cua Gạch Cà Mau Chính Gốc',     '/uploads/banners/banner2.jpg', '/products?category=2', 2, 1),
	('Hải Sản Sạch – Giao Tận Nhà',   '/uploads/banners/banner3.jpg', '/products',            3, 1);

	UPDATE users 
	SET password = '123456'
	WHERE username IN ('admin_dylee', 'nv_banhang', 'khach_test');

	UPDATE users SET role_id = 1 
	WHERE username = 'duyy';
    
    SELECT * FROM product_images;
