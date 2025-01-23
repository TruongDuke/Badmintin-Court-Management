-- Tạo bảng KHACHHANG
CREATE TABLE KHACHHANG (
    MAKHACHHANG INT PRIMARY KEY,
    TENKHACHHANG VARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    DIACHI VARCHAR(100) NOT NULL
);

-- Tạo bảng NHANVIEN
CREATE TABLE NHANVIEN (
    MANHANVIEN INT PRIMARY KEY,
    TENNHANVIEN VARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    DIACHI VARCHAR(100),
    CHUCVU VARCHAR(50)
);

-- Tạo bảng SANCAULONG
CREATE TABLE SANCAULONG (
    MASAN INT PRIMARY KEY,
    TENSAN VARCHAR(100) NOT NULL,
    VITRI VARCHAR(100),
    GIATIEN INT
    
);

-- Tạo bảng LICHTHUESAN
CREATE TABLE LICHTHUESAN (
    MALICH INT PRIMARY KEY,
    NGAYTHUE DATE,
    GIOBATDAU TIME,
    GIOKETTHUC TIME,
    MAKHACHHANG INT REFERENCES KHACHHANG(MAKHACHHANG),
    MASAN INT REFERENCES SANCAULONG(MASAN)
);

-- Tạo bảng HOADON
CREATE TABLE HOADON (
    MAHOADON INT PRIMARY KEY,
    NGAYLAP DATE,
    NGAYTHANHTOAN DATE,
    TONGTIEN INT,
    MAKHACHHANG INT REFERENCES KHACHHANG(MAKHACHHANG),
    MANHANVIEN INT REFERENCES NHANVIEN(MANHANVIEN)
);

-- Tạo bảng CHITIETHOADON
CREATE TABLE CHITIETHOADON (
    MAHOADON INT,
    MALICH INT,
    FOREIGN KEY (MAHOADON) REFERENCES HOADON(MAHOADON),
    FOREIGN KEY (MALICH) REFERENCES LICHTHUESAN(MALICH)
);


INSERT INTO KHACHHANG 
VALUES
(1, 'Tran Van An', '0123456789', 'So 123, Quan 3, TP. HCM'),
(2, 'Tran Thi Binh', '0987654321', 'So 123, Quan 3, TP. HCM'),
(3, 'Le Van Nhung', '0369852142', 'So 123, Quan 3, TP. HCM'),
(4, 'Pham Thi Yen', '0789456129', 'So 123, Quan 3, TP. HCM'),
(5, 'Hoang Van Hoa', '0541236987', 'So 123, Quan 3, TP. HCM'),
(6, 'Tran Van An', '0123456789', 'So 123, Quan 3, TP. HCM'),
(7, 'Tran Thi Binh', '0987654321', 'So 123, Quan 3, TP. HCM'),
(8, 'Le Van Nhung', '0369852142', 'So 123, Quan 3, TP. HCM'),
(9, 'Pham Thi Yen', '0789456129', 'So 123, Quan 3, TP. HCM'),
(10, 'Hoang Van Hoa', '0541236987', 'So 123, Quan 3, TP. HCM'),
(11, 'Tran Van An', '0123456789', 'So 123, Quan 3, TP. HCM'),
(12, 'Tran Thi Binh', '0987654321', 'So 123, Quan 3, TP. HCM'),
(13, 'Le Van Nhung', '0369852142', 'So 123, Quan 3, TP. HCM'),
(14, 'Pham Thi Yen', '0789456129', 'So 123, Quan 3, TP. HCM'),
(15, 'Hoang Van Hoa', '0541236987', 'So 123, Quan 3, TP. HCM'),
(16, 'Tran Van Bao', '0911234567', 'So 11, Quan 2, TP. HCM'),
(17, 'Le Thi Cam', '0921234567', 'So 12, Quan 2, TP. HCM'),
(18, 'Hoang Van Dat', '0931234567', 'So 13, Quan 2, TP. HCM'),
(19, 'Pham Thi Lan', '0941234567', 'So 14, Quan 2, TP. HCM'),
(20, 'Nguyen Van Minh', '0951234567', 'So 15, Quan 2, TP. HCM'),
(21, 'Bui Thi Ngoc', '0961234567', 'So 16, Quan 2, TP. HCM'),
(22, 'Vo Van Long', '0971234567', 'So 17, Quan 2, TP. HCM'),
(23, 'Dinh Thi Thao', '0981234567', 'So 18, Quan 2, TP. HCM'),
(24, 'Dang Van Khoa', '0991234567', 'So 19, Quan 2, TP. HCM'),
(25, 'Tran Van Hai', '0912345678', 'So 20, Quan 2, TP. HCM'),
(26, 'Le Thi Lan', '0922345678', 'So 21, Quan 2, TP. HCM'),
(27, 'Hoang Van Son', '0932345678', 'So 22, Quan 2, TP. HCM'),
(28, 'Pham Thi Ha', '0942345678', 'So 23, Quan 2, TP. HCM'),
(29, 'Nguyen Van Tung', '0952345678', 'So 24, Quan 2, TP. HCM'),
(30, 'Bui Thi Hanh', '0962345678', 'So 25, Quan 2, TP. HCM'),
(31, 'Vo Van Phu', '0972345678', 'So 26, Quan 2, TP. HCM'),
(32, 'Dinh Thi Mai', '0982345678', 'So 27, Quan 2, TP. HCM'),
(33, 'Dang Van Tuan', '0992345678', 'So 28, Quan 2, TP. HCM'),
(34, 'Tran Thi Thu', '0913456789', 'So 1, Quan Hoan Kiem, Ha Noi'),
(35, 'Le Van Phuc', '0923456789', 'So 2, Quan Hoan Kiem, Ha Noi'),
(36, 'Hoang Thi An', '0933456789', 'So 3, Quan Hoan Kiem, Ha Noi'),
(37, 'Pham Van Bao', '0943456789', 'So 4, Quan Hoan Kiem, Ha Noi'),
(38, 'Nguyen Thi Dung', '0953456789', 'So 5, Quan Hoan Kiem, Ha Noi'),
(39, 'Bui Van Cuong', '0963456789', 'So 6, Quan Hoan Kiem, Ha Noi'),
(40, 'Vo Thi Diep', '0973456789', 'So 7, Quan Hoan Kiem, Ha Noi'),
(41, 'Dinh Van Phong', '0983456789', 'So 8, Quan Hoan Kiem, Ha Noi'),
(42, 'Dang Thi Giang', '0993456789', 'So 9, Quan Hoan Kiem, Ha Noi'),
(43, 'Tran Van Hoang', '0914567890', 'So 10, Quan Hoan Kiem, Ha Noi'),
(44, 'Le Thi Hang', '0924567890', 'So 11, Quan Hoan Kiem, Ha Noi'),
(45, 'Hoang Van Khiem', '0934567890', 'So 12, Quan Hoan Kiem, Ha Noi'),
(46, 'Pham Thi Linh', '0944567890', 'So 13, Quan Hoan Kiem, Ha Noi'),
(47, 'Nguyen Van Manh', '0954567890', 'So 14, Quan Hoan Kiem, Ha Noi'),
(48, 'Bui Thi Nhung', '0964567890', 'So 15, Quan Hoan Kiem, Ha Noi'),
(49, 'Vo Van Quang', '0974567890', 'So 16, Quan Hoan Kiem, Ha Noi'),
(50, 'Dinh Thi Oanh', '0984567890', 'So 17, Quan Hoan Kiem, Ha Noi'),
(51, 'Dang Van Phuoc', '0994567890', 'So 18, Quan Hoan Kiem, Ha Noi'),
(52, 'Tran Thi Quynh', '0915678901', 'So 19, Quan Hoan Kiem, Ha Noi'),
(53, 'Le Van Son', '0925678901', 'So 20, Quan Hoan Kiem, Ha Noi'),
(54, 'Hoang Thi Tam', '0935678901', 'So 21, Quan Hoan Kiem, Ha Noi'),
(55, 'Pham Van Tien', '0945678901', 'So 22, Quan Hoan Kiem, Ha Noi'),
(56, 'Nguyen Thi Uyen', '0955678901', 'So 23, Quan Hoan Kiem, Ha Noi'),
(57, 'Bui Van Vu', '0965678901', 'So 24, Quan Hoan Kiem, Ha Noi'),
(58, 'Vo Thi Xuan', '0975678901', 'So 25, Quan Hoan Kiem, Ha Noi'),
(59, 'Dinh Van Yen', '0985678901', 'So 26, Quan Hoan Kiem, Ha Noi'),
(60, 'Dang Thi Lan', '0995678901', 'So 27, Quan Hoan Kiem, Ha Noi'),
(61, 'Tran Van An', '0916789012', 'So 28, Quan Ba Dinh, Ha Noi'),
(62, 'Le Thi Binh', '0926789012', 'So 29, Quan Ba Dinh, Ha Noi'),
(63, 'Hoang Van Hoa', '0936789012', 'So 30, Quan Ba Dinh, Ha Noi'),
(64, 'Pham Thi Yen', '0946789012', 'So 31, Quan Ba Dinh, Ha Noi'),
(65, 'Nguyen Van Khoa', '0956789012', 'So 32, Quan Ba Dinh, Ha Noi');

-- Chèn dữ liệu vào bảng NHANVIEN
INSERT INTO NHANVIEN 
VALUES
(1, 'Tran Van Xuyen', '0123456789', 'So 123, Quan 3, TP. HCM','Quan Li'),
(2, 'Nguyen Thi Yen', '0987654321', 'So 123, Quan 3, TP. HCM','Quan Li'),
(3, 'Le Van trung', '0369852141', 'So 3, Quan 3, TP. HCM', 'Nhan vien'),
(4, 'Pham Thi Quang', '0789456121', 'So 12, Quan 1, TP. HCM', 'Nhan vien'),
(5, 'Hoang Van Khanh', '0541236986', 'So 13, Quan 4, TP. HCM', 'Nhan vien'),
(6, 'Tran Van Phuong', '0123456785', 'So 123, Quan 3, TP. HCM','Quan Li'),
(7, 'Nguyen Thi Oanh', '0987654321', 'So 123, Quan 8, TP. HCM','Quan Li'),
(8, 'Le Van Tra', '0369852148', 'So 3, Quan 3, TP. HCM', 'Nhan vien'),
(9, 'Pham Thi Hoa', '0789456823', 'So 12, Quan 1, TP. HCM', 'Nhan vien'),
(10, 'Hoang Van Khu', '0541236989', 'So 13, Quan 4, TP. HCM', 'Nhan vien'),
(11, 'Tran Van Van', '0123456786', 'So 123, Quan 3, TP. HCM','Quan Li'),
(12, 'Nguyen Thi Long', '0987654326', 'So 123, Quan 7, TP. HCM','Quan Li'),
(13, 'Le Van Ky', '0369852146', 'So 3, Quan 3, TP. HCM', 'Nhan vien'),
(14, 'Pham Thi Hoa', '0789456125', 'So 12, Quan 7, TP. HCM', 'Nhan vien'),
(15, 'Hoang Van Xuan', '0541236987', 'So 13, Quan 7, TP. HCM', 'Nhan vien');
(16, 'Nguyen Van An', '0912234567', 'So 11, Quan 2, TP. HCM', 'Nhan vien'),
(17, 'Pham Thi Bich', '0922234567', 'So 12, Quan 2, TP. HCM', 'Nhan vien'),
(18, 'Vo Van Cuong', '0932234567', 'So 13, Quan 2, TP. HCM', 'Nhan vien'),
(19, 'Bui Thi Dao', '0942234567', 'So 14, Quan 2, TP. HCM', 'Nhan vien'),
(20, 'Tran Van Duy', '0952234567', 'So 15, Quan 2, TP. HCM', 'Nhan vien'),
(21, 'Nguyen Thi Giang', '0962234567', 'So 16, Quan 2, TP. HCM', 'Quan Li'),
(22, 'Pham Van Hao', '0972234567', 'So 17, Quan 2, TP. HCM', 'Quan Li'),
(23, 'Le Thi Hien', '0982234567', 'So 18, Quan 2, TP. HCM', 'Nhan vien'),
(24, 'Vo Van Hoang', '0992234567', 'So 19, Quan 2, TP. HCM', 'Nhan vien'),
(25, 'Nguyen Thi Hoa', '0912345678', 'So 20, Quan 2, TP. HCM', 'Nhan vien'),
(26, 'Pham Van Khanh', '0922345678', 'So 21, Quan 2, TP. HCM', 'Quan Li'),
(27, 'Bui Thi Lan', '0932345678', 'So 22, Quan 2, TP. HCM', 'Nhan vien'),
(28, 'Le Van Lam', '0942345678', 'So 23, Quan 2, TP. HCM', 'Nhan vien'),
(29, 'Vo Thi Mai', '0952345678', 'So 24, Quan 2, TP. HCM', 'Nhan vien'),
(30, 'Nguyen Van Minh', '0962345678', 'So 25, Quan 2, TP. HCM', 'Nhan vien'),
(31, 'Pham Thi Nga', '0972345678', 'So 26, Quan 2, TP. HCM', 'Quan Li'),
(32, 'Le Van Phu', '0982345678', 'So 27, Quan 2, TP. HCM', 'Quan Li'),
(33, 'Nguyen Thi Quynh', '0992345678', 'So 28, Quan 2, TP. HCM', 'Nhan vien'),
(34, 'Pham Van Son', '0913456789', 'So 1, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(35, 'Bui Thi Tam', '0923456789', 'So 2, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(36, 'Le Van Thanh', '0933456789', 'So 3, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(37, 'Vo Thi Trang', '0943456789', 'So 4, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(38, 'Nguyen Van Tri', '0953456789', 'So 5, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(39, 'Pham Thi Tuyet', '0963456789', 'So 6, Quan Hoan Kiem, Ha Noi', 'Quan Li'),
(40, 'Bui Van Vinh', '0973456789', 'So 7, Quan Hoan Kiem, Ha Noi', 'Quan Li'),
(41, 'Le Thi Xuan', '0983456789', 'So 8, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(42, 'Nguyen Van Y', '0993456789', 'So 9, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(43, 'Pham Thi An', '0914567890', 'So 10, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(44, 'Bui Van Bao', '0924567890', 'So 11, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(45, 'Le Thi Chinh', '0934567890', 'So 12, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(46, 'Vo Van Dat', '0944567890', 'So 13, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(47, 'Nguyen Thi Dien', '0954567890', 'So 14, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(48, 'Pham Van Dinh', '0964567890', 'So 15, Quan Hoan Kiem, Ha Noi', 'Quan Li'),
(49, 'Bui Thi Dung', '0974567890', 'So 16, Quan Hoan Kiem, Ha Noi', 'Quan Li'),
(50, 'Le Van Giang', '0984567890', 'So 17, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(51, 'Nguyen Thi Hanh', '0994567890', 'So 18, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(52, 'Pham Van Hieu', '0915678901', 'So 19, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(53, 'Bui Thi Hong', '0925678901', 'So 20, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(54, 'Le Van Hoang', '0935678901', 'So 21, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(55, 'Vo Thi Hue', '0945678901', 'So 22, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(56, 'Nguyen Van Khanh', '0955678901', 'So 23, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(57, 'Pham Thi Kieu', '0965678901', 'So 24, Quan Hoan Kiem, Ha Noi', 'Quan Li'),
(58, 'Bui Van Long', '0975678901', 'So 25, Quan Hoan Kiem, Ha Noi', 'Quan Li'),
(59, 'Le Thi Mai', '0985678901', 'So 26, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(60, 'Vo Van Manh', '0995678901', 'So 27, Quan Hoan Kiem, Ha Noi', 'Nhan vien'),
(61, 'Nguyen Thi Nga', '0916789012', 'So 28, Quan Ba Dinh, Ha Noi', 'Nhan vien'),
(62, 'Pham Van Nhat', '0926789012', 'So 29, Quan Ba Dinh, Ha Noi', 'Nhan vien'),
(63, 'Bui Thi Oanh', '0936789012', 'So 30, Quan Ba Dinh, Ha Noi', 'Nhan vien'),
(64, 'Le Van Phat', '0946789012', 'So 31, Quan Ba Dinh, Ha Noi', 'Nhan vien'),
(65, 'Vo Thi Quyen', '0956789012', 'So 32, Quan Ba Dinh, Ha Noi', 'Nhan vien');

-- Chèn dữ liệu vào bảng SANCAULONG 
INSERT INTO SANCAULONG 
VALUES
(1, 'San cau long A', 'Tang 1', 50000),
(2, 'San cau long B', 'Tang 2', 60000),
(3, 'San cau long C', 'Tang 3', 70000),
(4, 'San cau long D', 'Tang 4', 80000),
(5, 'San cau long E', 'Tang 5', 90000),
(6, 'San cau long A1', 'Tang 1', 50000),
(7, 'San cau long B1', 'Tang 2', 60000),
(8, 'San cau long C1', 'Tang 3', 70000),
(9, 'San cau long D1', 'Tang 4', 80000),
(10, 'San cau long E1', 'Tang 5', 90000),
(11, 'San cau long A2', 'Tang 1', 50000),
(12, 'San cau long B2', 'Tang 2', 60000),
(13, 'San cau long C2', 'Tang 3', 70000),
(14, 'San cau long D2', 'Tang 4', 80000),
(15, 'San cau long E2', 'Tang 5', 90000);

--Chèn dữ liệu vào bảng lichthuesan
INSERT INTO LICHTHUESAN 
VALUES
(1, '2024-06-01', '14:00:00', '16:00:00', 1, 1),
(2, '2024-06-02', '15:00:00', '17:00:00', 2, 2),
(3, '2024-06-03', '16:00:00', '18:00:00', 3, 3),
(4, '2024-06-04', '17:00:00', '19:00:00', 4, 4),
(5, '2024-06-05', '18:00:00', '20:00:00', 5, 2),
(6, '2024-06-01', '17:00:00', '19:00:00', 2, 1),
(7, '2024-06-02', '10:00:00', '12:00:00', 3, 2),
(8, '2024-06-03', '21:00:00', '23:00:00', 1, 3),
(9, '2024-06-04', '10:00:00', '12:00:00', 4, 3),
(10, '2024-06-05', '11:00:00', '13:00:00', 1, 5),
(11, '2024-06-01', '7:00:00', '9:00:00', 6, 3),
(12, '2024-06-02', '8:00:00', '10:00:00', 2, 2),
(13, '2024-06-03', '9:00:00', '11:00:00', 3, 4),
(14, '2024-06-04', '14:00:00', '16:00:00', 4, 4),
(15, '2024-06-05', '12:00:00', '14:00:00', 5, 1);


-- Chèn dữ liệu vào bảng HOADON
INSERT INTO HOADON (MAHOADON, NGAYLAP, NGAYTHANHTOAN, TONGTIEN, MAKHACHHANG, MANHANVIEN)
VALUES
(1, '2024-06-01', '2024-06-02',null, 1, 1),
(2, '2024-06-02', '2024-06-03',null, 2, 2),
(3, '2024-06-03', '2024-06-04',null, 3, 3),
(4, '2024-06-04', '2024-06-05',null, 4, 4),
(5, '2024-06-05', '2024-06-06',null, 5, 5);


-- Chèn dữ liệu vào bảng chi tiết hóa đơn
INSERT INTO CHITIETHOADON (MAHOADON, MALICH)
VALUES
(1, 1),
(1, 8),
(1, 10),
(2, 2),
(2, 6),
(2, 12),
(3, 3),
(3, 7),
(3, 13),
(4, 4),
(4, 9),
(4, 14),
(5, 5),
(5, 15);

