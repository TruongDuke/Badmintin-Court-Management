Trương Công Thái Đức - MSSV: 20225815
1.  Liệt kê lịch thuê sân với tên khách hàng
SELECT KH.TENKHACHHANG, L.* 
FROM LICHTHUESAN L
INNER JOIN KHACHHANG KH ON L.MAKHACHHANG = KH.MAKHACHHANG;
→ Thực hiện hiện phép join 2 bảng cho phép bạn kết hợp thông tin về khách hàng (từ bảng KHACHHANG) với thông tin về lịch thuê sân (từ bảng LICHTHUESAN).
		




	
2. Tìm hóa đơn có tổng tiền lớn hơn 60000:
SELECT * FROM HOADON WHERE TONGTIEN > 60000
 3. Liệt kê các khách hàng có hóa đơn có tổng tiền lớn hơn 70000
SELECT
  KHACHHANG.*
FROM
  KHACHHANG
  JOIN HOADON ON KHACHHANG.MAKHACHHANG = HOADON.MAKHACHHANG
WHERE
  HOADON.TONGTIEN > 70000;
     4. Tìm danh sách các khách hàng đã thuê sân trong tháng 6 năm 2024 và tổng số tiền họ đã chi tiêu
WITH tmp AS (
    SELECT 
        KH.MAKHACHHANG, 
        KH.TENKHACHHANG, 
        SUM(HD.TONGTIEN) AS tongchitieu
    FROM 
        KHACHHANG KH
    JOIN 
        HOADON HD ON KH.MAKHACHHANG = HD.MAKHACHHANG
    JOIN 
        CHITIETHOADON CTHD ON HD.MAHOADON = CTHD.MAHOADON
    JOIN 
        LICHTHUESAN LTS ON CTHD.MALICH = LTS.MALICH
    WHERE 
        EXTRACT(MONTH FROM LTS.NGAYTHUE) = 6 
        AND EXTRACT(YEAR FROM LTS.NGAYTHUE) = 2024
    GROUP BY 
        KH.MAKHACHHANG, KH.TENKHACHHANG
)
SELECT 
    MAKHACHHANG, 
    TENKHACHHANG, 
    tongchitieu
FROM 
    tmp
ORDER BY 
    tongchitieu DESC;

Giải thích:
Đoạn mã SQL này nhằm mục đích lấy danh sách các khách hàng và tổng chi tiêu của họ trong tháng 6 năm 2024, sắp xếp từ cao đến thấp dựa trên tổng chi tiêu. Nó sử dụng CTE để trực quan hóa các bước truy vấn và xử lý dữ liệu, giúp cấu trúc câu lệnh trở nên rõ ràng và dễ hiểu hơn.


        5. Tạo hàm tính doanh thu theo ngày
CREATE OR REPLACE FUNCTION tinh_doanh_thu_theo_ngay(ngay DATE)
RETURNS INT AS $$
DECLARE
    tong_doanh_thu INT;
BEGIN
    SELECT COALESCE(SUM(TONGTIEN), 0) INTO tong_doanh_thu
    FROM HOADON
    WHERE NGAYLAP = ngay;

    RETURN tong_doanh_thu;
END;
$$ 
LANGUAGE plpgsql;


-- Sử dụng hàm để tính doanh thu của ngày 2024-06-01
SELECT tinh_doanh_thu_theo_ngay('2024-06-01');
Giải thích chức năng:
Hàm tinh_doanh_thu_theo_ngay này có chức năng là tính tổng doanh thu từ các hóa đơn được lập vào một ngày cụ thể được truyền vào qua tham số ngay. Nó sử dụng các câu lệnh SQL để truy vấn và tính toán dữ liệu từ bảng HOADON, sau đó trả về kết quả tính được dưới dạng một số nguyên (INT). Lưu ý rằng trong trường hợp không có hóa đơn nào lập vào ngày cụ thể đó, hàm sẽ trả về 0 thay vì NULL, nhờ vào việc sử dụng COALESCE để xử lý giá trị NULL.


6. Trigger update_total_price được tạo ra để cập nhật tổng tiền (TONGTIEN) của một hóa đơn khi có sự thay đổi trong bảng CHITIETHOADON
CREATE OR REPLACE FUNCTION update_total_price() 
RETURNS TRIGGER AS $$
DECLARE
    v_mahoadon INT;
BEGIN
    -- Lấy mã hóa đơn từ bảng CHITIETHOADON dựa trên mã lịch thuê sân từ NEW
    SELECT MAHOADON INTO v_mahoadon
    FROM CHITIETHOADON
    WHERE MALICH = NEW.MALICH
    LIMIT 1;

    -- Nếu tìm thấy mã hóa đơn
    IF v_mahoadon IS NOT NULL THEN
        -- Cập nhật tổng tiền cho hóa đơn tương ứng
        UPDATE HOADON
        SET TONGTIEN = (
            SELECT SUM(SANCAULONG.GIATIEN)
            FROM CHITIETHOADON
            JOIN LICHTHUESAN ON CHITIETHOADON.MALICH = LICHTHUESAN.MALICH
            JOIN SANCAULONG ON LICHTHUESAN.MASAN = SANCAULONG.MASAN
            WHERE CHITIETHOADON.MAHOADON = v_mahoadon
        )
        WHERE HOADON.MAHOADON = v_mahoadon;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_total_price_trigger
AFTER INSERT OR UPDATE ON CHITIETHOADON
FOR EACH ROW
EXECUTE FUNCTION update_total_price();
Giải thích: 
Hàm trigger update_total_price này được thiết kế để tự động cập nhật trường TONGTIEN của các hóa đơn trong bảng HOADON dựa trên thông tin từ bảng CHITIETHOADON. Khi một bản ghi mới được chèn vào CHITIETHOADON, hàm sẽ xác định hóa đơn tương ứng và tính toán lại tổng tiền dựa trên các chi tiết thuê sân, sau đó cập nhật tổng tiền vào hóa đơn đó.

7. Tạo trigger để kiểm tra việc chèn ngày thanh toán phải >= ngày lập hóa đơn
CREATE
OR REPLACE FUNCTION kiem_tra_ngay_thanh_toan () RETURNS TRIGGER AS $$
BEGIN
    IF NEW.NGAYTHANHTOAN < NEW.NGAYLAP THEN
        RAISE EXCEPTION 'Ngày thanh toán phải lớn hơn hoặc bằng ngày lập hóa đơn!';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_kiem_tra_ngay_thanh_toan BEFORE INSERT
OR
UPDATE ON HOADON FOR EACH ROW
EXECUTE FUNCTION kiem_tra_ngay_thanh_toan ();


8. Tính tổng số lượng hóa đơn mà mỗi khách hàng đã lập
SELECT
  MAKHACHHANG,
  COUNT(MAHOADON) AS SO_HOA_DON
FROM
  HOADON
GROUP BY
  MAKHACHHANG;



9. Tạo procedure để cập nhật thông tin khách hàng

CREATE
OR REPLACE PROCEDURE CapNhatThongTinKhachHang1 (
  IN makh INT,
  IN ten_khachhang VARCHAR(100),
  IN sdt_moi VARCHAR(15),
  IN dia_chi VARCHAR(100)
) AS $$
BEGIN
    UPDATE KHACHHANG
    SET TENKHACHHANG = ten_khachhang, SDT = sdt_moi, DIACHI = dia_chi
    WHERE MAKHACHHANG = makh;
    
    RAISE NOTICE 'Đã cập nhật thông tin khách hàng thành công!';
END;
$$ LANGUAGE plpgsql;
                       -- Sử dụng procedure để cập nhật thông tin khách hàng có mã khách hàng là 1
CALL CapNhatThongTinKhachHang1 (1, 'Nguyen Van Bao', '098764321', '456 Nguyen Hue, Quan 9');


10. Truy vấn con này tìm tất cả các mã nhân viên (MANHANVIEN) từ bảng HOADON mà tổng tiền (TONGTIEN) của hóa đơn lớn hơn 5000
                        SELECT TENNHANVIEN 
                        FROM NHANVIEN 
                        WHERE MANHANVIEN IN (
                        SELECT MANHANVIEN 
                        FROM HOADON 
                       WHERE TONGTIEN > 5000
                       );


		
II.Nguyễn Thanh Bình-MSSV: 20225792
           1. Liệt kê lịch thuê sân với tên sân
     SELECT S.TENSAN, L.*
     FROM LICHTHUESAN L
    INNER JOIN SANCAULONG S ON L.MASAN = S.MASAN
    ORDER BY L.malich

           2. Phân loại sân dựa vào giá tiền sân
                      
  SELECT TENSAN, GIATIEN,
    CASE 
            WHEN GIATIEN < 60000 THEN 'VIP_1'
            WHEN GIATIEN >= 60000 AND GIATIEN <= 80000 THEN 'VIP_2'
            ELSE 'VIP_3'
        END AS loai_san
  FROM SANCAULONG;


         3. Lấy danh sách các nhân viên và số hóa đơn họ đã lập, sắp xếp theo tổng số đơn đã lập giảm dần
   SELECT NV.TENNHANVIEN, COUNT(HD.MAHOADON) AS so_lan_phu_trach
   FROM NHANVIEN NV
   LEFT JOIN HOADON HD ON NV.MANHANVIEN = HD.MANHANVIEN
  GROUP BY NV.TENNHANVIEN
  ORDER BY COUNT(HD.MAHOADON) DESC;

      4. Tìm các khách hàng đã thanh toán hóa đơn trễ hạn
WITH LatePayments AS (
                 SELECT MAHOADON, MAKHACHHANG, NGAYLAP, NGAYTHANHTOAN    
              FROM HOADON
             WHERE NGAYTHANHTOAN > NGAYLAP)
SELECT KH.TENKHACHHANG, LP.MAHOADON, LP.NGAYLAP, LP.NGAYTHANHTOAN
FROM KHACHHANG  as KH
JOIN LatePayments as LP ON KH.MAKHACHHANG = LP.MAKHACHHANG;

     5. Tìm khách hàng chưa từng thuê sân cầu lông
WITH tmp AS (
     SELECT DISTINCT MAKHACHHANG
         FROM LICHTHUESAN )
 SELECT TENKHACHHANG
 FROM KHACHHANG
WHERE MAKHACHHANG NOT IN (SELECT MAKHACHHANG FROM tmp);


    6. Lấy danh sách các khách hàng đã thuê ít nhất 2 sân cầu lông khác nhau
              SELECT TENKHACHHANG
          FROM KHACHHANG
             WHERE MAKHACHHANG IN (
                                  SELECT MAKHACHHANG
                             FROM LICHTHUESAN
                                 GROUP BY MAKHACHHANG
                             HAVING COUNT(DISTINCT MASAN) >= 2 ) ;


      7. Lấy thông tin của các sân cầu lông đã được thuê vào một ngày cụ thể 
SELECT DISTINCT TENSAN, VITRI
FROM SANCAULONG
WHERE MASAN IN (
          SELECT MASAN
         FROM LICHTHUESAN
         WHERE NGAYTHUE = '2024-06-01' );



      8.  Tạo hàm tính số lần thuê sân của một khách hàng
CREATE OR REPLACE FUNCTION tinh_so_lan_thue_san(makh INT) -- đếm số lượng hàng
RETURNS INT AS 
$$
DECLARE
    so_lan_thue_san INT;
BEGIN
    SELECT COALESCE(COUNT(*), 0) INTO so_lan_thue_san
    FROM LICHTHUESAN
    WHERE MAKHACHHANG = makh;

    RETURN so_lan_thue_san;
END;
$$ 
LANGUAGE plpgsql;


Giải thích: Hàm tinh_so_lan_thue_san trong PostgreSQL được sử dụng để tính số lần một khách hàng đã thuê sân từ bảng LICHTHUESAN. Hàm này nhận vào mã khách hàng (makh) 
và đếm số lần xuất hiện của makh trong bảng LICHTHUESAN,gán vào biến so_lan_thue_san.  Hàm này sử dụng COALESCE để đảm bảo rằng nếu không có bản ghi nào thỏa mãn điều kiện,
 nó sẽ trả về 0.


     9. --Tạo procedure để hiển thị thông tin khách hàng khi nhập mã khách  hàng
CREATE OR REPLACE PROCEDURE HienThiThongTinKhachHang (IN makh INT)
 AS 
$$
DECLARE
    khach_hang_info RECORD;
BEGIN
    SELECT *  INTO khach_hang_info
    FROM KHACHHANG
    WHERE MAKHACHHANG = makh;
    IF FOUND THEN
        RAISE NOTICE 'Thong tin khach hang - Ma: %, Ten: %, So dien thoai: %,Dia chi: %',
khach_hang_info.MAKHACHHANG,khach_hang_info.TENKHACHHANG,khach_hang_info.SDT, khach_hang_info.DIACHI;
    ELSE
        RAISE EXCEPTION 'Khong tim thay thong tin cho ma khach hang %', makh;
    END IF;
END;
$$ 
LANGUAGE plpgsql;




Giải thích: Đoạn mã PL/pgSQL trên định nghĩa một procedure có tên HienThiThongTinKhachHang, được thiết kế để hiển thị thông tin của một khách hàng dựa trên mã khách hàng (makh) được cung cấp.
Khi thực thi, procedure này sẽ thực hiện các bước sau:
Tìm kiếm và lấy thông tin chi tiết của khách hàng từ bảng KHACHHANG dựa trên makh.
Nếu tìm thấy khách hàng, thông tin chi tiết sẽ được in ra dưới dạng thông báo sử dụng lệnh RAISE NOTICE.
Nếu không tìm thấy khách hàng với mã đã cho, procedure sẽ đưa ra một exception thông báo lỗi.


      10. Tạo trigger kiểm tra lịch đặt sân có bị trùng nhau
CREATE OR REPLACE FUNCTION kiem_tra_trung_lich_thue()
RETURNS TRIGGER AS $$
BEGIN
    -- Kiểm tra sự trùng lặp thời gian thuê
    IF EXISTS (
        SELECT 1
        FROM lichthuesan
        WHERE masan = NEW.masan
          AND ngaythue = NEW.ngaythue
          AND (
                (NEW.giobatdau < gioketthuc AND NEW.gioketthuc > giobatdau)
              OR (NEW.giobatdau >= giobatdau AND NEW.giobatdau < gioketthuc)
              OR (NEW.gioketthuc >giobatdau AND NEW.gioketthuc <= gioketthuc)
          )
    ) THEN
        RAISE EXCEPTION 'Sân % đã được đặt trong khoảng thời gian này. Vui lòng chọn thời gian khác.', NEW.MASAN;
    END IF;


    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER kiem_tra_trung_lich_thue_trigger
BEFORE INSERT ON LICHTHUESAN
FOR EACH ROW
EXECUTE FUNCTION kiem_tra_trung_lich_thue();



Giải thích : Đoạn mã PL/pgSQL và trigger trên được sử dụng để kiểm tra và ngăn chặn sự trùng lặp thời gian thuê sân trong bảng LICHTHUESAN khi có thêm dữ liệu mới. Function kiem_tra_trung_lich_thue sử dụng câu lệnh IF EXISTS để kiểm tra xem có bất kỳ lịch thuê sân nào trùng lặp thời gian với dữ liệu mới (NEW) không. Điều kiện kiểm tra bao gồm so sánh thời gian bắt đầu và kết thúc của lịch thuê mới với các lịch thuê đã có trong cơ sở dữ liệu. Nếu phát hiện trùng lặp, trigger sẽ kích hoạt và đưa ra một exception thông báo cho người dùng biết sân đã được đặt trong khoảng thời gian đó và yêu cầu chọn thời gian khác. Điều này giúp đảm bảo tính toàn vẹn dữ liệu và tránh tình trạng trùng lặp trong quá trình quản lý lịch thuê sân.


III.Cao Thành Đạt - MSSV:20225803
    1.Lấy ra lịch thuê sân vào ngày 6/3/2024 
                SELECT * FROM LICHTHUESAN WHERE NGAYTHUE=’ 2024-03-06’;
    2.Tính tổng số lượng hóa đơn mà mỗi khách hàng đã lập
SELECT
  MAKHACHHANG,COUNT(MAHOADON) AS SO_HOA_DON
FROM
  HOADON
GROUP BY
  MAKHACHHANG;
    3.Tính số lượng các sân cầu lông đã được thuê ít nhất 3 lần
SELECT COUNT(*)
FROM
  (SELECT   MASAN
    FROM  LICHTHUESAN
    GROUP BY
      MASAN
    HAVING
      COUNT(DISTINCT MALICH) >= 3
  ) AS subquery;

    4.Tìm sân được sử dụng nhiều nhất
SELECT S.*,COUNT(MALICH) AS SO_LAN_SU_DUNG
	FROM SANCAULONG S LEFT JOIN LICHTHUESAN LTS USING(MASAN)
GROUP BY S.MASAN
ORDER BY SO_LAN_SU_DUNG DESC
LIMIT 1;

   5.Tính trung bình giá sân được sử dụng trong tháng 6
SELECT
         AVG(S.GIATIEN) AS GiaSanTrungBinhThang6
FROM 
         LICHTHUESAN LTS 
         JOIN SANCAULONG S USING(MASAN)
WHERE 
         LTS.NGAYTHUE >= DATE '2024-06-01'
         AND LTS.NGAYTHUE <= DATE '2024-06-30';


  6.Tạo view cung cấp thông tin chi tiết về từng lần đặt sân của khách hàng, bao gồm tên khách hàng, ngày đặt, giờ bắt đầu, giờ kết thúc và tên sân.

CREATE VIEW ChiTietDatSanKhachHang AS
SELECT 
    KH.TENKHACHHANG AS TenKhachHang,
    LTS.NGAYTHUE AS NgayThue,
    LTS.GIOBATDAU AS GioBatDau,
    LTS.GIOKETTHUC AS GioKetThuc,
    SC.TENSAN AS TenSan
FROM 
    LICHTHUESAN LTS
JOIN 
    KHACHHANG KH ON LTS.MAKHACHHANG = KH.MAKHACHHANG
JOIN 
    SANCAULONG SC ON LTS.MASAN = SC.MASAN;
	
   7.Tạo view  cung cấp lịch sử chi tiết của tất cả các lần đặt sân, bao gồm thông tin khách hàng, thông tin sân và thời gian đặt.
CREATE VIEW LichSuDatSanChiTiet AS
SELECT 
    LTS.MALICH AS MaLich,
    KH.TENKHACHHANG AS TenKhachHang,
    SC.TENSAN AS TenSan,
    LTS.NGAYTHUE AS NgayThue,
    LTS.GIOBATDAU AS GioBatDau,
    LTS.GIOKETTHUC AS GioKetThuc
FROM 
    LICHTHUESAN LTS
JOIN 
    KHACHHANG KH ON LTS.MAKHACHHANG = KH.MAKHACHHANG
JOIN 
    SANCAULONG SC ON LTS.MASAN = SC.MASAN;

  8.Tìm mã sân đã được đặt bởi khách hàng có mã là 1.
SELECT TENSAN, VITRI, GIATIEN
FROM SANCAULONG 
WHERE MASAN IN (
    SELECT MASAN 
    FROM LICHTHUESAN 
    WHERE MAKHACHHANG = 1
);
  
  9.Cập nhật giá sân
CREATE OR REPLACE PROCEDURE update_gia_san(
IN ma_san INT,
IN ten_san VARCHAR(100),
IN gia_moi INT)
LANGUAGE plpgsql
AS $$
BEGIN 
     UPDATE SANCAULONG
     SET TENSAN= ten_san,GIATIEN=gia_moi
     WHERE MASAN = ma_san;
     
     RAISE NOTICE' Cập nhật thành công!';
END;
$$;
 
  10.Xóa lịch thuê sân khi khách muốn hủy
CREATE OR REPLACE PROCEDURE xoa_lich(
IN ma_lich INT
)LANGUAGE plpgsql
AS $$
BEGIN
   DELETE FROM LICHTHUESAN
   WHERE MALICH=ma_lich;
  
      RAISE NOTICE 'Xử lý thành công!';
   END;
$$;
