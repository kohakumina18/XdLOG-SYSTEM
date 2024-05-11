﻿-- Tạo bảng người dùng
CREATE TABLE NguoiDung (
    ID INT PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Role NVARCHAR(20) NOT NULL
);

-- Tạo bảng giáo viên
CREATE TABLE GiaoVien (
    MaGV INT PRIMARY KEY,
    TenGV NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    MaMonHoc INT,
    FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc)
);

-- Tạo bảng tổ trưởng bộ môn
CREATE TABLE ToTruongBoMon (
    MaGV INT PRIMARY KEY,
    MaMonHoc INT,
    FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV),
    FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc)
);

-- Tạo bảng giáo viên chủ nhiệm
CREATE TABLE GVCN (
    MaGV INT PRIMARY KEY,
    MaLop INT,
    FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV),
     
);

alter table GVCN
add constraint MaLop
FOREIGN KEY (MaLop) REFERENCES LopHoc(MaLop);

-- Tạo bảng ban giám hiệu
CREATE TABLE BanGiamHieu (
    MaBGH INT PRIMARY KEY,
    TenBGH NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL
);

-- Tạo bảng học sinh
CREATE TABLE HocSinh (
    MaHS INT PRIMARY KEY,
    TenHS NVARCHAR(50) NOT NULL,
    NgaySinh DATE NOT NULL,
    GioiTinh NVARCHAR(10) NOT NULL,
    DiaChi NVARCHAR(100) NOT NULL,
    MaLop INT,
    FOREIGN KEY (MaLop) REFERENCES LopHoc(MaLop)
);

-- Tạo bảng lớp học
CREATE TABLE LopHoc (
    MaLop INT PRIMARY KEY,
    TenLop NVARCHAR(50) NOT NULL,
    MaGVCN INT,
    FOREIGN KEY (MaGVCN) REFERENCES GVCN(MaGV)
);

-- Tạo bảng môn học
CREATE TABLE MonHoc (
    MaMonHoc INT PRIMARY KEY,
    TenMonHoc NVARCHAR(50) NOT NULL
);

-- Tạo bảng sổ đầu bài
CREATE TABLE SoDauBai (
    MaSoDauBai INT PRIMARY KEY,
    MaHS INT,
    MaMonHoc INT,
    Diem FLOAT,
    FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc)
);

-- Tạo bảng tiết học
CREATE TABLE TietHoc (
    MaTietHoc INT PRIMARY KEY,
    MaLop INT,
    MaMonHoc INT,
    NgayHoc DATE,
    FOREIGN KEY (MaLop) REFERENCES LopHoc(MaLop),
    FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc)
);

-- Tạo bảng mini game
CREATE TABLE MiniGame (
    MaGame INT PRIMARY KEY,
    TenGame NVARCHAR(50) NOT NULL,
    DiemSo INT,
    MaHS INT,
    FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS)
);

-- Tạo trigger cho việc thêm người dùng mới
CREATE TRIGGER ThemNguoiDungTrigger
ON NguoiDung
AFTER INSERT
AS
BEGIN
  -- Lưu thông tin đăng nhập vào bảng người dùng
  INSERT INTO NguoiDung (ID, Username, Password, Role)
  SELECT ID, Username, Password, Role
  FROM inserted;
END;

-- Tạo trigger cho việc xóa người dùng
CREATE TRIGGER XoaNguoiDungTrigger
ON NguoiDung
AFTER DELETE
AS
BEGIN
  -- Xóa thông tin đăng nhập trong bảng người dùng
  DELETE FROM NguoiDung
  WHERE ID IN (SELECT ID FROM deleted);
END;

-- Tạo procedure để thêm giáo viên mới
CREATE PROCEDURE ThemGiaoVien
(
    @MaGV INT,
    @TenGV NVARCHAR(50),
    @Email NVARCHAR(50),
    @MaMonHoc INT
)
AS
BEGIN
    INSERT INTO GiaoVien (MaGV, TenGV, Email, MaMonHoc)
    VALUES (@MaGV, @TenGV, @Email, @MaMonHoc);
END;

-- Tạo procedure để thêm học sinh mới
CREATE PROCEDURE ThemHocSinh
(
    @MaHS INT,
    @TenHS NVARCHAR(50),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @DiaChi NVARCHAR(100),
    @MaLop INT
)
AS
BEGIN
    INSERT INTO HocSinh (MaHS, TenHS, NgaySinh, GioiTinh, DiaChi, MaLop)
    VALUES (@MaHS, @TenHS, @NgaySinh, @GioiTinh, @DiaChi, @MaLop);
END;

-- Tạo procedure để cập nhật điểm sổ đầu bài
CREATE PROCEDURE CapNhatDiemSoDauBai
(
    @MaSoDauBai INT,
    @Diem FLOAT
)
AS
BEGIN
    UPDATE SoDauBai
    SET Diem = @Diem
    WHERE MaSoDauBai = @MaSoDauBai;
END;

-- Tạo procedure để thêm điểm sổ đầu bài
CREATE PROCEDURE ThemDiemSoDauBai
(
    @MaHS INT,
    @MaMonHoc INT,
    @Diem FLOAT
)
AS
BEGIN
    INSERT INTO SoDauBai (MaHS, MaMonHoc, Diem)
    VALUES (@MaHS, @MaMonHoc, @Diem);
END;

-- Tạo procedure để cập nhật điểm mini game
CREATE PROCEDURE CapNhatDiemMiniGame
(
    @MaGame INT,
    @DiemSo INT
)
AS
BEGIN
    UPDATE MiniGame
    SET DiemSo = @DiemSo
    WHERE MaGame = @MaGame;
END;

-- Tạo procedure để thêm điểm mini game
CREATE PROCEDURE ThemDiemMiniGame
(
    @MaGame INT,
    @TenGame NVARCHAR(50),
    @DiemSo INT,
    @MaHS INT
)
AS
BEGIN
    INSERT INTO MiniGame (MaGame, TenGame, DiemSo, MaHS)
    VALUES (@MaGame, @TenGame, @DiemSo, @MaHS);
END;
 
 -- Tạo bảng Nhận xét sổ đầu bài
CREATE TABLE NhanXetSoDauBai (
MaNhanXet INT PRIMARY KEY,
MaGV INT,
MaSoDauBai INT,
NoiDung NVARCHAR(1000),
FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV),
FOREIGN KEY (MaSoDauBai) REFERENCES SoDauBai(MaSoDauBai)
);

-- Trigger cho việc thêm nhận xét sổ đầu bài
CREATE TRIGGER ThemNhanXetSoDauBaiTrigger
ON NhanXetSoDauBai
AFTER INSERT
AS
BEGIN
-- Cập nhật điểm sổ đầu bài sau khi thêm nhận xét
UPDATE SoDauBai
SET Diem = Diem + 1 -- Giả sử mỗi nhận xét tăng 1 điểm
WHERE MaSoDauBai IN (SELECT MaSoDauBai FROM inserted);
END;

-- Tạo bảng LichDayHangTuan
CREATE TABLE LichDayHangTuan (
MaLich INT PRIMARY KEY,
MaGV INT,
MaMonHoc INT,
Thu INT,
TietHoc INT,
FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV),
FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc)
);

alter table GiaoVien
add SoTietDay int;
-- Trigger cho việc thêm lịch dạy hàng tuần
CREATE TRIGGER ThemLichDayHangTuanTrigger
ON LichDayHangTuan
AFTER INSERT
AS
BEGIN
-- Cập nhật số lượng tiết dạy của giáo viên sau khi thêm lịch dạy
UPDATE GiaoVien
SET SoTietDay = SoTietDay + 1
WHERE MaGV IN (SELECT MaGV FROM inserted);
END;

-- Tạo procedure cho chức năng phân công lịch dạy hàng tuần
CREATE PROCEDURE PhanCongLichDayHangTuan
(
@MaGVCN INT,
@MaGV INT,
@MaMonHoc INT,
@Thu INT,
@TietHoc INT
)
AS
BEGIN
-- Kiểm tra xem giáo viên có quyền phân công không
IF EXISTS (SELECT 1 FROM ToTruongBoMon WHERE MaGV = @MaGVCN)
BEGIN
-- Kiểm tra xem lịch dạy hàng tuần đã tồn tại chưa
IF NOT EXISTS (SELECT 1 FROM LichDayHangTuan WHERE MaGV = @MaGV AND MaMonHoc = @MaMonHoc AND Thu = @Thu AND TietHoc = @TietHoc)
BEGIN
-- Thêm lịch dạy hàng tuần
INSERT INTO LichDayHangTuan (MaGV, MaMonHoc, Thu, TietHoc)
VALUES (@MaGV, @MaMonHoc, @Thu, @TietHoc);
END;
END;
END;

-- Tạo procedure cho chức năng phân công lịch dạy thay
CREATE PROCEDURE PhanCongLichDayThay
(
@MaGVCN INT,
@MaGV INT,
@MaMonHoc INT,
@Thu INT,
@TietHoc INT,
@NgayHoc DATE
)
AS
BEGIN
-- Kiểm tra xem giáo viên có quyền phân công không
IF EXISTS (SELECT 1 FROM ToTruongBoMon WHERE MaGV = @MaGVCN)
BEGIN
-- Kiểm tra xem lịch dạy thay đã tồn tại chưa
IF NOT EXISTS (SELECT 1 FROM LichDay WHERE MaGV = @MaGV AND MaMonHoc = @MaMonHoc AND Thu = @Thu AND TietHoc = @TietHoc AND NgayHoc = @NgayHoc)
BEGIN
-- Thêm lịch dạy thay
INSERT INTO LichDay (MaGV, MaMonHoc, Thu, TietHoc, NgayHoc)
VALUES (@MaGV, @MaMonHoc, @Thu, @TietHoc, @NgayHoc);
END;
END;
END;

-- Tạo procedure cho chức năng phân công lịch dạy bù
CREATE PROCEDURE PhanCongLichDayBu
(
@MaGVCN INT,
@MaGV INT,
@MaMonHoc INT,
@Thu INT,
@TietHoc INT,
@NgayHoc DATE
)
AS
BEGIN
-- Kiểm tra xem giáo viên có quyền phân công không
IF EXISTS (SELECT 1 FROM ToTruongBoMon WHERE MaGV = @MaGVCN)
BEGIN
-- Kiểm tra xem lịch dạy bù đã tồn tại chưa
IF NOT EXISTS (SELECT 1 FROM LichDayBu WHERE MaGV = @MaGV AND MaMonHoc = @MaMonHoc AND Thu = @Thu AND TietHoc = @TietHoc AND NgayHoc = @NgayHoc)
BEGIN
-- Thêm lịch dạy bù
INSERT INTO LichDayBu (MaGV, MaMonHoc, Thu, TietHoc, NgayHoc)
VALUES (@MaGV, @MaMonHoc, @Thu, @TietHoc, @NgayHoc);
END;
END;
END;
 
-- Tạo procedure cho chức năng quản lý tài khoản
CREATE PROCEDURE QuanLyTaiKhoan
(
@ID INT,
@Username NVARCHAR(50),
@Password NVARCHAR(50),
@Role NVARCHAR(20)
)
AS
BEGIN
-- Kiểm tra xem người dùng có quyền quản lý tài khoản không
IF EXISTS (SELECT 1 FROM NguoiDung WHERE ID = @ID AND Role = 'sysadmin')
BEGIN
-- Cập nhật thông tin tài khoản
UPDATE NguoiDung
SET Username = @Username, Password = @Password, Role = @Role
WHERE ID = @ID;
END;
END;

alter table SoDauBai
add SoTiet int,
 NgayNhap date;
 
alter table SoDauBai
add MaGV int,
 constraint MaGV
FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV);

CREATE PROCEDURE KiemTraVaGhiSoDauBai
    @MaSoDauBai INT
AS
BEGIN
    -- Kiểm tra sổ đầu bài
    IF EXISTS (SELECT * FROM SodauBai WHERE MaSoDauBai = @MaSoDauBai)
    BEGIN
        -- Lấy thông tin về sổ đầu bài
        DECLARE @MaGV INT, @NgayNhap DATE, @SoTiet INT;
        SELECT @MaGV = MaGV, @NgayNhap = NgayNhap, @SoTiet = SoTiet FROM SodauBai WHERE MaSoDauBai = @MaSoDauBai;

        -- Kiểm tra và ghi sổ đầu bài
        IF EXISTS (SELECT * FROM GiaoVien WHERE MaGV = @MaGV)
        BEGIN
            -- Kiểm tra xem giáo viên đã ghi sổ đầu bài cho ngày nhập đó hay chưa
            IF NOT EXISTS (SELECT * FROM SodauBaiGiaoVien WHERE MaGV = @MaGV AND NgayNhap = @NgayNhap)
            BEGIN
                -- Ghi sổ đầu bài cho giáo viên
                INSERT INTO SodauBaiGiaoVien (MaGV, NgayNhap, SoTiet)
                VALUES (@MaGV, @NgayNhap, @SoTiet);

                -- In thông báo ghi sổ đầu bài thành công
                PRINT 'Ghi sổ đầu bài thành công.';
            END;
            ELSE
            BEGIN
                -- In thông báo sổ đầu bài đã được ghi
                PRINT 'Sổ đầu bài đã được ghi cho ngày nhập đó.';
            END;
        END;
        ELSE
        BEGIN
            -- In thông báo giáo viên không tồn tại
            PRINT 'Giáo viên không tồn tại.';
        END;
    END;
    ELSE
    BEGIN
        -- In thông báo sổ đầu bài không tồn tại
        PRINT 'Sổ đầu bài không tồn tại.';
    END;
END;

CREATE TRIGGER KiemTraVaGhiSoDauBaiTrigger
ON SodauBai
AFTER INSERT
AS
BEGIN
    -- Kiểm tra và báo cáo sổ đầu bài
    DECLARE @MaSoDauBai INT;
    SELECT @MaSoDauBai = MaSoDauBai FROM inserted;

    -- Lấy thông tin về sổ đầu bài
    DECLARE @MaGV INT, @NgayNhap DATE, @SoTiet INT;
    SELECT @MaGV = MaGV, @NgayNhap = NgayNhap, @SoTiet = SoTiet FROM SodauBai WHERE MaSoDauBai = @MaSoDauBai;

    -- Kiểm tra và ghi sổ đầu bài
    IF EXISTS (SELECT * FROM GiaoVien WHERE MaGV = @MaGV)
    BEGIN
        -- Kiểm tra xem giáo viên đã ghi sổ đầu bài cho ngày nhập đó hay chưa
        IF NOT EXISTS (SELECT * FROM SodauBaiGiaoVien WHERE MaGV = @MaGV AND NgayNhap = @NgayNhap)
        BEGIN
            -- Ghi sổ đầu bài cho giáo viên
            INSERT INTO SodauBaiGiaoVien (MaGV, NgayNhap, SoTiet)
            VALUES (@MaGV, @NgayNhap, @SoTiet);

            -- In thông báo ghi sổ đầu bài thành công
            PRINT 'Ghi sổ đầu bài thành công.';
        END;
        ELSE
        BEGIN
            -- In thông báo sổ đầu bài đã được ghi
            PRINT 'Sổ đầu bài đã được ghi cho ngày nhập đó.';
        END;
    END;
    ELSE
    BEGIN
        -- In thông báo giáo viên không tồn tại
        PRINT 'Giáo viên không tồn tại.';
    END;
END;
