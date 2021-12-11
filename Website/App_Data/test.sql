use master
go
-- Tao CSDL
if exists	(
	select 1
	from master.sys.databases
	where name = N'TN213'
)
drop database TN213
go
create database TN213
go
use TN213
go
-- Tao cac table
-- Table VaiTro
if exists (
	select 1
	from sys.tables
	where name = N'VaiTro'
)
drop table VaiTro
go
create table VaiTro (
	ma_vt int not null identity(1,1),
	ten_vt nvarchar(50) not null
	

	constraint pk_vaitro_ma_vt primary key (ma_vt),
	constraint uc_vaitro_tenvt unique(ten_vt)
)
go
-- Table MauSac
if exists (
	select 1
	from sys.tables
	where name = N'MauSac'
)
drop table MauSac
go
create table MauSac (
	ma_ms char(6) not null,
	ten_ms nvarchar(50) not null

	constraint pk_masac_ma_ms primary key (ma_ms),
	constraint uc_mausac_ten_ms unique(ten_ms)
)
go
-- Table LoaiBaoCao
if exists (
	select 1
	from sys.tables
	where name = N'LoaiBaoCao'
)
drop table LoaiBaoCao
go
create table LoaiBaoCao (
	ma_lbc int not null identity(1,1),
	ten_lbc nvarchar(50) not null

	constraint pk_loaibaocao_ma_lbc primary key (ma_lbc),
	constraint uc_loabaocao_ten_lbc unique(ten_lbc)
)
go
-- Table LoaiPhong
if exists (
	select 1
	from sys.tables
	where name = N'LoaiPhong'
)
drop table LoaiPhong
go
create table LoaiPhong (
	ma_lp int not null identity(1,1),
	ten_lp nvarchar(50) not null,
	mota_lp  nvarchar(1000)

	constraint pk_loaiphong_ma_lp primary key (ma_lp),
	constraint uc_loaiphong_ten_lp unique(ten_lp)
)
go
-- Table Ngay
if exists (
	select 1
	from sys.tables
	where name = N'Ngay'
)
drop table Ngay
go
create table Ngay (
	ngay datetime default GETDATE()

	constraint pk_ngay_ngay primary key (ngay)
)
go
-- Table NguoiDung
if exists (
	select 1
	from sys.tables
	where name = N'NguoiDung'
)
drop table NguoiDung
go
create table NguoiDung (
	ma_nd int not null identity(1,1),
	ma_vt int not null,
	ten_nd nvarchar(15) not null,
	holot_nd nvarchar(35)not null,
	gioitinh_nd tinyint not null,
	sdt_nd char(10),
	email varchar(50),
	diachi nvarchar(200),
	anh_nd varchar(200) not null,
	taikhoan varchar(50) not null,
	matkhau varchar(100) not null

	constraint pk_nguoidung_ma_nd primary key (ma_nd),
	constraint fp_nguoidung_ma_vt_vaitro_ma_vt foreign key (ma_vt) references VaiTro(ma_vt),
	constraint uc_nguoidung_taikhoan unique(taikhoan)
)
go
-- Table KhuVuc
if exists (
	select 1
	from sys.tables
	where name = N'KhuVuc'
)
drop table KhuVuc
go
create table KhuVuc (
	ma_kv int not null identity(1,1),
	ma_ms char(6) not null,
	ten_kv nvarchar(50) not null,
	toado_kv geometry not null,
	polygon_kv geometry not null

	constraint pk_khuvuc_ma_kv primary key (ma_kv),
	constraint fk_khuvuc_ma_ms_mausac_ma_ms foreign key (ma_ms) references MauSac(ma_ms),
	constraint uc_khuvuc_ten_kv unique(ten_kv)
)
go
-- Table NhaTro
if exists (
	select 1
	from sys.tables
	where name = N'NhaTro'
)
drop table NhaTro
go
create table NhaTro (
	ma_nt int not null identity(1,1),
	ma_nd int not null,
	ma_kv int not null,
	ten_nt nvarchar(50) not null,
	diachi_nt nvarchar(200) not null,
	sdt_nt char(10) not null,
	toado_nt geometry not null

	constraint pk_nhatro_ma_nt primary key (ma_nt),
	constraint fp_nhatro_ma_nd_nguoidung_ma_nd foreign key (ma_nd) references NguoiDung(ma_nd),
	constraint fp_nhatro_ma_kv_khuvuc_ma_kv foreign key (ma_kv) references KhuVuc(ma_kv)
)
go
-- Table TruongHoc
if exists (
	select 1
	from sys.tables
	where name = N'TruongHoc'
)
drop table TruongHoc
go
create table TruongHoc (
	ma_th int not null identity(1,1),
	ma_kv int not null,
	ten_th nvarchar(100) not null,
	diachi_th nvarchar(200) not null,
	toado_th geometry not null

	constraint pk_truonghoc_ma_th primary key (ma_th),
	constraint fp_truonghoc_ma_kv_khuvuc_ma_kv foreign key (ma_kv) references KhuVuc(ma_kv),
	constraint uc_truonghoc_ten_th unique(ten_th)
)
go
-- Table AnhNhaTro
if exists (
	select 1
	from sys.tables
	where name = N'AnhNhaTro'
)
drop table AnhNhaTro
go
create table AnhNhaTro (
	ma_nt int not null,
	STT int not null,
	ten_anh nvarchar(200) not null,
	mota_anh  nvarchar(1000)

	constraint pk_anhnhatro_ma_nt primary key (ma_nt, STT),
	constraint fp_anhnhatro_ma_nt_anhnhatro_nt foreign key (ma_nt) references NhaTro(ma_nt)
)
go
-- Table BaoCaoNguoiDung
if exists (
	select 1
	from sys.tables
	where name = N'BaoCaoNguoiDung'
)
drop table BaoCaoNguoiDung
go
create table BaoCaoNguoiDung (
	nguoi_bao_cao int not null,
	nguoi_bi_bao_cao int not null,
	ma_lbc int not null,
	ngay datetime not null,
	lydo  nvarchar(1000) ,
	trangthai tinyint default 0

	constraint pk_baocaonguoidung primary key (nguoi_bao_cao, nguoi_bi_bao_cao, ma_lbc, ngay),
	constraint fp_baocaonguoidung1 foreign key (nguoi_bao_cao) references NguoiDung(ma_nd),
	constraint fp_baocaonguoidung2 foreign key (nguoi_bi_bao_cao) references NguoiDung(ma_nd),
	constraint fp_baocaonguoidung3 foreign key (ma_lbc) references LoaiBaoCao(ma_lbc),
	constraint fp_baocaonguoidung4 foreign key (ngay) references Ngay(ngay)
)
go
-- Table BaoCaoNhaTro
if exists (
	select 1
	from sys.tables
	where name = N'BaoCaoNhaTro'
)
drop table BaoCaoNhaTro
go
create table BaoCaoNhaTro (
	ma_nd int not null,
	ma_nt int not null,
	ma_lbc int not null,
	ngay datetime not null,
	lydobaocao  nvarchar(1000) ,
	trangthaibaocao tinyint default 0

	constraint pk_nhatro primary key (ma_nd, ma_nt, ma_lbc, ngay),
	constraint fp_nhatro1 foreign key (ma_nd) references NguoiDung(ma_nd),
	constraint fp_nhatro2 foreign key (ma_nt) references NhaTro(ma_nt),
	constraint fp_nhatro3 foreign key (ma_lbc) references LoaiBaoCao(ma_lbc),
	constraint fp_nhatro4 foreign key (ngay) references Ngay(ngay)
)
go
-- Table CoTienDienNuoc
if exists (
	select 1
	from sys.tables
	where name = N'CoTienDienNuoc'
)
drop table CoTienDienNuoc
go
create table CoTienDienNuoc (
	ma_nt int not null,
	ngay datetime not null,
	tiendien float default 0,
	tiennuoc float default 0

	constraint pk_cotiendiennuoc primary key (ma_nt, ngay),
	constraint fp_cotiendiennuoc1 foreign key (ma_nt) references NhaTro(ma_nt),
	constraint fp_cotiendiennuoc2 foreign key (ngay) references Ngay(ngay)
)
go
-- Table CoGia
if exists (
	select 1
	from sys.tables
	where name = N'CoGia'
)
drop table CoGia
go
create table CoGia (
	ma_nt int not null,
	ngay datetime not null,
	ma_lp int not null,
	giaphong float default 0

	constraint pk_cogia primary key (ma_nt, ngay),
	constraint fp_cogia1 foreign key (ma_nt) references NhaTro(ma_nt),
	constraint fp_cogia2 foreign key (ngay) references Ngay(ngay),
	constraint fp_cogia3 foreign key (ma_lp) references LoaiPhong(ma_lp)
)
go
-- Table DanhGia
if exists (
	select 1
	from sys.tables
	where name = N'DanhGia'
)
drop table DanhGia
go
create table DanhGia (
	ma_nt int not null,
	ngay datetime not null,
	ma_nd int not null,
	danhgia nvarchar(1000) ,
	sosao int not null

	constraint pk_danhgia primary key (ma_nt, ngay),
	constraint fp_danhgia1 foreign key (ma_nt) references NhaTro(ma_nt),
	constraint danhgia2 foreign key (ngay) references Ngay(ngay),
	constraint danhgia3 foreign key (ma_nd) references NguoiDung(ma_nd)
)
go
-- Them du lieu
insert into VaiTro (ten_vt)
values
	(N'Admin'),
	(N'Chủ trọ'),
	(N'Người dùng')
go
insert into MauSac(ma_ms, ten_ms)
values	
	(N'000000', N'Đen'),
	(N'FF0000', N'Đỏ'),
	(N'00FF00', N'Xanh chanh'),
	(N'0000FF', N'Xanh dương'),
	(N'FFFF00', N'Vàng'),
	(N'00FFFF', N'Lục lam (Aqua)'),
	(N'FF00FF', N'Đỏ tươi (Fuchsia)'),
	(N'C0C0C0', N'Bạc'),
	(N'808080', N'Xám'),
	(N'800000', N'Đỏ (Maroon)'),
	(N'808000', N'Ôliu'),
	(N'008000', N'Xanh lá'),
	(N'800080', N'Tía (Purple)'),
	(N'008080', N'Mòng két (Teal)'),
	(N'000080', N'Xanh Navy'),
	(N'FFFFFF', N'Trắng');
go
insert into LoaiBaoCao(ten_lbc)
values
	(N'Nhà trọ không tồn tại'),
	(N'Nhà trọ đã đóng cửa/ngừng kinh doanh'),
	(N'Tiền điện/nước không đúng'),
	(N'Người dùng quấy rối'),
	(N'Người dùng không lịch sự'),
	(N'Người dùng đưa thông tin sai'),
	(N'Khác');
go
insert into LoaiPhong(ten_lp, mota_lp)
values
	(N'Phòng thường', N'Phòng không có sự khác biệt so với các phòng trong khu nhà trọ'),
	(N'Phòng có máy lạnh', N'Phòng được phép lắp máy lạnh hoặc đã được lắp máy lạnh trong khi các phòng thường không có hoặc không được phép lắp'),
	(N'Phòng có gác lửng', N'Phòng có gác lửng trong khi các phòng thường không có gác lửng'),
	(N'Phòng ở mặt tiền', N'Phòng ở mặt tiền trong khi các phòng thường khuất phía trong'),
	(N'Phòng không có gác', N'Phòng không có gác trong khi các phòng thường có gác lửng'),
	(N'Phòng cho 1 người ở', N'');
go
insert into KhuVuc(ma_ms, ten_kv, toado_kv, polygon_kv)
values
	(N'FF0000', N'An Phú', geometry::STGeomFromText('POINT (105.77797393798828 10.031647109985386)', 0), geometry::STGeomFromText('POLYGON ((105.77990722656244 10.029501914978027, 105.7770233154298 10.027043342590389, 105.77456665039057 10.03265285491949, 105.77646636962885 10.03774452209467, 105.78190612792974 10.031292915344352, 105.77990722656244 10.029501914978027 ))', 0)),
	(N'000080', N'An Bình', geometry::STGeomFromText('POINT (105.73596679687502 10.009947452545207)', 0), geometry::STGeomFromText('POLYGON ((105.73963165283214 9.99405479431158, 105.73500061035162 9.99346923828125, 105.73162841796886 9.994029998779354, 105.73243713378906 9.9960355758667, 105.73126983642572 9.997006416320744, 105.7312469482423 10.000364303588924, 105.73001861572271 10.001773834228516, 105.72899627685547 10.001826286315975, 105.72901916503906 10.00252914428711, 105.72677612304693 10.003549575805778, 105.72650909423822 10.004782676696834, 105.72243499755865 10.003251075744629, 105.7205200195313 10.004156112670955, 105.71913909912115 10.003540039062614, 105.71737670898438 10.00781631469738, 105.72020721435541 10.010971069336051, 105.7210540771485 10.011114120483512, 105.7237396240235 10.009398460388297, 105.72447204589844 10.010979652404899, 105.72582244873053 10.009654998779354, 105.72730255126953 10.011291503906307, 105.72753143310553 10.010048866272086, 105.72897338867182 10.009836196899471, 105.73023986816412 10.010531425476074, 105.73013305664057 10.011805534362907, 105.73210144042969 10.013679504394531, 105.7343139648437 10.014757156372127, 105.73428344726574 10.015789985656795, 105.73343658447266 10.016019821167049, 105.73441314697271 10.016469955444279, 105.73442840576178 10.017342567443848, 105.73770904541027 10.016681671142578, 105.73995971679693 10.019230842590389, 105.74156188964838 10.023065567016545, 105.7438430786134 10.03245735168457, 105.74876403808605 10.03028583526617, 105.75137329101568 10.025925636291504, 105.75250244140625 10.021870613098201, 105.75156402587896 10.020942687988281, 105.75105285644543 10.018297195434513, 105.7525253295899 10.016695976257381, 105.75145721435558 10.015800476074219, 105.7517318725586 10.014616012573242, 105.75384521484375 10.013381004333553, 105.75600433349615 10.008525848388729, 105.75306701660156 10.008012771606445, 105.7476272583009 10.006089210510254, 105.74515533447277 10.004319190979118, 105.74346160888683 9.998361587524471, 105.74067687988281 9.994936943054256, 105.73963165283214 9.99405479431158 ))', 0)), 	
	(N'008080', N'An Cư', geometry::STGeomFromText('POINT (105.78074972970147 10.03688035692494)', 0), geometry::STGeomFromText('POLYGON ((105.78653717041027 10.035424232482853, 105.78218841552729 10.031546592712516, 105.78190612792974 10.031292915344352, 105.77646636962885 10.03774452209467, 105.77749633789062 10.040566444397086, 105.77944183349615 10.040320396423454, 105.78121185302746 10.041267395019645, 105.78653717041027 10.035424232482853 ))', 0)), 	
	(N'800080', N'An Hòa', geometry::STGeomFromText('POINT (105.76593208312988 10.044519424438501)', 0), geometry::STGeomFromText('POLYGON ((105.77305603027344 10.040645599365178, 105.77193450927734 10.039216041565055, 105.77006530761724 10.039093017578125, 105.76923370361322 10.038523674011174, 105.76776885986328 10.038884162902889, 105.76226043701178 10.044759750366211, 105.7609252929688 10.04507827758789, 105.75833129882824 10.043702125549316, 105.75379943847656 10.045870780944881, 105.75517272949219 10.047430992126465, 105.75926208496105 10.04569244384777, 105.76054382324224 10.047856330871639, 105.76995086669933 10.051004409790096, 105.77178192138678 10.053653717041016, 105.77783966064453 10.047591209411564, 105.77298736572277 10.043308258056754, 105.77305603027344 10.040645599365178 ))', 0)), 	
	(N'008000', N'An Khánh', geometry::STGeomFromText('POINT (105.75835997482828 10.030040247686996)', 0), geometry::STGeomFromText('POLYGON ((105.76923370361322 10.038523674011174, 105.76784515380871 10.036955833435059, 105.76750946044916 10.034730911254883, 105.7645034790039 10.032960891723746, 105.76245117187506 10.02994251251232, 105.76385498046886 10.027530670166016, 105.76631927490246 10.025544166564941, 105.76551818847662 10.02385234832758, 105.7623672485351 10.025735855102482, 105.7609252929688 10.025456428527832, 105.76038360595709 10.024511337280273, 105.7593154907226 10.025263786315975, 105.7570190429687 10.018251419067496, 105.75611877441406 10.018129348754883, 105.75566864013683 10.017092704773006, 105.7525253295899 10.016695976257381, 105.75105285644543 10.018297195434513, 105.75156402587896 10.020942687988281, 105.75250244140625 10.021870613098201, 105.75137329101568 10.025925636291504, 105.74876403808605 10.03028583526617, 105.7438430786134 10.03245735168457, 105.74608612060553 10.035618782043514, 105.7526092529298 10.046296119689885, 105.75379943847656 10.045870780944881, 105.75833129882824 10.043702125549316, 105.7609252929688 10.04507827758789, 105.76226043701178 10.044759750366211, 105.76776885986328 10.038884162902889, 105.76923370361322 10.038523674011174 ))', 0)), 	
	(N'800000', N'An Nghiệp', geometry::STGeomFromText('POINT (105.77393086751302 10.038319746653267)', 0), geometry::STGeomFromText('POLYGON ((105.77646636962885 10.03774452209467, 105.77456665039057 10.03265285491949, 105.77006530761724 10.039093017578125, 105.77193450927734 10.039216041565055, 105.77305603027344 10.040645599365178, 105.77749633789062 10.040566444397086, 105.77646636962885 10.03774452209467 ))', 0)), 	
	(N'808080', N'Cái Khế', geometry::STGeomFromText('POINT (105.78425643023326 10.052169519312278)', 0), geometry::STGeomFromText('POLYGON ((105.78341674804693 10.042012214660588, 105.77783966064453 10.047591209411564, 105.77178192138678 10.053653717041016, 105.77137756347656 10.054058074951172, 105.7743911743164 10.056389808654899, 105.77043151855469 10.061621665954647, 105.77671813964844 10.067522048950195, 105.77846527099615 10.071363449096793, 105.7810440063476 10.07008266448986, 105.78886413574213 10.062847137451172, 105.7951126098634 10.053308486938533, 105.79844665527344 10.049043655395508, 105.80301666259766 10.043032646179256, 105.79503631591797 10.036508560180721, 105.79214477539062 10.036084175109977, 105.78921508789074 10.038972854614315, 105.78505706787104 10.042789459228516, 105.78341674804693 10.042012214660588 ))', 0)), 	
	(N'C0C0C0', N'Hưng Lợi', geometry::STGeomFromText('POINT (105.76219003850764 10.017582459883274)', 0), geometry::STGeomFromText('POLYGON ((105.7525253295899 10.016695976257381, 105.75566864013683 10.017092704773006, 105.75611877441406 10.018129348754883, 105.7570190429687 10.018251419067496, 105.7593154907226 10.025263786315975, 105.76038360595709 10.024511337280273, 105.7609252929688 10.025456428527832, 105.7623672485351 10.025735855102482, 105.76551818847662 10.02385234832758, 105.76636505126947 10.023159980773926, 105.76807403564447 10.025103569030819, 105.77172088623047 10.020546913146916, 105.7741088867188 10.019733428955078, 105.77394104003918 10.01699161529541, 105.77178192138678 10.011948585510368, 105.76966857910156 10.009299278259277, 105.76603698730469 10.00655746459961, 105.76360321044928 10.006160736083984, 105.75600433349615 10.008525848388729, 105.75384521484375 10.013381004333553, 105.7517318725586 10.014616012573242, 105.75145721435558 10.015800476074219, 105.7525253295899 10.016695976257381 ))', 0)), 	
	(N'FF00FF', N'Tân An', geometry::STGeomFromText('POINT (105.78759256998703 10.031908671061254)', 0), geometry::STGeomFromText('POLYGON ((105.78123807907104 10.041236055882486, 105.78648447990417 10.035531177030729, 105.77987551689148 10.02954094604865, 105.78086256980896 10.024173943084676, 105.78691363334656 10.026128472171555, 105.78863024711609 10.028188638718467, 105.78970313072203 10.033365409657616, 105.79195618629456 10.036460867849225, 105.78498244285583 10.042831291050609, 105.78123807907104 10.041236055882486 ))', 0)), 	
	(N'FF0000', N'Thới Bình', geometry::STGeomFromText('POINT (105.7779214041574 10.042244502476324)', 0), geometry::STGeomFromText('POLYGON ((105.77305603027344 10.040645599365178, 105.77298736572277 10.043308258056754, 105.77783966064453 10.047591209411564, 105.78341674804693 10.042012214660588, 105.78121185302746 10.041267395019645, 105.77944183349615 10.040320396423454, 105.77749633789062 10.040566444397086, 105.77305603027344 10.040645599365178 ))', 0)), 	
	(N'0000FF', N'Xuân khánh', geometry::STGeomFromText('POINT (105.77029800415039 10.02857049306236)', 0), geometry::STGeomFromText('POLYGON ((105.76923370361322 10.038523674011174, 105.77006530761724 10.039093017578125, 105.77456665039057 10.03265285491949, 105.7770233154298 10.027043342590389, 105.77990722656244 10.029501914978027, 105.78089141845703 10.024167060852108, 105.77540588378912 10.023225784301871, 105.7741088867188 10.019733428955078, 105.77172088623047 10.020546913146916, 105.76807403564447 10.025103569030819, 105.76636505126947 10.023159980773926, 105.76551818847662 10.02385234832758, 105.76631927490246 10.025544166564941, 105.76385498046886 10.027530670166016, 105.76245117187506 10.02994251251232, 105.7645034790039 10.032960891723746, 105.76750946044916 10.034730911254883, 105.76784515380871 10.036955833435059, 105.76923370361322 10.038523674011174))', 0));
go 
insert into NguoiDung(ma_vt, ten_nd, holot_nd, gioitinh_nd, sdt_nd, email, diachi, anh_nd, taikhoan, matkhau) 
values
 	(1, N'Lý', N'Quản', 1, '0123456789', 'quanly@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'admin', '12345'),
 	(2, N'Trọ', N'Chủ', 0, '0918273645', 'chutro@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'user1', '12345'),
	(2, N'Gia', N'An', 1, '0115206154', 'angia@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/angia.jpg', 'angia', '12345'),
	(2, N'Nam', N'Hoàng', 1, '0760435692', 'hoangnam@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/hoangnam.jpg', 'hoangnam', '12345'),
	(2, N'Hưng', N'Thới', 0, '0242127720', 'thoihung@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/thoihung.jpg', 'thoihung', '12345'),
	(2, N'Tâm', N'Đăng', 0, '0973662788', 'dangtam@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/dangtam.jpg', 'dangtam', '12345'),
	(2, N'Đạt', N'Tấn', 1, '0310754913', 'tandat@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/tandat.jpg', 'tandat', '12345'),
	(2, N'Nga', N'Khánh', 0, '0427492698', 'khanhnga@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/khanhnga.jpg', 'khanhnga', '12345'),
	(2, N'Khánh', N'Minh', 0, '0282479244', 'minhkhanh@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/minhkhanh.jpg', 'minhkhanh', '12345'),
	(2, N'Thành', N'Đặng', 1, '0254308536', 'dangthanh@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/dangthanh.jpg', 'dangthanh', '12345'),
	(2, N'Anh', N'Tuấn', 1, '0629942832', 'tuananh@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/tuananh.jpg', 'tuananh', '12345'),
	(2, N'Quyên', N'Lệ', 0, '0318453946', 'lequyen@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/lequyen.jpg', 'lequyen', '12345'),
	(2, N'Hằng', N'Thị', 0, '0822917147', 'thihang@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/thihang.jpg', 'thihang', '12345'),
	(2, N'Tín', N'Trung', 1, '0694678593', 'trungtin@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/trungtin.jpg', 'trungtin', '12345'),
	(2, N'Nhựt', N'Minh', 1, '0470213104', 'minhnhut@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/minhnhut.jpg', 'minhnhut', '12345'),
	(2, N'Thuận', N'Trọ', 0, '0198693704', 'trothuan@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/trothuan.jpg', 'trothuan', '12345'),
	(2, N'Phong', N'Trấn', 1, '0399887876', 'tranphong@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/tranphong.jpg', 'tranphong', '12345'),
	(2, N'An', N'Mỹ', 0, '0583703479', 'myan@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/myan.jpg', 'myan', '12345'),
	(2, N'Vân', N'Thanh', 0, '0820744164', 'thanhvan@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/thanhvan.jpg', 'thanhvan', '12345'),
	(2, N'Trí', N'Đức', 1, '0821833408', 'ductri@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/ductri.jpg', 'ductri', '12345'),
	(2, N'Lộc', N'Quốc', 1, '0942410378', 'quocloc@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/quocloc.jpg', 'quocloc', '12345'),
	(2, N'Thuỷ', N'Thị', 0, '0304204426', 'thithuy@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/thithuy.jpg', 'thithuy', '12345'),
	(2, N'Bảo', N'Quốc', 1, '0437105672', 'quocbao@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/quocbao.jpg', 'quocbao', '12345'),
	(2, N'Lệ', N'Bích', 0, '0462998535', 'bichle@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/bichle.jpg', 'bichle', '12345'),
	(2, N'Hồng', N'Cô', 0, '0591213252', 'cohong@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/cohong.jpg', 'cohong', '12345'),
	(2, N'Hương', N'Thị', 0, '0657020836', 'thihuong@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/thihuong.jpg', 'thihuong', '12345'),
	(2, N'VĂN', N'HAI', 0, '0423433010', 'haivan@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/haivan.jpg', 'haivan', '12345'),
	(2, N'NGỌC', N'PHƯỚC', 1, '0454765002', 'phuocngoc@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/phuocngoc.jpg', 'phuocngoc', '12345'),
	(2, N'Vân', N'Cô', 0, '0334910097', 'covan@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/covan.jpg', 'covan', '12345'),
	(2, N'Tido', N'SV', 0, '0581252991', 'svtido@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'svtido', '12345'),
	(2, N'Tài.', N'Đức', 1, '0723813816', 'ductai.@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/ductai.jpg', 'ductai.', '12345'),
	(2, N'Tiên', N'Cô', 0, '0757575442', 'cotien@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/cotien.jpg', 'cotien', '12345'),
	(2, N'Trang', N'Trọ', 0, '0476089852', 'trotrang@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/trotrang.jpg', 'trotrang', '12345'),
	(2, N'Tín', N'Đức', 1, '0751274073', 'ductin@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/ductin.jpg', 'ductin', '12345'),
	(2, N'Hồng', N'Thu', 0, '0363742197', 'thuhong@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/thuhong.jpg', 'thuhong', '12345'),
	(2, N'Trung', N'Quang', 1, '0931347579', 'quangtrung@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/quangtrung.jpg', 'quangtrung', '12345'),
	(2, N'Thuý', N'Ngọc', 0, '0564796241', 'ngocthuy@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/ngocthuy.jpg', 'ngocthuy', '12345'),
	(2, N'Đệ', N'Nguyễn', 1, '0244775786', 'nguyende@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/nguyende.jpg', 'nguyende', '12345'),
	(2, N'Tâm', N'Thanh', 1, '0694674225', 'thanhtam@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/thanhtam.jpg', 'thanhtam', '12345'),
	(2, N'Yến', N'Cô', 0, '0559194267', 'coyen@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/coyen.jpg', 'coyen', '12345'),
	(2, N'Duyên', N'Lệ', 0, '0861156243', 'leduyen@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/leduyen.jpg', 'leduyen', '12345'),
	(2, N'Ngọc', N'Hồng', 0, '0263414532', 'hongngoc@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/hongngoc.jpg', 'hongngoc', '12345'),
	(2, N'Viên', N'Sinh', 1, '0223416165', 'sinhvien@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/sinhvien.jpg', 'sinhvien', '12345'),
	(2, N'Hoàng', N'Cô', 0, '0175359444', 'cohoang@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'cohoang', '12345'),
	(2, N'Tâm', N'Thanh', 0, '0437511214', 'thanhtam@gmail.com', N'Cần Thơ', '/Content/ckfinder/userfiles/images/thanhtam2.jpg', 'thanhtam2', '12345'),
	(2, N'Ngọc', N'Hồng', 0, '0245037035', 'hongngoc@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'hongngoc2', '12345'),
	(2, N'Hưng', N'Hồng', 1, '0842129689', 'honghung@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'honghung', '12345'),
	(2, N'Thanh', N'sĩ', 1, '0288538291', 'sithanh@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'sithanh', '12345'),
	(2, N'Sáu', N'Văn', 0, '0521255634', 'vansau@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'vansau', '12345'),
	(2, N'Phú', N'trọ', 0, '0157811890', 'trophu@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'trophu', '12345'),
	(2, N'Tiến', N'Hải', 0, '0741480508', 'haitien@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'haitien', '12345'),
	(2, N'Lộc', N'Phát', 0, '0512246995', 'phatloc@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'phatloc', '12345'),
	(2, N'Ý', N'Như', 1, '0405538585', 'nhuy@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'nhuy', '12345'),
	(2, N'Loan', N'Bích', 0, '0164255168', 'bichloan@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'bichloan', '12345'),
	(2, N'Châm', N'Mỹ', 1, '0702801017', 'mycham@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'mycham', '12345'),
	(2, N'Lưu', N'Quỳnh', 1, '0167304912', 'quynhluu@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'quynhluu', '12345'),
	(2, N'Thanh', N'Hà', 0, '0178808336', 'hathanh@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'hathanh', '12345'),
	(2, N'Yến', N'Hồng', 0, '0939382420', 'hongyen@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'hongyen', '12345'),
	(2, N'Hải', N'Phát', 1, '0487079491', 'phathai@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'phathai', '12345'),
	(2, N'Anh', N'Hồng', 1, '0978365476', 'honganh@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'honganh', '12345'),
	(2, N'Tuyền', N'Ngân', 1, '0618344881', 'ngantuyen@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'ngantuyen', '12345'),
	(2, N'Tuấn', N'Minh', 1, '0319441626', 'minhtuan@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'minhtuan', '12345'),
	(2, N'Tùng', N'Thanh', 1, '0700108903', 'thanhtung@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'thanhtung', '12345'),
	(2, N'Phượng', N'Cô', 1, '0428034107', 'cophuong@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'cophuong', '12345'),
	(2, N'Châu', N'Ngọc', 1, '0871171941', 'ngocchau@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'ngocchau', '12345'),
	(2, N'Hà', N'Huỳnh', 0, '0357790811', 'huynhha@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'huynhha', '12345'),
	(2, N'Tam', N'Mười', 1, '0638534053', 'muoitam@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'muoitam', '12345'),
	(2, N'Thân', N'Thị', 0, '0613707441', 'thithan@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'thithan', '12345'),
	(2, N'Gia', N'An', 1, '0352522034', 'angia@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'angia2', '12345'),
	(2, N'Ân', N'Vĩnh', 1, '0196197140', 'vinhan@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'vinhan', '12345'),
	(2, N'Thành', N'Mai', 1, '0120522688', 'maithanh@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'maithanh', '12345'),
	(2, N'Hóa', N'Văn', 1, '0768329537', 'vanhoa@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'vanhoa', '12345'),
	(2, N'Linh', N'Tường', 0, '0224470895', 'tuonglinh@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'tuonglinh', '12345'),
	(2, N'Vũ', N'Huỳnh', 1, '0661897835', 'huynhvu@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'huynhvu', '12345'),
	(2, N'Nhân', N'Trọ', 1, '0304123221', 'tronhan@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'tronhan', '12345'),
	(2, N'Thọ', N'Chí', 1, '0953064574', 'chitho@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'chitho', '12345'),
	(2, N'Trang', N'Thảo', 0, '0536386119', 'thaotrang@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'thaotrang', '12345'),
	(2, N'Trâm', N'Anh', 0, '0424166452', 'anhtram@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'anhtram', '12345'),
	(2, N'Phượng', N'Thu', 0, '0749100828', 'thuphuong@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'thuphuong', '12345'),
	(2, N'Thư', N'Ngọc', 0, '0323345008', 'ngocthu@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'ngocthu', '12345'),
	(2, N'Việt', N'Trí', 1, '0249613113', 'triviet@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'triviet', '12345'),
	(2, N'Bảy', N'Cô', 0, '0176638239', 'cobay@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'cobay', '12345'),
	(2, N'Kiều', N'trọ', 0, '0535593981', 'trokieu@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'trokieu', '12345'),
	(2, N'Liên', N'Huỳnh', 0, '0692582717', 'huynhlien@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'huynhlien', '12345'),
	(2, N'Tường', N'Hữu', 1, '0708303901', 'huutuong@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'huutuong', '12345'),
	(2, N'Yến', N'Thị', 0, '0203287848', 'thiyen@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'thiyen', '12345'),
	(2, N'Khánh', N'An', 0, '0372171995', 'ankhanh@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'ankhanh', '12345'),
	(2, N'Lợi', N'Vạn', 0, '0993549278', 'vanloi@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'vanloi', '12345'),
	(2, N'Nhi', N'Trọ', 0, '0611468830', 'tronhi@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'tronhi', '12345'),
	(2, N'Phạm', N'Hiếu', 0, '0470547501', 'hieupham@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'hieupham', '12345'),
	(2, N'Trí', N'Hữu', 1, '0288403032', 'huutri@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'huutri', '12345'),
	(2, N'Tú', N'Cẩm', 0, '0848366559', 'camtu@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'camtu', '12345'),
	(2, N'Lệ', N'Ngọc', 0, '0279072695', 'ngocle@gmail.com', N'Cần Thơ', '/Content/avatar.jpg', 'ngocle', '12345'),
 	(3, N'Dùng', N'Người', 1, null, null, null, '/Content/avatar.jpg', 'user2', '12345');
go
insert into TruongHoc(ma_kv, ten_th, diachi_th, toado_th)
values
	(9, N'Khu 3 - Đại học Cần Thơ', N'1 Đ. Lý Tự Trọng, An Lạc, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7797672 10.0336736)', 0)),
	(2, N'Trường Đại học Nam Cần Thơ', N'168 Nguyễn Văn Cừ nối dài, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.722688 10.007083)', 0)),
	(2, N'Trường Đại học FPT Cần Thơ', N'Cầu Rau Răm, đường Nguyễn Văn Cừ nối dài, An Bình, Ninh Kiều, Cần Thơ 900000, Việt Nam', geometry::STGeomFromText('POINT (105.731642 10.012069)', 0)),
	(4, N'Trường Cao đẳng Y tế Cần Thơ', N'340 Nguyễn Văn Cừ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7653427 10.044201)', 0)),
	(5, N'Đại Học Y Dược Cần Thơ', N'Số 179 Nguyễn Văn Cừ, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7545464 10.0334046)', 0)),
	(8, N'Đại học Cần Thơ Khu 1', N'Số 411 Đường 30 Tháng 4, Hưng Lợi, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7661977 10.0173986)', 0)),
	(11, N'Trường Cao đẳng Cần Thơ', N'413 đường 30 Tháng 4, phường Hưng Lợi, quận Ninh Kiều, 413 Đường 30 Tháng 4, Hưng Lợi, Ninh Kiều, Cần Thơ 92000, Việt Nam', geometry::STGeomFromText('POINT (105.764809 10.014161)', 0)),
	(11, N'Đại học Cần Thơ', N'Khu II, Đ. 3/2, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7706006 10.0297427)', 0)),
	(8, N'Trường Cao Đẳng Phạm Ngọc Thạch Cần Thơ', N'600 Đường 30 Tháng 4, Hưng Lợi, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7631112 10.0152634)', 0)),
	(1, N'Trường Cao đẳng Việt Mỹ', N'135 P Đ. Trần Hưng Đạo, An Phú, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7747009 10.0333245)', 0)),
	(8, N'Trường cao đẳng FPT Polytechnic Cần Thơ', N'Số 288 Đường Nguyễn Văn Linh, Hưng Lợi, Ninh Kiều, Cần Thơ 900000, Việt Nam', geometry::STGeomFromText('POINT (105.7570286 10.0269575)', 0)),
	(4, N'Trường Cao Đẳng Văn Hóa Nghệ Thuật Cần Thơ', N'188/35A Nguyễn Văn Cừ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7676894 10.0491236)', 0)),
	(4, N'Trường Cao đẳng Kinh tế - Kỹ thuật Cần Thơ', N'9 Đường Cách Mạng Tháng 8, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', geometry::STGeomFromText('POINT (105.7725678 10.052562)', 0)),
	(4, N'Trường Đại học Kỹ thuật - Công nghệ Cần Thơ', N'256 Nguyễn Văn Cừ, An Hoà, Ninh Kiều, Cần Thơ 900000, Việt Nam', geometry::STGeomFromText('POINT (105.7678188 10.0466393)', 0));
go
insert into NhaTro(ma_nd, ma_kv, ten_nt, diachi_nt, sdt_nt, toado_nt)
values
	(34, 2, N'Nhà trọ An Gia', N'An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.728828 10.011763)', 0)),
	(8, 2, N'Nhà trọ Hoàng Nam', N'đường Nguyễn Văn Trường, phường An Bình, quận Ninh Kiều, Tp. Cần Thơ.', '0123456789', geometry::STGeomFromText('POINT (105.729343 10.012518)', 0)),
	(64, 2, N'Nhà trọ Thới Hưng', N'KV4 Nguyễn Văn Cừ nối dài, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.745458 10.026339)', 0)),
	(36, 2, N'Nhà trọ sinh viên Đăng Tâm', N'Hoàng Quốc Việt, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0982295577', geometry::STGeomFromText('POINT (105.746864 10.013609)', 0)),
	(4, 2, N'Nhà Trọ Tấn Đạt', N'2P7W+RFP, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.746191 10.014597)', 0)),
	(90, 2, N'Nhà trọ Khánh Nga', N'2P7V+QWV, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.744784 10.014482)', 0)),
	(71, 2, N'Nhà Trọ Minh Khánh', N'Khu Vực Thạnh Mỹ, Phường An Bình, Quận Cái Răng, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0348431897', geometry::STGeomFromText('POINT (105.746145 10.012130)', 0)),
	(56, 2, N'Nhà Trọ Đặng Thành', N'69/109/2/2, hẻm 1, Trần Vĩnh Kiết, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.748141 10.011777)', 0)),
	(90, 2, N'Nhà trọ Thiên Hương 1', N'694/47/24, Khu Vực 3, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0932810679', geometry::STGeomFromText('POINT (105.749124 10.010950)', 0)),
	(71, 2, N'Nhà Trọ Thiên Hương 2', N'13/67 Trần Vĩnh Kiết, Khu vực 1, P. An Bình, Q. Ninh Kiều, TP, Cần Thơ 900000, Việt Nam', '0932810679', geometry::STGeomFromText('POINT (105.749594 10.011774)', 0)),
	(56, 2, N'Nhà Trọ Võ Tuấn Anh', N'115D/3, Khu Vực 1, Phường An Bình, Quận Ninh Kiều, Cần Thơ, Việt Nam', '0917303353', geometry::STGeomFromText('POINT (105.750128 10.010696)', 0)),
	(49, 2, N'Nhà Trọ Nguyễn Thị Lệ Quyên', N'100A/10C, Đường Ba Tháng Hai, Phường An Bình, Quận Ninh Kiều, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0915121091', geometry::STGeomFromText('POINT (105.750520 10.010641)', 0)),
	(23, 2, N'Nhà Trọ Lâm Thị Hằng', N'112/3, Quốc Lộ 1, Phường An Bình, Quận Ninh Kiều, Thành Phố Cần Thơ, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0858796538', geometry::STGeomFromText('POINT (105.750338 10.010020)', 0)),
	(25, 2, N'Phòng Trọ Trung Tín', N'45/8, Đường Lộ Vòng Cung, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0782927722', geometry::STGeomFromText('POINT (105.737687 9.995092)', 0)),
	(26, 2, N'Nhà Trọ 149', N'Nguyễn Văn Trường, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.734909 10.001160)', 0)),
	(34, 2, N'Nhà Trọ Minh Nhựt', N'113 Đường 3-2, P, Ninh Kiều, Cần Thơ, Việt Nam', '0917637272', geometry::STGeomFromText('POINT (105.752214 10.011460)', 0)),
	(11, 2, N'Nhà Trọ Thuận', N'129/3, Quốc Lộ 1A, P. Lê Bình, Quận Cái Răng, Hưng Lợi, Ninh Kiều, Cần Thơ, Việt Nam', '0923846612', geometry::STGeomFromText('POINT (105.753095 10.012295)', 0)),
	(67, 2, N'Nhà Cho Thuê Ngô Trấn Phong', N'9, Đường Ba Tháng Hai, Phường Hưng Lợi, Quận Ninh Kiều, Thành Phố Cần Thơ, Hưng Lợi, Ninh Kiều, Cần Thơ, Việt Nam', '0917964427', geometry::STGeomFromText('POINT (105.753116 10.012507)', 0)),
	(27, 2, N'Nhà Trọ 74/2', N'74/2 hẻm 4, Trần Vĩnh Kiết, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0907596427', geometry::STGeomFromText('POINT (105.751216 10.013719)', 0)),
	(83, 2, N'NHÀ TRỌ 68', N'2Q72+722, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0901041041', geometry::STGeomFromText('POINT (105.750007 10.013145)', 0)),
	(60, 2, N'Nhà trọ SV CACAO', N'129/92 (Hẻm 7) Trần Vĩnh Kiết, An Bình Ninh Kiều Can Tho City, 900000, Việt Nam', '0982333057', geometry::STGeomFromText('POINT (105.748277 10.015174)', 0)),
	(30, 2, N'Nhà trọ Mỹ An', N'129/98 Trần Vĩnh Kiết Cần Thơ Can Tho City, 92000, Việt Nam', '0908990993', geometry::STGeomFromText('POINT (105.748161 10.015095)', 0)),
	(63, 2, N'Nhà Trọ Võ Thanh Vân', N'1136, Khu Dân Cư Cái Sơn-Hàng Bàng, Phường An Bình, Quận Ninh Kiều, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0816811912', geometry::STGeomFromText('POINT (105.744042 10.017365)', 0)),
	(42, 2, N'Nhà Trọ Huỳnh Đức Trí', N'25A3, Đường Nguyễn Văn Cừ, Khu Vực 4, Phường An Bình, Quận Ninh Kiều, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0914847083', geometry::STGeomFromText('POINT (105.741509 10.019149)', 0)),
	(91, 2, N'Nhà Trọ Quốc Lộc', N'2P8J+HJX, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.731606 10.016481)', 0)),

	(52, 3, N'Nhà Trọ Phan Thị Thuỷ', N'107/90, Hoàng Văn Thụ, Phường An Cư, Quận Ninh Kiều, Thành Phố Cần Thơ, An Cư, Ninh Kiều, Cần Thơ, Việt Nam', '0931949267', geometry::STGeomFromText('POINT (105.777658 10.040054)', 0)),
	(21, 3, N'Nhà Trọ Trần Quốc Bảo', N'111 Hoàng Văn Thụ, An Cư, Ninh Kiều, Cần Thơ, Việt Nam', '0345956208', geometry::STGeomFromText('POINT (105.779819 10.039780)', 0)),
	(36, 3, N'Nhà Cho Thuê Huỳnh Thị Bích Lệ', N'149/8, Hoàng Văn Thụ, phường An Cư, Quận Ninh Kiều, Thành Phố Cần Thơ, An Cư, Ninh Kiều, Cần Thơ, Việt Nam', '0347943463', geometry::STGeomFromText('POINT (105.779125 10.039894)', 0)),
	(78, 3, N'Nhà Trọ Cô Hồng', N'An Cư, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.776540 10.040967)', 0)),

	(36, 4, N'Nhà Trọ Lê Thị Hương', N'69/10/7, Đường Vành Đai Phi Trường, Phường An Thới, Quận Bình Thủy, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0903893365', geometry::STGeomFromText('POINT (105.757219 10.047564)', 0)),
	(76, 4, N'Nhà Trọ 228', N'228, Đường Vành Đai Phi Trường, Phường An Thới, Quận Bình Thủy, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0922212459', geometry::STGeomFromText('POINT (105.758086 10.047675)', 0)),
	(36, 4, N'Nhà Trọ Bình Dân HAI VĂN', N'Hẻm 85, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0939469515', geometry::STGeomFromText('POINT (105.763851 10.047986)', 0)),
	(74, 4, N'NHÀ TRỌ SINH VIÊN PHƯỚC NGỌC', N'An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.768519 10.044068)', 0)),
	(52, 4, N'Nhà trọ Cô Vân', N'311/35/21 Nguyễn Văn Cừ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0973759476', geometry::STGeomFromText('POINT (105.769154 10.043789)', 0)),
	(29, 4, N'Nhà trọ SV Tido', N'36/4C Nguyễn Văn Cừ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.768592 10.044739)', 0)),
	(3, 4, N'Nhà trọ Đức Tài.', N'30A/311, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.768768 10.044818)', 0)),
	(38, 4, N'Nhà trọ Văn Đời 8', N'C233/46/3, hẻm 233, Nguyễn Văn Cừ, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.770348 10.045787)', 0)),
	(11, 4, N'Nhà trọ Cô Tiên', N'46/1B Nguyễn Văn Cừ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.770921 10.045589)', 0)),
	(21, 4, N'Trọ Trang', N'2QW9+JV7, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.769686 10.046540)', 0)),
	(67, 4, N'Nhà trọ Đức Tín', N'147/38A10 Nguyễn Văn Cừ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0907844436', geometry::STGeomFromText('POINT (105.771607 10.047342)', 0)),
	(36, 4, N'Nhà Trọ 140B', N'140 Trần Văn Ơn, An Hoà, Ninh Kiều, Cần Thơ', '0923894055', geometry::STGeomFromText('POINT (105.7704166 10.049418)', 0)),
	(55, 4, N'Nhà Trọ Thu Hồng', N'390D Nguyễn Văn Cừ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0939049968', geometry::STGeomFromText('POINT (105.7677661 10.0464303)', 0)),
	(66, 4, N'Nhà Trọ Quang Trung', N'188/15E, Đường Nguyễn Văn Cừ, Phường An Hoà, Quận Ninh Kiều, Tp Cần Thơ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0923893697', geometry::STGeomFromText('POINT (105.7677661 10.0464303)', 0)),
	(86, 4, N'Nhà Trọ Ngọc Thuý', N'117/15, Đường Nguyễn Văn Cừ, Phường An Hoà, Quận Ninh Kiều, Tp Cần Thơ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0936749814', geometry::STGeomFromText('POINT (105.7673487 10.0470883)', 0)),
	(44, 4, N'Nhà Trọ 18 Nguyễn Đệ', N'18 Nguyễn Đệ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0939646655', geometry::STGeomFromText('POINT (105.7677001 10.0502072)', 0)),
	(10, 4, N'Nhà Trọ Thânh Tâm', N'140B/22, Đường Nguyễn Văn Cừ, Phường An Hoà, Quận Ninh Kiều, Tp Cần Thơ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0918063466', geometry::STGeomFromText('POINT (105.768513 10.0503572)', 0)),
	(6, 4, N'Nhà Trọ Cô Yến', N'43 Nguyễn Đệ, An Hoà, Ninh Kiều, Cần Thơ, Việt Nam', '0939699523', geometry::STGeomFromText('POINT (105.7644636 10.0476664)', 0)),
	(13, 4, N'Nhà Trọ Trịnh Thị Lệ Duyên', N'109, Đường Vành Đai Phi Trường, Phường An Hòa, Quận Ninh Kiều, An Thới, Bình Thủy, Cần Thơ, Việt Nam', '0983119074', geometry::STGeomFromText('POINT (105.7570794 10.0480745)', 0)),
	(8, 4, N'Nhà Trọ Hồng Ngọc', N'113/30, Đường Vành Đai Phi Trường, Phường An Thới, Quận Bình Thủy, Thành Phố Cần Thơ, An Thới, Bình Thủy, Cần Thơ, Việt Nam', '0919054668', geometry::STGeomFromText('POINT (105.7570794 10.0480745)', 0)),

	(45, 5, N'Nhà trọ Sinh Viên', N'Số 390X, Đường Trần Nam Phú, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7500908 10.0343936)', 0)),
	(19, 5, N'Nhà trọ Cô Hoàng', N'12 Nguyễn Văn Cừ nối dài, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.749378 10.028138)', 0)),
	(48, 5, N'Nhà trọ Thanh Tâm', N'Hẻm Tổ 10A, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.749330 10.029068)', 0)),
	(18, 5, N'Nhà trọ Minh Hải 2', N'289B2/8, hẻm tổ 10A, KV4, Nguyễn Văn Cừ, Ninh Kiều, Cần Thơ 10000, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.748435 10.029684)', 0)),
	(68, 5, N'Nhà trọ Hồng Ngọc 2', N'Hẻm Tổ 10A, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.748747 10.030050)', 0)),
	(53, 5, N'Nhà trọ Hồng Hưng', N'338T/10B, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.748100 10.030510)', 0)),
	(78, 5, N'Nhà trọ Bác sĩ Thanh', N'321T/10B, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0977454146', geometry::STGeomFromText('POINT (105.747393 10.030883)', 0)),
	(75, 5, N'Nhà Trọ Võ Văn Sáu', N'306A1/12, Khu Vực 5, Phường An Khánh, Quận Ninh Kiều, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0914355298', geometry::STGeomFromText('POINT (105.746639 10.032272)', 0)),
	(58, 5, N'Nhà trọ Phú', N'2PMV+QX9, Phường An Khánh, Bình Thủy, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.744983 10.034404)', 0)),
	(80, 5, N'Nhà Trọ Hải Tiến', N'Làng Hoa Bà Bộ, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0923893129', geometry::STGeomFromText('POINT (105.745018 10.034539)', 0)),
	(22, 5, N'Nhà trọ sinh viên Phát Lộc', N'2PPV+694, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.743442 10.035510)', 0)),
	(45, 5, N'Nhà trọ sinh viên Như Ý', N'2PPV+J53, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.742913 10.036468)', 0)),
	(15, 5, N'Nhà Cho Thuê Nguyễn Thị Bích Loan', N'306J2/2, Đường Cái Sơn Hàng Bàng, Phường An Khánh, Quận Ninh Kiều, An Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.745385 10.033003)', 0)),
	(58, 5, N'Nhà Trọ Phạm Thị Mỹ Châm', N'660C/24, Đường NguyễnVăn Linh, Khu Vực Bình Trung, Phường Long Hòa, Quận Bình Thủy, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0923890248', geometry::STGeomFromText('POINT (105.743936 10.038253)', 0)),
	(26, 5, N'Nhà Trọ Quỳnh Lưu', N'660A/24, Khu Vực Bình Trung, Phường Long Hòa, Quận Bình Thuỷ, Thành Phố Cần Thơ, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0384642103', geometry::STGeomFromText('POINT (105.744993 10.038850)', 0)),
	(85, 5, N'Nhà Trọ Hà Thanh', N'Hẻm 388, Phường An Khánh, Ninh Kiều, Cần Thơ', '0934300350', geometry::STGeomFromText('POINT (105.7617504 10.0368286)', 0)),
	(19, 5, N'Nhà Trọ 126a', N'126a Hẻm Lò Mổ, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7628271 10.0478805)', 0)),
	(15, 5, N'Nhà Trọ Sinh Viên Hồng Yến', N'Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0913388299', geometry::STGeomFromText('POINT (105.7591902 10.043206)', 0)),
	(64, 5, N'Nhà Trọ Phát Hải', N'12 Hẻm liên tổ 12-13-14-15-16-17-18-19-20, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0986858157', geometry::STGeomFromText('POINT (105.7588128 10.042998)', 0)),
	(25, 5, N'Nhà Trọ Hồng Anh', N'2QP7+V33, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0939293902', geometry::STGeomFromText('POINT (105.7620101 10.0362416)', 0)),
	(90, 5, N'Nhà Trọ Phước Lộc 3', N'63X, tổ 10, khu vực 2, hẻm, 388 Nguyễn Văn Cừ, Phường An Khánh, Ninh Kiều, Cần Thơ 94117, Việt Nam', '0939466236', geometry::STGeomFromText('POINT (105.7634676 10.0362654)', 0)),
	(37, 5, N'Nhà Trọ Ngân Tuyền', N'72D2, khu vực 2, Ninh Kiều, Cần Thơ, Việt Nam', '0909071283', geometry::STGeomFromText('POINT (105.764387 10.0377196)', 0)),
	(9, 5, N'Nhà Trọ Bà 6', N'122/31 Đ. Võ Văn Kiệt, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0939496659', geometry::STGeomFromText('POINT (105.7566315 10.0463129)', 0)),
	(39, 5, N'Nhà trọ 17', N'176 Nguyễn Thị Minh Khai, Phường An Khánh, Ninh Kiều, Cần Thơ 94115, Việt Nam', '0947222332', geometry::STGeomFromText('POINT (105.7779791 10.0256263)', 0)),

	(52, 6, N'Nguyễn Minh Tuấn', N'138/116, Trần Hưng Đạo, Phường An Nghiệp, Quận Ninh Kiều, Thành Phố Cần Thơ, An Phú, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7756284 10.036365)', 0)),
	(64, 6, N'nhà Ớt & Kiwi', N'13 Nguyễn Văn Trỗi, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.769560 10.037341)', 0)),

	(3, 1, N'Nhà Trọ 95', N'95 Mậu Thân, An Phú, Ninh Kiều, Cần Thơ', '0923734510', geometry::STGeomFromText('POINT (105.7746085 10.0317938)', 0)),
	(32, 1, N'Nhà Trọ 11', N'11 Hẻm 11 Mậu Thân, An Phú, Ninh Kiều, Cần Thơ', '0123456789', geometry::STGeomFromText('POINT (105.7725031 10.0329215)', 0)),
	(10, 1, N'Nhà Trọ Sinh Viên', N'11/37, Mậu Thân, Quận Ninh Kiều, Tp Cần Thơ, An Phú, Ninh Kiều, Cần Thơ, Việt Nam', '0923831208', geometry::STGeomFromText('POINT (105.7721403 10.0332951)', 0)),
	(42, 1, N'Nhà Trọ Sinh Viên Học Sinh', N'227/17, Trần Bình Trọng, Phường An Phú, Quận Ninh Kiều, TP Cần Thơ, An Phú, Ninh Kiều, Cần Thơ, Việt Nam', '0923784623', geometry::STGeomFromText('POINT (105.7767452 10.0343403)', 0)),

	(18, 7, N'Nhà Trọ 293', N'293 Trần Văn Khéo, Cái Khế, Ninh Kiều, Cần Thơ, Việt Nam', '0923812774', geometry::STGeomFromText('POINT (105.7856012 10.0460473)', 0)),
	(58, 7, N'Nhà Trọ A Hón 2', N'36/14A, Đường Cách Mạng Tháng Tám, Phường An Thới, Quận Ninh Kiều, Cái Khế, Ninh Kiều, Cần Thơ, Việt Nam', '0906827769', geometry::STGeomFromText('POINT (105.7721289 10.0529784)', 0)),
	(37, 7, N'Nhà Trọ Thanh Tùng', N'118 Trần Văn Khéo, Cái Khế, Ninh Kiều, Cần Thơ, Việt Nam', '0918951924', geometry::STGeomFromText('POINT (105.7881674 10.0464723)', 0)),
	(20, 7, N'Nhà Trọ Cô Phượng', N'Hẻm Số Đỏ, Cái Khế, Ninh Kiều, Cần Thơ, Việt Nam', '0939506593', geometry::STGeomFromText('POINT (105.78322 10.0539824)', 0)),
	(6, 7, N'Nhà Trọ Ngọc Châu', N'156 Đoàn Thị Điểm, Cái Khế, Ninh Kiều, Cần Thơ, Việt Nam', '0923822154', geometry::STGeomFromText('POINT (105.7741897 10.0518305)', 0)),

	(3, 8, N'Không có tên', N'Gần 102/8C Hưng Lợi, Ninh Kiều, Cần Thơ', '0123456789', geometry::STGeomFromText('POINT (105.7638269 10.0091319)', 0)),
	(17, 8, N'Nhà trọ sinh viên 216/6', N'Hẻm 216, Hưng Lợi, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.764727 10.022845)', 0)),
	(71, 8, N'Không có tên', N'148/29 Đ. 3-2, Hưng Lợi, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.757654 10.019690)', 0)),
	(90, 8, N'Nhà Trọ Kiều Hạnh 2', N'Số nhà 42 hẻm 102 Đường 3 tháng 2, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.756197 10.017539)', 0)),
	(30, 8, N'Nhà trọ nữ sinh', N'150 Ba Tháng Hai, Hưng Lợi, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.765155 10.022083)', 0)),
	(25, 8, N'Nhà Trọ Huỳnh Hà', N'02, Đường Tầm Vu, Quận Ninh Kiều, Tp Cần Thơ, Hưng Lợi, Ninh Kiều, Cần Thơ', '0923839654', geometry::STGeomFromText('POINT (105.7684176 10.0106525)', 0)),
	(17, 8, N'Nhà Trọ 203', N'203D, Đường 3/2, Quận Ninh Kiều, Tp Cần Thơ, Hưng Lợi, Ninh Kiều, Cần Thơ', '0704946237', geometry::STGeomFromText('POINT (105.7644265 10.0202145)', 0)),
	(83, 8, N'Nhà Trọ 132/28c', N'132/28c Ba Tháng Hai, Hưng Lợi, Ninh Kiều, Cần Thơ 900000', '0123456789', geometry::STGeomFromText('POINT (105.7621875 10.0179286)', 0)),
	(88, 8, N'Nhà Trọ Mười Tam', N'120 Hẻm 132, Hưng Lợi, Ninh Kiều, Cần Thơ', '0123456789', geometry::STGeomFromText('POINT (105.7585885 10.0195242)', 0)),

	(57, 9, N'Nhà Trọ Cao Thị Thân', N'329C/3, Khu Vực 5, Phường Tân An, Quận Ninh Kiều, Tân An, Ninh Kiều, Cần Thơ', '0123456789', geometry::STGeomFromText('POINT (105.7872175 10.032552)', 0)),
	(37, 9, N'Nhà trọ An Gia', N'146 Đường Châu Văn Liêm, Tân An, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7830011 10.0300013)', 0)),
	(65, 9, N'Nhà Trọ Trương Vĩnh Ân', N'45C4/2, Lê Lai, Phường Tân An, Quận Ninh Kiều, Thành Phố Cần Thơ, An Lạc, Ninh Kiều, Cần Thơ, Việt Nam', '0918815981', geometry::STGeomFromText('POINT (105.7795573 10.0323855)', 0)),
	(27, 9, N'Nhà Trọ Mai Thành', N'01 Nguyễn Thị Minh Khai, Tân An, Ninh Kiều, Cần Thơ, Việt Nam', '0923822563', geometry::STGeomFromText('POINT (105.7853289 10.0267612)', 0)),

	(57, 10, N'Nhà Trọ 84', N'84/32, Đường Cách Mạng Tháng 8, Quận Ninh Kiều, Tp Cần Thơ, Thới Bình, Ninh Kiều, Cần Thơ', '0923893984', geometry::STGeomFromText('POINT (105.7785483 10.0474731)', 0)),
	(71, 10, N'Nhà Trọ 19', N'47 Phạm Ngũ Lão, Thới Bình, Ninh Kiều, Cần Thơ', '0922246331', geometry::STGeomFromText('POINT (105.7765571 10.046484)', 0)),
	(61, 10, N'Nhà Trọ Văn Hóa', N'A, 90/2/59 Hùng Vương, Thới Bình, Ninh Kiều, Cần Thơ', '0923826940', geometry::STGeomFromText('POINT (105.7757995 10.0430055)', 0)),
	(17, 10, N'Nhà trọ Tường Linh', N'2/121B Hẻm 311, Thới Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0833670755', geometry::STGeomFromText('POINT (105.7719421 10.0435583)', 0)),
	(90, 10, N'Nhà Trọ Huỳnh Vũ', N'94 Phạm Ngũ Lão, Thới Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0909969252', geometry::STGeomFromText('POINT (105.774589 10.0448624)', 0)),
	(23, 10, N'Nhà Trọ Nhân', N'54 Trần Việt Châu, Thới Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0908804747', geometry::STGeomFromText('POINT (105.7751997 10.0469345)', 0)),
	(56, 10, N'Nhà Trọ Chí Thọ', N'75 Trần Việt Châu, Thới Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0918877579', geometry::STGeomFromText('POINT (105.7733421 10.0462794)', 0)),
	(63, 10, N'Nhà Trọ Máy Lạnh Thảo Trang', N'8 Đường A2, Thới Bình, Ninh Kiều, Cần Thơ, Việt Nam', '0923763088', geometry::STGeomFromText('POINT (105.780035 10.0460373)', 0)),

	(27, 11, N'Nhà Trọ Anh Trâm', N'47/5, Đường 3/2, Quận Ninh Kiều, Tp Cần Thơ, Xuân Khánh, Ninh Kiều, Cần Thơ', '0923732376', geometry::STGeomFromText('POINT (105.7674213 10.0249266)', 0)),
	(87, 11, N'Nhà Trọ 35', N'35 Quản Trọng Hoàng, Xuân Khánh, Ninh Kiều, Cần Thơ', '0123456789', geometry::STGeomFromText('POINT (105.7675343 10.0227537)', 0)),
	(36, 11, N'Nhà Trọ C36B', N'2QGF+MPV, Xuân Khánh, Ninh Kiều, Cần Thơ', '0123456789', geometry::STGeomFromText('POINT (105.7737689 10.0269592)', 0)),
	(20, 11, N'Nhà Trọ Dương Thị Thu Phượng', N'Số 13, Đường Trần Văn Hoài, Phường Xuân Khánh, Quận Ninh Kiều, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0923739284', geometry::STGeomFromText('POINT (105.7729072 10.0246398)', 0)),
	(17, 11, N'Nhà Trọ Kiều Hạnh 2', N'Số nhà 42 hẻm 102 Đường 3 tháng 2, Ninh Kiều, Cần Thơ, Việt Nam', '0909363799', geometry::STGeomFromText('POINT (105.7561987 10.0175668)', 0)),
	(83, 11, N'Nhà trọ sinh viên Ngọc Thư', N'102 102/38 A Đường 3-2, P, Ninh Kiều, 900000, Việt Nam', '0932912588', geometry::STGeomFromText('POINT (105.7565843 10.0174335)', 0)),
	(35, 11, N'Nhà Trọ Sinh Viên Trí Việt', N'12/6, Đường 30/04, Quận Ninh Kiều, Tp Cần Thơ, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0923839545', geometry::STGeomFromText('POINT (105.7720808 10.021645)', 0)),
	(10, 11, N'Nhà trọ 51D5', N'Hẻm 51, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7645233 10.026069)', 0)),
	(4, 11, N'Nhà Trọ Sinh Viên Cô Bảy', N'51F7, Hẻm 51, Ba Tháng Hai, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0907314287', geometry::STGeomFromText('POINT (105.7654892 10.0257418)', 0)),
	(57, 11, N'Nhà trọ Kiều', N'124/8/20 Đ. 3/2, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7716407 10.0275338)', 0)),
	(69, 11, N'Nhà Trọ Sinh viên Huỳnh Liên', N'124/8/10 Ba Tháng Hai, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0969912599', geometry::STGeomFromText('POINT (105.7716407 10.0275338)', 0)),
	(56, 11, N'Nhà Trọ Hữu Tường', N'44 Ba Tháng Hai, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0944929921', geometry::STGeomFromText('POINT (105.7737128 10.0314473)', 0)),
	(46, 11, N'Nhà Trọ Vũ Thị Yến', N'Số 124/8/22, Đường 3/2, Phường Xuân Khánh, Quận Ninh Kiều, An Phú, Ninh Kiều, Cần Thơ, Việt Nam', '0903822438', geometry::STGeomFromText('POINT (105.7741537 10.0324333)', 0)),
	(87, 11, N'Nhà Trọ An Khánh', N'Hẻm cầu Xèo Lá, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0943561466', geometry::STGeomFromText('POINT (105.7620101 10.0362416)', 0)),
	(86, 11, N'Nhà Trọ Vạn Lợi', N'Hẻm cầu Xèo Lá, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7620101 10.0362416)', 0)),
	(36, 11, N'Nhà Trọ Nhi', N'117 Hẻm Lò Mổ, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7657032 10.0396609)', 0)),
	(80, 11, N'Nhà Trọ Hiếu Phạm', N'2QM7+63X, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0789550278', geometry::STGeomFromText('POINT (105.7613146 10.0322829)', 0)),
	(32, 11, N'Nhà Trọ D20', N'D20 Trần Khánh Dư, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0973733705', geometry::STGeomFromText('POINT (105.7742976 10.0274706)', 0)),
	(23, 11, N'Nhà Trọ Lương Hữu Trí', N'12/21/25, Đường Nguyễn Việt Hồng, Phường Xuân Khánh, Quận Ninh Kiều, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0832301754', geometry::STGeomFromText('POINT (105.7753953 10.0298514)', 0)),
	(58, 11, N'Nhà Trọ Cẩm Tú', N'51/51H Đ. 3/2, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0123456789', geometry::STGeomFromText('POINT (105.7725893 10.028417)', 0)),
	(40, 11, N'Nhà Trọ Ngọc Lệ', N'Đ. 3/2, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0813949960', geometry::STGeomFromText('POINT (105.7725893 10.028417)', 0)),
	(74, 11, N'Nhà Trọ Số 9', N'9, Đường 30/04, Quận Ninh Kiều, Tp Cần Thơ, Xuân Khánh, Ninh Kiều, Cần Thơ, Việt Nam', '0926250131', geometry::STGeomFromText('POINT (105.7761853 10.0262206)', 0));
go
if exists (
	select 1
	from sys.objects
	where name = N'tr_add_cogia'
	and type = N'TR'
)
drop trigger tr_add_cogia
go
create trigger tr_add_cogia
on CoGia
instead of insert
as
	declare @ngay datetime = (select ngay from inserted);
	if not exists (
		select 1
		from Ngay a
		where a.ngay = @ngay
	)
		insert into Ngay values (@ngay);
	insert into CoGia select * from inserted;
go
if exists (
	select 1
	from sys.objects
	where name = N'tr_add_cotiendiennuoc'
	and type = N'TR'
)
drop trigger tr_add_cotiendiennuoc
go
create trigger tr_add_cotiendiennuoc
on CoTienDienNuoc
instead of insert
as
	declare @ngay datetime = (select ngay from inserted);
	if not exists (
		select 1
		from Ngay a
		where a.ngay = @ngay
	)
		insert into Ngay values (@ngay);
	insert into CoTienDienNuoc select * from inserted;
go
if exists (
	select 1
	from sys.objects
	where name = N'tr_add_baocaonhatro'
	and type = N'TR'
)
drop trigger tr_add_baocaonhatro
go
create trigger tr_add_baocaonhatro
on BaoCaoNhaTro
instead of insert
as
	declare @ngay datetime = (select ngay from inserted);
	if not exists (
		select 1
		from Ngay a
		where a.ngay = @ngay
	)
		insert into Ngay values (@ngay);
	insert into BaoCaoNhaTro select * from inserted;
go
if exists (
	select 1
	from sys.objects
	where name = N'tr_add_baocaonguoidung'
	and type = N'TR'
)
drop trigger tr_add_baocaonguoidung
go
create trigger tr_add_baocaonguoidung
on BaoCaoNguoiDung
instead of insert
as
	declare @ngay datetime = (select ngay from inserted);
	if not exists (
		select 1
		from Ngay a
		where a.ngay = @ngay
	)
		insert into Ngay values (@ngay);
	insert into BaoCaoNguoiDung select * from inserted;
go
if exists (
	select 1
	from sys.objects
	where name = N'tr_add_danhgia'
	and type = N'TR'
)
drop trigger tr_add_danhgia
go
create trigger tr_add_danhgia
on DanhGia
instead of insert
as
	declare @ngay datetime = (select ngay from inserted);
	if not exists (
		select 1
		from Ngay a
		where a.ngay = @ngay
	)
		insert into Ngay values (@ngay);
	insert into DanhGia select * from inserted;
go
if exists (
	select 1
	from sys.objects
	where name = N'sp_login'
	and type = 'P'
)
drop proc sp_login
go
create proc sp_login @taikhoan char(50), @matkhau char(100)
as
begin
	declare @count int;
	declare @res bit;
	select @count = count(*)
	from NguoiDung
	where taikhoan = @taikhoan
		and matkhau = @matkhau;
	if @count > 0
		set @res = 1
	else
		set @res = 0;
	select @res;
end
go
if exists (
	select 1
	from sys.objects
	where name = N'sp_get_nguoi_dung'
	and type = 'P'
)
drop proc sp_get_nguoi_dung
go
create proc sp_get_nguoi_dung @taikhoan char(50)
as
begin
	select *
	from NguoiDung
	where taikhoan = @taikhoan;
end
go
if exists (
	select 1
	from sys.objects
	where name = N'fn_tim_tien_nuoc'
	and type = 'FN'
)
drop function dbo.fn_tim_tien_nuoc
go
create function fn_tim_tien_nuoc (@ma_nt int)
returns float
as
begin
	declare @res float;
	select @res = a.tiennuoc
	from CoTienDienNuoc a
	where ma_nt = @ma_nt
	and ngay = (
		select MAX(b.ngay)
		from CoTienDienNuoc b
		where b.ma_nt = @ma_nt
		group by b.ma_nt
	);
	return @res;
end
go
if exists (
	select 1
	from sys.objects
	where name = N'fn_tim_tien_dien'
	and type = 'FN'
)
drop function dbo.fn_tim_tien_dien
go
create function fn_tim_tien_dien (@ma_nt int)
returns float
as
begin
	declare @res float;
	select @res = a.tiendien
	from CoTienDienNuoc a
	where ma_nt = @ma_nt
	and ngay = (
		select MAX(b.ngay)
		from CoTienDienNuoc b
		where b.ma_nt = @ma_nt
		group by b.ma_nt
	);
	return @res;
end
go
if exists (
	select 1
	from sys.objects
	where name = N'fn_tim_tien_phong'
	and type = 'FN'
)
drop function dbo.fn_tim_tien_phong
go
create function fn_tim_tien_phong (@ma_nt int, @ma_lp int)
returns float
as
begin
	declare @res float;
	select @res = a.giaphong
	from CoGia a
	where ma_nt = @ma_nt
	and ma_lp = @ma_lp
	and ngay = (
		select MAX(b.ngay)
		from CoGia b
		where ma_nt = @ma_nt
		and ma_lp = @ma_lp
		group by b.ma_nt, b.ma_lp
	);
	return @res;
end
go
if exists (
	select 1
	from sys.objects
	where name = N'sp_filter_nha_tro'
	and type = 'P'
)
drop proc sp_filter_nha_tro
go
create proc sp_filter_nha_tro @ma_kv int, @tiendien float, @tiennuoc float, @giaphong float
as
begin
	select a.ma_kv, a.diachi_nt, a.ma_nd, a.ma_nt, a.sdt_nt, a.ten_nt, a.toado_nt
	from NhaTro a
	where (@ma_kv is null or a.ma_kv = @ma_kv)
	and (@tiennuoc is null or @tiennuoc >= dbo.fn_tim_tien_nuoc(a.ma_nt))
	and (@tiendien is null or @tiendien >= dbo.fn_tim_tien_dien(a.ma_nt))
	and (@giaphong is null or @giaphong >= (select min(dbo.fn_tim_tien_phong(b.ma_nt, b.ma_lp)) from CoGia b where b.ma_nt = a.ma_nt))
end
go
if exists (
	select 1
	from sys.objects
	where name = N'sp_get_gia_phong_hien_tai'
	and type = 'P'
)
drop proc sp_get_gia_phong_hien_tai
go
create proc sp_get_gia_phong_hien_tai @ma_nt int
as
begin
	select a.*
	from CoGia a, (
		select a1.ma_nt, a1.ma_lp, max(a1.ngay) 'ngay'
		from CoGia a1
		where a1.ma_nt = @ma_nt
		group by a1.ma_nt, a1.ma_lp
	) as b
	where a.ma_nt = b.ma_nt
	and a.ma_lp = b.ma_lp
	and a.ngay = b.ngay
end
go
if exists (
	select 1
	from sys.objects
	where name = N'tr_del_anh'
	and type = N'TR'
)
drop trigger tr_del_anh
go
create trigger tr_del_anh
on AnhNhaTro
for delete
as
	declare @ma_nt int = (select ma_nt from deleted);
	declare @i int = 1;
	declare cur cursor scroll for
	select STT from AnhNhaTro where ma_nt = @ma_nt
	open cur
	declare @stt int
	while @@FETCH_STATUS = 0
	begin
		fetch next from cur into @stt
		update AnhNhaTro
		set STT = @i
		where ma_nt = @ma_nt
		and STT = @stt
		set @i = @i + 1
	end
go
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-12-09 09:05:02',5,'Suspendisse sollicitudin dui dictum, consequat lectus non, ullamcorper metus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (85,'2021-11-28 16:25:49',24,'Maecenas et libero sed est vehicula tempus ac ut sem.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (119,'2021-11-04 11:14:12',91,'Quisque rhoncus arcu id nisl lobortis lobortis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (8,'2021-11-01 07:57:22',14,'Aliquam fringilla leo ut commodo porttitor.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-12-07 12:20:10',4,'Suspendisse in ante sed nisl lacinia efficitur vel vel ipsum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-12-10 07:52:54',3,'Integer porta leo sed lorem suscipit, non elementum dolor vehicula.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (79,'2021-12-11 13:31:35',42,'Praesent sed mi et justo commodo consequat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-11-17 16:29:34',12,'Integer at diam accumsan, feugiat est quis, auctor nisi.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (58,'2021-11-20 21:57:19',6,'Vivamus posuere justo porttitor, auctor libero sed, scelerisque nisi.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-11-22 10:04:05',73,'Sed rutrum orci at tortor faucibus, quis ornare eros commodo.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-12-09 15:40:19',80,'Nulla ut nibh sodales, semper ex non, imperdiet purus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (56,'2021-12-02 11:11:02',30,'Morbi eleifend augue a posuere interdum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-12-08 08:57:42',23,'Nunc vestibulum arcu vitae augue molestie gravida.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (76,'2021-11-27 19:00:20',20,'Pellentesque convallis purus vel posuere scelerisque.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-11-20 18:43:21',53,'Ut finibus sapien vitae egestas blandit.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (33,'2021-11-02 17:55:49',4,'Vestibulum hendrerit metus quis nunc accumsan, nec tincidunt augue aliquam.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-11-13 07:44:33',66,'Nam sed lacus at nibh fringilla lacinia.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (17,'2021-11-30 17:48:55',73,'Vivamus faucibus magna porta felis dapibus, id porta quam suscipit.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-12-06 13:05:57',78,'Fusce placerat dui ac tellus gravida viverra.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (80,'2021-11-06 11:16:31',7,'Etiam non nisl a dolor pellentesque tempus eget in ipsum.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (120,'2021-11-29 19:01:03',59,'Aenean sit amet justo a massa molestie varius ut eget ex.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (48,'2021-11-07 11:30:55',28,'Donec tristique eros nec sollicitudin porttitor.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-12-06 07:49:09',75,'Morbi ullamcorper sem ut neque facilisis, at tincidunt quam imperdiet.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (77,'2021-11-20 16:51:19',65,'Vestibulum sed lorem eu sapien mattis lobortis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (70,'2021-12-10 10:45:24',17,'Sed luctus mi eu justo interdum condimentum sit amet in quam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (73,'2021-11-27 19:17:28',34,'Phasellus nec augue ultrices, scelerisque lectus eu, ultricies orci.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (12,'2021-11-02 21:06:55',9,'Fusce convallis massa imperdiet mi aliquet viverra.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (19,'2021-11-29 10:57:30',88,'Vivamus ac orci at justo ultricies viverra.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (60,'2021-12-08 19:33:19',86,'Proin vel enim a orci iaculis interdum non at metus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (51,'2021-11-25 17:19:06',67,'Nulla auctor augue in lectus pharetra laoreet.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (2,'2021-11-18 11:02:41',41,'Pellentesque vehicula purus non auctor ultrices.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (68,'2021-11-12 13:02:30',46,'Integer semper felis a neque venenatis finibus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-11-08 08:57:24',28,'Maecenas ornare erat eget ante sagittis, sed varius quam facilisis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-12-02 10:15:36',85,'Praesent non ligula eu arcu sodales fermentum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-11-26 13:48:09',76,'Sed maximus orci eu ex aliquet pretium.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-23 10:46:34',92,'Proin tempus libero in massa gravida, id fermentum felis blandit.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-11-12 12:23:20',74,'Donec fermentum nunc in nibh ornare, id ornare massa vestibulum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-12-09 10:11:17',13,'Quisque auctor felis sed leo egestas, at efficitur diam efficitur.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (19,'2021-12-06 07:08:15',82,'Maecenas accumsan orci eget odio faucibus, vel dapibus nunc malesuada.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (64,'2021-11-20 11:49:12',57,'Proin pretium nisi ultricies nisi tincidunt, ultricies efficitur dolor dapibus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-11-26 07:36:37',90,'Ut vitae odio nec dui lobortis commodo.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-03 12:45:13',88,'Nullam scelerisque mi in lorem gravida eleifend.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (92,'2021-11-02 07:41:23',14,'Nunc non velit quis arcu cursus porttitor id id dui.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-12-11 10:52:54',73,'Suspendisse ut felis vel urna bibendum auctor sit amet in diam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (8,'2021-11-07 06:11:31',85,'Integer sed libero a ligula facilisis scelerisque et id dui.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (44,'2021-11-04 13:56:56',42,'Cras non metus gravida, egestas ante cursus, sollicitudin nulla.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (4,'2021-11-25 20:33:56',52,'Nulla viverra leo consequat felis varius, ac mollis felis congue.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (35,'2021-11-04 11:09:19',56,'Nunc accumsan ipsum sed tortor pretium maximus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-12-03 21:10:13',77,'Vivamus a libero pulvinar, tempor ipsum sit amet, placerat ipsum.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (114,'2021-11-06 11:04:16',69,'Suspendisse scelerisque arcu vel massa scelerisque vehicula.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (119,'2021-11-28 07:02:04',34,'Quisque ac quam et enim aliquet suscipit.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (94,'2021-11-09 10:34:54',84,'Vivamus non diam eget ante tempor mollis eget condimentum augue.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (87,'2021-12-05 11:43:26',49,'Curabitur et libero consectetur, egestas ex ut, egestas sapien.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (77,'2021-12-05 15:44:38',57,'Mauris vitae eros vitae metus viverra volutpat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (15,'2021-12-05 18:00:26',7,'Mauris id felis laoreet, vehicula sem quis, mattis quam.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (34,'2021-11-11 16:12:43',63,'Duis hendrerit nisl viverra diam cursus, in vulputate ipsum fringilla.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-11-05 14:53:31',28,'Curabitur convallis arcu eu varius maximus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (112,'2021-11-01 08:46:11',6,'Cras sed metus auctor, sodales libero a, varius neque.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-12-10 21:47:48',63,'Phasellus vulputate lectus sit amet hendrerit pulvinar.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-07 08:34:57',85,'Maecenas viverra lacus in tellus luctus, vel commodo eros bibendum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (63,'2021-12-09 14:59:34',55,'Ut sit amet ipsum sit amet nisi varius elementum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-10 17:58:16',38,'Suspendisse faucibus libero vel tortor laoreet, a rutrum odio iaculis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-11-15 15:37:18',91,'Sed dapibus tortor non ex aliquet tincidunt.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (89,'2021-11-30 09:40:19',69,'Maecenas faucibus mi non leo ullamcorper, eget dapibus ligula malesuada.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (113,'2021-11-17 06:42:03',46,'Fusce eget eros dapibus nibh porta congue vel vitae ligula.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (13,'2021-11-10 08:50:30',81,'Mauris efficitur tortor eu lectus tincidunt facilisis a quis lacus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (26,'2021-12-09 13:25:15',52,'Nulla rutrum arcu at pulvinar tempus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (31,'2021-11-30 19:28:16',65,'Cras scelerisque sapien eget lacus tincidunt consequat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-11-13 07:37:29',3,'Integer id purus vel sapien tempus cursus eu luctus nisi.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (14,'2021-11-03 15:53:17',15,'In dignissim arcu ac malesuada bibendum.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (90,'2021-11-08 06:29:57',50,'Etiam ut purus feugiat ligula laoreet auctor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (13,'2021-11-02 07:16:02',48,'Cras et arcu at ante auctor rutrum eget nec leo.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-27 17:06:35',65,'Quisque et dolor dapibus, consequat ligula id, pretium urna.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (87,'2021-12-07 20:14:12',5,'Vivamus id felis quis turpis ullamcorper bibendum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (75,'2021-11-07 20:09:53',13,'Sed porta mauris a tristique auctor.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (77,'2021-11-24 16:01:47',58,'Nunc porta dolor quis quam lobortis, a viverra mi eleifend.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (8,'2021-11-15 14:23:43',18,'Sed pulvinar ipsum tincidunt diam lacinia sollicitudin.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (103,'2021-11-18 20:39:59',59,'Phasellus semper velit ut pharetra tincidunt.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (72,'2021-12-06 18:24:29',40,'Pellentesque scelerisque est ut eros feugiat commodo vel ut metus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (76,'2021-11-26 12:16:16',69,'Vivamus sed ligula sit amet lorem consequat dignissim.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (77,'2021-11-08 20:43:52',53,'Fusce fringilla odio nec risus aliquam, in tempor nulla accumsan.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-06 18:06:20',46,'Fusce ullamcorper velit et elit sollicitudin accumsan.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-09 11:55:49',12,'Aenean tincidunt elit sit amet dolor molestie maximus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-11-30 10:23:14',29,'Donec sed erat eleifend, lobortis mi consequat, fringilla ipsum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (112,'2021-11-25 17:44:27',28,'Quisque id orci nec urna laoreet posuere auctor at massa.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (21,'2021-12-02 19:41:23',90,'Duis ultrices dui nec consectetur elementum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (90,'2021-12-01 09:35:43',17,'Etiam sed metus a eros rutrum commodo.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-09 07:39:56',60,'Vestibulum condimentum nisl eu ipsum ornare, eget pharetra magna tincidunt.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-25 12:22:19',31,'Nam at dui sed nisl elementum consequat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (56,'2021-11-05 14:49:47',87,'Sed molestie lectus at mauris vulputate malesuada.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (39,'2021-11-11 16:25:24',69,'Fusce convallis diam non turpis egestas, ac sagittis turpis facilisis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (89,'2021-11-01 16:20:21',31,'Curabitur sit amet ligula condimentum orci facilisis aliquet.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-11-27 17:05:25',41,'Maecenas nec augue id nisi vulputate hendrerit.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (37,'2021-11-21 16:51:10',78,'Morbi ornare leo eu elit auctor, sed cursus mi dictum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-12-02 13:31:26',40,'Quisque in eros non tellus pharetra placerat sit amet a ante.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (85,'2021-12-03 18:05:02',42,'Proin nec lorem ac ipsum iaculis ultricies eget nec massa.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (2,'2021-11-24 13:45:07',64,'Quisque eleifend orci sed enim pharetra, sit amet venenatis massa posuere.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-11-18 19:19:12',16,'Cras dictum felis a lorem vulputate, in dapibus risus hendrerit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (100,'2021-11-03 12:37:44',28,'Nunc pharetra urna porttitor, suscipit nunc vitae, mattis nulla.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (94,'2021-12-07 11:28:54',86,'Nulla ornare dui vel scelerisque volutpat.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (125,'2021-11-11 14:15:13',30,'Donec semper justo at dolor facilisis sollicitudin.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (4,'2021-11-23 06:38:44',93,'Duis mattis ligula aliquam urna luctus mollis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-12-03 14:19:41',67,'Sed eget mi ut massa auctor efficitur.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-12-09 13:33:45',69,'Ut eu metus congue magna vulputate facilisis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (22,'2021-12-07 12:02:36',45,'Proin non urna consectetur, malesuada dolor sed, dictum elit.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (39,'2021-12-06 12:57:01',17,'Nulla tincidunt est eget accumsan imperdiet.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (33,'2021-11-27 21:31:32',77,'Vestibulum ac est vitae enim venenatis bibendum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (51,'2021-11-22 09:51:33',20,'Fusce eu velit tincidunt, dapibus urna vulputate, malesuada ipsum.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-11-30 21:32:41',71,'Proin consequat ligula sed lorem finibus, et fringilla mauris mattis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (71,'2021-11-25 08:00:23',64,'Duis id risus nec libero laoreet mollis ac eu dolor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-11-04 18:15:24',62,'Sed consequat velit in risus eleifend, eget venenatis velit fermentum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (10,'2021-11-05 10:47:25',24,'Sed rutrum lectus ac massa ultricies sodales.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-11-14 11:07:44',24,'Donec lobortis ante auctor nulla convallis fringilla.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (2,'2021-11-05 14:59:25',25,'Cras eu risus a ante laoreet semper.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (90,'2021-11-03 21:55:00',81,'Aenean efficitur lacus at pretium pulvinar.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (87,'2021-11-29 16:21:13',52,'Ut at est molestie, aliquet lectus eu, malesuada nisi.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-30 18:12:32',21,'Sed id lacus cursus, placerat nisl quis, bibendum justo.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (102,'2021-12-02 07:29:17',57,'Nullam vitae est eu ipsum consectetur posuere sit amet venenatis urna.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-12-03 20:31:55',10,'Aliquam vulputate nulla eget massa mattis, suscipit finibus neque ornare.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (73,'2021-11-10 06:03:45',41,'Integer lobortis diam eu iaculis vehicula.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (63,'2021-11-09 17:12:55',9,'Mauris posuere odio eu gravida sagittis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (90,'2021-11-21 12:32:07',69,'In vel lectus tempor, ornare dui non, pretium turpis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (112,'2021-11-02 07:05:57',70,'Pellentesque eget felis pulvinar, porttitor ligula vel, ornare libero.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (4,'2021-11-20 16:52:36',79,'Sed vitae ligula efficitur nisi pretium finibus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (34,'2021-11-22 10:15:01',27,'Curabitur in elit feugiat, tempus lorem nec, dignissim diam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-13 21:49:15',4,'Ut euismod tellus quis iaculis porttitor.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-12-06 17:23:51',40,'Pellentesque tempus metus quis eros rhoncus, sit amet facilisis dolor luctus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-12-01 12:02:27',61,'Integer luctus tellus et ligula sollicitudin, et convallis erat efficitur.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-16 12:44:38',54,'Sed at leo ac eros sagittis aliquet eu sed nulla.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (21,'2021-11-09 21:04:45',80,'Aliquam at sapien malesuada, malesuada nibh quis, imperdiet lacus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-08 19:21:04',51,'Pellentesque ac erat eget mauris ullamcorper convallis vel sit amet nunc.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (17,'2021-11-10 21:57:27',84,'Etiam sit amet tellus eu orci molestie mollis eget gravida lorem.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (101,'2021-12-05 16:19:38',35,'Aliquam quis orci et nisi faucibus imperdiet.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (23,'2021-12-03 13:40:31',56,'Nam dignissim diam et sapien sollicitudin, id ultricies ante malesuada.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-12-11 21:26:21',76,'Ut vestibulum velit quis sem posuere, sed tempor diam ornare.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-11-29 07:23:14',3,'Phasellus dapibus augue quis lectus vehicula, vitae imperdiet quam eleifend.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (119,'2021-12-06 08:09:27',58,'Quisque eu nisi a turpis placerat euismod.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (64,'2021-11-10 10:19:38',41,'Sed convallis ligula id mauris fermentum vehicula.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (106,'2021-11-11 15:12:06',57,'Mauris faucibus sem et gravida tempor.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (28,'2021-12-04 11:58:25',7,'In eget justo vel quam pretium pretium.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-11-13 21:15:50',7,'Praesent a eros eget nunc pulvinar rutrum in eget justo.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (80,'2021-12-04 10:05:31',62,'Donec quis ex vitae nulla tincidunt viverra in eu quam.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-11-26 14:08:18',57,'Mauris vitae velit posuere, vulputate ipsum nec, feugiat ipsum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-12-08 20:09:45',51,'Integer nec lorem tristique, lobortis mi vel, consectetur mi.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-11-22 08:47:37',45,'Fusce eu metus a ante efficitur iaculis eget sed ante.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (39,'2021-11-12 21:07:12',10,'Proin euismod lacus nec laoreet facilisis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-11-25 19:45:59',70,'Sed luctus lacus in ornare sollicitudin.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-11-04 12:55:26',79,'Quisque luctus leo vitae pretium lacinia.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (30,'2021-12-09 17:20:59',5,'Phasellus ultricies libero nec augue elementum vehicula.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (4,'2021-12-05 13:50:36',89,'Praesent accumsan quam vel ligula molestie, vel efficitur sem fermentum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-11-08 19:12:09',40,'Pellentesque in odio a odio dapibus porttitor id id arcu.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-11-17 12:31:41',45,'Curabitur ut arcu ut dui tristique aliquet.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (72,'2021-11-06 12:22:02',17,'Curabitur congue augue a libero laoreet fringilla.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-11-17 13:29:08',12,'Nam ullamcorper felis sed leo pellentesque posuere.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (48,'2021-11-15 11:09:01',51,'In eget arcu bibendum, rhoncus ipsum id, molestie ex.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (28,'2021-11-15 17:44:27',83,'Nullam eget nisi pretium, imperdiet magna sit amet, aliquam risus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (101,'2021-11-08 21:51:59',9,'Proin quis odio vel arcu fermentum cursus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (32,'2021-11-22 08:16:48',24,'Donec euismod tellus sit amet dui porta, ac varius neque tincidunt.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-11-11 07:38:04',15,'Nunc ut ipsum luctus, efficitur enim scelerisque, ultricies dui.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (54,'2021-11-18 08:10:28',71,'Duis tempus nisi in erat rhoncus, eget placerat nunc auctor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (109,'2021-11-19 07:52:36',53,'Nam sit amet leo luctus erat placerat suscipit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-24 20:21:59',19,'Pellentesque sed velit a dui mattis cursus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (48,'2021-11-22 07:36:29',13,'Vivamus faucibus velit sed est lobortis commodo.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (80,'2021-12-05 06:52:42',22,'Aliquam faucibus augue eget metus aliquet, sed aliquam tellus condimentum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (64,'2021-11-13 07:46:51',75,'Integer euismod ipsum semper dolor dignissim, in ultricies enim finibus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (33,'2021-11-05 11:35:05',70,'Nunc malesuada nibh vel eros pretium, ac efficitur ex varius.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (97,'2021-11-30 09:08:12',17,'In viverra ante ut dolor maximus, non euismod nisi feugiat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (39,'2021-11-22 07:29:43',70,'Nulla ac turpis dignissim nisl laoreet vehicula non ultrices dolor.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (106,'2021-11-25 18:12:32',10,'Vestibulum quis purus in magna vulputate auctor eu id odio.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (14,'2021-11-08 18:12:06',61,'Sed sed risus sagittis, elementum arcu sed, elementum turpis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (68,'2021-11-17 18:54:09',40,'Suspendisse non nibh quis ante lobortis mollis nec ac sapien.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (108,'2021-12-10 06:02:44',70,'Ut id elit pellentesque, dictum mi quis, rhoncus felis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (91,'2021-11-12 06:58:28',89,'Curabitur facilisis quam nec risus fringilla, et finibus enim luctus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (77,'2021-11-29 11:16:48',49,'Ut tempor risus sit amet pellentesque ultrices.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (79,'2021-11-06 10:53:11',6,'Praesent at ex eget diam ullamcorper porta a nec nulla.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (79,'2021-11-21 18:43:47',52,'Curabitur placerat tellus a lectus placerat placerat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (96,'2021-11-06 10:54:46',33,'Ut pretium ex lacinia sem lobortis aliquet.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (82,'2021-12-03 09:23:46',73,'Duis efficitur nisl rhoncus, semper lorem at, luctus felis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-12-09 14:33:22',6,'Pellentesque pellentesque dolor vel leo lacinia, nec vehicula leo tempus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-18 10:56:04',12,'Morbi luctus massa non purus egestas facilisis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (91,'2021-12-02 06:37:18',30,'Maecenas at felis non ipsum varius commodo sed quis ante.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-12 08:51:30',56,'In eu ligula tincidunt, ultricies nulla ac, placerat nulla.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (69,'2021-11-09 18:41:37',65,'Nullam sollicitudin mauris at justo tempor, at porttitor libero sodales.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (107,'2021-12-08 16:44:15',43,'Suspendisse porttitor libero ut mauris venenatis dignissim.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (106,'2021-11-06 12:30:40',81,'Duis lacinia est a tellus sollicitudin, eu aliquet lectus pharetra.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (88,'2021-11-09 10:23:40',88,'Mauris pharetra lorem et accumsan posuere.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (54,'2021-12-05 14:25:26',27,'Nullam ac magna mollis neque porta feugiat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (18,'2021-11-16 14:31:47',90,'Aliquam ut diam sed sem dapibus posuere eget vitae massa.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (56,'2021-11-02 12:03:10',70,'Phasellus quis lectus eget turpis facilisis mattis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (71,'2021-12-06 08:39:24',88,'Sed varius nunc ut erat maximus dapibus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (1,'2021-12-09 06:01:44',24,'Vivamus eget sapien et ipsum gravida iaculis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-12-03 12:19:26',17,'Phasellus at mauris non nulla semper consequat vitae ac leo.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (20,'2021-11-26 11:05:17',66,'Vestibulum sed metus sodales, vestibulum odio id, varius ante.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-11-13 19:28:08',44,'Proin nec nisl et justo hendrerit elementum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (19,'2021-11-12 09:47:57',35,'Sed in diam id tortor semper efficitur et et libero.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-12 11:19:06',30,'Sed sodales lectus a tincidunt semper.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (75,'2021-11-25 07:18:37',4,'Vestibulum fringilla diam sit amet leo euismod accumsan.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (112,'2021-12-09 12:59:20',31,'Nullam rhoncus justo a turpis ultrices, id vehicula mauris mattis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (73,'2021-11-17 10:17:28',53,'Cras vestibulum arcu vehicula orci interdum elementum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (118,'2021-11-07 21:24:12',57,'Duis cursus justo in lacus efficitur, non sodales neque tempor.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (56,'2021-11-23 11:36:23',9,'Nunc nec magna ut sapien aliquam molestie.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (37,'2021-12-01 07:21:04',89,'Vestibulum sed nisi id justo sodales rutrum nec nec odio.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (41,'2021-12-10 18:25:21',23,'Cras a sem a turpis iaculis mattis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (112,'2021-11-07 08:56:33',14,'Aenean laoreet massa eget felis ultricies vehicula.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (29,'2021-12-09 09:03:01',84,'Fusce non turpis at lorem fringilla ultricies sed et velit.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-04 21:21:27',36,'Aliquam placerat magna id sodales feugiat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (39,'2021-11-18 20:33:22',54,'Nunc non ex a ligula ultricies scelerisque.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-11-13 07:17:11',26,'Ut feugiat enim vitae facilisis congue.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-11-30 18:21:36',23,'Praesent porttitor metus egestas, finibus purus auctor, elementum dolor.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (78,'2021-11-25 15:12:49',49,'Aenean tempus nibh et tempus luctus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (88,'2021-11-08 09:01:18',27,'Duis luctus magna viverra orci gravida, sed rutrum urna dignissim.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (44,'2021-11-11 09:44:56',52,'Duis sit amet nibh efficitur, tincidunt augue sit amet, sodales tellus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-11-27 16:19:55',46,'Nulla bibendum nunc a dui pulvinar ultricies.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (121,'2021-11-01 20:49:12',1,'Nullam vestibulum metus ut hendrerit consectetur.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (14,'2021-11-26 07:46:25',16,'Vestibulum vitae dolor id est tempor aliquet.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (6,'2021-11-20 08:36:32',79,'Curabitur et diam molestie, aliquam neque vehicula, feugiat purus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-12-11 07:38:04',38,'Sed ultricies diam iaculis finibus vehicula.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (26,'2021-11-03 13:33:10',90,'Nullam rhoncus velit at dui iaculis, at auctor ligula euismod.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-11-08 07:27:07',39,'Nulla ac eros efficitur, commodo purus lacinia, viverra felis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (41,'2021-12-11 06:20:10',80,'Vivamus quis tortor id eros ultricies lacinia.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (109,'2021-11-07 14:38:24',56,'In quis augue sollicitudin, vestibulum ante sit amet, tristique purus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-29 11:21:24',26,'Quisque eget arcu id sapien tincidunt malesuada a vitae lacus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-11-08 14:23:17',85,'In elementum mauris quis hendrerit fringilla.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (118,'2021-11-12 10:55:12',76,'Vivamus rhoncus urna vehicula, sollicitudin dui et, interdum lacus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-11 08:13:21',65,'Vestibulum vitae nunc pellentesque, commodo tortor in, volutpat risus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-12-06 14:48:46',76,'Aenean mattis libero ac eros fermentum, a ornare turpis tempus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-11-11 17:41:00',54,'Sed quis tortor vitae enim vulputate gravida.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (25,'2021-11-18 21:31:49',24,'Proin non erat nec nunc consequat ullamcorper vel in nibh.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-15 19:44:41',37,'Cras id eros sed nibh ultrices cursus varius in massa.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (63,'2021-11-16 16:20:30',22,'Nullam ac justo sodales, blandit tellus sed, hendrerit nibh.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (21,'2021-11-12 11:26:44',74,'Aliquam quis diam tincidunt, hendrerit nibh id, tempor urna.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (86,'2021-12-02 06:14:07',18,'Etiam vitae turpis non lectus porta pharetra.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (91,'2021-11-20 18:59:54',21,'Quisque eu ex venenatis, consectetur urna sit amet, dapibus justo.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (118,'2021-11-06 14:37:06',50,'Cras elementum tellus ut enim pretium placerat.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (22,'2021-12-05 07:34:45',6,'Pellentesque vitae leo tempus, fermentum augue eget, egestas nibh.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-02 20:53:05',7,'Nunc hendrerit mauris at hendrerit semper.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (6,'2021-11-01 15:28:31',26,'Nullam non tortor a odio elementum posuere.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (68,'2021-12-02 15:55:44',72,'Mauris interdum nunc quis sollicitudin rhoncus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-12-11 14:45:53',11,'Curabitur convallis est sit amet neque sodales, sit amet volutpat enim lacinia.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-11-07 06:49:32',86,'Duis at libero cursus, luctus metus id, consequat nulla.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (82,'2021-12-07 11:50:21',55,'Sed id tellus iaculis, consequat erat quis, fermentum elit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (87,'2021-11-02 12:24:12',19,'Aenean interdum eros id nisi finibus, in volutpat sem mattis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (125,'2021-12-09 11:08:36',75,'Curabitur a quam quis risus porta pretium at a massa.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-12-06 21:48:49',35,'Ut nec nulla non quam convallis pulvinar ut sollicitudin nisl.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-19 21:46:22',48,'Aliquam euismod eros et malesuada faucibus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (36,'2021-11-22 12:11:40',45,'Ut quis nulla tincidunt, dignissim nisl quis, aliquet dui.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-20 09:31:41',4,'Nam efficitur lectus vel dolor aliquet, finibus accumsan mauris tincidunt.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (3,'2021-12-05 17:36:49',78,'Mauris vitae risus hendrerit, feugiat enim a, dictum dui.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (31,'2021-11-11 16:59:57',8,'Maecenas ut ante in orci dapibus euismod.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (17,'2021-11-02 15:32:07',20,'Aliquam tincidunt massa et semper tempus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (20,'2021-12-06 07:59:40',32,'Donec ut quam nec dolor blandit malesuada non id augue.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (83,'2021-11-21 16:57:48',80,'Nullam sit amet mauris scelerisque, pretium velit sed, imperdiet massa.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (100,'2021-11-30 09:06:55',50,'Aliquam et metus sed urna gravida ultrices.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-11-21 15:51:33',33,'Curabitur eget leo fermentum, porttitor est ut, viverra diam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (17,'2021-11-24 08:08:36',74,'Sed luctus felis vitae urna consectetur, sit amet efficitur odio accumsan.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (114,'2021-11-02 06:11:14',9,'Quisque quis dui vel libero pretium convallis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (50,'2021-11-12 15:50:41',6,'Sed ac dolor in massa vestibulum congue maximus quis arcu.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-12-01 17:44:44',74,'Donec sed odio a justo mattis sodales a non diam.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (51,'2021-11-30 16:35:28',11,'Aenean viverra risus lobortis diam hendrerit, nec maximus quam mattis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (106,'2021-12-03 11:09:27',9,'Aliquam vel ante quis tellus condimentum consequat.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (26,'2021-12-11 11:47:37',15,'Nullam nec neque vel tortor fermentum molestie.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (2,'2021-11-10 18:00:00',46,'Suspendisse bibendum augue varius, posuere nibh vel, egestas ligula.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (39,'2021-11-15 16:12:26',39,'Duis euismod quam a massa aliquet, et dictum leo dictum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-11-20 14:51:30',87,'Phasellus dignissim felis eu magna semper vestibulum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (89,'2021-11-14 21:35:34',40,'Nunc pulvinar neque dignissim urna rutrum ultricies.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-13 18:45:30',13,'Pellentesque sit amet massa molestie libero pulvinar luctus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (88,'2021-11-06 06:23:11',43,'Pellentesque dignissim leo ultricies, lobortis arcu rhoncus, pulvinar felis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (121,'2021-11-22 15:05:54',9,'In volutpat elit at pulvinar faucibus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (91,'2021-11-26 12:57:36',18,'Pellentesque in tortor sit amet diam tempus egestas.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (61,'2021-12-06 14:22:16',72,'Nunc pretium elit ut tincidunt rhoncus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-28 21:19:09',8,'In vehicula dui sed mi mattis, non aliquam turpis varius.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-11-28 11:53:57',41,'Etiam eleifend justo vel mi rutrum efficitur quis non lacus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (87,'2021-11-26 09:38:53',44,'In vel sapien sed odio efficitur convallis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-07 12:52:16',54,'Sed eleifend ligula in augue interdum consequat.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (10,'2021-11-22 17:53:23',26,'Maecenas sed sem vitae sem imperdiet viverra sed ullamcorper sem.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (92,'2021-11-26 07:46:16',89,'Quisque vel velit faucibus, interdum justo a, fermentum ligula.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (126,'2021-11-20 14:12:29',78,'Nulla finibus elit id efficitur mollis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (71,'2021-11-12 20:30:46',58,'Suspendisse luctus mauris posuere ante condimentum luctus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (71,'2021-12-04 08:27:10',38,'Etiam vitae lectus id enim ultricies porttitor ut sit amet ex.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (104,'2021-11-28 14:19:41',52,'Sed ornare ipsum nec nibh pulvinar, posuere mollis ligula molestie.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (13,'2021-11-21 10:25:58',31,'Mauris tincidunt massa eget vestibulum efficitur.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (85,'2021-11-23 11:40:25',93,'Cras ac elit id leo posuere varius.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (63,'2021-11-12 08:19:24',50,'Nulla et orci ornare, ultricies turpis non, consectetur neque.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (68,'2021-12-03 13:52:54',93,'Nulla at turpis vitae risus condimentum varius vitae ac nunc.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (119,'2021-11-11 08:46:54',30,'Vestibulum non elit vulputate, scelerisque risus id, ultrices eros.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (35,'2021-11-13 15:25:21',17,'Aenean malesuada nisi eu velit semper, a interdum sem auctor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (31,'2021-11-04 17:21:50',2,'Sed at tortor in sem lobortis accumsan.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (33,'2021-11-02 16:03:22',21,'Nullam a magna sit amet magna sollicitudin porta.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (105,'2021-12-06 07:05:40',57,'Sed ac nisl vel mauris fringilla ultrices.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (87,'2021-12-02 08:00:40',92,'Aliquam sed urna vitae ipsum molestie lacinia et vitae velit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (26,'2021-12-05 18:48:58',41,'Praesent pharetra risus sit amet nibh aliquet, eget tincidunt tellus vulputate.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (13,'2021-11-20 19:59:05',22,'Phasellus quis mauris quis magna laoreet facilisis vel id tellus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (21,'2021-11-05 16:02:12',15,'Integer in arcu laoreet, maximus ante eget, iaculis leo.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (34,'2021-11-17 13:56:47',59,'In id lorem tincidunt, sollicitudin metus faucibus, varius nulla.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (92,'2021-11-06 13:37:12',67,'Nullam varius orci a est bibendum, maximus cursus mi gravida.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-11-07 18:30:58',53,'Phasellus vestibulum elit hendrerit est gravida, sit amet iaculis lectus laoreet.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-04 19:05:31',18,'Etiam nec quam at augue facilisis ornare.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-12-09 19:46:42',38,'Fusce pharetra lorem sit amet orci posuere, vel convallis lorem tincidunt.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (22,'2021-12-02 08:50:04',17,'Etiam vitae magna ut mauris dignissim suscipit et a mi.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (13,'2021-11-21 08:43:44',8,'Proin et nisl id arcu consectetur rhoncus rutrum ac ipsum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (45,'2021-11-07 08:23:43',45,'Mauris sollicitudin neque eu dictum laoreet.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (76,'2021-11-14 11:01:41',11,'Pellentesque in tortor porta, dapibus massa et, feugiat ante.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (31,'2021-11-17 09:30:23',18,'Phasellus pulvinar justo at enim auctor, quis feugiat turpis ultrices.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (25,'2021-12-04 18:36:00',30,'Aenean in orci vel risus finibus semper.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-11-25 09:51:42',76,'In facilisis ex ac lobortis dignissim.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (37,'2021-11-30 11:52:13',76,'Aliquam consequat sapien ut libero imperdiet, nec iaculis sem dapibus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-06 12:14:07',84,'Aenean ac dolor ac metus condimentum ullamcorper sit amet id libero.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-04 10:01:47',7,'Nullam varius lacus at augue laoreet rutrum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (97,'2021-11-21 11:26:53',69,'Nullam luctus nisl id magna pretium interdum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (34,'2021-11-24 11:29:54',15,'Integer in odio semper, gravida urna nec, tincidunt mauris.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (27,'2021-11-03 07:08:41',63,'Nulla semper magna in nisi tincidunt placerat.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (42,'2021-12-08 14:49:21',75,'Praesent condimentum felis egestas, molestie ipsum id, dapibus mauris.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (40,'2021-11-27 15:58:28',62,'Vestibulum efficitur metus id mattis lacinia.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (91,'2021-11-05 21:09:30',18,'Aenean id odio condimentum, facilisis turpis et, dapibus dolor.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (40,'2021-11-15 21:12:06',10,'Sed sagittis odio id sem feugiat sollicitudin.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-02 21:09:30',31,'Nullam elementum neque in turpis ullamcorper, eu condimentum diam gravida.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-11-12 15:54:26',56,'Donec et nunc porttitor, dictum sem vitae, porttitor ante.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (44,'2021-12-02 20:21:24',84,'In dictum lorem ut sapien rutrum lobortis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-11-17 19:14:44',3,'Cras id mauris vel velit mollis imperdiet.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (48,'2021-12-05 10:31:26',69,'Cras gravida velit eget ex porttitor viverra.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (30,'2021-11-16 18:03:01',18,'Nullam ut velit vitae elit facilisis tincidunt.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (72,'2021-11-07 06:26:21',46,'Etiam eget magna tincidunt mi tincidunt commodo.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (10,'2021-11-01 07:49:18',48,'Nunc facilisis libero commodo scelerisque tincidunt.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (96,'2021-11-12 06:44:12',37,'In quis nulla volutpat, fringilla nibh et, malesuada felis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (84,'2021-11-04 14:34:05',56,'Praesent suscipit ante lacinia diam feugiat blandit.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (119,'2021-12-08 21:00:00',85,'Nunc eu urna eget justo tincidunt rhoncus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-11-24 13:29:00',72,'Curabitur ut nisl posuere, ultricies leo tempor, aliquet dolor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (63,'2021-11-07 19:06:32',48,'Duis ut libero non velit mattis sagittis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (53,'2021-12-03 14:46:36',32,'Nam laoreet nunc et ante lobortis mattis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (41,'2021-11-14 20:27:36',3,'Aliquam ut augue lobortis, vehicula urna sit amet, sagittis mauris.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-12-10 06:38:53',3,'Ut porttitor justo non magna aliquet, a pulvinar mi scelerisque.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (96,'2021-11-03 21:01:18',51,'Proin accumsan justo nec tellus convallis viverra.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (30,'2021-11-18 13:26:24',46,'Vestibulum vestibulum erat feugiat euismod efficitur.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (80,'2021-11-18 21:50:33',64,'Nam laoreet justo rhoncus augue interdum sodales.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (86,'2021-11-19 12:59:37',32,'Sed sit amet leo vel risus porta commodo ut nec sem.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-11-08 12:17:17',74,'Sed nec diam hendrerit, vestibulum massa eget, tincidunt mauris.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-12-06 14:26:18',8,'Maecenas varius tellus ac dolor interdum vestibulum.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (77,'2021-11-18 09:00:00',32,'Donec in odio dignissim, eleifend nibh in, varius felis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (107,'2021-11-14 13:31:00',70,'Mauris ullamcorper risus nec pulvinar vestibulum.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (79,'2021-11-04 15:11:57',44,'Quisque in tellus et dolor tincidunt hendrerit.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (50,'2021-12-07 19:31:09',69,'Aliquam eleifend purus congue lectus feugiat, eu convallis neque ultricies.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (21,'2021-12-10 10:57:13',38,'Vivamus bibendum urna vel velit elementum, in semper tellus vestibulum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (89,'2021-11-04 13:42:14',10,'Nam at dolor in ex euismod luctus at et mi.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (78,'2021-11-13 20:30:03',90,'Suspendisse ut ex semper, laoreet velit et, consectetur ex.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (51,'2021-11-10 06:22:54',55,'Ut quis mi ut leo vestibulum finibus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-12-06 09:56:53',72,'Nunc faucibus lectus at quam dictum, quis gravida nisi sagittis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-11-04 18:15:16',4,'Cras accumsan erat at leo tempus pellentesque.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-11-09 20:23:43',83,'Phasellus tempor turpis eget ipsum accumsan ultricies.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (6,'2021-11-23 12:29:05',94,'Donec at turpis sit amet orci aliquam ullamcorper facilisis quis ante.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-11-08 19:45:16',76,'Donec sit amet sem eu enim porttitor euismod.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (76,'2021-12-09 16:34:28',59,'Sed ut tortor non eros mattis pulvinar.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (22,'2021-11-01 21:12:58',10,'In quis ante ut lorem porta faucibus ac ac mauris.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (67,'2021-11-04 13:29:08',21,'Aliquam rhoncus sapien sit amet porttitor consectetur.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (48,'2021-11-06 17:43:26',58,'Duis ut nulla quis quam luctus mollis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (29,'2021-11-24 17:09:45',80,'Aliquam auctor nibh vel maximus aliquam.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (14,'2021-12-07 09:33:16',36,'Nulla eget massa imperdiet mauris ultricies pretium eu condimentum tortor.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (69,'2021-11-30 16:34:36',54,'Sed feugiat orci vestibulum lorem mollis, id fringilla velit dignissim.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (45,'2021-11-14 17:10:19',39,'Nulla pulvinar ligula at porttitor hendrerit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (105,'2021-11-24 21:40:54',30,'Ut dapibus turpis sit amet lacus imperdiet, eu lacinia augue lobortis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (34,'2021-12-01 13:24:58',52,'Sed porta nisl eget commodo pharetra.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-11-27 08:12:03',24,'In commodo ante in egestas porttitor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (126,'2021-11-25 20:09:10',88,'Duis sed ante quis mi rutrum semper suscipit nec risus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (68,'2021-11-19 19:01:21',91,'Phasellus sagittis neque et tortor ultricies mollis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (15,'2021-12-11 10:15:01',71,'Integer sed justo sit amet erat tempor feugiat lacinia eu lorem.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (108,'2021-11-07 15:40:36',13,'Integer finibus massa vel mauris venenatis euismod.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (35,'2021-11-02 15:06:12',78,'Proin a felis venenatis tellus interdum tristique.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (122,'2021-11-19 12:30:06',6,'Maecenas consequat libero sed dapibus pharetra.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (16,'2021-11-03 06:38:01',43,'Phasellus dapibus urna sit amet massa condimentum molestie vitae quis velit.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-15 08:50:12',18,'In malesuada erat non nisl volutpat, ut tincidunt tortor interdum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (60,'2021-11-25 10:20:56',74,'Curabitur sed est in justo convallis auctor eu sed nulla.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (13,'2021-11-30 14:34:39',27,'Phasellus sit amet dui eget nibh convallis condimentum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-26 14:06:52',53,'Praesent viverra mi eu finibus suscipit.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (18,'2021-11-14 08:22:25',32,'Quisque vitae magna non orci fermentum luctus ultrices id ante.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (125,'2021-11-04 20:55:49',28,'Maecenas sit amet enim a diam facilisis sollicitudin.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (108,'2021-11-28 08:04:25',76,'Proin porta lorem sed commodo ullamcorper.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (37,'2021-12-09 07:12:26',19,'Fusce laoreet turpis ac dictum feugiat.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (45,'2021-11-14 09:30:49',91,'Donec pretium elit sed justo imperdiet dapibus et vitae dui.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (73,'2021-11-04 15:30:32',78,'Vestibulum eget felis efficitur, commodo nisl convallis, blandit libero.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (107,'2021-11-18 18:28:22',40,'Aliquam in quam vel mi posuere posuere.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-11-23 18:24:46',35,'Proin at ipsum venenatis, convallis ante at, placerat lorem.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (49,'2021-12-07 07:14:18',38,'In finibus lacus eu elementum auctor.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (20,'2021-12-05 19:55:38',58,'In in ante posuere, porta turpis quis, fringilla felis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (76,'2021-12-03 20:20:50',80,'Nunc consectetur ipsum in nisi ultricies, nec imperdiet tellus placerat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (44,'2021-11-14 10:16:02',2,'Donec finibus turpis eu nunc sagittis, vitae elementum risus ultricies.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (108,'2021-11-18 20:19:49',6,'Pellentesque dignissim eros ac urna maximus porta.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (100,'2021-11-04 14:28:54',54,'Praesent ut nibh sed diam pellentesque lobortis quis non libero.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-12-08 20:52:05',9,'Fusce a augue laoreet, commodo quam sed, porta dolor.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-11-30 19:13:52',13,'Fusce hendrerit sem sit amet nulla maximus cursus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (16,'2021-12-02 08:38:50',65,'Nunc sit amet magna id enim tincidunt luctus eget ac quam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (31,'2021-12-08 21:16:25',72,'Sed sed diam vitae sapien ullamcorper tempus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (59,'2021-11-12 10:35:20',2,'Donec interdum ligula at neque efficitur sagittis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (80,'2021-11-18 15:53:08',20,'Nulla tristique purus eget magna hendrerit, a venenatis purus sodales.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (119,'2021-11-12 20:57:33',59,'Proin molestie ligula nec tortor consequat iaculis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (105,'2021-11-02 19:44:50',57,'Ut rhoncus diam eu maximus consequat.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (58,'2021-11-24 12:16:34',73,'Praesent tempor neque nec malesuada tincidunt.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-09 17:15:22',75,'Aliquam et ex id lorem sollicitudin fringilla at quis nisi.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-20 13:40:13',69,'Maecenas ac nulla quis felis molestie blandit ut ac felis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (10,'2021-11-04 09:46:31',83,'Donec venenatis leo a volutpat interdum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (54,'2021-12-08 15:35:51',59,'Donec posuere magna et sollicitudin consectetur.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (16,'2021-11-21 19:03:56',11,'Sed tristique arcu sit amet justo pretium, vel accumsan mi consequat.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (121,'2021-12-07 20:05:51',34,'Nam vel augue non tellus rutrum tempor eu in velit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (8,'2021-11-25 21:06:29',7,'Nulla tempus dui sit amet hendrerit malesuada.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (29,'2021-11-13 14:52:05',20,'Nullam vel purus non ligula lobortis tristique ac nec dolor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (107,'2021-12-02 20:19:49',90,'Sed vel mi in augue iaculis interdum at sit amet ante.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-24 15:05:11',73,'Morbi euismod neque et lectus luctus efficitur.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-12-08 17:28:19',71,'Integer congue turpis a odio rhoncus elementum.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-11-01 11:44:44',36,'Integer posuere turpis quis ultricies ultricies.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (6,'2021-11-03 12:51:24',79,'Maecenas semper sem eget odio mollis, eu vehicula tellus varius.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-11-21 14:38:50',4,'Donec ac turpis volutpat, pulvinar diam non, placerat quam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (3,'2021-12-03 06:06:12',26,'Aenean efficitur diam sit amet ligula aliquet, ac rutrum tellus lacinia.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (33,'2021-11-13 10:42:58',72,'Phasellus volutpat nisi et tempor tempus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (121,'2021-12-08 19:46:42',41,'Vestibulum et massa sed nisl mattis vestibulum eget non metus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (82,'2021-12-03 12:10:57',9,'Pellentesque nec leo a lorem eleifend semper eu sit amet tellus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-12-11 18:31:24',62,'Proin fringilla tortor et tincidunt varius.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (39,'2021-12-07 18:38:36',93,'Sed vitae lectus at erat efficitur molestie.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (79,'2021-11-08 16:53:11',83,'Phasellus in ipsum eget eros consequat ornare pellentesque quis risus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-11-30 08:07:00',14,'Morbi eget lectus sed velit porttitor bibendum a eu nisl.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-11-08 17:53:14',59,'Praesent vitae massa id ligula iaculis porttitor.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (86,'2021-11-24 17:43:44',14,'Proin mattis massa et lectus aliquam, eget ullamcorper felis pretium.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (14,'2021-11-12 07:25:06',92,'Etiam eget neque at dolor sollicitudin ornare.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (58,'2021-11-17 19:07:49',41,'Phasellus sodales nibh ac tempus tristique.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (112,'2021-12-01 21:14:24',28,'Cras in augue at odio scelerisque mattis vel a est.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (37,'2021-11-16 13:43:49',29,'Duis pulvinar lacus vel nibh tincidunt, ut facilisis ligula iaculis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (36,'2021-12-09 14:15:30',50,'Nullam convallis felis sed metus ullamcorper, nec aliquet ligula hendrerit.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (64,'2021-11-23 14:00:49',2,'Curabitur et metus ornare, tempus turpis aliquam, fermentum turpis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (76,'2021-12-05 08:27:45',42,'Fusce eu sapien sed felis euismod semper id et sem.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (103,'2021-11-12 21:15:24',43,'Vivamus vitae felis varius, vehicula arcu ut, volutpat quam.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (103,'2021-11-08 13:55:03',67,'Proin eu velit vitae neque ullamcorper viverra.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (72,'2021-12-06 14:36:58',92,'Duis non erat eget ligula ultricies porttitor vel sit amet magna.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (15,'2021-11-23 09:05:54',56,'Aenean placerat tellus vitae sagittis placerat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (118,'2021-11-06 12:00:17',74,'Vivamus vehicula lectus a neque fringilla tempus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (34,'2021-12-07 09:53:17',13,'Integer tincidunt mauris in placerat efficitur.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-12-03 12:31:58',32,'Praesent vestibulum nulla vel commodo malesuada.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (31,'2021-11-03 17:52:05',2,'Proin quis ex iaculis ligula commodo malesuada.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-12-07 19:55:03',20,'Phasellus sed lectus a est molestie tempor.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-11-15 06:22:45',68,'Maecenas tincidunt dui quis aliquet dapibus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (12,'2021-11-25 08:34:13',10,'Curabitur aliquet urna sed neque sagittis, vitae sollicitudin urna iaculis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-11-02 20:52:22',58,'Etiam auctor massa nec mauris mollis euismod quis vel neque.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (102,'2021-12-07 09:57:19',24,'Aenean ultrices quam vitae orci tristique laoreet.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (71,'2021-11-04 20:28:02',35,'Proin consectetur erat et tempor iaculis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-12-05 10:26:33',5,'Aliquam sed justo in elit aliquam vehicula at ut erat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (4,'2021-11-30 08:25:09',56,'Aenean lacinia elit vestibulum vulputate scelerisque.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (8,'2021-11-06 17:30:55',54,'Curabitur id turpis at orci dictum pretium.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (116,'2021-11-26 13:24:23',82,'Proin varius ex accumsan enim ornare gravida.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-11-05 08:59:43',67,'Sed mattis dui sit amet tristique ornare.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (41,'2021-11-21 15:58:28',85,'Praesent sodales nibh in eros sagittis dictum.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (80,'2021-11-15 14:28:11',80,'Nunc a augue accumsan, hendrerit elit a, imperdiet enim.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (62,'2021-12-03 20:37:41',27,'Sed in nulla aliquam, vehicula eros sed, tincidunt nisl.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (84,'2021-11-10 16:25:32',91,'Integer imperdiet felis ac risus pretium sollicitudin.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (27,'2021-11-12 11:50:38',85,'Aliquam at velit at augue tempus tristique eu ac purus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-11-26 21:58:19',57,'Nam eget tellus ut turpis posuere malesuada.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-11-04 10:45:07',2,'In ac ex eget velit fermentum tristique quis eget libero.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (37,'2021-12-11 13:34:28',89,'Nunc ut ante ullamcorper, malesuada nulla convallis, cursus arcu.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (6,'2021-11-08 16:55:29',86,'Sed a magna a enim feugiat laoreet.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-12-04 18:44:12',64,'Proin placerat nunc in massa rutrum commodo.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (5,'2021-11-20 13:50:44',57,'Vivamus et nulla eleifend, vehicula dolor a, mollis sem.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-11-08 20:34:31',35,'Sed eget libero sed ipsum dictum porta.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (56,'2021-12-05 20:12:46',16,'Phasellus sed erat ac ligula dapibus tempus ultrices in est.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-12-03 13:40:48',15,'Fusce viverra lacus eu suscipit volutpat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (105,'2021-12-09 21:41:46',34,'Nullam nec enim quis risus dignissim mattis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (88,'2021-11-29 19:31:09',68,'In consequat libero et mauris porta, a accumsan enim luctus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (6,'2021-11-28 21:43:03',83,'Vivamus volutpat lorem sed purus facilisis, ut euismod leo sodales.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (54,'2021-11-23 15:48:23',10,'Vestibulum non erat vitae dolor blandit aliquet pellentesque eget nisl.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (125,'2021-11-02 08:27:27',65,'Maecenas eget mauris vitae diam auctor tempus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-11-26 21:56:27',23,'Nunc a augue a odio facilisis feugiat eget nec sapien.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-12-06 11:42:26',90,'Aenean vitae quam interdum, lobortis ipsum eget, sollicitudin velit.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (36,'2021-12-02 21:23:20',57,'Mauris porttitor diam non enim interdum accumsan.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-24 17:06:26',35,'Nunc convallis augue in felis ornare tempus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (23,'2021-11-25 19:41:48',3,'Mauris finibus mauris id interdum convallis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (127,'2021-11-13 18:41:11',41,'Phasellus vehicula tellus a libero dignissim imperdiet.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (114,'2021-11-16 12:21:19',86,'Quisque ac turpis vulputate, viverra tellus et, malesuada est.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (90,'2021-11-29 17:18:32',94,'Suspendisse at massa id magna sodales condimentum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-19 21:37:44',24,'Nam hendrerit sem sed purus ornare, et facilisis ex placerat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (122,'2021-11-29 15:18:52',27,'Suspendisse pulvinar leo quis viverra aliquam.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (54,'2021-11-29 10:59:57',75,'Maecenas mollis metus at porttitor dictum.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (62,'2021-11-02 11:46:28',50,'Integer rhoncus odio et orci aliquam, mollis lobortis orci consectetur.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (61,'2021-11-27 09:08:12',39,'Nam eu elit et ex facilisis sollicitudin.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (10,'2021-11-28 21:04:19',73,'In sed nibh consequat arcu euismod ultrices.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (30,'2021-12-07 16:59:48',9,'Maecenas ut nunc quis elit tincidunt posuere.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (37,'2021-11-02 15:42:12',91,'Sed cursus nisi ac felis pellentesque, et placerat quam faucibus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (82,'2021-11-09 08:26:10',67,'Morbi blandit dolor aliquet, sollicitudin tortor sit amet, cursus sem.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (113,'2021-12-11 08:28:19',80,'Donec quis arcu vitae augue fringilla elementum sit amet et tortor.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (2,'2021-11-22 15:39:19',63,'Nam vel ante consectetur, imperdiet leo sit amet, mattis leo.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (126,'2021-11-23 15:11:48',65,'Nam ut lorem hendrerit, porta purus sed, bibendum dui.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (70,'2021-11-04 09:20:10',90,'Mauris placerat sapien vel felis efficitur, non sodales sem mollis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (36,'2021-11-04 07:12:09',75,'Mauris suscipit erat id erat posuere, at imperdiet sapien pulvinar.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-11-01 08:23:25',45,'Ut suscipit justo nec pellentesque rhoncus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (12,'2021-11-15 06:50:07',47,'Donec pharetra dui in leo facilisis, a auctor nisi vestibulum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (16,'2021-11-25 14:22:25',82,'Morbi non augue commodo, rhoncus enim et, venenatis turpis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-18 19:11:25',46,'Sed semper sapien nec lobortis convallis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-11-22 15:09:48',85,'Suspendisse eget elit viverra, facilisis libero sit amet, sollicitudin ex.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-11-27 15:41:54',33,'Cras imperdiet diam sit amet tellus ornare, non aliquam lacus dignissim.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-05 19:57:56',38,'Etiam tincidunt velit in risus auctor, vitae commodo velit placerat.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (94,'2021-11-24 12:51:07',38,'Morbi in purus non tellus auctor mattis lacinia eu nisl.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-05 15:50:50',41,'Aenean ut quam sit amet orci gravida euismod.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (100,'2021-11-03 13:34:19',70,'Sed gravida arcu ullamcorper dolor tristique, sodales dignissim felis varius.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (72,'2021-11-27 09:14:15',34,'Praesent egestas orci nec felis tempor, in tristique ligula pulvinar.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-11-01 13:47:34',27,'Suspendisse vehicula dui sit amet nisl elementum efficitur eget sodales dui.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (87,'2021-11-06 15:41:46',17,'Vivamus vestibulum enim et ex scelerisque viverra.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (20,'2021-11-11 17:42:26',86,'Curabitur sed magna at turpis tempus dignissim quis quis lacus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-11-06 17:22:42',65,'Nulla elementum dolor sed hendrerit congue.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (89,'2021-11-01 18:58:02',24,'Nulla at elit et metus consectetur feugiat.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (64,'2021-11-18 21:20:44',27,'Nulla et eros vel odio consequat egestas vitae ut dui.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (120,'2021-11-18 20:26:36',89,'Nulla varius quam at dui bibendum, ut cursus lacus varius.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (86,'2021-11-09 08:43:35',26,'Vestibulum malesuada elit et suscipit eleifend.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-11-29 12:14:59',4,'Sed et ante eu eros pharetra tempor et at sem.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (22,'2021-12-01 10:34:36',74,'Donec accumsan ante ac elit bibendum consequat.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (51,'2021-11-07 16:51:53',75,'Aenean ultrices augue laoreet orci accumsan malesuada.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (34,'2021-11-26 17:58:25',65,'Praesent fermentum lectus eu est aliquet maximus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-06 08:05:34',92,'Proin dignissim ex a ante luctus, nec pharetra mauris elementum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (44,'2021-11-28 19:54:20',49,'Mauris vitae quam eget risus consequat varius.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (90,'2021-11-23 17:50:30',34,'Nulla at eros sit amet sapien mattis commodo.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (106,'2021-12-09 12:36:09',45,'Vivamus at massa eu augue posuere consectetur.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (61,'2021-12-02 21:14:24',54,'Fusce malesuada lacus et metus mollis rutrum.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-01 12:09:22',53,'Pellentesque sodales diam eu hendrerit egestas.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (48,'2021-11-14 11:28:19',65,'Quisque pulvinar ipsum eget rhoncus commodo.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-12-01 14:20:24',19,'Proin in urna sit amet diam convallis vestibulum vitae eu velit.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-12-09 15:28:22',21,'Integer quis sapien mollis massa mollis fringilla.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (49,'2021-12-06 18:19:44',86,'Donec id erat nec sapien convallis gravida.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (62,'2021-11-13 11:20:07',49,'Proin eget est id velit condimentum facilisis vel quis sem.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (109,'2021-11-07 21:26:30',87,'Proin quis odio porttitor, iaculis tortor ac, cursus nunc.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (60,'2021-11-29 12:46:13',59,'Phasellus ac lacus eu elit condimentum consectetur vel lacinia mauris.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (15,'2021-11-04 06:23:02',14,'Nam in libero posuere, tempus magna vitae, gravida enim.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (45,'2021-11-05 13:21:39',28,'Cras mattis nibh vitae nunc finibus, at mollis augue laoreet.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (35,'2021-11-03 12:05:28',40,'Proin vitae justo vitae elit vehicula tincidunt non in sem.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (15,'2021-11-11 21:48:23',22,'In eu eros sit amet tellus accumsan pharetra non cursus diam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (26,'2021-11-28 11:41:08',56,'Mauris condimentum odio non turpis interdum faucibus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-12-04 16:16:28',74,'Nullam in enim at leo sagittis eleifend et eu lectus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-11-30 19:41:31',53,'Mauris pretium diam ac neque facilisis, in pharetra nisi laoreet.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-11-28 11:51:48',12,'Mauris dictum nisi eu neque fermentum lacinia.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (15,'2021-11-14 09:55:35',79,'Mauris eget metus nec ex ullamcorper egestas vitae eu nibh.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (18,'2021-12-09 08:43:26',1,'Sed porttitor libero a tincidunt eleifend.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (102,'2021-11-14 17:06:26',87,'Duis eu purus hendrerit, suscipit lacus eu, iaculis velit.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-11-19 20:23:08',78,'Etiam semper est hendrerit, bibendum enim ut, suscipit sem.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (96,'2021-11-23 08:30:20',12,'Vestibulum vehicula risus a consectetur dignissim.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (121,'2021-11-17 13:44:15',46,'Nulla ac mauris ultricies, vehicula augue sit amet, placerat ipsum.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (27,'2021-11-25 14:33:13',12,'Phasellus cursus velit consectetur sagittis consequat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (112,'2021-11-20 18:00:52',21,'Suspendisse in massa ac ipsum cursus eleifend at pulvinar velit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (28,'2021-11-18 14:45:01',28,'Phasellus ut tortor eu ex gravida rutrum at placerat ipsum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-02 16:14:36',25,'Praesent ultricies leo eget sem placerat, sit amet dapibus mauris auctor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (107,'2021-11-08 07:18:20',7,'Aenean convallis justo et purus blandit euismod.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (72,'2021-11-18 08:10:11',61,'Donec bibendum urna at mauris malesuada, id sagittis augue feugiat.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (35,'2021-12-01 08:34:31',45,'Donec ut elit eu mi dapibus sodales at a orci.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (57,'2021-11-02 07:39:48',23,'Cras vitae ligula in orci dignissim euismod.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-11-26 11:57:07',78,'Fusce hendrerit erat a dolor congue sagittis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (84,'2021-11-12 19:02:47',6,'Vestibulum et turpis eu est pretium consectetur.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (107,'2021-11-24 07:57:48',79,'Vestibulum a dui vitae ligula fermentum venenatis eu ornare dui.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (59,'2021-12-01 09:00:17',34,'Fusce volutpat lorem sed est iaculis, non rutrum massa sollicitudin.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (12,'2021-11-03 20:05:34',32,'Proin id elit sit amet purus fermentum varius eget nec sapien.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (75,'2021-11-30 09:50:59',82,'Etiam et mi lobortis, tincidunt leo volutpat, mollis lorem.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (7,'2021-12-02 06:04:11',13,'Nunc auctor purus vitae nibh imperdiet euismod.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-12-07 12:22:19',20,'Etiam et risus nec velit aliquam porta quis eu est.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-12-02 15:44:38',9,'Aenean egestas orci sit amet porttitor luctus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (34,'2021-11-22 17:32:04',21,'Nunc vel elit hendrerit, scelerisque felis eget, venenatis elit.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (67,'2021-12-08 16:52:54',4,'Aenean rutrum sem a diam bibendum rhoncus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (121,'2021-12-04 19:26:15',93,'Nam ac urna vitae mauris mattis vehicula a sed ligula.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (73,'2021-12-04 12:30:40',57,'Sed vel lectus mollis, placerat lectus eu, aliquet nulla.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-11-23 20:31:12',16,'Aenean vel erat varius, convallis augue auctor, gravida turpis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (28,'2021-11-21 07:20:12',33,'Maecenas euismod sapien id justo molestie, id dignissim augue maximus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (19,'2021-12-05 15:24:20',27,'Nunc in leo id urna porta facilisis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (12,'2021-11-17 12:54:52',55,'In mattis sapien sed dignissim tincidunt.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (62,'2021-11-29 19:35:54',76,'Ut malesuada enim in tortor semper porttitor.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-27 12:48:32',67,'Praesent vitae lacus eget tellus ullamcorper cursus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (44,'2021-11-16 16:58:22',1,'Vivamus viverra elit et lacus lacinia feugiat at non ex.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (96,'2021-12-05 08:17:31',41,'Nam condimentum massa eget lectus efficitur suscipit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-11-19 06:12:23',82,'Aenean consequat nulla in semper tristique.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-12-01 06:22:36',34,'Aliquam viverra mauris lobortis mi egestas, quis pretium risus varius.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-16 07:40:13',46,'Aenean quis orci ut velit porta gravida vel vel lectus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (61,'2021-11-23 19:36:37',14,'Maecenas luctus nulla et diam convallis varius.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (20,'2021-11-28 18:33:07',19,'Duis sed ante fermentum, tincidunt justo ac, ultricies odio.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-12-09 19:48:00',25,'Vestibulum pulvinar odio vel leo fringilla tristique.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (15,'2021-12-09 21:17:34',8,'Fusce pretium tellus congue pulvinar rutrum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (50,'2021-11-03 13:17:54',55,'In varius urna at turpis gravida porta.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-12-03 18:46:48',13,'Integer eu libero tincidunt, mattis metus vel, pellentesque metus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (100,'2021-11-24 11:00:58',14,'Fusce sit amet metus eu lectus volutpat consequat at eu velit.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (19,'2021-12-09 18:57:19',86,'Donec bibendum sapien volutpat varius venenatis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-11-21 11:57:42',94,'Donec finibus arcu sit amet efficitur auctor.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-11-04 11:12:03',20,'Cras at neque nec tellus laoreet tincidunt in ac turpis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-11-24 19:13:00',38,'Quisque sollicitudin libero non nisi facilisis iaculis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (102,'2021-11-11 13:19:21',64,'Nam rhoncus justo non pulvinar vulputate.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (40,'2021-11-17 17:03:07',11,'Donec quis ex facilisis, pulvinar odio eu, malesuada libero.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (50,'2021-12-10 08:10:28',57,'Vivamus pretium orci eget laoreet molestie.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (90,'2021-11-17 14:35:40',6,'Fusce at nunc blandit, gravida ex non, accumsan arcu.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-11-17 13:51:36',79,'Nulla eu odio accumsan, facilisis quam euismod, dapibus turpis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (42,'2021-11-06 13:53:37',19,'Curabitur elementum dui sed malesuada gravida.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (25,'2021-11-01 06:23:02',29,'Ut sed dolor efficitur, blandit purus sit amet, elementum lacus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-11-08 13:34:19',67,'Nullam in velit eget eros ultrices dictum.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (57,'2021-11-30 21:28:57',51,'Duis vel metus vulputate, porttitor eros sit amet, imperdiet diam.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (49,'2021-11-17 15:22:45',9,'Pellentesque vitae purus ac ex fermentum luctus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (68,'2021-11-12 13:01:47',76,'Suspendisse eu erat et dui semper accumsan a eu tortor.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (1,'2021-11-16 20:22:25',30,'Ut venenatis mauris quis ligula sagittis, ac consectetur nisi faucibus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (1,'2021-11-27 21:56:27',74,'Donec non velit id est tristique eleifend.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (98,'2021-12-10 19:47:25',23,'Maecenas consequat augue nec libero fringilla rhoncus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-17 08:17:31',82,'Vivamus ut nisi ornare, iaculis magna sed, hendrerit dolor.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (36,'2021-11-25 08:59:08',17,'Aliquam eget sapien varius, convallis nibh eu, condimentum enim.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-11-11 18:15:42',75,'Fusce eget lectus sit amet tortor tincidunt scelerisque.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (100,'2021-11-23 11:59:08',44,'Aliquam ac quam ut metus facilisis euismod.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-12-01 15:31:32',36,'Quisque posuere odio at odio lobortis, eu ultrices nunc accumsan.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (101,'2021-12-05 16:25:49',11,'Sed quis massa non metus convallis feugiat porta sed augue.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (69,'2021-11-01 12:20:44',36,'Pellentesque quis ex vel sem rhoncus mollis tempor vitae quam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-02 20:54:32',16,'Pellentesque ac leo eget enim mattis posuere.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-24 14:56:33',62,'Ut varius tortor nec justo lacinia lobortis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-11-23 07:34:36',48,'Nam a ante vel lacus bibendum sagittis sit amet sit amet elit.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (100,'2021-11-13 07:42:23',38,'Cras viverra diam id dui tristique faucibus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (61,'2021-11-18 19:55:03',55,'Mauris fermentum leo et mattis aliquet.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (11,'2021-11-14 16:21:30',29,'Fusce egestas dolor quis ultrices fermentum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (122,'2021-11-16 19:23:05',14,'Curabitur pellentesque justo quis dignissim ultricies.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-30 14:13:29',4,'Donec quis mauris vel ante fringilla posuere nec in nunc.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (56,'2021-11-22 18:12:49',6,'Mauris ultricies erat nec erat ultricies tincidunt.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (91,'2021-11-06 09:28:05',30,'Sed tristique enim nec quam interdum tempus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (102,'2021-12-08 10:06:58',9,'Etiam lobortis lorem id risus luctus maximus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (106,'2021-11-19 10:44:24',12,'Cras ornare diam nec sem convallis porta.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-11-10 15:43:03',94,'Maecenas aliquet purus eu commodo faucibus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (121,'2021-11-21 18:41:46',32,'Suspendisse quis nulla eget tortor auctor iaculis nec sed mauris.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (32,'2021-11-19 20:20:07',44,'Fusce sit amet nisi vel urna viverra bibendum quis sodales dolor.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (58,'2021-12-05 15:48:40',71,'Maecenas auctor felis sit amet arcu tincidunt, nec porta tortor gravida.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (126,'2021-11-19 16:42:49',20,'Sed vitae nibh a mi egestas luctus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-12-07 07:40:39',56,'Morbi ac lacus quis urna fermentum auctor vel in dolor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (120,'2021-12-04 06:14:50',13,'Integer ultricies est nec tristique venenatis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (20,'2021-11-05 16:35:46',31,'Vestibulum pharetra turpis ullamcorper semper blandit.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (32,'2021-11-19 08:21:16',90,'Suspendisse dignissim elit ut molestie convallis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (67,'2021-12-03 15:22:54',62,'Ut quis libero in erat dictum mattis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (75,'2021-11-26 07:21:56',80,'Aliquam viverra mauris id leo sollicitudin sodales lacinia quis diam.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-11 08:37:41',39,'Mauris pharetra odio at diam mollis, sit amet lobortis erat scelerisque.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-02 16:23:40',3,'Cras posuere felis ut felis blandit, finibus lacinia nisl condimentum.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (59,'2021-11-17 06:53:34',27,'Maecenas ac enim eget risus ultricies rhoncus egestas id eros.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (105,'2021-12-10 18:25:38',31,'Donec non nibh tempor, mollis augue in, ultrices erat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (29,'2021-11-03 15:24:20',1,'Pellentesque ornare nulla sit amet sollicitudin gravida.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (107,'2021-12-08 15:19:09',73,'Ut ac elit tincidunt, fermentum lacus rhoncus, maximus sapien.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (50,'2021-11-04 08:52:39',11,'Curabitur sit amet diam a eros finibus lacinia a non mauris.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (76,'2021-11-11 15:05:54',15,'Nam cursus nisi sit amet arcu consequat sagittis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (43,'2021-11-19 20:26:10',32,'Morbi blandit eros vitae aliquet vulputate.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-11-11 07:24:58',64,'Ut consectetur mauris facilisis efficitur varius.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (27,'2021-12-10 13:50:10',89,'Donec in nulla vitae sem tincidunt dapibus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (70,'2021-11-13 09:17:43',54,'Proin maximus nibh sed imperdiet vestibulum.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (119,'2021-12-10 09:29:05',19,'Quisque eu justo at sem volutpat interdum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (23,'2021-11-21 12:09:30',89,'Curabitur imperdiet lectus quis lacus tristique luctus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (94,'2021-11-22 09:16:08',86,'Cras in enim eget orci scelerisque pharetra vitae ut purus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (30,'2021-11-19 14:58:25',11,'Nunc tempor elit rutrum rhoncus pulvinar.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-15 07:33:01',93,'Quisque vel leo a nisi fringilla ultricies eget non enim.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (103,'2021-11-10 06:07:55',82,'Duis tristique ipsum non ipsum aliquet, vel volutpat risus ullamcorper.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-11-29 17:11:20',24,'Nullam porttitor ante sit amet ex viverra, sed cursus odio facilisis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (114,'2021-11-05 17:55:41',7,'Suspendisse eu est id justo tempor consequat a sit amet orci.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-09 19:27:07',94,'Sed in risus in sapien tempor tempor id id massa.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (17,'2021-11-29 18:42:46',12,'Sed a sem eu ex tempus lacinia eu eget odio.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (27,'2021-11-05 14:04:34',76,'Praesent pulvinar quam quis odio tristique viverra.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (104,'2021-11-04 10:10:08',61,'Aenean in erat eleifend, vulputate lectus nec, blandit nulla.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (3,'2021-11-29 18:38:01',50,'Pellentesque eu nunc aliquet, egestas nisl varius, ultricies ex.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (16,'2021-11-03 12:07:29',64,'Curabitur posuere sem eget est commodo sodales.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (32,'2021-11-16 11:53:31',3,'Nullam dictum purus et porttitor pharetra.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-20 17:17:14',60,'Etiam sit amet mauris accumsan, dictum mi ut, pellentesque nibh.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (16,'2021-11-21 18:10:39',34,'Duis mollis est condimentum nibh malesuada sodales.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (64,'2021-11-10 13:38:38',39,'Sed sagittis odio ut lacinia posuere.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (10,'2021-12-03 21:30:32',59,'Curabitur aliquet risus facilisis dapibus varius.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (94,'2021-11-04 17:12:55',66,'Nam eu tellus fringilla, suscipit ante nec, tristique magna.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (59,'2021-11-19 07:19:12',65,'Nunc a enim ut quam egestas rhoncus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (42,'2021-11-01 15:47:48',4,'Nullam vestibulum massa id felis ullamcorper, et blandit lorem lacinia.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (12,'2021-11-28 21:41:20',1,'In fermentum lectus ut neque posuere, a consequat lacus euismod.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (68,'2021-11-21 21:46:31',55,'Praesent nec urna sed odio sagittis ultricies.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (122,'2021-11-20 07:52:54',92,'Proin elementum ex at tincidunt pretium.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (63,'2021-11-13 12:33:59',82,'Vivamus imperdiet lorem in mattis molestie.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-01 20:58:34',67,'Cras nec lorem dapibus lectus commodo bibendum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-26 09:39:10',42,'Sed interdum ex ac ipsum viverra ultricies.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (108,'2021-11-07 06:30:40',63,'Quisque nec quam sed enim aliquam ultrices id eget enim.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (67,'2021-11-27 12:35:00',13,'Maecenas fringilla nibh pellentesque, pulvinar neque a, semper dolor.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (116,'2021-11-28 08:16:57',24,'Curabitur quis leo ut ante suscipit pulvinar sit amet eu lorem.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (45,'2021-12-11 20:48:46',80,'Etiam eu metus convallis, auctor justo ac, fringilla diam.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-11-08 18:46:05',66,'Aenean sagittis augue ut metus tincidunt efficitur.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-11-06 11:12:03',84,'Morbi in nunc tempor, consequat tellus vel, laoreet orci.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (66,'2021-11-17 16:22:05',64,'Etiam vel mauris vitae quam congue rutrum.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (5,'2021-11-05 10:59:31',86,'Nullam at tellus vel sapien lobortis consequat.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (122,'2021-11-14 13:57:39',32,'Sed tempus felis et efficitur consectetur.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (122,'2021-11-26 16:20:56',88,'Fusce interdum lectus at nisi hendrerit, sed posuere felis porttitor.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (24,'2021-11-28 16:59:23',2,'Donec porttitor velit eu tempus porta.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (40,'2021-11-24 19:26:41',68,'Nam varius massa molestie nibh gravida, sit amet pretium lorem iaculis.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (9,'2021-12-06 07:21:56',51,'Fusce eget sapien dignissim, convallis justo in, fringilla metus.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (74,'2021-11-08 09:34:08',35,'Donec sed nisl volutpat, placerat dolor eu, eleifend tortor.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-11-10 16:10:34',27,'Curabitur volutpat orci et consequat blandit.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (91,'2021-11-01 16:06:23',19,'Nam consectetur velit in faucibus commodo.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (52,'2021-11-13 06:41:54',63,'Praesent vitae velit elementum, eleifend magna at, facilisis quam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (77,'2021-11-17 18:19:00',74,'Nunc sit amet elit ac ipsum tempus sagittis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (122,'2021-11-16 17:14:47',90,'Donec sed sapien eget arcu malesuada cursus quis vitae risus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (22,'2021-11-18 13:43:49',52,'Nulla vitae lorem at erat ultricies condimentum vitae nec nisi.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (32,'2021-11-29 19:53:11',77,'Nam commodo justo sit amet nibh dapibus cursus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (89,'2021-11-13 17:48:29',71,'Nulla molestie arcu non malesuada sollicitudin.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (127,'2021-12-03 17:10:02',42,'Ut eget nibh facilisis, placerat sapien sit amet, tincidunt lacus.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (81,'2021-12-08 17:16:13',55,'Proin in sapien vitae lacus finibus sodales vitae nec justo.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (65,'2021-11-04 06:09:30',6,'Suspendisse et justo nec neque commodo ultricies.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-11-15 21:44:38',69,'Quisque suscipit sem quis metus fringilla egestas.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (72,'2021-11-17 13:25:32',29,'Vivamus in nulla luctus lectus vulputate dictum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (56,'2021-11-14 07:27:42',14,'Mauris imperdiet mi in dignissim feugiat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (73,'2021-12-09 16:43:41',59,'Donec id est pharetra, dignissim orci et, facilisis odio.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (45,'2021-11-19 13:06:49',48,'Sed cursus felis eu volutpat venenatis.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (6,'2021-12-06 19:07:58',82,'Vivamus non lectus vulputate, accumsan risus id, porttitor purus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (29,'2021-12-08 17:02:24',40,'Fusce placerat felis fermentum justo vulputate maximus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (58,'2021-11-20 15:06:20',45,'Donec venenatis lorem a mi eleifend, quis hendrerit enim dignissim.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (84,'2021-11-14 21:58:11',39,'Quisque porttitor tortor ac odio molestie ornare.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (84,'2021-12-08 09:04:19',44,'Pellentesque mattis nunc ac sapien dignissim, id convallis erat gravida.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (61,'2021-11-16 10:17:28',75,'Sed euismod nisl quis maximus sagittis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (69,'2021-11-15 10:44:24',68,'Quisque ultricies orci vitae nulla gravida semper.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (115,'2021-11-17 10:21:39',58,'Ut in elit non massa aliquam scelerisque at ut quam.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (48,'2021-11-13 06:27:56',39,'Quisque et mi suscipit, ultricies risus ut, ultrices tortor.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (56,'2021-11-07 15:14:24',49,'Integer elementum leo a mattis malesuada.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (117,'2021-11-06 15:52:25',27,'Vestibulum eget arcu ac augue tincidunt consequat.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (40,'2021-11-11 14:19:58',80,'Nam gravida sem eu nisi pharetra hendrerit.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (69,'2021-11-07 19:12:09',12,'Mauris non metus nec elit posuere pellentesque et id ante.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (28,'2021-11-10 12:11:05',52,'Cras egestas mauris at mi egestas eleifend.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (61,'2021-11-29 06:30:58',49,'Nam in lorem sed neque ultricies sollicitudin efficitur id lectus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (46,'2021-11-24 14:55:41',62,'Mauris ac lacus id nunc pellentesque interdum ac at lacus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-11-21 20:58:25',79,'Aenean lacinia tortor id leo lacinia, eget luctus nulla porttitor.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (99,'2021-11-30 13:04:48',64,'Nulla ultrices quam et ex posuere ornare.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-11-07 18:00:00',33,'Donec venenatis purus et sapien laoreet, nec elementum mauris luctus.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (124,'2021-11-25 07:41:31',39,'Vestibulum posuere leo consectetur magna luctus congue.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (26,'2021-12-01 10:56:21',40,'Integer feugiat est vel metus sollicitudin, vel lobortis enim condimentum.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (79,'2021-11-25 12:17:25',36,'Phasellus id arcu in nunc volutpat sodales eget at velit.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (36,'2021-11-22 21:34:25',13,'In a nulla quis ante posuere dictum eu sed turpis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (47,'2021-11-27 08:04:08',62,'Duis a quam sed velit dapibus ornare.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (106,'2021-11-13 16:21:39',94,'Vivamus sed massa aliquet, auctor magna a, ullamcorper orci.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (55,'2021-11-09 08:08:44',65,'Praesent pulvinar lectus a quam tincidunt euismod.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (94,'2021-11-18 20:42:00',72,'Aliquam auctor leo ac sagittis sollicitudin.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (95,'2021-12-05 11:15:30',33,'Pellentesque in lorem at metus fermentum imperdiet nec non mi.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (49,'2021-11-30 10:10:34',21,'Nulla ac lacus ut eros euismod gravida a in orci.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-09 20:46:54',42,'Ut iaculis ligula molestie, fringilla erat id, vehicula lectus.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (27,'2021-11-28 14:02:50',87,'Proin gravida nibh sagittis purus imperdiet, sit amet aliquam lacus dignissim.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (96,'2021-11-28 07:34:36',30,'Proin quis lectus bibendum odio semper lacinia.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (108,'2021-11-18 11:03:59',3,'Curabitur ac est ut magna vestibulum elementum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (86,'2021-11-13 07:37:47',31,'Integer in felis et nunc ultricies pulvinar rutrum eget elit.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (110,'2021-11-18 10:25:24',4,'Sed ac neque lobortis, varius nisi id, eleifend orci.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (68,'2021-11-11 19:08:15',65,'Aliquam ut massa bibendum, viverra est et, aliquet ex.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (41,'2021-11-07 17:33:04',20,'Aliquam vehicula nulla eu quam semper tristique.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (29,'2021-11-17 15:39:01',61,'Integer mattis metus sit amet aliquam aliquet.',2);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (76,'2021-11-28 17:25:26',59,'Nam semper erat non augue aliquam, ut congue velit vehicula.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-11-06 21:20:53',79,'Donec bibendum tortor nec mauris ultricies efficitur.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (40,'2021-11-17 21:20:27',25,'Praesent id justo sed tortor blandit dapibus sit amet faucibus tellus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (101,'2021-11-08 13:19:29',10,'Quisque sit amet odio eu leo hendrerit dignissim.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (78,'2021-11-27 12:18:00',81,'Nullam hendrerit diam nec molestie ullamcorper.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (22,'2021-11-08 16:19:29',21,'Nam suscipit orci nec nunc feugiat, at euismod neque auctor.',5);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (57,'2021-11-19 12:39:01',81,'Cras id magna sit amet erat pharetra viverra vitae sed nisl.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (8,'2021-12-08 06:11:23',37,'Duis blandit ante rhoncus, accumsan justo ut, euismod lacus.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (57,'2021-11-29 07:54:12',25,'Sed vitae odio cursus, egestas nisi vitae, fermentum turpis.',3);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (38,'2021-12-09 16:57:48',11,'Vestibulum pharetra lorem ac gravida mattis.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (88,'2021-11-16 20:51:30',28,'Morbi scelerisque leo sit amet interdum interdum.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (89,'2021-11-28 12:26:30',82,'Nunc vel arcu sagittis, consectetur lorem nec, eleifend velit.',4);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (93,'2021-12-08 12:48:14',70,'Sed nec mauris tempus, vestibulum nisi quis, facilisis turpis.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (48,'2021-12-04 14:38:07',59,'Vestibulum consectetur enim ut eros venenatis malesuada.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (90,'2021-11-11 07:40:22',93,'Aliquam ut neque eu tortor pellentesque sollicitudin id ut eros.',1);
INSERT INTO DanhGia (ma_nt,ngay,ma_nd,danhgia,sosao) VALUES (112,'2021-11-14 10:00:20',30,'Nulla ullamcorper tortor ac risus vehicula, sed fringilla dui lacinia.',4);

INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (41,1,'/Content/ckfinder/userfiles/images/15.jpg','Suspendisse sollicitudin dui dictum, consequat lectus non, ullamcorper metus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (49,1,'/Content/ckfinder/userfiles/images/9.jpg','Maecenas et libero sed est vehicula tempus ac ut sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,1,'/Content/ckfinder/userfiles/images/7.jpg','Quisque rhoncus arcu id nisl lobortis lobortis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (84,1,'/Content/ckfinder/userfiles/images/15.jpg','Aliquam fringilla leo ut commodo porttitor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,1,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Suspendisse in ante sed nisl lacinia efficitur vel vel ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (67,1,'/Content/ckfinder/userfiles/images/10.jpg','Integer porta leo sed lorem suscipit, non elementum dolor vehicula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (92,1,'/Content/ckfinder/userfiles/images/10.jpg','Praesent sed mi et justo commodo consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (81,1,'/Content/ckfinder/userfiles/images/6.jpg','Integer at diam accumsan, feugiat est quis, auctor nisi.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (76,1,'/Content/ckfinder/userfiles/images/1.jpg','Vivamus posuere justo porttitor, auctor libero sed, scelerisque nisi.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (65,1,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Sed rutrum orci at tortor faucibus, quis ornare eros commodo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (89,1,'/Content/ckfinder/userfiles/images/12.jpg','Nulla ut nibh sodales, semper ex non, imperdiet purus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (61,1,'/Content/ckfinder/userfiles/images/15.jpg','Morbi eleifend augue a posuere interdum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,1,'/Content/ckfinder/userfiles/images/19.jpg','Nunc vestibulum arcu vitae augue molestie gravida.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (7,1,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Pellentesque convallis purus vel posuere scelerisque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (66,1,'/Content/ckfinder/userfiles/images/13.jpg','Ut finibus sapien vitae egestas blandit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (41,2,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Vestibulum hendrerit metus quis nunc accumsan, nec tincidunt augue aliquam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (52,1,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Nam sed lacus at nibh fringilla lacinia.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,1,'/Content/ckfinder/userfiles/images/15.jpg','Vivamus faucibus magna porta felis dapibus, id porta quam suscipit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (38,1,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Fusce placerat dui ac tellus gravida viverra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (66,2,'/Content/ckfinder/userfiles/images/6.jpg','Etiam non nisl a dolor pellentesque tempus eget in ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (50,1,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Aenean sit amet justo a massa molestie varius ut eget ex.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (29,1,'/Content/ckfinder/userfiles/images/angia/anh4.png','Donec tristique eros nec sollicitudin porttitor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (76,2,'/Content/ckfinder/userfiles/images/7.jpg','Morbi ullamcorper sem ut neque facilisis, at tincidunt quam imperdiet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,1,'/Content/ckfinder/userfiles/images/17.jpg','Vestibulum sed lorem eu sapien mattis lobortis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (62,1,'/Content/ckfinder/userfiles/images/2.jpg','Sed luctus mi eu justo interdum condimentum sit amet in quam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (59,1,'/Content/ckfinder/userfiles/images/14.jpg','Phasellus nec augue ultrices, scelerisque lectus eu, ultricies orci.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (67,2,'/Content/ckfinder/userfiles/images/15.jpg','Fusce convallis massa imperdiet mi aliquet viverra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (48,1,'/Content/ckfinder/userfiles/images/1.jpg','Vivamus ac orci at justo ultricies viverra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (85,1,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Proin vel enim a orci iaculis interdum non at metus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (38,2,'/Content/ckfinder/userfiles/images/1.jpg','Nulla auctor augue in lectus pharetra laoreet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,1,'/Content/ckfinder/userfiles/images/10.jpg','Pellentesque vehicula purus non auctor ultrices.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (86,1,'/Content/ckfinder/userfiles/images/10.jpg','Integer semper felis a neque venenatis finibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (50,2,'/Content/ckfinder/userfiles/images/4.jpg','Maecenas ornare erat eget ante sagittis, sed varius quam facilisis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (27,1,'/Content/ckfinder/userfiles/images/5.jpg','Praesent non ligula eu arcu sodales fermentum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (82,1,'/Content/ckfinder/userfiles/images/1.jpg','Sed maximus orci eu ex aliquet pretium.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (33,1,'/Content/ckfinder/userfiles/images/6.jpg','Proin tempus libero in massa gravida, id fermentum felis blandit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (93,1,'/Content/ckfinder/userfiles/images/19.jpg','Donec fermentum nunc in nibh ornare, id ornare massa vestibulum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (2,1,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Quisque auctor felis sed leo egestas, at efficitur diam efficitur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (56,1,'/Content/ckfinder/userfiles/images/2.jpg','Maecenas accumsan orci eget odio faucibus, vel dapibus nunc malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (64,1,'/Content/ckfinder/userfiles/images/18.jpg','Proin pretium nisi ultricies nisi tincidunt, ultricies efficitur dolor dapibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (57,1,'/Content/ckfinder/userfiles/images/10.jpg','Ut vitae odio nec dui lobortis commodo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (33,2,'/Content/ckfinder/userfiles/images/20.jpg','Nullam scelerisque mi in lorem gravida eleifend.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (71,1,'/Content/ckfinder/userfiles/images/18.jpg','Nunc non velit quis arcu cursus porttitor id id dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (83,1,'/Content/ckfinder/userfiles/images/17.jpg','Suspendisse ut felis vel urna bibendum auctor sit amet in diam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (26,1,'/Content/ckfinder/userfiles/images/12.jpg','Integer sed libero a ligula facilisis scelerisque et id dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (57,2,'/Content/ckfinder/userfiles/images/2.jpg','Cras non metus gravida, egestas ante cursus, sollicitudin nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (16,1,'/Content/ckfinder/userfiles/images/13.jpg','Nulla viverra leo consequat felis varius, ac mollis felis congue.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (10,1,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Nunc accumsan ipsum sed tortor pretium maximus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (78,1,'/Content/ckfinder/userfiles/images/2.jpg','Vivamus a libero pulvinar, tempor ipsum sit amet, placerat ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (93,2,'/Content/ckfinder/userfiles/images/17.jpg','Suspendisse scelerisque arcu vel massa scelerisque vehicula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (52,2,'/Content/ckfinder/userfiles/images/19.jpg','Quisque ac quam et enim aliquet suscipit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,2,'/Content/ckfinder/userfiles/images/10.jpg','Vivamus non diam eget ante tempor mollis eget condimentum augue.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (37,1,'/Content/ckfinder/userfiles/images/13.jpg','Curabitur et libero consectetur, egestas ex ut, egestas sapien.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,2,'/Content/ckfinder/userfiles/images/7.jpg','Mauris vitae eros vitae metus viverra volutpat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (34,1,'/Content/ckfinder/userfiles/images/3.jpg','Mauris id felis laoreet, vehicula sem quis, mattis quam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Duis hendrerit nisl viverra diam cursus, in vulputate ipsum fringilla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (16,2,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Curabitur convallis arcu eu varius maximus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (68,1,'/Content/ckfinder/userfiles/images/10.jpg','Cras sed metus auctor, sodales libero a, varius neque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (37,2,'/Content/ckfinder/userfiles/images/4.jpg','Phasellus vulputate lectus sit amet hendrerit pulvinar.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (77,1,'/Content/ckfinder/userfiles/images/19.jpg','Maecenas viverra lacus in tellus luctus, vel commodo eros bibendum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (74,1,'/Content/ckfinder/userfiles/images/16.jpg','Ut sit amet ipsum sit amet nisi varius elementum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (60,1,'/Content/ckfinder/userfiles/images/11.jpg','Suspendisse faucibus libero vel tortor laoreet, a rutrum odio iaculis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,1,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Sed dapibus tortor non ex aliquet tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (86,2,'/Content/ckfinder/userfiles/images/20.jpg','Maecenas faucibus mi non leo ullamcorper, eget dapibus ligula malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,1,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Fusce eget eros dapibus nibh porta congue vel vitae ligula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (5,1,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Mauris efficitur tortor eu lectus tincidunt facilisis a quis lacus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,1,'/Content/ckfinder/userfiles/images/15.jpg','Nulla rutrum arcu at pulvinar tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (29,2,'/Content/ckfinder/userfiles/images/9.jpg','Cras scelerisque sapien eget lacus tincidunt consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (19,1,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Integer id purus vel sapien tempus cursus eu luctus nisi.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,1,'/Content/ckfinder/userfiles/images/10.jpg','In dignissim arcu ac malesuada bibendum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,2,'/Content/ckfinder/userfiles/images/10.jpg','Etiam ut purus feugiat ligula laoreet auctor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (16,3,'/Content/ckfinder/userfiles/images/1.jpg','Cras et arcu at ante auctor rutrum eget nec leo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (86,3,'/Content/ckfinder/userfiles/images/3.jpg','Quisque et dolor dapibus, consequat ligula id, pretium urna.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (32,1,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Vivamus id felis quis turpis ullamcorper bibendum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,2,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Sed porta mauris a tristique auctor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (53,1,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Nunc porta dolor quis quam lobortis, a viverra mi eleifend.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (17,1,'/Content/ckfinder/userfiles/images/17.jpg','Sed pulvinar ipsum tincidunt diam lacinia sollicitudin.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (58,1,'/Content/ckfinder/userfiles/images/10.jpg','Phasellus semper velit ut pharetra tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (65,2,'/Content/ckfinder/userfiles/images/6.jpg','Pellentesque scelerisque est ut eros feugiat commodo vel ut metus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,2,'/Content/ckfinder/userfiles/images/15.jpg','Vivamus sed ligula sit amet lorem consequat dignissim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (93,3,'/Content/ckfinder/userfiles/images/angia/anh4.png','Fusce fringilla odio nec risus aliquam, in tempor nulla accumsan.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (88,1,'/Content/ckfinder/userfiles/images/18.jpg','Fusce ullamcorper velit et elit sollicitudin accumsan.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (6,1,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Aenean tincidunt elit sit amet dolor molestie maximus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (70,1,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Donec sed erat eleifend, lobortis mi consequat, fringilla ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (36,1,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Quisque id orci nec urna laoreet posuere auctor at massa.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (42,1,'/Content/ckfinder/userfiles/images/5.jpg','Duis ultrices dui nec consectetur elementum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (43,1,'/Content/ckfinder/userfiles/images/10.jpg','Etiam sed metus a eros rutrum commodo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (14,1,'/Content/ckfinder/userfiles/images/1.jpg','Vestibulum condimentum nisl eu ipsum ornare, eget pharetra magna tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (27,2,'/Content/ckfinder/userfiles/images/16.jpg','Nam at dui sed nisl elementum consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (29,3,'/Content/ckfinder/userfiles/images/8.jpg','Sed molestie lectus at mauris vulputate malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (48,2,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Fusce convallis diam non turpis egestas, ac sagittis turpis facilisis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (13,1,'/Content/ckfinder/userfiles/images/7.jpg','Curabitur sit amet ligula condimentum orci facilisis aliquet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,3,'/Content/ckfinder/userfiles/images/19.jpg','Maecenas nec augue id nisi vulputate hendrerit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (43,2,'/Content/ckfinder/userfiles/images/11.jpg','Morbi ornare leo eu elit auctor, sed cursus mi dictum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (40,1,'/Content/ckfinder/userfiles/images/14.jpg','Quisque in eros non tellus pharetra placerat sit amet a ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (34,2,'/Content/ckfinder/userfiles/images/2.jpg','Proin nec lorem ac ipsum iaculis ultricies eget nec massa.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (65,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Quisque eleifend orci sed enim pharetra, sit amet venenatis massa posuere.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (27,3,'/Content/ckfinder/userfiles/images/17.jpg','Cras dictum felis a lorem vulputate, in dapibus risus hendrerit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (85,2,'/Content/ckfinder/userfiles/images/8.jpg','Nunc pharetra urna porttitor, suscipit nunc vitae, mattis nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (24,1,'/Content/ckfinder/userfiles/images/16.jpg','Nulla ornare dui vel scelerisque volutpat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (3,1,'/Content/ckfinder/userfiles/images/12.jpg','Donec semper justo at dolor facilisis sollicitudin.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (16,4,'/Content/ckfinder/userfiles/images/7.jpg','Duis mattis ligula aliquam urna luctus mollis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (78,2,'/Content/ckfinder/userfiles/images/6.jpg','Sed eget mi ut massa auctor efficitur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,4,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Ut eu metus congue magna vulputate facilisis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (76,3,'/Content/ckfinder/userfiles/images/10.jpg','Proin non urna consectetur, malesuada dolor sed, dictum elit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (90,1,'/Content/ckfinder/userfiles/images/10.jpg','Nulla tincidunt est eget accumsan imperdiet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (61,2,'/Content/ckfinder/userfiles/images/8.jpg','Vestibulum ac est vitae enim venenatis bibendum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (15,1,'/Content/ckfinder/userfiles/images/4.jpg','Fusce eu velit tincidunt, dapibus urna vulputate, malesuada ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (51,1,'/Content/ckfinder/userfiles/images/2.jpg','Proin consequat ligula sed lorem finibus, et fringilla mauris mattis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (68,2,'/Content/ckfinder/userfiles/images/8.jpg','Duis id risus nec libero laoreet mollis ac eu dolor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (60,2,'/Content/ckfinder/userfiles/images/4.jpg','Sed consequat velit in risus eleifend, eget venenatis velit fermentum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,2,'/Content/ckfinder/userfiles/images/18.jpg','Sed rutrum lectus ac massa ultricies sodales.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (20,1,'/Content/ckfinder/userfiles/images/6.jpg','Donec lobortis ante auctor nulla convallis fringilla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (90,2,'/Content/ckfinder/userfiles/images/12.jpg','Cras eu risus a ante laoreet semper.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (32,2,'/Content/ckfinder/userfiles/images/11.jpg','Aenean efficitur lacus at pretium pulvinar.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (75,1,'/Content/ckfinder/userfiles/images/6.jpg','Ut at est molestie, aliquet lectus eu, malesuada nisi.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Sed id lacus cursus, placerat nisl quis, bibendum justo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,1,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Nullam vitae est eu ipsum consectetur posuere sit amet venenatis urna.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (69,1,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Aliquam vulputate nulla eget massa mattis, suscipit finibus neque ornare.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (61,3,'/Content/ckfinder/userfiles/images/11.jpg','Integer lobortis diam eu iaculis vehicula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (4,1,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Mauris posuere odio eu gravida sagittis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (18,1,'/Content/ckfinder/userfiles/images/17.jpg','In vel lectus tempor, ornare dui non, pretium turpis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (71,2,'/Content/ckfinder/userfiles/images/9.jpg','Pellentesque eget felis pulvinar, porttitor ligula vel, ornare libero.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (37,3,'/Content/ckfinder/userfiles/images/3.jpg','Sed vitae ligula efficitur nisi pretium finibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,1,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Curabitur in elit feugiat, tempus lorem nec, dignissim diam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (68,3,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Ut euismod tellus quis iaculis porttitor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (2,2,'/Content/ckfinder/userfiles/images/10.jpg','Pellentesque tempus metus quis eros rhoncus, sit amet facilisis dolor luctus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (71,3,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Integer luctus tellus et ligula sollicitudin, et convallis erat efficitur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (48,3,'/Content/ckfinder/userfiles/images/4.jpg','Sed at leo ac eros sagittis aliquet eu sed nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,3,'/Content/ckfinder/userfiles/images/7.jpg','Aliquam at sapien malesuada, malesuada nibh quis, imperdiet lacus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,1,'/Content/ckfinder/userfiles/images/2.jpg','Pellentesque ac erat eget mauris ullamcorper convallis vel sit amet nunc.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (56,2,'/Content/ckfinder/userfiles/images/8.jpg','Etiam sit amet tellus eu orci molestie mollis eget gravida lorem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (59,2,'/Content/ckfinder/userfiles/images/4.jpg','Aliquam quis orci et nisi faucibus imperdiet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (33,3,'/Content/ckfinder/userfiles/images/1.jpg','Nam dignissim diam et sapien sollicitudin, id ultricies ante malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (15,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Ut vestibulum velit quis sem posuere, sed tempor diam ornare.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,5,'/Content/ckfinder/userfiles/images/1.jpg','Phasellus dapibus augue quis lectus vehicula, vitae imperdiet quam eleifend.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (23,1,'/Content/ckfinder/userfiles/images/19.jpg','Quisque eu nisi a turpis placerat euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (77,2,'/Content/ckfinder/userfiles/images/1.jpg','Sed convallis ligula id mauris fermentum vehicula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (19,2,'/Content/ckfinder/userfiles/images/7.jpg','Mauris faucibus sem et gravida tempor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,1,'/Content/ckfinder/userfiles/images/8.jpg','In eget justo vel quam pretium pretium.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (75,2,'/Content/ckfinder/userfiles/images/3.jpg','Praesent a eros eget nunc pulvinar rutrum in eget justo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (15,3,'/Content/ckfinder/userfiles/images/5.jpg','Donec quis ex vitae nulla tincidunt viverra in eu quam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (27,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Mauris vitae velit posuere, vulputate ipsum nec, feugiat ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,2,'/Content/ckfinder/userfiles/images/2.jpg','Integer nec lorem tristique, lobortis mi vel, consectetur mi.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (81,2,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Fusce eu metus a ante efficitur iaculis eget sed ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,2,'/Content/ckfinder/userfiles/images/20.jpg','Proin euismod lacus nec laoreet facilisis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (68,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Sed luctus lacus in ornare sollicitudin.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,6,'/Content/ckfinder/userfiles/images/17.jpg','Quisque luctus leo vitae pretium lacinia.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (18,2,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Phasellus ultricies libero nec augue elementum vehicula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (87,1,'/Content/ckfinder/userfiles/images/6.jpg','Praesent accumsan quam vel ligula molestie, vel efficitur sem fermentum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,3,'/Content/ckfinder/userfiles/images/12.jpg','Pellentesque in odio a odio dapibus porttitor id id arcu.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (36,2,'/Content/ckfinder/userfiles/images/1.jpg','Curabitur ut arcu ut dui tristique aliquet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (41,3,'/Content/ckfinder/userfiles/images/3.jpg','Curabitur congue augue a libero laoreet fringilla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (84,2,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Nam ullamcorper felis sed leo pellentesque posuere.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,4,'/Content/ckfinder/userfiles/images/19.jpg','In eget arcu bibendum, rhoncus ipsum id, molestie ex.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,3,'/Content/ckfinder/userfiles/images/angia/anh4.png','Nullam eget nisi pretium, imperdiet magna sit amet, aliquam risus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (8,1,'/Content/ckfinder/userfiles/images/18.jpg','Proin quis odio vel arcu fermentum cursus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (17,2,'/Content/ckfinder/userfiles/images/angia/anh4.png','Donec euismod tellus sit amet dui porta, ac varius neque tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,4,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Nunc ut ipsum luctus, efficitur enim scelerisque, ultricies dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (65,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Duis tempus nisi in erat rhoncus, eget placerat nunc auctor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (84,3,'/Content/ckfinder/userfiles/images/12.jpg','Nam sit amet leo luctus erat placerat suscipit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (13,2,'/Content/ckfinder/userfiles/images/20.jpg','Pellentesque sed velit a dui mattis cursus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (45,1,'/Content/ckfinder/userfiles/images/18.jpg','Vivamus faucibus velit sed est lobortis commodo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,4,'/Content/ckfinder/userfiles/images/9.jpg','Aliquam faucibus augue eget metus aliquet, sed aliquam tellus condimentum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (6,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Integer euismod ipsum semper dolor dignissim, in ultricies enim finibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (85,3,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Nunc malesuada nibh vel eros pretium, ac efficitur ex varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','In viverra ante ut dolor maximus, non euismod nisi feugiat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (58,2,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Nulla ac turpis dignissim nisl laoreet vehicula non ultrices dolor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,7,'/Content/ckfinder/userfiles/images/15.jpg','Vestibulum quis purus in magna vulputate auctor eu id odio.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,5,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Sed sed risus sagittis, elementum arcu sed, elementum turpis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (42,2,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Suspendisse non nibh quis ante lobortis mollis nec ac sapien.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (86,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Ut id elit pellentesque, dictum mi quis, rhoncus felis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (10,2,'/Content/ckfinder/userfiles/images/17.jpg','Curabitur facilisis quam nec risus fringilla, et finibus enim luctus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (14,2,'/Content/ckfinder/userfiles/images/18.jpg','Ut tempor risus sit amet pellentesque ultrices.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (91,1,'/Content/ckfinder/userfiles/images/4.jpg','Praesent at ex eget diam ullamcorper porta a nec nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (15,4,'/Content/ckfinder/userfiles/images/13.jpg','Curabitur placerat tellus a lectus placerat placerat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (85,4,'/Content/ckfinder/userfiles/images/1.jpg','Ut pretium ex lacinia sem lobortis aliquet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (86,5,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Duis efficitur nisl rhoncus, semper lorem at, luctus felis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (70,2,'/Content/ckfinder/userfiles/images/15.jpg','Pellentesque pellentesque dolor vel leo lacinia, nec vehicula leo tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Morbi luctus massa non purus egestas facilisis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (31,1,'/Content/ckfinder/userfiles/images/9.jpg','Maecenas at felis non ipsum varius commodo sed quis ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (81,3,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','In eu ligula tincidunt, ultricies nulla ac, placerat nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (81,4,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Nullam sollicitudin mauris at justo tempor, at porttitor libero sodales.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (70,3,'/Content/ckfinder/userfiles/images/13.jpg','Suspendisse porttitor libero ut mauris venenatis dignissim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,2,'/Content/ckfinder/userfiles/images/17.jpg','Duis lacinia est a tellus sollicitudin, eu aliquet lectus pharetra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (57,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Mauris pharetra lorem et accumsan posuere.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (89,2,'/Content/ckfinder/userfiles/images/14.jpg','Nullam ac magna mollis neque porta feugiat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (24,2,'/Content/ckfinder/userfiles/images/16.jpg','Aliquam ut diam sed sem dapibus posuere eget vitae massa.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,3,'/Content/ckfinder/userfiles/images/1.jpg','Phasellus quis lectus eget turpis facilisis mattis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,6,'/Content/ckfinder/userfiles/images/13.jpg','Sed varius nunc ut erat maximus dapibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (84,4,'/Content/ckfinder/userfiles/images/11.jpg','Vivamus eget sapien et ipsum gravida iaculis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (3,2,'/Content/ckfinder/userfiles/images/20.jpg','Phasellus at mauris non nulla semper consequat vitae ac leo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (62,2,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Vestibulum sed metus sodales, vestibulum odio id, varius ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,5,'/Content/ckfinder/userfiles/images/9.jpg','Proin nec nisl et justo hendrerit elementum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (17,3,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Sed in diam id tortor semper efficitur et et libero.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (91,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Sed sodales lectus a tincidunt semper.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (37,4,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Vestibulum fringilla diam sit amet leo euismod accumsan.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (3,3,'/Content/ckfinder/userfiles/images/18.jpg','Nullam rhoncus justo a turpis ultrices, id vehicula mauris mattis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (71,4,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Cras vestibulum arcu vehicula orci interdum elementum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (45,2,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Duis cursus justo in lacus efficitur, non sodales neque tempor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (15,5,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Nunc nec magna ut sapien aliquam molestie.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (49,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Vestibulum sed nisi id justo sodales rutrum nec nec odio.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (23,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Cras a sem a turpis iaculis mattis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (34,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Aenean laoreet massa eget felis ultricies vehicula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,5,'/Content/ckfinder/userfiles/images/14.jpg','Fusce non turpis at lorem fringilla ultricies sed et velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (5,2,'/Content/ckfinder/userfiles/images/10.jpg','Aliquam placerat magna id sodales feugiat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,2,'/Content/ckfinder/userfiles/images/angia/anh4.png','Nunc non ex a ligula ultricies scelerisque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (63,1,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Ut feugiat enim vitae facilisis congue.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,2,'/Content/ckfinder/userfiles/images/8.jpg','Praesent porttitor metus egestas, finibus purus auctor, elementum dolor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (85,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Aenean tempus nibh et tempus luctus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (63,2,'/Content/ckfinder/userfiles/images/19.jpg','Duis luctus magna viverra orci gravida, sed rutrum urna dignissim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (60,3,'/Content/ckfinder/userfiles/images/13.jpg','Duis sit amet nibh efficitur, tincidunt augue sit amet, sodales tellus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (59,3,'/Content/ckfinder/userfiles/images/20.jpg','Nulla bibendum nunc a dui pulvinar ultricies.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,3,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Nullam vestibulum metus ut hendrerit consectetur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,2,'/Content/ckfinder/userfiles/images/11.jpg','Vestibulum vitae dolor id est tempor aliquet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (85,6,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Curabitur et diam molestie, aliquam neque vehicula, feugiat purus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (31,2,'/Content/ckfinder/userfiles/images/6.jpg','Sed ultricies diam iaculis finibus vehicula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (73,1,'/Content/ckfinder/userfiles/images/11.jpg','Nullam rhoncus velit at dui iaculis, at auctor ligula euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (64,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Nulla ac eros efficitur, commodo purus lacinia, viverra felis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (62,3,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Vivamus quis tortor id eros ultricies lacinia.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (61,4,'/Content/ckfinder/userfiles/images/1.jpg','In quis augue sollicitudin, vestibulum ante sit amet, tristique purus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,8,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Quisque eget arcu id sapien tincidunt malesuada a vitae lacus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,3,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','In elementum mauris quis hendrerit fringilla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (15,6,'/Content/ckfinder/userfiles/images/7.jpg','Vivamus rhoncus urna vehicula, sollicitudin dui et, interdum lacus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,3,'/Content/ckfinder/userfiles/images/8.jpg','Vestibulum vitae nunc pellentesque, commodo tortor in, volutpat risus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (56,3,'/Content/ckfinder/userfiles/images/angia/anh4.png','Aenean mattis libero ac eros fermentum, a ornare turpis tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (6,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Sed quis tortor vitae enim vulputate gravida.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (36,3,'/Content/ckfinder/userfiles/images/14.jpg','Proin non erat nec nunc consequat ullamcorper vel in nibh.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (45,3,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Cras id eros sed nibh ultrices cursus varius in massa.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (66,3,'/Content/ckfinder/userfiles/images/11.jpg','Nullam ac justo sodales, blandit tellus sed, hendrerit nibh.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (58,3,'/Content/ckfinder/userfiles/images/15.jpg','Aliquam quis diam tincidunt, hendrerit nibh id, tempor urna.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,3,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Etiam vitae turpis non lectus porta pharetra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (87,2,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Quisque eu ex venenatis, consectetur urna sit amet, dapibus justo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (74,2,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Cras elementum tellus ut enim pretium placerat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (86,6,'/Content/ckfinder/userfiles/images/9.jpg','Pellentesque vitae leo tempus, fermentum augue eget, egestas nibh.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,5,'/Content/ckfinder/userfiles/images/20.jpg','Nunc hendrerit mauris at hendrerit semper.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (83,2,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Nullam non tortor a odio elementum posuere.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,4,'/Content/ckfinder/userfiles/images/1.jpg','Mauris interdum nunc quis sollicitudin rhoncus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,2,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Curabitur convallis est sit amet neque sodales, sit amet volutpat enim lacinia.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (78,3,'/Content/ckfinder/userfiles/images/1.jpg','Duis at libero cursus, luctus metus id, consequat nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (10,3,'/Content/ckfinder/userfiles/images/13.jpg','Sed id tellus iaculis, consequat erat quis, fermentum elit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,3,'/Content/ckfinder/userfiles/images/15.jpg','Aenean interdum eros id nisi finibus, in volutpat sem mattis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (13,3,'/Content/ckfinder/userfiles/images/13.jpg','Curabitur a quam quis risus porta pretium at a massa.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (64,3,'/Content/ckfinder/userfiles/images/15.jpg','Ut nec nulla non quam convallis pulvinar ut sollicitudin nisl.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (36,4,'/Content/ckfinder/userfiles/images/9.jpg','Aliquam euismod eros et malesuada faucibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,4,'/Content/ckfinder/userfiles/images/4.jpg','Ut quis nulla tincidunt, dignissim nisl quis, aliquet dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,6,'/Content/ckfinder/userfiles/images/8.jpg','Nam efficitur lectus vel dolor aliquet, finibus accumsan mauris tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Mauris vitae risus hendrerit, feugiat enim a, dictum dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,4,'/Content/ckfinder/userfiles/images/4.jpg','Maecenas ut ante in orci dapibus euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (32,3,'/Content/ckfinder/userfiles/images/15.jpg','Aliquam tincidunt massa et semper tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,1,'/Content/ckfinder/userfiles/images/6.jpg','Donec ut quam nec dolor blandit malesuada non id augue.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (88,2,'/Content/ckfinder/userfiles/images/4.jpg','Nullam sit amet mauris scelerisque, pretium velit sed, imperdiet massa.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (16,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Aliquam et metus sed urna gravida ultrices.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (47,1,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Curabitur eget leo fermentum, porttitor est ut, viverra diam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,5,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Sed luctus felis vitae urna consectetur, sit amet efficitur odio accumsan.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (17,4,'/Content/ckfinder/userfiles/images/5.jpg','Quisque quis dui vel libero pretium convallis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (16,6,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Sed ac dolor in massa vestibulum congue maximus quis arcu.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (79,1,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Donec sed odio a justo mattis sodales a non diam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (10,4,'/Content/ckfinder/userfiles/images/11.jpg','Aenean viverra risus lobortis diam hendrerit, nec maximus quam mattis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,4,'/Content/ckfinder/userfiles/images/1.jpg','Aliquam vel ante quis tellus condimentum consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (21,1,'/Content/ckfinder/userfiles/images/5.jpg','Nullam nec neque vel tortor fermentum molestie.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (51,2,'/Content/ckfinder/userfiles/images/5.jpg','Suspendisse bibendum augue varius, posuere nibh vel, egestas ligula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,2,'/Content/ckfinder/userfiles/images/13.jpg','Duis euismod quam a massa aliquet, et dictum leo dictum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (45,4,'/Content/ckfinder/userfiles/images/20.jpg','Phasellus dignissim felis eu magna semper vestibulum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (52,3,'/Content/ckfinder/userfiles/images/5.jpg','Nunc pulvinar neque dignissim urna rutrum ultricies.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (26,2,'/Content/ckfinder/userfiles/images/18.jpg','Pellentesque sit amet massa molestie libero pulvinar luctus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,3,'/Content/ckfinder/userfiles/images/3.jpg','Pellentesque dignissim leo ultricies, lobortis arcu rhoncus, pulvinar felis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (43,3,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','In volutpat elit at pulvinar faucibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,5,'/Content/ckfinder/userfiles/images/18.jpg','Pellentesque in tortor sit amet diam tempus egestas.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (18,3,'/Content/ckfinder/userfiles/images/1.jpg','Nunc pretium elit ut tincidunt rhoncus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (92,2,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','In vehicula dui sed mi mattis, non aliquam turpis varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,4,'/Content/ckfinder/userfiles/images/8.jpg','Etiam eleifend justo vel mi rutrum efficitur quis non lacus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (75,3,'/Content/ckfinder/userfiles/images/11.jpg','In vel sapien sed odio efficitur convallis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (48,4,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Sed eleifend ligula in augue interdum consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,6,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Maecenas sed sem vitae sem imperdiet viverra sed ullamcorper sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (6,4,'/Content/ckfinder/userfiles/images/9.jpg','Quisque vel velit faucibus, interdum justo a, fermentum ligula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (64,4,'/Content/ckfinder/userfiles/images/2.jpg','Nulla finibus elit id efficitur mollis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (33,4,'/Content/ckfinder/userfiles/images/10.jpg','Suspendisse luctus mauris posuere ante condimentum luctus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (18,4,'/Content/ckfinder/userfiles/images/13.jpg','Etiam vitae lectus id enim ultricies porttitor ut sit amet ex.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,3,'/Content/ckfinder/userfiles/images/9.jpg','Sed ornare ipsum nec nibh pulvinar, posuere mollis ligula molestie.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (91,3,'/Content/ckfinder/userfiles/images/18.jpg','Mauris tincidunt massa eget vestibulum efficitur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (10,5,'/Content/ckfinder/userfiles/images/2.jpg','Cras ac elit id leo posuere varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,7,'/Content/ckfinder/userfiles/images/1.jpg','Nulla et orci ornare, ultricies turpis non, consectetur neque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,3,'/Content/ckfinder/userfiles/images/6.jpg','Nulla at turpis vitae risus condimentum varius vitae ac nunc.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (49,3,'/Content/ckfinder/userfiles/images/6.jpg','Vestibulum non elit vulputate, scelerisque risus id, ultrices eros.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,5,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Aenean malesuada nisi eu velit semper, a interdum sem auctor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,4,'/Content/ckfinder/userfiles/images/6.jpg','Sed at tortor in sem lobortis accumsan.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (52,4,'/Content/ckfinder/userfiles/images/12.jpg','Nullam a magna sit amet magna sollicitudin porta.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (67,3,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Sed ac nisl vel mauris fringilla ultrices.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,4,'/Content/ckfinder/userfiles/images/angia/anh4.png','Aliquam sed urna vitae ipsum molestie lacinia et vitae velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (20,2,'/Content/ckfinder/userfiles/images/12.jpg','Praesent pharetra risus sit amet nibh aliquet, eget tincidunt tellus vulputate.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (3,4,'/Content/ckfinder/userfiles/images/11.jpg','Phasellus quis mauris quis magna laoreet facilisis vel id tellus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (89,3,'/Content/ckfinder/userfiles/images/3.jpg','Integer in arcu laoreet, maximus ante eget, iaculis leo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (56,4,'/Content/ckfinder/userfiles/images/14.jpg','In id lorem tincidunt, sollicitudin metus faucibus, varius nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (82,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Nullam varius orci a est bibendum, maximus cursus mi gravida.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (41,4,'/Content/ckfinder/userfiles/images/17.jpg','Phasellus vestibulum elit hendrerit est gravida, sit amet iaculis lectus laoreet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,4,'/Content/ckfinder/userfiles/images/8.jpg','Etiam nec quam at augue facilisis ornare.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (41,5,'/Content/ckfinder/userfiles/images/4.jpg','Fusce pharetra lorem sit amet orci posuere, vel convallis lorem tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,5,'/Content/ckfinder/userfiles/images/16.jpg','Etiam vitae magna ut mauris dignissim suscipit et a mi.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (91,4,'/Content/ckfinder/userfiles/images/11.jpg','Proin et nisl id arcu consectetur rhoncus rutrum ac ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (75,4,'/Content/ckfinder/userfiles/images/8.jpg','Mauris sollicitudin neque eu dictum laoreet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,5,'/Content/ckfinder/userfiles/images/2.jpg','Pellentesque in tortor porta, dapibus massa et, feugiat ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,4,'/Content/ckfinder/userfiles/images/3.jpg','Phasellus pulvinar justo at enim auctor, quis feugiat turpis ultrices.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,6,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Aenean in orci vel risus finibus semper.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,6,'/Content/ckfinder/userfiles/images/5.jpg','In facilisis ex ac lobortis dignissim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,5,'/Content/ckfinder/userfiles/images/9.jpg','Aliquam consequat sapien ut libero imperdiet, nec iaculis sem dapibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (79,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Aenean ac dolor ac metus condimentum ullamcorper sit amet id libero.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (51,3,'/Content/ckfinder/userfiles/images/4.jpg','Nullam varius lacus at augue laoreet rutrum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (57,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Nullam luctus nisl id magna pretium interdum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (77,3,'/Content/ckfinder/userfiles/images/12.jpg','Integer in odio semper, gravida urna nec, tincidunt mauris.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (69,2,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Nulla semper magna in nisi tincidunt placerat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (63,3,'/Content/ckfinder/userfiles/images/3.jpg','Praesent condimentum felis egestas, molestie ipsum id, dapibus mauris.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (90,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Vestibulum efficitur metus id mattis lacinia.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,7,'/Content/ckfinder/userfiles/images/14.jpg','Aenean id odio condimentum, facilisis turpis et, dapibus dolor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (90,4,'/Content/ckfinder/userfiles/images/1.jpg','Sed sagittis odio id sem feugiat sollicitudin.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (64,5,'/Content/ckfinder/userfiles/images/angia/anh4.png','Nullam elementum neque in turpis ullamcorper, eu condimentum diam gravida.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (51,4,'/Content/ckfinder/userfiles/images/4.jpg','Donec et nunc porttitor, dictum sem vitae, porttitor ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (70,4,'/Content/ckfinder/userfiles/images/17.jpg','In dictum lorem ut sapien rutrum lobortis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (62,4,'/Content/ckfinder/userfiles/images/15.jpg','Cras id mauris vel velit mollis imperdiet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (87,3,'/Content/ckfinder/userfiles/images/8.jpg','Cras gravida velit eget ex porttitor viverra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (58,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Nullam ut velit vitae elit facilisis tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (84,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Etiam eget magna tincidunt mi tincidunt commodo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (6,5,'/Content/ckfinder/userfiles/images/5.jpg','Nunc facilisis libero commodo scelerisque tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (3,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','In quis nulla volutpat, fringilla nibh et, malesuada felis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (37,5,'/Content/ckfinder/userfiles/images/13.jpg','Praesent suscipit ante lacinia diam feugiat blandit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (15,7,'/Content/ckfinder/userfiles/images/10.jpg','Nunc eu urna eget justo tincidunt rhoncus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (69,3,'/Content/ckfinder/userfiles/images/5.jpg','Curabitur ut nisl posuere, ultricies leo tempor, aliquet dolor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (6,6,'/Content/ckfinder/userfiles/images/2.jpg','Duis ut libero non velit mattis sagittis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (15,8,'/Content/ckfinder/userfiles/images/7.jpg','Nam laoreet nunc et ante lobortis mattis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,7,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Aliquam ut augue lobortis, vehicula urna sit amet, sagittis mauris.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (61,5,'/Content/ckfinder/userfiles/images/14.jpg','Ut porttitor justo non magna aliquet, a pulvinar mi scelerisque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (70,5,'/Content/ckfinder/userfiles/images/4.jpg','Proin accumsan justo nec tellus convallis viverra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (45,5,'/Content/ckfinder/userfiles/images/17.jpg','Vestibulum vestibulum erat feugiat euismod efficitur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (31,3,'/Content/ckfinder/userfiles/images/4.jpg','Nam laoreet justo rhoncus augue interdum sodales.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (64,6,'/Content/ckfinder/userfiles/images/9.jpg','Sed sit amet leo vel risus porta commodo ut nec sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (27,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Sed nec diam hendrerit, vestibulum massa eget, tincidunt mauris.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (78,4,'/Content/ckfinder/userfiles/images/13.jpg','Maecenas varius tellus ac dolor interdum vestibulum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (8,2,'/Content/ckfinder/userfiles/images/angia/anh4.png','Donec in odio dignissim, eleifend nibh in, varius felis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,6,'/Content/ckfinder/userfiles/images/20.jpg','Mauris ullamcorper risus nec pulvinar vestibulum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,9,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Quisque in tellus et dolor tincidunt hendrerit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,6,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Aliquam eleifend purus congue lectus feugiat, eu convallis neque ultricies.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (62,5,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Vivamus bibendum urna vel velit elementum, in semper tellus vestibulum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (39,1,'/Content/ckfinder/userfiles/images/20.jpg','Nam at dolor in ex euismod luctus at et mi.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,6,'/Content/ckfinder/userfiles/images/2.jpg','Suspendisse ut ex semper, laoreet velit et, consectetur ex.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (61,6,'/Content/ckfinder/userfiles/images/14.jpg','Ut quis mi ut leo vestibulum finibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (76,4,'/Content/ckfinder/userfiles/images/12.jpg','Nunc faucibus lectus at quam dictum, quis gravida nisi sagittis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (84,6,'/Content/ckfinder/userfiles/images/1.jpg','Cras accumsan erat at leo tempus pellentesque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,6,'/Content/ckfinder/userfiles/images/angia/anh4.png','Phasellus tempor turpis eget ipsum accumsan ultricies.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (58,5,'/Content/ckfinder/userfiles/images/19.jpg','Donec at turpis sit amet orci aliquam ullamcorper facilisis quis ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,7,'/Content/ckfinder/userfiles/images/1.jpg','Donec sit amet sem eu enim porttitor euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (29,4,'/Content/ckfinder/userfiles/images/10.jpg','Sed ut tortor non eros mattis pulvinar.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (66,4,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','In quis ante ut lorem porta faucibus ac ac mauris.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (87,4,'/Content/ckfinder/userfiles/images/3.jpg','Aliquam rhoncus sapien sit amet porttitor consectetur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,5,'/Content/ckfinder/userfiles/images/5.jpg','Duis ut nulla quis quam luctus mollis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (69,4,'/Content/ckfinder/userfiles/images/12.jpg','Aliquam auctor nibh vel maximus aliquam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (21,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Nulla eget massa imperdiet mauris ultricies pretium eu condimentum tortor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (69,5,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Sed feugiat orci vestibulum lorem mollis, id fringilla velit dignissim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (57,5,'/Content/ckfinder/userfiles/images/14.jpg','Nulla pulvinar ligula at porttitor hendrerit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,5,'/Content/ckfinder/userfiles/images/3.jpg','Ut dapibus turpis sit amet lacus imperdiet, eu lacinia augue lobortis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,7,'/Content/ckfinder/userfiles/images/20.jpg','Sed porta nisl eget commodo pharetra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (88,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','In commodo ante in egestas porttitor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (84,7,'/Content/ckfinder/userfiles/images/18.jpg','Duis sed ante quis mi rutrum semper suscipit nec risus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (19,3,'/Content/ckfinder/userfiles/images/18.jpg','Phasellus sagittis neque et tortor ultricies mollis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (13,4,'/Content/ckfinder/userfiles/images/19.jpg','Integer sed justo sit amet erat tempor feugiat lacinia eu lorem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (91,5,'/Content/ckfinder/userfiles/images/4.jpg','Integer finibus massa vel mauris venenatis euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (68,5,'/Content/ckfinder/userfiles/images/19.jpg','Proin a felis venenatis tellus interdum tristique.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (24,3,'/Content/ckfinder/userfiles/images/8.jpg','Maecenas consequat libero sed dapibus pharetra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (48,5,'/Content/ckfinder/userfiles/images/20.jpg','Phasellus dapibus urna sit amet massa condimentum molestie vitae quis velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (20,3,'/Content/ckfinder/userfiles/images/3.jpg','In malesuada erat non nisl volutpat, ut tincidunt tortor interdum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,8,'/Content/ckfinder/userfiles/images/7.jpg','Curabitur sed est in justo convallis auctor eu sed nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (50,3,'/Content/ckfinder/userfiles/images/7.jpg','Phasellus sit amet dui eget nibh convallis condimentum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,7,'/Content/ckfinder/userfiles/images/3.jpg','Praesent viverra mi eu finibus suscipit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (93,4,'/Content/ckfinder/userfiles/images/9.jpg','Quisque vitae magna non orci fermentum luctus ultrices id ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (77,4,'/Content/ckfinder/userfiles/images/18.jpg','Maecenas sit amet enim a diam facilisis sollicitudin.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (23,3,'/Content/ckfinder/userfiles/images/8.jpg','Proin porta lorem sed commodo ullamcorper.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (26,3,'/Content/ckfinder/userfiles/images/angia/anh4.png','Fusce laoreet turpis ac dictum feugiat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (71,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Donec pretium elit sed justo imperdiet dapibus et vitae dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (7,2,'/Content/ckfinder/userfiles/images/8.jpg','Vestibulum eget felis efficitur, commodo nisl convallis, blandit libero.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,8,'/Content/ckfinder/userfiles/images/16.jpg','Aliquam in quam vel mi posuere posuere.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,9,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Proin at ipsum venenatis, convallis ante at, placerat lorem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (13,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','In finibus lacus eu elementum auctor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,7,'/Content/ckfinder/userfiles/images/9.jpg','In in ante posuere, porta turpis quis, fringilla felis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (42,3,'/Content/ckfinder/userfiles/images/18.jpg','Nunc consectetur ipsum in nisi ultricies, nec imperdiet tellus placerat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,6,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Donec finibus turpis eu nunc sagittis, vitae elementum risus ultricies.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (85,7,'/Content/ckfinder/userfiles/images/19.jpg','Pellentesque dignissim eros ac urna maximus porta.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (4,2,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Praesent ut nibh sed diam pellentesque lobortis quis non libero.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (81,5,'/Content/ckfinder/userfiles/images/2.jpg','Fusce a augue laoreet, commodo quam sed, porta dolor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (49,4,'/Content/ckfinder/userfiles/images/2.jpg','Fusce hendrerit sem sit amet nulla maximus cursus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (18,5,'/Content/ckfinder/userfiles/images/17.jpg','Nunc sit amet magna id enim tincidunt luctus eget ac quam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,6,'/Content/ckfinder/userfiles/images/10.jpg','Sed sed diam vitae sapien ullamcorper tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (35,1,'/Content/ckfinder/userfiles/images/14.jpg','Donec interdum ligula at neque efficitur sagittis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,9,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Nulla tristique purus eget magna hendrerit, a venenatis purus sodales.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (49,5,'/Content/ckfinder/userfiles/images/20.jpg','Proin molestie ligula nec tortor consequat iaculis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,8,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Ut rhoncus diam eu maximus consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (32,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Praesent tempor neque nec malesuada tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,9,'/Content/ckfinder/userfiles/images/15.jpg','Aliquam et ex id lorem sollicitudin fringilla at quis nisi.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (50,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Maecenas ac nulla quis felis molestie blandit ut ac felis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,8,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Donec venenatis leo a volutpat interdum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,10,'/Content/ckfinder/userfiles/images/10.jpg','Donec posuere magna et sollicitudin consectetur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,8,'/Content/ckfinder/userfiles/images/14.jpg','Sed tristique arcu sit amet justo pretium, vel accumsan mi consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (21,3,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Nam vel augue non tellus rutrum tempor eu in velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (60,4,'/Content/ckfinder/userfiles/images/9.jpg','Nulla tempus dui sit amet hendrerit malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,8,'/Content/ckfinder/userfiles/images/6.jpg','Nullam vel purus non ligula lobortis tristique ac nec dolor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (31,4,'/Content/ckfinder/userfiles/images/angia/anh4.png','Sed vel mi in augue iaculis interdum at sit amet ante.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (90,5,'/Content/ckfinder/userfiles/images/20.jpg','Morbi euismod neque et lectus luctus efficitur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,7,'/Content/ckfinder/userfiles/images/9.jpg','Integer congue turpis a odio rhoncus elementum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,11,'/Content/ckfinder/userfiles/images/9.jpg','Integer posuere turpis quis ultricies ultricies.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (31,5,'/Content/ckfinder/userfiles/images/8.jpg','Maecenas semper sem eget odio mollis, eu vehicula tellus varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,4,'/Content/ckfinder/userfiles/images/12.jpg','Donec ac turpis volutpat, pulvinar diam non, placerat quam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (77,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Aenean efficitur diam sit amet ligula aliquet, ac rutrum tellus lacinia.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (67,4,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Phasellus volutpat nisi et tempor tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (52,5,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Vestibulum et massa sed nisl mattis vestibulum eget non metus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,5,'/Content/ckfinder/userfiles/images/3.jpg','Pellentesque nec leo a lorem eleifend semper eu sit amet tellus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (42,4,'/Content/ckfinder/userfiles/images/15.jpg','Proin fringilla tortor et tincidunt varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (75,5,'/Content/ckfinder/userfiles/images/2.jpg','Sed vitae lectus at erat efficitur molestie.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,6,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Phasellus in ipsum eget eros consequat ornare pellentesque quis risus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (69,6,'/Content/ckfinder/userfiles/images/3.jpg','Morbi eget lectus sed velit porttitor bibendum a eu nisl.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,10,'/Content/ckfinder/userfiles/images/5.jpg','Praesent vitae massa id ligula iaculis porttitor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (45,6,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Proin mattis massa et lectus aliquam, eget ullamcorper felis pretium.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (41,6,'/Content/ckfinder/userfiles/images/12.jpg','Etiam eget neque at dolor sollicitudin ornare.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (79,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Phasellus sodales nibh ac tempus tristique.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (88,4,'/Content/ckfinder/userfiles/images/4.jpg','Cras in augue at odio scelerisque mattis vel a est.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (63,4,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Duis pulvinar lacus vel nibh tincidunt, ut facilisis ligula iaculis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,6,'/Content/ckfinder/userfiles/images/2.jpg','Nullam convallis felis sed metus ullamcorper, nec aliquet ligula hendrerit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (90,6,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Curabitur et metus ornare, tempus turpis aliquam, fermentum turpis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (34,4,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Fusce eu sapien sed felis euismod semper id et sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (34,5,'/Content/ckfinder/userfiles/images/16.jpg','Vivamus vitae felis varius, vehicula arcu ut, volutpat quam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (58,6,'/Content/ckfinder/userfiles/images/15.jpg','Proin eu velit vitae neque ullamcorper viverra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (24,4,'/Content/ckfinder/userfiles/images/20.jpg','Duis non erat eget ligula ultricies porttitor vel sit amet magna.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (46,12,'/Content/ckfinder/userfiles/images/2.jpg','Aenean placerat tellus vitae sagittis placerat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,7,'/Content/ckfinder/userfiles/images/1.jpg','Vivamus vehicula lectus a neque fringilla tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (52,6,'/Content/ckfinder/userfiles/images/8.jpg','Integer tincidunt mauris in placerat efficitur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (4,3,'/Content/ckfinder/userfiles/images/2.jpg','Praesent vestibulum nulla vel commodo malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,7,'/Content/ckfinder/userfiles/images/12.jpg','Proin quis ex iaculis ligula commodo malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,7,'/Content/ckfinder/userfiles/images/angia/anh4.png','Phasellus sed lectus a est molestie tempor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (14,3,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Maecenas tincidunt dui quis aliquet dapibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (33,5,'/Content/ckfinder/userfiles/images/4.jpg','Curabitur aliquet urna sed neque sagittis, vitae sollicitudin urna iaculis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (31,6,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Etiam auctor massa nec mauris mollis euismod quis vel neque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,6,'/Content/ckfinder/userfiles/images/12.jpg','Aenean ultrices quam vitae orci tristique laoreet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,10,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Proin consectetur erat et tempor iaculis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (26,4,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Aliquam sed justo in elit aliquam vehicula at ut erat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (91,6,'/Content/ckfinder/userfiles/images/1.jpg','Aenean lacinia elit vestibulum vulputate scelerisque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,7,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Curabitur id turpis at orci dictum pretium.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,8,'/Content/ckfinder/userfiles/images/8.jpg','Proin varius ex accumsan enim ornare gravida.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (88,5,'/Content/ckfinder/userfiles/images/5.jpg','Sed mattis dui sit amet tristique ornare.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (85,8,'/Content/ckfinder/userfiles/images/16.jpg','Praesent sodales nibh in eros sagittis dictum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (20,4,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Nunc a augue accumsan, hendrerit elit a, imperdiet enim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,7,'/Content/ckfinder/userfiles/images/18.jpg','Sed in nulla aliquam, vehicula eros sed, tincidunt nisl.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (32,5,'/Content/ckfinder/userfiles/images/13.jpg','Integer imperdiet felis ac risus pretium sollicitudin.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (52,7,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Aliquam at velit at augue tempus tristique eu ac purus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (67,5,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Nam eget tellus ut turpis posuere malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (26,5,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','In ac ex eget velit fermentum tristique quis eget libero.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (74,3,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Nunc ut ante ullamcorper, malesuada nulla convallis, cursus arcu.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,11,'/Content/ckfinder/userfiles/images/2.jpg','Sed a magna a enim feugiat laoreet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,7,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Proin placerat nunc in massa rutrum commodo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (14,4,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Vivamus et nulla eleifend, vehicula dolor a, mollis sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (23,4,'/Content/ckfinder/userfiles/images/20.jpg','Sed eget libero sed ipsum dictum porta.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (83,3,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Phasellus sed erat ac ligula dapibus tempus ultrices in est.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (26,6,'/Content/ckfinder/userfiles/images/4.jpg','Fusce viverra lacus eu suscipit volutpat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,8,'/Content/ckfinder/userfiles/images/8.jpg','Nullam nec enim quis risus dignissim mattis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (64,7,'/Content/ckfinder/userfiles/images/14.jpg','In consequat libero et mauris porta, a accumsan enim luctus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,9,'/Content/ckfinder/userfiles/images/12.jpg','Vivamus volutpat lorem sed purus facilisis, ut euismod leo sodales.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (89,4,'/Content/ckfinder/userfiles/images/12.jpg','Vestibulum non erat vitae dolor blandit aliquet pellentesque eget nisl.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (63,5,'/Content/ckfinder/userfiles/images/3.jpg','Maecenas eget mauris vitae diam auctor tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (21,4,'/Content/ckfinder/userfiles/images/19.jpg','Nunc a augue a odio facilisis feugiat eget nec sapien.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (7,3,'/Content/ckfinder/userfiles/images/14.jpg','Aenean vitae quam interdum, lobortis ipsum eget, sollicitudin velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (4,4,'/Content/ckfinder/userfiles/images/12.jpg','Mauris porttitor diam non enim interdum accumsan.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (5,3,'/Content/ckfinder/userfiles/images/16.jpg','Nunc convallis augue in felis ornare tempus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (33,6,'/Content/ckfinder/userfiles/images/3.jpg','Mauris finibus mauris id interdum convallis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (30,11,'/Content/ckfinder/userfiles/images/11.jpg','Phasellus vehicula tellus a libero dignissim imperdiet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (2,3,'/Content/ckfinder/userfiles/images/13.jpg','Quisque ac turpis vulputate, viverra tellus et, malesuada est.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,12,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Suspendisse at massa id magna sodales condimentum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (68,6,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Nam hendrerit sem sed purus ornare, et facilisis ex placerat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (47,2,'/Content/ckfinder/userfiles/images/11.jpg','Suspendisse pulvinar leo quis viverra aliquam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (76,5,'/Content/ckfinder/userfiles/images/6.jpg','Maecenas mollis metus at porttitor dictum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,8,'/Content/ckfinder/userfiles/images/8.jpg','Integer rhoncus odio et orci aliquam, mollis lobortis orci consectetur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,8,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Nam eu elit et ex facilisis sollicitudin.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (40,2,'/Content/ckfinder/userfiles/images/9.jpg','In sed nibh consequat arcu euismod ultrices.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (73,2,'/Content/ckfinder/userfiles/images/14.jpg','Maecenas ut nunc quis elit tincidunt posuere.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,8,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Sed cursus nisi ac felis pellentesque, et placerat quam faucibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,8,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Morbi blandit dolor aliquet, sollicitudin tortor sit amet, cursus sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (33,7,'/Content/ckfinder/userfiles/images/18.jpg','Donec quis arcu vitae augue fringilla elementum sit amet et tortor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (89,5,'/Content/ckfinder/userfiles/images/13.jpg','Nam vel ante consectetur, imperdiet leo sit amet, mattis leo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (73,3,'/Content/ckfinder/userfiles/images/4.jpg','Nam ut lorem hendrerit, porta purus sed, bibendum dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (26,7,'/Content/ckfinder/userfiles/images/11.jpg','Mauris placerat sapien vel felis efficitur, non sodales sem mollis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (8,3,'/Content/ckfinder/userfiles/images/7.jpg','Mauris suscipit erat id erat posuere, at imperdiet sapien pulvinar.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (6,7,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Ut suscipit justo nec pellentesque rhoncus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (48,6,'/Content/ckfinder/userfiles/images/5.jpg','Donec pharetra dui in leo facilisis, a auctor nisi vestibulum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (70,6,'/Content/ckfinder/userfiles/images/15.jpg','Morbi non augue commodo, rhoncus enim et, venenatis turpis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (38,3,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Sed semper sapien nec lobortis convallis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (79,4,'/Content/ckfinder/userfiles/images/5.jpg','Suspendisse eget elit viverra, facilisis libero sit amet, sollicitudin ex.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (33,8,'/Content/ckfinder/userfiles/images/13.jpg','Cras imperdiet diam sit amet tellus ornare, non aliquam lacus dignissim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (67,6,'/Content/ckfinder/userfiles/images/9.jpg','Etiam tincidunt velit in risus auctor, vitae commodo velit placerat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (67,7,'/Content/ckfinder/userfiles/images/15.jpg','Morbi in purus non tellus auctor mattis lacinia eu nisl.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (78,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Aenean ut quam sit amet orci gravida euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (81,6,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Sed gravida arcu ullamcorper dolor tristique, sodales dignissim felis varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,8,'/Content/ckfinder/userfiles/images/20.jpg','Praesent egestas orci nec felis tempor, in tristique ligula pulvinar.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (14,5,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Suspendisse vehicula dui sit amet nisl elementum efficitur eget sodales dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (38,4,'/Content/ckfinder/userfiles/images/angia/anh4.png','Vivamus vestibulum enim et ex scelerisque viverra.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (23,5,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Curabitur sed magna at turpis tempus dignissim quis quis lacus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (64,8,'/Content/ckfinder/userfiles/images/18.jpg','Nulla elementum dolor sed hendrerit congue.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (4,5,'/Content/ckfinder/userfiles/images/14.jpg','Nulla at elit et metus consectetur feugiat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (70,7,'/Content/ckfinder/userfiles/images/6.jpg','Nulla et eros vel odio consequat egestas vitae ut dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (68,7,'/Content/ckfinder/userfiles/images/14.jpg','Nulla varius quam at dui bibendum, ut cursus lacus varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (8,4,'/Content/ckfinder/userfiles/images/3.jpg','Vestibulum malesuada elit et suscipit eleifend.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (27,6,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Sed et ante eu eros pharetra tempor et at sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (52,8,'/Content/ckfinder/userfiles/images/18.jpg','Donec accumsan ante ac elit bibendum consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (21,5,'/Content/ckfinder/userfiles/images/20.jpg','Aenean ultrices augue laoreet orci accumsan malesuada.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (8,5,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Praesent fermentum lectus eu est aliquet maximus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,9,'/Content/ckfinder/userfiles/images/13.jpg','Proin dignissim ex a ante luctus, nec pharetra mauris elementum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (8,6,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Mauris vitae quam eget risus consequat varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (56,5,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Nulla at eros sit amet sapien mattis commodo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (92,3,'/Content/ckfinder/userfiles/images/4.jpg','Vivamus at massa eu augue posuere consectetur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (84,8,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Fusce malesuada lacus et metus mollis rutrum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (45,7,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Pellentesque sodales diam eu hendrerit egestas.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,9,'/Content/ckfinder/userfiles/images/14.jpg','Quisque pulvinar ipsum eget rhoncus commodo.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (59,4,'/Content/ckfinder/userfiles/images/1.jpg','Proin in urna sit amet diam convallis vestibulum vitae eu velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (43,4,'/Content/ckfinder/userfiles/images/khanhnga/anhtro1.jpg','Integer quis sapien mollis massa mollis fringilla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (38,5,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Donec id erat nec sapien convallis gravida.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (24,5,'/Content/ckfinder/userfiles/images/18.jpg','Proin eget est id velit condimentum facilisis vel quis sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (88,6,'/Content/ckfinder/userfiles/images/8.jpg','Proin quis odio porttitor, iaculis tortor ac, cursus nunc.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (31,7,'/Content/ckfinder/userfiles/images/4.jpg','Phasellus ac lacus eu elit condimentum consectetur vel lacinia mauris.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (17,5,'/Content/ckfinder/userfiles/images/angia/anh4.png','Nam in libero posuere, tempus magna vitae, gravida enim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (43,5,'/Content/ckfinder/userfiles/images/14.jpg','Cras mattis nibh vitae nunc finibus, at mollis augue laoreet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (29,5,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Proin vitae justo vitae elit vehicula tincidunt non in sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (31,8,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','In eu eros sit amet tellus accumsan pharetra non cursus diam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (17,6,'/Content/ckfinder/userfiles/images/5.jpg','Mauris condimentum odio non turpis interdum faucibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (88,7,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Nullam in enim at leo sagittis eleifend et eu lectus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (10,6,'/Content/ckfinder/userfiles/images/2.jpg','Mauris pretium diam ac neque facilisis, in pharetra nisi laoreet.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (11,10,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Mauris dictum nisi eu neque fermentum lacinia.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,10,'/Content/ckfinder/userfiles/images/18.jpg','Mauris eget metus nec ex ullamcorper egestas vitae eu nibh.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (42,5,'/Content/ckfinder/userfiles/images/15.jpg','Sed porttitor libero a tincidunt eleifend.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (67,8,'/Content/ckfinder/userfiles/images/18.jpg','Duis eu purus hendrerit, suscipit lacus eu, iaculis velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (87,5,'/Content/ckfinder/userfiles/images/3.jpg','Etiam semper est hendrerit, bibendum enim ut, suscipit sem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (49,6,'/Content/ckfinder/userfiles/images/18.jpg','Vestibulum vehicula risus a consectetur dignissim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (69,7,'/Content/ckfinder/userfiles/images/7.jpg','Nulla ac mauris ultricies, vehicula augue sit amet, placerat ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (82,3,'/Content/ckfinder/userfiles/images/14.jpg','Phasellus cursus velit consectetur sagittis consequat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (26,8,'/Content/ckfinder/userfiles/images/18.jpg','Suspendisse in massa ac ipsum cursus eleifend at pulvinar velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (90,7,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Phasellus ut tortor eu ex gravida rutrum at placerat ipsum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (8,7,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Praesent ultricies leo eget sem placerat, sit amet dapibus mauris auctor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (6,8,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Aenean convallis justo et purus blandit euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (47,3,'/Content/ckfinder/userfiles/images/16.jpg','Donec bibendum urna at mauris malesuada, id sagittis augue feugiat.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,9,'/Content/ckfinder/userfiles/images/angia/anh4.png','Donec ut elit eu mi dapibus sodales at a orci.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (70,8,'/Content/ckfinder/userfiles/images/13.jpg','Cras vitae ligula in orci dignissim euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (19,4,'/Content/ckfinder/userfiles/images/1.jpg','Fusce hendrerit erat a dolor congue sagittis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (63,6,'/Content/ckfinder/userfiles/images/khanhnga/anhtro2.jpg','Vestibulum et turpis eu est pretium consectetur.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (1,10,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Vestibulum a dui vitae ligula fermentum venenatis eu ornare dui.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (58,7,'/Content/ckfinder/userfiles/images/khanhnga/anhtro3.jpg','Fusce volutpat lorem sed est iaculis, non rutrum massa sollicitudin.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (51,5,'/Content/ckfinder/userfiles/images/5.jpg','Proin id elit sit amet purus fermentum varius eget nec sapien.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (44,11,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Etiam et mi lobortis, tincidunt leo volutpat, mollis lorem.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (48,7,'/Content/ckfinder/userfiles/images/7.jpg','Nunc auctor purus vitae nibh imperdiet euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (54,9,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Etiam et risus nec velit aliquam porta quis eu est.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (56,6,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Aenean egestas orci sit amet porttitor luctus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (43,6,'/Content/ckfinder/userfiles/images/5.jpg','Nunc vel elit hendrerit, scelerisque felis eget, venenatis elit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (23,6,'/Content/ckfinder/userfiles/images/16.jpg','Aenean rutrum sem a diam bibendum rhoncus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (36,5,'/Content/ckfinder/userfiles/images/9.jpg','Nam ac urna vitae mauris mattis vehicula a sed ligula.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (90,8,'/Content/ckfinder/userfiles/images/6.jpg','Sed vel lectus mollis, placerat lectus eu, aliquet nulla.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (34,6,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Aenean vel erat varius, convallis augue auctor, gravida turpis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (37,6,'/Content/ckfinder/userfiles/images/18.jpg','Maecenas euismod sapien id justo molestie, id dignissim augue maximus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,9,'/Content/ckfinder/userfiles/images/ductin/unnamed.jpg','Nunc in leo id urna porta facilisis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (40,3,'/Content/ckfinder/userfiles/images/13.jpg','In mattis sapien sed dignissim tincidunt.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,10,'/Content/ckfinder/userfiles/images/18.jpg','Ut malesuada enim in tortor semper porttitor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (77,6,'/Content/ckfinder/userfiles/images/19.jpg','Praesent vitae lacus eget tellus ullamcorper cursus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (12,10,'/Content/ckfinder/userfiles/images/1.jpg','Vivamus viverra elit et lacus lacinia feugiat at non ex.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (47,4,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Nam condimentum massa eget lectus efficitur suscipit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (94,9,'/Content/ckfinder/userfiles/images/20.jpg','Aenean consequat nulla in semper tristique.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,8,'/Content/ckfinder/userfiles/images/12.jpg','Aliquam viverra mauris lobortis mi egestas, quis pretium risus varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (50,5,'/Content/ckfinder/userfiles/images/19.jpg','Aenean quis orci ut velit porta gravida vel vel lectus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (93,5,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Maecenas luctus nulla et diam convallis varius.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (7,4,'/Content/ckfinder/userfiles/images/angia/anh4.png','Duis sed ante fermentum, tincidunt justo ac, ultricies odio.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (19,5,'/Content/ckfinder/userfiles/images/4.jpg','Vestibulum pulvinar odio vel leo fringilla tristique.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,9,'/Content/ckfinder/userfiles/images/9.jpg','Fusce pretium tellus congue pulvinar rutrum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (61,7,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','In varius urna at turpis gravida porta.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (28,13,'/Content/ckfinder/userfiles/images/7.jpg','Integer eu libero tincidunt, mattis metus vel, pellentesque metus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (45,8,'/Content/ckfinder/userfiles/images/3.jpg','Fusce sit amet metus eu lectus volutpat consequat at eu velit.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,10,'/Content/ckfinder/userfiles/images/1.jpg','Donec bibendum sapien volutpat varius venenatis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (35,2,'/Content/ckfinder/userfiles/images/5.jpg','Donec finibus arcu sit amet efficitur auctor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (3,6,'/Content/ckfinder/userfiles/images/7.jpg','Cras at neque nec tellus laoreet tincidunt in ac turpis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (13,6,'/Content/ckfinder/userfiles/images/18.jpg','Quisque sollicitudin libero non nisi facilisis iaculis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,11,'/Content/ckfinder/userfiles/images/9.jpg','Nam rhoncus justo non pulvinar vulputate.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (91,7,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Donec quis ex facilisis, pulvinar odio eu, malesuada libero.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (9,11,'/Content/ckfinder/userfiles/images/15.jpg','Vivamus pretium orci eget laoreet molestie.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (41,7,'/Content/ckfinder/userfiles/images/1.jpg','Fusce at nunc blandit, gravida ex non, accumsan arcu.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (86,7,'/Content/ckfinder/userfiles/images/11.jpg','Nulla eu odio accumsan, facilisis quam euismod, dapibus turpis.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (81,7,'/Content/ckfinder/userfiles/images/19.jpg','Curabitur elementum dui sed malesuada gravida.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (72,12,'/Content/ckfinder/userfiles/images/15.jpg','Ut sed dolor efficitur, blandit purus sit amet, elementum lacus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (78,6,'/Content/ckfinder/userfiles/images/9.jpg','Nullam in velit eget eros ultrices dictum.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (35,3,'/Content/ckfinder/userfiles/images/2.jpg','Duis vel metus vulputate, porttitor eros sit amet, imperdiet diam.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (2,4,'/Content/ckfinder/userfiles/images/6.jpg','Pellentesque vitae purus ac ex fermentum luctus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (22,9,'/Content/ckfinder/userfiles/images/19.jpg','Suspendisse eu erat et dui semper accumsan a eu tortor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (8,8,'/Content/ckfinder/userfiles/images/ductin/anh2.jpg','Ut venenatis mauris quis ligula sagittis, ac consectetur nisi faucibus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (62,6,'/Content/ckfinder/userfiles/images/7.jpg','Donec non velit id est tristique eleifend.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (57,6,'/Content/ckfinder/userfiles/images/4.jpg','Maecenas consequat augue nec libero fringilla rhoncus.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (80,10,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Vivamus ut nisi ornare, iaculis magna sed, hendrerit dolor.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (25,9,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Aliquam eget sapien varius, convallis nibh eu, condimentum enim.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (69,8,'/Content/ckfinder/userfiles/images/angia/anh3.jpg','Fusce eget lectus sit amet tortor tincidunt scelerisque.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (55,9,'/Content/ckfinder/userfiles/images/16.jpg','Aliquam ac quam ut metus facilisis euismod.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (51,6,'/Content/ckfinder/userfiles/images/ductin/anh1.jpg','Quisque posuere odio at odio lobortis, eu ultrices nunc accumsan.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (62,7,'/Content/ckfinder/userfiles/images/14.jpg','Sed quis massa non metus convallis feugiat porta sed augue.');
INSERT INTO AnhNhaTro (ma_nt,STT,ten_anh,mota_anh) VALUES (2,5,'/Content/ckfinder/userfiles/images/11.jpg','Pellentesque quis ex vel sem rhoncus mollis tempor vitae quam.');

INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,66,3,'2021-11-25 13:10:08','Cras gravida ex sed gravida ultricies.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (65,82,1,'2021-11-06 18:49:58','Phasellus tempor diam vitae quam pellentesque, quis fringilla felis hendrerit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (58,66,7,'2021-11-21 14:46:19','Maecenas malesuada ligula nec ornare interdum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,6,2,'2021-12-06 06:13:58','Aenean a quam eget est ornare rutrum eu nec libero.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (30,84,7,'2021-11-06 20:32:12','Phasellus a lorem ac nibh sodales finibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,88,7,'2021-12-02 08:05:51','Suspendisse a augue non felis volutpat luctus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,69,1,'2021-11-05 12:42:12','Vestibulum id nisl porttitor, pretium ante eu, euismod tortor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,84,7,'2021-12-01 06:59:28','Vestibulum tincidunt enim vitae dui luctus, non elementum purus dictum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (40,31,7,'2021-11-18 15:57:27','Aenean tempor orci in elit lacinia, vel lacinia lectus luctus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (19,11,7,'2021-11-09 19:51:10','In non nunc imperdiet, scelerisque lectus interdum, scelerisque augue.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (25,115,2,'2021-11-05 08:31:12','Integer ornare nibh at vehicula gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (24,58,3,'2021-12-05 10:45:24','Vestibulum volutpat elit vitae dui elementum, et maximus leo varius.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,35,1,'2021-11-05 15:34:51','Duis nec orci varius, blandit risus id, varius dui.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (60,7,7,'2021-11-05 06:17:25','Etiam vehicula leo eu facilisis tempus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (76,16,1,'2021-11-09 21:23:02','Praesent ullamcorper quam eget maximus viverra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (23,41,7,'2021-12-02 12:03:36','Duis aliquet nunc eget nibh ornare, id dapibus turpis facilisis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,57,7,'2021-11-24 10:47:51','Vivamus luctus urna vel massa luctus rhoncus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (21,105,2,'2021-12-01 20:48:03','Morbi in lorem imperdiet, accumsan ante dignissim, laoreet lacus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (3,120,7,'2021-11-30 08:05:25','Donec tristique mi et eros rhoncus, eu fringilla erat finibus.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (27,92,7,'2021-11-04 08:49:29','Etiam ornare dui non pellentesque rutrum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (27,43,2,'2021-11-02 19:12:00','Aenean ac mauris iaculis, fringilla ligula a, euismod mi.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (77,113,3,'2021-11-13 20:40:51','Nulla pretium urna eget metus efficitur feugiat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,77,1,'2021-12-05 20:15:48','Duis ac orci et augue sagittis tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (51,27,7,'2021-11-18 21:22:36','Pellentesque a urna facilisis, consectetur ipsum eu, venenatis mauris.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,3,7,'2021-11-05 09:19:52','Suspendisse quis ligula porta, tempor dolor a, luctus lacus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (66,72,3,'2021-11-23 15:57:53','Nam auctor felis nec tempor ultrices.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (30,38,7,'2021-11-10 10:28:25','Mauris lacinia enim vitae egestas rhoncus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (25,49,3,'2021-11-05 11:41:25','Nunc vitae urna id nisi feugiat molestie at at justo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (40,81,2,'2021-11-20 11:22:51','Fusce euismod libero a eros fermentum, non ornare diam convallis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (50,53,2,'2021-12-08 21:13:06','Maecenas posuere nisl quis eros interdum, ut imperdiet diam dapibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (44,58,7,'2021-12-05 21:12:58','Sed vulputate magna convallis, consequat dui non, facilisis elit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,92,3,'2021-11-27 11:42:00','Sed in dolor feugiat, dapibus elit vel, dignissim diam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,18,2,'2021-11-17 09:27:22','In et erat eu sapien fermentum lacinia.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (10,125,7,'2021-11-18 14:33:39','Quisque cursus odio ac blandit auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (37,5,2,'2021-12-07 15:09:22','Suspendisse dapibus tortor placerat odio fringilla, sit amet ultricies nisl feugiat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (94,12,3,'2021-11-29 08:41:00','Quisque nec felis facilisis, cursus est eu, rhoncus ipsum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (21,81,2,'2021-12-08 17:52:57','Praesent at eros in eros porttitor pulvinar.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,117,3,'2021-11-11 18:43:47','Integer sagittis diam et interdum volutpat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,95,2,'2021-11-28 21:47:57','Nulla semper nisi id mauris iaculis sollicitudin.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (14,85,2,'2021-12-06 20:18:40','Pellentesque cursus elit vitae velit hendrerit interdum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (42,79,3,'2021-12-04 11:50:21','Quisque in dui non sem bibendum auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (61,9,1,'2021-11-05 09:29:23','Donec id erat porta, fringilla augue vel, dignissim ante.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,74,7,'2021-11-29 13:59:40','Vestibulum convallis magna vel accumsan luctus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (70,35,2,'2021-12-07 19:50:18','Integer vel augue semper, rhoncus ante et, venenatis elit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (31,32,1,'2021-11-19 10:28:25','Proin eget orci eleifend, vulputate risus eget, sollicitudin est.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,57,2,'2021-12-02 16:13:18','Sed rutrum turpis a tellus auctor mattis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,39,2,'2021-12-05 21:36:52','Fusce a velit vel ex euismod scelerisque vel eu dolor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,45,3,'2021-11-21 10:24:40','Proin in odio id nisi varius lobortis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (77,9,2,'2021-12-05 17:44:01','Fusce vitae neque nec quam malesuada convallis et eu nulla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,111,2,'2021-11-04 14:32:12','Sed faucibus ante ut sapien commodo, quis suscipit quam vehicula.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (29,27,7,'2021-11-01 10:38:47','Quisque fringilla massa sed turpis rhoncus, non egestas nisl dictum.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (22,10,7,'2021-11-18 18:26:38','Pellentesque in augue eget turpis tempor posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (60,106,7,'2021-11-16 10:11:08','Sed egestas risus eget velit maximus fermentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (39,34,3,'2021-11-06 16:23:23','Duis vitae urna vitae turpis scelerisque pulvinar.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (6,26,3,'2021-12-10 17:31:03','Suspendisse mattis orci venenatis, dapibus sapien quis, mollis nunc.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (25,18,7,'2021-11-22 21:40:54','Phasellus id ante non purus blandit bibendum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,41,1,'2021-11-28 07:37:29','Aenean luctus tortor pulvinar, laoreet lectus vel, laoreet ipsum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (64,49,7,'2021-11-12 15:27:30','Praesent vehicula velit et leo euismod, vitae tristique eros facilisis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (46,56,2,'2021-12-10 15:18:35','Donec consectetur orci nec vestibulum finibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,63,1,'2021-12-04 06:47:57','Sed vulputate elit in neque blandit dignissim.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (15,38,3,'2021-11-26 15:04:02','Fusce pellentesque metus a mattis viverra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,48,1,'2021-11-11 20:28:28','Morbi vitae lorem id leo aliquam fringilla et at lacus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (38,83,2,'2021-12-08 11:44:10','Aliquam rutrum est a auctor blandit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,32,1,'2021-11-27 17:29:28','Phasellus maximus orci at felis malesuada sodales.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,29,7,'2021-11-02 19:38:04','Vestibulum porta orci et pulvinar feugiat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,122,1,'2021-11-22 07:35:20','Cras cursus sapien ultricies enim tempus feugiat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (37,18,7,'2021-11-20 09:43:55','Aliquam in justo lacinia, cursus mauris vitae, interdum dui.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (39,98,7,'2021-12-11 20:57:42','In egestas diam at arcu blandit fringilla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (27,104,7,'2021-11-07 12:46:39','Curabitur vehicula ipsum ut consectetur aliquam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (83,24,2,'2021-11-05 07:48:35','In ut arcu iaculis, tincidunt neque sed, scelerisque neque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (3,58,2,'2021-11-18 17:15:30','Aliquam lacinia quam vitae turpis rhoncus, et ullamcorper turpis euismod.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (4,73,2,'2021-11-04 17:28:11','Quisque ultrices purus nec venenatis faucibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,5,1,'2021-11-09 20:38:15','Cras porta est at lorem congue luctus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,87,7,'2021-11-13 08:11:54','Morbi a tellus et neque maximus suscipit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,28,3,'2021-11-02 07:01:29','Nulla rhoncus augue sit amet dignissim vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (64,127,7,'2021-11-17 13:34:19','In vel tellus dignissim, lacinia neque quis, imperdiet nulla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (69,3,7,'2021-12-05 14:30:37','Nulla faucibus magna ac egestas sollicitudin.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (80,91,1,'2021-12-03 12:16:51','Proin commodo arcu vitae quam finibus, sed feugiat eros interdum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,55,1,'2021-11-11 12:00:17','Quisque congue nisl tempor nulla porta convallis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (64,58,3,'2021-12-04 17:02:33','Aliquam at neque tincidunt, egestas purus vel, fermentum orci.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (29,58,2,'2021-12-02 13:20:12','Praesent tincidunt quam a lacus sollicitudin, in sollicitudin ante mattis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (74,6,3,'2021-11-04 11:02:24','Integer pharetra massa vel interdum commodo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (44,80,7,'2021-11-30 15:43:12','Nulla ornare risus quis malesuada sagittis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (55,99,7,'2021-11-26 06:10:57','Nullam euismod risus vel ex efficitur, sed rhoncus urna convallis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (24,78,3,'2021-12-07 17:45:45','Nunc vel ex et arcu mattis vulputate.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (28,34,7,'2021-11-17 16:22:57','Quisque rutrum dolor non erat sagittis, quis sollicitudin nulla iaculis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (44,105,7,'2021-11-24 17:22:42','Phasellus a lacus a sapien sodales congue.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,95,3,'2021-11-13 12:54:35','Integer at nibh quis dolor rhoncus vulputate sit amet sit amet massa.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,1,7,'2021-11-22 14:31:55','Curabitur id nisi nec lectus convallis condimentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (15,10,7,'2021-12-03 14:15:30','Fusce eget risus iaculis, commodo dui non, laoreet nisi.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (46,91,3,'2021-11-04 07:00:55','Sed elementum mi in tincidunt fermentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,95,7,'2021-11-17 15:33:33','Aenean et nisl a arcu molestie rhoncus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,103,7,'2021-11-01 07:56:30','Aenean a augue sollicitudin, faucibus nulla non, gravida velit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (30,124,3,'2021-12-10 15:11:40','Cras ut quam ac sem facilisis sollicitudin.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,24,7,'2021-11-14 11:12:29','Donec vehicula turpis eleifend sodales condimentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,18,7,'2021-12-09 08:31:03','Fusce dictum erat vehicula lectus faucibus, nec rhoncus tellus auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (39,112,3,'2021-12-02 18:47:31','Cras sollicitudin risus eget mauris congue, id sodales nibh commodo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (36,113,7,'2021-11-17 20:21:24','Sed faucibus magna eu felis fermentum aliquam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (22,127,7,'2021-11-16 11:51:04','Etiam non justo varius magna fermentum tempor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (40,44,1,'2021-11-01 13:10:25','Phasellus sed metus ac orci dictum auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (78,98,2,'2021-11-05 11:22:51','Donec malesuada orci sit amet nibh dictum rhoncus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,52,2,'2021-11-25 17:36:40','Cras non ligula congue, ornare odio quis, hendrerit augue.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (24,113,7,'2021-12-11 10:56:56','Quisque ut dui vitae justo interdum bibendum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,100,2,'2021-11-30 21:10:48','Curabitur sollicitudin dui a dignissim facilisis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (63,37,2,'2021-11-02 12:28:22','Nunc ultrices velit a tortor consequat laoreet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (86,30,1,'2021-11-14 18:27:13','Donec dapibus lectus sed metus lacinia ultrices at quis sapien.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (85,112,7,'2021-11-15 06:45:22','Ut mollis elit vel est euismod ullamcorper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (41,113,7,'2021-11-11 09:59:28','Nam consequat metus eu felis semper tempus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (87,7,3,'2021-12-05 16:32:36','Maecenas interdum metus eu arcu fringilla tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (85,86,7,'2021-12-06 13:25:32','Integer pharetra ante non porta posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (65,86,7,'2021-12-02 16:54:20','Etiam sed purus a turpis hendrerit sodales eu a lacus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (20,98,7,'2021-11-05 11:49:29','Phasellus pellentesque massa nec iaculis ornare.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,9,3,'2021-12-01 14:43:26','Suspendisse posuere nulla a lorem maximus, ac bibendum purus porttitor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (24,127,2,'2021-11-17 11:09:10','Praesent tempus lacus in eros convallis, nec efficitur nibh lacinia.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (22,65,3,'2021-11-12 11:04:16','Nullam ut elit nec mi egestas elementum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (61,94,1,'2021-11-03 17:14:30','Suspendisse nec arcu ut ex volutpat suscipit id at erat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (74,22,7,'2021-12-01 20:45:45','Curabitur quis neque eget mauris semper fringilla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,59,7,'2021-12-01 10:13:09','Aenean posuere mi eu quam interdum volutpat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,62,3,'2021-11-03 07:47:34','Ut posuere metus vitae est sodales dignissim.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (49,103,2,'2021-11-23 06:51:59','Pellentesque eget justo sed enim efficitur maximus ac non metus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,54,7,'2021-11-15 14:34:22','Fusce et dui vehicula sapien tincidunt venenatis ut in elit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,121,3,'2021-11-27 16:48:00','Quisque fringilla velit a ullamcorper condimentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,44,3,'2021-11-18 11:05:34','Integer at elit sit amet diam eleifend posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (86,29,7,'2021-12-11 16:14:36','In pharetra mauris eu velit mattis aliquet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (77,6,7,'2021-11-08 17:31:12','Donec faucibus elit a sem porttitor, at elementum est bibendum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (74,1,7,'2021-11-18 20:41:17','Sed sagittis nunc non dui efficitur ornare.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,59,1,'2021-12-09 15:11:48','Nulla facilisis dolor id nisi eleifend, at suscipit ligula feugiat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,39,3,'2021-12-03 12:43:47','Sed laoreet massa eget ante ultrices, eu gravida diam tempor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (57,20,1,'2021-11-24 14:58:42','Praesent id dolor lobortis, blandit ex non, molestie lectus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (34,114,3,'2021-12-07 15:44:12','Vestibulum malesuada arcu id placerat eleifend.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (5,9,7,'2021-11-24 19:32:10','Nulla pretium libero at commodo ullamcorper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (4,126,3,'2021-11-14 07:36:12','Cras pulvinar lectus dapibus lacus mollis, sit amet mollis nisi egestas.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,7,2,'2021-11-16 19:04:39','Nulla iaculis purus quis neque venenatis, ac pellentesque massa vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (49,27,3,'2021-11-04 20:03:07','Cras eu ipsum non nisi vulputate faucibus vestibulum vitae metus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (4,2,1,'2021-11-30 09:40:02','Fusce convallis tellus nec tortor venenatis molestie.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (42,40,2,'2021-12-07 08:16:05','Pellentesque laoreet elit nec suscipit suscipit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (74,14,1,'2021-11-13 18:08:47','Cras scelerisque lectus vel ante aliquam molestie.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (64,17,3,'2021-12-09 10:57:30','Phasellus vulputate quam sed elit viverra dapibus sed vel leo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,22,7,'2021-11-28 08:39:42','Sed tincidunt metus sit amet mi rhoncus scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (29,18,1,'2021-12-03 19:14:53','In ac erat non turpis vestibulum auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (45,99,1,'2021-11-15 17:53:23','Etiam efficitur leo id urna facilisis, id sagittis elit blandit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,94,2,'2021-11-20 14:35:05','Vestibulum at erat id nisl porta finibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (34,24,7,'2021-11-03 12:56:53','Sed rhoncus nunc a risus efficitur, at euismod odio sodales.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,66,2,'2021-11-17 19:12:35','Ut imperdiet risus imperdiet arcu gravida, non pulvinar diam ultricies.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,79,1,'2021-11-13 21:01:09','Nulla vel est vel ipsum aliquet iaculis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,84,7,'2021-11-22 19:16:28','Nunc lobortis erat a nulla tempor pellentesque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,90,3,'2021-11-22 19:30:52','Vestibulum at tellus ut purus blandit pulvinar.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,121,7,'2021-11-30 10:24:23','In at sapien sit amet magna elementum fermentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,79,7,'2021-11-23 06:23:28','In egestas sem id facilisis interdum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (13,29,1,'2021-11-05 14:09:19','Integer bibendum urna ut ex dictum pharetra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (45,105,1,'2021-11-25 18:59:54','Nulla imperdiet est sit amet enim egestas, tristique tempor quam tristique.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (12,8,2,'2021-11-15 13:23:14','Mauris vehicula lorem feugiat est euismod eleifend.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (82,66,7,'2021-11-04 13:12:26','Morbi sodales metus luctus turpis condimentum, ut finibus augue dictum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (61,96,1,'2021-11-09 17:39:50','Fusce quis risus non odio mattis egestas id quis justo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (89,127,1,'2021-12-07 15:56:27','Phasellus vel ligula a ipsum porta varius.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (66,23,3,'2021-11-29 20:50:12','In suscipit diam eu erat aliquam vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (38,100,3,'2021-11-03 19:06:58','Nulla hendrerit ligula sed elementum sodales.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (43,41,1,'2021-11-14 14:57:07','Donec quis sapien in purus varius ultrices.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (59,65,3,'2021-11-06 20:04:25','Nulla mollis metus eu nunc dapibus condimentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (74,45,7,'2021-11-25 17:00:40','Ut eu magna ut sapien volutpat dapibus nec a leo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (78,7,7,'2021-11-29 07:27:59','Proin nec nisl dictum libero congue facilisis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (70,90,2,'2021-11-25 14:47:28','Aliquam bibendum metus non diam viverra commodo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,94,3,'2021-11-10 11:18:23','Maecenas condimentum augue nec mattis pulvinar.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,27,7,'2021-11-10 09:45:56','Nullam dignissim mi sit amet lacus pretium lobortis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,52,1,'2021-11-10 12:30:32','Phasellus placerat sapien eu magna faucibus posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (4,37,3,'2021-11-19 15:21:27','Sed ut arcu gravida, auctor massa at, eleifend purus.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (25,21,3,'2021-11-06 07:56:38','Quisque quis dui in metus pulvinar porttitor a at lectus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (78,23,1,'2021-11-24 18:18:09','Duis ultrices risus aliquet, viverra mauris id, feugiat magna.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,88,7,'2021-11-11 09:36:52','In vel nisl in est dictum aliquet in vel tortor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (49,125,7,'2021-11-21 11:47:11','Duis elementum neque nec egestas vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (14,71,7,'2021-11-08 14:49:29','Ut ullamcorper nulla quis quam imperdiet rutrum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (86,101,3,'2021-12-11 10:11:00','Fusce tristique justo a nulla blandit semper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,99,3,'2021-11-06 09:55:44','Nam ultricies arcu nec dolor varius maximus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (28,53,2,'2021-11-17 20:18:49','In at velit non purus egestas consectetur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (13,18,2,'2021-11-15 18:34:08','Fusce aliquam lorem at mi placerat, at luctus lectus scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (31,49,2,'2021-11-14 07:59:40','Nam venenatis sem vitae sagittis lobortis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,33,3,'2021-12-07 13:35:02','Maecenas iaculis erat non felis porttitor, in dictum enim vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (85,52,7,'2021-11-08 11:03:42','Nullam tincidunt urna a lorem pretium, et tempus erat interdum.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,126,3,'2021-11-23 06:43:29','Phasellus eget nunc eget tellus pellentesque tristique in id felis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (83,103,1,'2021-12-03 11:13:21','Pellentesque cursus nisi vel sapien pharetra maximus.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (49,86,7,'2021-11-01 17:28:28','Cras cursus lacus et neque lacinia ultrices.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (59,90,7,'2021-11-25 17:43:18','Pellentesque molestie sem sit amet libero accumsan, ut elementum felis convallis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,125,3,'2021-12-08 21:15:16','Aliquam sed dolor sit amet urna porta imperdiet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (28,4,7,'2021-11-17 17:58:25','Nunc a elit et lacus commodo tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (12,126,1,'2021-12-06 12:59:11','Curabitur rutrum est quis facilisis consequat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (94,41,1,'2021-11-25 08:20:50','Aliquam id orci in metus efficitur efficitur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (21,22,2,'2021-12-08 14:50:56','Proin congue sem quis commodo porta.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (62,45,7,'2021-11-26 19:46:25','Cras gravida odio sed commodo consequat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,85,1,'2021-11-25 12:02:53','Nunc sed sapien eget sem sodales sodales vel in ligula.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (38,33,3,'2021-11-11 15:24:46','Sed vel lorem auctor, faucibus ante sit amet, facilisis nulla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (37,73,3,'2021-11-01 11:44:27','Phasellus et est nec purus luctus dapibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (31,124,1,'2021-11-24 06:20:44','Phasellus et ligula vitae elit facilisis ullamcorper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (36,81,2,'2021-11-09 10:46:25','Curabitur ac lectus sed dui faucibus fringilla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,91,1,'2021-12-08 17:08:27','Aenean at velit ut enim egestas sodales vel vitae lacus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (21,76,1,'2021-11-06 20:31:38','Vestibulum eu purus ut mauris mollis viverra non ut dui.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (85,94,7,'2021-12-02 09:53:08','Praesent eget ligula vel dui elementum ullamcorper eu id ante.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (12,123,7,'2021-12-08 19:39:39','Vivamus vitae massa non elit pulvinar posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (84,7,7,'2021-11-08 15:41:46','Nulla ut lacus vehicula, dignissim magna vel, convallis diam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,118,7,'2021-11-16 15:41:54','Morbi facilisis arcu id lorem sodales, eu auctor dui venenatis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (1,66,3,'2021-11-25 08:41:34','Donec aliquam lacus rutrum, maximus arcu eget, congue quam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,77,7,'2021-11-22 17:00:58','Praesent aliquet enim nec dictum tempus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,73,1,'2021-11-23 14:19:32','Pellentesque a nibh vitae turpis tempor tristique ut id risus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,19,1,'2021-12-08 11:47:37','Integer ultrices arcu a dapibus commodo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (24,67,1,'2021-11-17 15:12:32','Ut scelerisque odio ac libero facilisis, ac sollicitudin enim consequat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (41,51,3,'2021-11-05 11:40:51','Quisque a nisi rhoncus, bibendum justo pretium, ultricies tortor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (83,99,7,'2021-12-06 09:56:18','Proin fermentum est non dui convallis tempus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (57,33,1,'2021-11-25 11:11:46','Sed tincidunt justo ac ligula vehicula, ut malesuada metus feugiat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (58,38,2,'2021-11-01 10:35:46','Cras posuere nisl vitae orci ultricies, at lacinia enim tempor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,42,2,'2021-11-22 07:34:45','Morbi tincidunt leo vitae nisl maximus, non aliquet neque laoreet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,75,1,'2021-11-14 09:00:17','In eu risus eget quam hendrerit consectetur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,28,7,'2021-12-04 09:13:24','In quis eros at sem molestie ullamcorper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (61,66,7,'2021-11-05 12:12:58','Ut at sem sed arcu lobortis ultricies in ac risus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (13,54,7,'2021-12-06 12:10:31','Sed quis eros ac velit viverra maximus at ac orci.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (30,105,7,'2021-11-24 17:37:06','Duis tempus erat lobortis ornare rutrum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (93,116,3,'2021-12-05 07:22:22','Vestibulum congue quam id tincidunt malesuada.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,4,1,'2021-11-11 13:24:58','Cras lacinia nunc in metus ornare, non feugiat lorem efficitur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (55,70,3,'2021-12-04 21:37:09','Etiam eget diam tempor, rutrum felis a, feugiat magna.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (74,5,3,'2021-11-02 10:49:00','Fusce eget sapien placerat, tempor diam quis, facilisis ipsum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (93,56,1,'2021-11-07 14:28:45','Duis eu sem vel est suscipit vulputate quis ut ex.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,19,7,'2021-11-08 20:23:08','Integer lacinia felis non laoreet scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (22,69,3,'2021-11-29 21:30:23','Phasellus venenatis tellus vitae nulla viverra congue.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,63,2,'2021-11-12 08:58:34','In vestibulum magna et tempus blandit.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (54,5,1,'2021-11-25 21:39:45','Mauris venenatis risus id consectetur aliquam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (59,57,1,'2021-11-17 21:17:08','Vivamus tincidunt ante eu mi sollicitudin, in tincidunt odio venenatis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,121,3,'2021-11-18 14:34:22','Maecenas non nisi at enim varius posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (28,94,1,'2021-11-11 10:43:06','Fusce in mi eget risus maximus placerat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (93,93,3,'2021-12-07 10:07:41','Duis vel velit eu quam feugiat mattis at non metus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (21,50,7,'2021-12-11 07:55:12','Fusce scelerisque est a turpis aliquet iaculis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,102,2,'2021-11-16 08:28:54','Etiam scelerisque nibh vitae viverra feugiat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,66,2,'2021-12-10 10:43:06','Nullam gravida risus eu rhoncus gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (22,6,2,'2021-11-09 19:51:53','Donec aliquet mi vel libero sagittis tempus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (29,23,1,'2021-11-03 21:25:12','Pellentesque at nulla vitae diam accumsan blandit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (64,105,7,'2021-11-11 19:59:23','Cras et ante congue, efficitur mi et, finibus leo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,2,7,'2021-11-23 07:36:12','Morbi ullamcorper diam sit amet leo semper, vel pretium urna facilisis.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (85,95,7,'2021-12-11 16:58:39','Pellentesque imperdiet lectus quis sapien rutrum viverra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (50,82,1,'2021-11-01 14:39:24','Vestibulum a est vel tellus blandit bibendum ac ac nisl.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,11,3,'2021-12-05 18:53:51','Ut vitae metus in tellus malesuada commodo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (13,94,1,'2021-11-06 13:06:06','Proin vel ipsum tristique, luctus odio consectetur, euismod dolor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (29,45,7,'2021-11-18 16:28:08','Aliquam sed metus rutrum, venenatis mauris ac, tincidunt lectus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (23,82,2,'2021-12-08 08:10:02','Fusce feugiat purus ut finibus hendrerit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (29,89,1,'2021-12-04 12:51:33','Praesent laoreet ligula eget augue malesuada porttitor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (30,100,2,'2021-11-17 13:31:44','Suspendisse ac arcu et neque placerat dictum quis ut dolor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,64,2,'2021-11-20 06:30:23','Duis sit amet purus dictum, faucibus sem id, sollicitudin metus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (2,66,7,'2021-11-27 18:29:48','Nam elementum erat interdum, interdum est sed, tempus nisl.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (6,114,7,'2021-11-15 12:18:09','Pellentesque in nisi a nunc commodo pellentesque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (89,37,7,'2021-11-18 12:04:45','Etiam et tortor porta, mattis leo sit amet, viverra ex.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,93,2,'2021-11-25 17:27:10','Morbi convallis quam et congue tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (56,47,3,'2021-11-17 13:31:18','Aliquam efficitur eros sed sollicitudin fermentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (39,121,2,'2021-12-05 14:29:20','Sed eu metus quis nisi semper ornare fringilla id ligula.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (86,53,3,'2021-11-28 15:13:41','Mauris eu nulla dignissim sapien molestie luctus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (19,30,7,'2021-11-15 11:16:31','Praesent vestibulum enim vel orci euismod sagittis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,3,7,'2021-12-07 21:02:36','Quisque eu ex molestie, feugiat est dignissim, efficitur orci.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (33,85,7,'2021-11-26 06:04:02','Cras pharetra est dapibus tellus feugiat, sit amet ultricies felis auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (30,87,2,'2021-11-06 14:12:46','Phasellus et enim id urna tempor mattis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,56,1,'2021-11-27 21:11:40','Sed eget sapien vel metus consectetur tempor eu at elit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (49,9,3,'2021-11-03 13:54:29','Mauris dapibus diam ut metus maximus gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,106,7,'2021-11-02 06:51:59','Nullam varius elit a porta eleifend.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,111,7,'2021-11-09 16:47:51','Morbi eu diam eu turpis posuere tempus nec eleifend nunc.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,76,1,'2021-12-04 15:10:22','Morbi a urna in justo consequat molestie.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (5,63,3,'2021-12-04 15:12:49','Nulla in justo sagittis, porttitor tellus a, pharetra quam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (14,94,2,'2021-11-03 18:36:52','Fusce at erat bibendum, bibendum dui a, efficitur tortor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (46,94,2,'2021-12-02 08:47:02','Integer pellentesque tortor nec elementum tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (78,95,1,'2021-11-20 13:16:02','Sed placerat ligula nec blandit ultrices.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (42,112,1,'2021-11-30 17:42:35','Integer gravida ipsum ac magna pretium, vel feugiat purus vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (74,124,2,'2021-12-02 10:36:29','Maecenas rutrum lectus ac est sodales auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,66,1,'2021-11-06 10:36:29','Nulla id lacus ac massa eleifend elementum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,43,2,'2021-12-06 14:09:19','Vestibulum placerat magna eu massa volutpat posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,105,3,'2021-11-14 21:16:16','Aenean sit amet metus sagittis diam ornare laoreet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,26,1,'2021-11-26 11:49:21','Sed ac ex commodo, condimentum turpis vel, dapibus ante.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (6,63,1,'2021-11-18 07:10:16','Nam id est laoreet neque laoreet blandit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (59,78,3,'2021-12-06 21:18:52','In a nulla vel mi vulputate lobortis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (4,123,2,'2021-11-23 08:51:56','Cras id quam congue, facilisis urna quis, feugiat purus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (55,73,7,'2021-11-06 14:59:34','Duis condimentum arcu eget semper scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,61,3,'2021-12-03 14:25:52','Ut consequat libero vel tempor posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (60,88,1,'2021-12-02 07:22:48','Aenean in augue tempor, dignissim elit et, sollicitudin orci.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,103,1,'2021-12-07 20:57:50','Phasellus blandit massa id lorem semper pellentesque ac sed mauris.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,26,3,'2021-12-01 18:26:12','Sed mattis urna sed maximus lobortis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (33,64,7,'2021-11-01 10:11:25','Nunc vel tellus mollis lacus volutpat lobortis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (85,44,2,'2021-11-13 21:05:28','Phasellus malesuada felis semper faucibus elementum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,124,1,'2021-11-03 14:34:48','Nam sagittis risus a lorem tincidunt dignissim.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (74,55,3,'2021-12-07 14:42:09','Cras non leo rutrum, gravida tortor vitae, semper lacus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (23,115,1,'2021-12-08 08:10:28','Curabitur iaculis risus finibus molestie sagittis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (87,43,1,'2021-12-01 14:20:07','Praesent nec ligula vel mauris faucibus dignissim.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (55,105,3,'2021-11-25 20:54:06','Donec sodales purus gravida massa venenatis, vitae efficitur mi sodales.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (83,119,7,'2021-11-09 11:37:32','Nulla sodales nisl ac enim imperdiet, mattis feugiat lectus commodo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (39,49,3,'2021-11-22 10:10:42','Pellentesque lobortis eros quis dui pretium scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (89,43,3,'2021-11-13 13:39:39','Proin vel risus id nisl auctor varius eu eu sapien.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (44,82,3,'2021-12-01 15:32:33','Aliquam malesuada tortor eu tellus dictum, quis dignissim odio fermentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (57,11,2,'2021-12-05 15:32:50','Cras sodales tortor ut velit tempor fringilla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (26,14,2,'2021-11-17 20:22:34','Pellentesque sollicitudin augue sed sem finibus, quis hendrerit neque tempus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (13,18,7,'2021-11-02 09:17:08','Duis sit amet nisl ut tortor sodales ornare.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (89,73,1,'2021-11-21 14:03:33','Etiam vel massa eleifend, varius lectus in, aliquet turpis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,110,7,'2021-12-01 17:51:56','Sed ullamcorper diam ut placerat luctus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (44,113,2,'2021-12-04 13:52:54','Aenean quis nisi non lacus dictum vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (64,60,1,'2021-11-29 13:06:58','Praesent vulputate sapien quis arcu sagittis consequat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (19,109,2,'2021-11-27 13:16:28','Sed varius diam at urna imperdiet vulputate id sit amet tortor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,14,1,'2021-11-09 20:35:31','Nam ut arcu et tortor dapibus volutpat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (19,34,3,'2021-12-11 12:33:33','Fusce tempor urna at nibh blandit, sed aliquam ante euismod.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,46,7,'2021-11-21 10:43:24','Nam lobortis justo nec dui scelerisque interdum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (14,34,1,'2021-11-19 09:36:43','Sed placerat est eu nulla auctor, tempor dapibus eros bibendum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,51,7,'2021-11-30 09:38:44','Nullam lobortis felis condimentum ipsum facilisis, nec feugiat nisl laoreet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,33,3,'2021-11-18 12:44:38','Quisque tempor diam quis pellentesque tempor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (83,126,1,'2021-11-17 10:27:07','Etiam feugiat nisl id dolor finibus pellentesque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (25,46,3,'2021-12-09 09:14:15','Donec laoreet tortor volutpat lectus tincidunt tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,16,3,'2021-11-08 07:36:55','Vestibulum lacinia nisl non sapien pellentesque gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (36,107,2,'2021-12-11 06:28:39','Nulla tristique ex at tristique hendrerit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (79,116,7,'2021-11-12 09:43:38','Aenean eu est gravida, tincidunt nibh non, luctus metus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (9,8,1,'2021-11-21 09:54:43','Nullam in metus cursus, efficitur leo at, rutrum quam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,79,1,'2021-11-06 06:17:43','Curabitur nec nibh sed nibh pulvinar fermentum in quis libero.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (52,90,7,'2021-11-14 11:22:25','Morbi et justo viverra diam semper accumsan.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,44,2,'2021-12-11 15:10:48','Mauris at velit eu ipsum molestie egestas eu et nulla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (20,23,2,'2021-11-16 19:10:34','Nulla faucibus nunc eget lacus molestie, at tempor tortor rutrum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (26,75,7,'2021-12-05 17:01:49','Duis bibendum massa ut ullamcorper dictum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,89,2,'2021-11-05 12:15:50','Proin iaculis mi id interdum vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (22,118,1,'2021-11-21 16:58:13','In finibus massa eget arcu malesuada, in malesuada leo gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,48,7,'2021-12-06 10:20:04','Cras cursus augue non felis scelerisque imperdiet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,37,3,'2021-12-07 20:59:25','Quisque dictum ligula sit amet placerat ultricies.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (60,35,7,'2021-11-24 09:20:18','Aliquam at lacus in magna laoreet posuere nec non leo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,96,1,'2021-11-25 21:02:18','Donec in lectus nec nunc aliquet mattis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,5,2,'2021-12-08 08:52:57','Suspendisse porttitor quam at metus tincidunt aliquet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (13,14,1,'2021-12-01 12:26:56','In vitae nulla rhoncus, volutpat ipsum ut, egestas nulla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (6,34,3,'2021-12-11 21:48:58','Nam nec dolor id est scelerisque porta.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,17,2,'2021-11-12 10:43:41','Phasellus ut justo ut purus sodales cursus ac sit amet lacus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (66,70,1,'2021-12-04 11:44:10','Nam ornare tellus sed elit porttitor, at maximus nisi lacinia.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,50,3,'2021-12-07 20:49:03','Etiam finibus lorem ac vestibulum interdum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (45,18,3,'2021-11-18 18:47:23','Maecenas nec lacus id justo molestie gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (75,48,1,'2021-11-03 10:08:24','Aenean porta orci non sapien eleifend, in eleifend tortor sodales.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (6,73,2,'2021-11-30 10:17:28','Curabitur nec est vulputate, tristique risus id, lobortis libero.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,66,1,'2021-11-28 09:11:57','Curabitur ac mauris a ligula mollis ultrices sed quis felis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (38,54,2,'2021-11-18 07:19:12','Quisque in ante cursus, lacinia quam in, euismod felis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (75,36,2,'2021-12-06 20:00:23','Etiam et tellus eget ligula iaculis laoreet nec sit amet mi.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (93,21,7,'2021-11-15 20:12:12','Suspendisse placerat libero vel faucibus scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,106,3,'2021-11-27 08:40:08','Vivamus nec urna egestas, imperdiet ante quis, faucibus felis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,85,7,'2021-12-11 07:37:47','Curabitur ultrices nisl nec maximus laoreet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (68,97,2,'2021-11-05 08:09:36','Donec varius eros quis placerat lacinia.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,72,1,'2021-11-28 08:20:33','Aliquam pretium turpis ac vestibulum iaculis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (23,4,2,'2021-11-07 16:15:45','Mauris fringilla quam vitae lacus hendrerit ullamcorper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (27,34,1,'2021-12-07 08:59:43','Phasellus vitae ipsum in dolor tincidunt rhoncus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (43,75,3,'2021-12-11 19:38:12','Cras placerat massa at auctor congue.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,12,1,'2021-11-28 17:12:55','Quisque iaculis tortor quis nisi sollicitudin, a blandit urna egestas.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (3,70,1,'2021-11-06 09:35:00','Nullam laoreet velit aliquet risus hendrerit, ac ullamcorper odio fermentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (40,26,7,'2021-11-04 11:15:48','Ut eu ligula in orci tempor egestas.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,90,7,'2021-11-11 07:53:54','Phasellus porttitor massa at elit porta egestas.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (36,65,3,'2021-11-22 06:16:34','Pellentesque vitae purus lacinia, mollis ex id, finibus ante.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (34,5,1,'2021-12-08 06:57:53','Quisque vestibulum nisl vehicula, auctor odio sed, egestas lorem.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (3,59,2,'2021-11-24 17:07:18','Ut a mauris non erat scelerisque bibendum ac sit amet lorem.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,79,3,'2021-11-08 20:09:01','Phasellus sed velit fringilla, congue erat vitae, dignissim dolor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,57,3,'2021-12-09 16:02:12','Fusce fermentum mi in mattis porta.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (26,65,7,'2021-12-07 12:43:21','Nullam auctor nisi et posuere faucibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (69,113,3,'2021-12-05 16:31:35','Phasellus et velit dictum, consequat ipsum quis, consequat neque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (45,9,7,'2021-11-27 17:25:44','Ut convallis est vitae commodo pulvinar.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,14,2,'2021-12-10 12:27:04','Pellentesque mollis ligula eu tellus rhoncus facilisis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (89,28,2,'2021-11-11 17:29:28','Cras volutpat leo at mauris tempor tempor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,107,3,'2021-11-22 11:46:54','Sed malesuada ipsum vitae erat efficitur tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,91,2,'2021-11-09 10:58:57','Etiam aliquam mi sit amet tortor consequat, sit amet interdum justo venenatis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,52,7,'2021-11-05 20:51:48','Pellentesque a metus sed velit blandit auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (68,124,2,'2021-11-15 08:00:06','Nunc euismod ante et nulla gravida facilisis ac non arcu.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,122,3,'2021-11-11 19:09:50','Morbi luctus nisl a mauris viverra tempor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (6,4,3,'2021-11-18 07:27:16','Nam a diam semper elit suscipit condimentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,49,7,'2021-11-06 06:17:25','Vivamus quis turpis quis quam venenatis pretium.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,54,7,'2021-11-10 13:30:09','Maecenas non augue lacinia, accumsan sapien et, fermentum erat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (59,59,3,'2021-11-22 12:04:02','Integer eu orci sit amet ligula ullamcorper euismod.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,65,3,'2021-12-08 11:08:53','Pellentesque quis magna in dolor rutrum efficitur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (54,38,7,'2021-11-08 18:16:16','Proin varius ipsum vitae est fermentum, a lacinia nisi iaculis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (54,46,3,'2021-11-05 07:00:03','Vivamus fringilla ipsum blandit, ornare sem ac, ullamcorper nisi.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (76,36,1,'2021-12-01 12:55:44','Praesent sit amet justo nec lectus pharetra cursus ac vitae purus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (79,32,7,'2021-11-05 17:08:44','Mauris tempus tortor non enim tincidunt, sed posuere sem dignissim.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (55,116,1,'2021-11-18 20:00:23','Mauris efficitur ante eget lacus finibus fringilla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,76,1,'2021-11-13 12:08:38','Nullam nec diam tempus, auctor purus pellentesque, malesuada diam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (85,57,3,'2021-11-07 14:27:10','Morbi cursus augue vel urna aliquam, sit amet laoreet velit pretium.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,105,2,'2021-11-16 08:14:47','Nam at metus sagittis, tempor mauris sed, lacinia neque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (54,123,7,'2021-12-04 20:57:42','Etiam in justo ut justo congue porttitor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (27,17,2,'2021-11-25 14:01:15','Nunc sed justo id ligula mattis facilisis sit amet sed leo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,88,3,'2021-11-12 06:06:55','Duis fermentum magna non lacus rhoncus, ut elementum magna blandit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (29,114,3,'2021-11-12 08:51:04','Morbi efficitur elit rhoncus tortor ornare, et laoreet magna consequat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (42,56,7,'2021-11-03 17:50:56','Sed ut diam ut risus tempor sagittis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,13,2,'2021-11-28 11:12:29','Suspendisse sit amet eros at justo hendrerit lobortis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,105,3,'2021-11-11 06:16:34','Nunc pharetra justo non diam laoreet ullamcorper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,22,3,'2021-11-16 19:38:38','Praesent in nunc a erat vulputate porta.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,77,1,'2021-11-05 13:38:30','Pellentesque sed nibh at ligula convallis pretium sed in nibh.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (66,45,1,'2021-11-23 08:05:17','Aenean et risus sit amet nisi eleifend mattis a vitae purus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (89,36,3,'2021-11-20 09:20:27','Mauris dictum dolor aliquam egestas sagittis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,65,3,'2021-11-03 13:26:33','Vivamus non leo at nibh varius sagittis vel vel eros.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,115,7,'2021-11-09 15:44:30','Duis in massa ultrices, ultricies metus vitae, lobortis urna.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,88,3,'2021-11-13 08:52:57','Nulla non quam tempor, auctor velit egestas, faucibus orci.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (30,36,3,'2021-11-02 06:38:36','Nam interdum dui in nunc volutpat elementum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,70,3,'2021-11-10 15:08:21','Donec tristique lorem vitae nunc convallis tempus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (6,65,2,'2021-12-08 14:37:41','Donec cursus massa quis lorem finibus vehicula.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (67,54,1,'2021-12-07 16:27:33','Vivamus egestas risus et egestas placerat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (10,85,2,'2021-11-27 10:00:20','Nullam quis turpis et leo mattis feugiat eu non arcu.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (54,53,2,'2021-11-06 13:17:11','Etiam a ex laoreet, vestibulum elit ac, fringilla risus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (39,10,2,'2021-11-28 08:57:16','Vestibulum nec sem a quam commodo malesuada et non lectus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (26,16,1,'2021-11-19 19:39:48','Etiam pharetra ligula nec dapibus ultricies.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,61,3,'2021-11-11 11:37:49','Morbi euismod neque eu lobortis convallis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (44,20,1,'2021-12-03 17:12:37','Nam auctor nunc eu ligula dictum, id tempus sem scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (70,64,2,'2021-11-21 20:13:55','Duis placerat magna eu tortor pharetra vulputate.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,60,7,'2021-11-10 19:18:37','Morbi luctus mi eget ipsum malesuada accumsan.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (40,32,2,'2021-11-13 07:47:08','Maecenas auctor arcu non tellus convallis suscipit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,46,1,'2021-11-03 14:57:42','Morbi eleifend enim sed mi laoreet vulputate sed eu massa.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (84,81,3,'2021-11-22 20:06:00','Proin quis massa eget enim maximus fringilla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (36,1,3,'2021-11-15 14:13:47','Phasellus ornare velit id libero eleifend, at viverra nibh maximus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (61,111,3,'2021-11-10 12:43:47','Aliquam quis neque elementum, malesuada felis id, volutpat neque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (59,80,3,'2021-11-07 15:23:37','Quisque fringilla urna a massa ultricies mollis.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (45,124,7,'2021-12-10 19:58:22','Etiam fringilla libero at massa commodo faucibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (86,51,7,'2021-11-07 21:04:36','Vivamus interdum magna vel sem vulputate cursus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (61,18,7,'2021-11-23 20:02:59','Praesent at nulla in nunc lacinia aliquam vel eu lacus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (13,21,1,'2021-11-25 16:54:20','Cras sed lorem ultricies magna bibendum venenatis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (4,70,1,'2021-11-04 08:42:17','Curabitur interdum erat vel feugiat sodales.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (83,78,7,'2021-11-22 12:50:07','Morbi nec mi et dolor sagittis vehicula.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (14,82,1,'2021-12-02 20:04:42','Aliquam id dui luctus, ullamcorper dui vitae, pellentesque mi.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,97,1,'2021-11-12 17:05:34','Donec vitae diam dignissim, vulputate magna eget, lacinia neque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (76,80,3,'2021-11-11 11:34:39','Curabitur consectetur lectus eu erat efficitur consequat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (40,38,2,'2021-11-21 11:08:27','In aliquam lorem nec urna efficitur efficitur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (38,98,2,'2021-11-10 14:54:40','Aenean scelerisque tellus vel pulvinar vulputate.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (24,107,7,'2021-11-20 07:08:41','Praesent ut magna sed eros sodales ullamcorper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (1,28,3,'2021-11-02 14:02:41','Maecenas euismod est eget nisl commodo elementum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (51,118,3,'2021-11-20 10:44:59','Praesent tempus risus in dolor bibendum, vitae dignissim magna condimentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (84,2,7,'2021-11-20 09:23:20','Proin a nisl non felis commodo lacinia sed aliquam ex.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (46,66,1,'2021-11-23 13:26:59','In mollis ex at sapien molestie elementum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (10,22,3,'2021-11-08 07:50:01','Proin tempor lacus nec eros vehicula vehicula.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (15,5,1,'2021-12-09 10:49:00','Proin in nisl pulvinar, tincidunt ipsum id, posuere quam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (69,11,1,'2021-11-02 10:47:34','Vivamus venenatis enim vitae lorem placerat, sed lacinia massa condimentum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (70,28,7,'2021-11-15 13:20:47','Integer eu enim lobortis, interdum sem eget, aliquam turpis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,92,1,'2021-11-11 21:55:35','Suspendisse commodo ante in nunc convallis aliquet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (24,27,1,'2021-11-23 07:29:25','Ut a nibh ut justo efficitur ultrices ac et urna.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (70,118,7,'2021-11-13 15:26:21','Duis laoreet ipsum ut enim interdum dapibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (46,74,7,'2021-11-01 12:46:48','Integer sed augue eu nisl finibus maximus ultricies non velit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (32,45,7,'2021-11-19 16:33:53','Nam laoreet ante nec turpis consequat cursus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (44,118,7,'2021-11-04 15:50:41','Vivamus imperdiet tellus nec blandit elementum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (63,30,7,'2021-12-11 09:59:20','Nullam id velit ac mi euismod lacinia.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,14,3,'2021-12-09 17:54:58','Pellentesque non erat nec dolor tincidunt luctus quis suscipit libero.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (45,29,7,'2021-11-30 11:04:51','Vivamus cursus ligula non erat tempor dapibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (2,67,7,'2021-12-05 19:20:04','Duis tincidunt orci ac tempor sodales.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (25,58,2,'2021-11-11 15:27:04','Vivamus non diam nec elit venenatis dapibus in eget mauris.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (78,62,1,'2021-11-19 19:19:21','Mauris tincidunt est vitae varius viverra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (62,77,7,'2021-12-10 08:31:55','Aenean vitae nisl vitae leo luctus finibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (15,28,2,'2021-12-06 06:15:50','Phasellus sit amet lacus egestas, commodo eros sed, pulvinar justo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,71,7,'2021-11-30 19:49:18','In sed tellus ac eros suscipit feugiat id ac risus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (30,3,1,'2021-11-07 09:04:19','Nullam bibendum lectus vitae orci vehicula commodo.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (69,12,2,'2021-11-21 11:19:24','Suspendisse quis ex vitae eros cursus consequat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (11,56,3,'2021-11-28 08:24:26','Maecenas id mi eu augue dapibus rhoncus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (77,117,1,'2021-11-21 07:11:43','Vestibulum accumsan risus in molestie sollicitudin.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (64,11,7,'2021-12-05 17:43:26','Cras finibus purus sed sem bibendum, non egestas purus dapibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,18,2,'2021-11-04 15:41:02','Praesent eleifend quam non purus congue gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (21,64,7,'2021-11-25 15:33:24','Sed tempor orci sit amet dignissim vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (69,73,2,'2021-11-10 17:59:51','Nulla in tellus vitae velit suscipit semper a a lectus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (41,89,2,'2021-11-09 20:15:22','Nulla consequat libero a tincidunt tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (87,21,2,'2021-11-29 12:35:25','Duis id orci porttitor, venenatis urna sed, egestas erat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (1,43,2,'2021-11-03 17:17:31','Integer ultrices risus ac luctus bibendum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (46,82,7,'2021-11-02 09:37:26','Vivamus cursus lacus in lectus tempus ultrices.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (19,16,7,'2021-11-08 20:27:01','Nunc consectetur magna at nisi facilisis, sit amet sagittis mi scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (70,98,7,'2021-12-10 20:31:03','Sed tristique urna non mattis consectetur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (33,102,7,'2021-11-29 12:04:28','Morbi semper ex eu felis ultricies, in convallis nibh sagittis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (7,4,2,'2021-11-11 11:05:00','Etiam a nibh ac magna ornare facilisis id eu sem.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (34,4,2,'2021-11-29 11:27:27','In nec velit ac libero cursus malesuada porta at erat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (73,60,2,'2021-11-26 18:17:34','Pellentesque cursus magna ut magna convallis, sit amet fringilla risus sodales.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (79,106,2,'2021-11-03 20:12:12','Ut finibus ante id mauris iaculis, id mattis sem convallis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,62,7,'2021-12-09 16:58:22','Duis eu lorem sit amet ipsum fermentum ultricies eu eu ante.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,25,3,'2021-11-10 21:47:40','Sed finibus nisi vel lacinia faucibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (68,30,3,'2021-11-15 10:50:18','In iaculis eros ut mauris finibus finibus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,74,2,'2021-12-11 10:11:08','Sed ut velit sed diam posuere semper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (75,63,2,'2021-11-23 16:38:12','Cras in purus vehicula, tincidunt dui a, lacinia nisi.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (8,9,3,'2021-12-03 09:49:49','Fusce pretium mi et feugiat tempus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,99,7,'2021-11-09 09:10:22','Mauris nec felis quis augue elementum dapibus vel venenatis ipsum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,126,1,'2021-11-19 20:32:04','Pellentesque ac risus quis ante luctus posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,4,1,'2021-11-27 10:26:07','Integer eget felis condimentum, facilisis augue et, volutpat massa.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (49,98,3,'2021-12-02 06:40:19','Nulla iaculis quam quis diam convallis posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (59,41,2,'2021-11-26 15:35:17','Cras dignissim nibh tempor sem tempus, ac rhoncus nibh euismod.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (52,86,7,'2021-12-07 13:46:25','Phasellus faucibus arcu fermentum, feugiat massa at, faucibus magna.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (51,102,3,'2021-11-01 06:57:27','Ut at dolor dictum, congue diam in, ultrices sem.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (7,9,3,'2021-11-04 20:50:21','Fusce nec lacus vulputate, finibus eros eu, faucibus sapien.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (40,117,1,'2021-11-09 08:16:57','Aenean ultricies justo nec efficitur lacinia.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,9,7,'2021-11-20 09:20:01','Quisque vel diam accumsan, placerat mi sed, mattis quam.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (49,80,7,'2021-11-28 17:08:27','Nulla eget ipsum at sapien consequat sodales et sit amet enim.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (6,4,3,'2021-11-14 06:00:26','Fusce bibendum leo lobortis mauris rutrum, quis tincidunt tortor auctor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (65,41,7,'2021-11-03 10:39:13','Integer non neque non quam ullamcorper varius.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (10,28,1,'2021-11-15 10:54:29','Sed placerat eros at mollis pharetra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (84,119,3,'2021-11-13 14:28:28','Nulla at nisl scelerisque risus lobortis lacinia.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (28,45,7,'2021-11-15 10:32:44','Etiam molestie diam aliquet nisl tempus semper.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,118,1,'2021-11-09 19:58:57','Praesent mollis ex id imperdiet gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (25,22,3,'2021-11-15 20:35:23','Donec eleifend enim nec ultrices sagittis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (94,115,2,'2021-12-06 11:52:22','Aliquam volutpat ipsum non lorem tincidunt, at porttitor sapien aliquet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (79,95,1,'2021-11-04 20:29:46','Duis a turpis quis sapien molestie efficitur vitae iaculis elit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (36,28,3,'2021-11-28 13:24:58','In porta massa molestie interdum hendrerit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,15,2,'2021-12-11 18:18:00','Integer in risus nec lorem bibendum tempus ut sit amet neque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (65,8,1,'2021-11-07 19:34:19','Nam ultricies risus sed mi tempus scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,51,3,'2021-11-29 20:56:33','Ut vehicula neque id nisi pulvinar, sed egestas mi sollicitudin.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (3,87,7,'2021-11-05 14:02:15','Ut sed lacus nec sapien rutrum aliquam et quis tortor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (54,36,2,'2021-12-04 07:13:09','Pellentesque lobortis nisi eu malesuada pharetra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (88,78,2,'2021-12-02 15:46:13','Nam euismod metus eu enim interdum, nec congue purus maximus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (22,30,1,'2021-11-06 12:49:49','Duis sed purus sollicitudin, volutpat augue sagittis, sodales nulla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (12,103,7,'2021-11-13 20:46:19','Aliquam vel velit convallis, cursus risus vel, viverra eros.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (93,113,2,'2021-12-02 17:23:34','Sed varius ligula sit amet lacus aliquam efficitur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (18,7,3,'2021-11-16 16:08:33','Mauris a mi interdum, sodales urna nec, euismod urna.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (78,113,1,'2021-12-02 14:49:21','Nam vitae mauris vulputate, hendrerit turpis sed, feugiat tellus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (41,87,7,'2021-11-08 19:37:38','Vestibulum aliquet lorem eu ornare convallis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (72,48,2,'2021-11-14 06:58:11','Pellentesque gravida mauris id mi hendrerit, ut rutrum felis venenatis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (33,44,1,'2021-11-28 13:17:37','Phasellus luctus urna ac ante maximus vehicula.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (1,98,1,'2021-11-21 06:07:21','Fusce ac ante posuere ipsum volutpat pellentesque eu sit amet massa.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (75,12,2,'2021-11-24 12:55:44','Praesent tristique nunc eu dui malesuada, id ultricies sapien lacinia.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (59,16,7,'2021-11-17 11:33:04','Vivamus nec tortor sed enim efficitur ultricies.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (53,73,1,'2021-12-09 10:51:53','Integer quis leo id risus rutrum facilisis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (16,67,1,'2021-11-08 17:25:26','Nulla a erat feugiat, dignissim ligula eget, lobortis purus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (47,82,1,'2021-11-26 08:49:38','Praesent porttitor neque quis risus ultricies, eget accumsan neque sollicitudin.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,72,2,'2021-11-06 19:09:33','In et felis nec mi efficitur imperdiet.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (20,32,2,'2021-11-09 13:09:50','Ut rhoncus orci id malesuada convallis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (3,66,3,'2021-11-20 15:24:55','Phasellus placerat dui ut leo pellentesque pellentesque.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (71,87,3,'2021-12-06 11:43:00','Pellentesque efficitur tortor vel luctus posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (38,114,1,'2021-11-15 08:45:27','Ut quis eros consectetur, fermentum ligula ac, auctor velit.',1);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (5,7,3,'2021-12-09 17:17:40','Praesent mattis ligula vel purus egestas, a ultricies lorem gravida.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (53,97,1,'2021-11-18 20:05:34','In dapibus tortor ac mollis vestibulum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (54,75,7,'2021-11-13 06:22:02','Integer in leo malesuada, laoreet nisi ac, imperdiet risus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (9,36,2,'2021-12-05 10:59:48','Vestibulum pretium risus eget finibus cursus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (42,121,2,'2021-11-25 14:32:04','Mauris eget quam placerat, elementum libero at, lobortis arcu.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (82,117,2,'2021-11-20 19:24:49','Donec sagittis tellus nec magna porta placerat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (62,40,3,'2021-12-07 11:44:18','Aliquam euismod ipsum eget mauris dictum, sit amet posuere purus suscipit.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,88,2,'2021-11-28 20:27:53','Proin consectetur ex eu massa aliquet consectetur.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (63,49,7,'2021-11-18 20:12:03','Pellentesque porttitor sem id sem vestibulum, sit amet mollis magna interdum.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (92,35,7,'2021-11-11 20:16:39','Mauris et leo non sem congue ultricies id in nisi.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (15,90,7,'2021-11-28 11:39:42','Aliquam id quam a tellus malesuada tincidunt eget et odio.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (10,94,3,'2021-11-04 13:51:45','Maecenas pretium eros a egestas posuere.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (90,112,7,'2021-12-06 20:52:05','Duis eu sapien hendrerit, hendrerit turpis ut, consequat erat.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,10,3,'2021-11-12 19:21:04','Quisque convallis risus in libero cursus pharetra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (57,120,3,'2021-11-15 19:11:17','Curabitur blandit turpis ac mauris iaculis, vel hendrerit diam ultrices.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (5,12,1,'2021-11-21 08:27:19','Pellentesque ultricies ante non eros cursus, in molestie nisi iaculis.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (29,103,1,'2021-11-02 09:37:35','Donec ac sem et quam aliquet tempus a vitae lectus.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (82,17,3,'2021-12-11 10:36:55','Morbi ac tellus eu urna laoreet dignissim.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (48,38,7,'2021-12-09 09:33:33','Phasellus ac neque a tortor molestie venenatis sit amet et enim.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (91,55,7,'2021-11-19 06:27:22','Etiam elementum leo vel sodales tempor.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (81,15,7,'2021-11-25 17:32:56','Phasellus cursus nunc quis nulla accumsan viverra.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (64,117,1,'2021-11-11 08:30:55','Phasellus ultrices orci dapibus posuere fringilla.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (76,52,3,'2021-12-04 14:19:24','Praesent interdum urna euismod sapien ullamcorper, nec tempus orci tincidunt.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (76,91,7,'2021-12-11 18:30:06','Morbi consectetur purus in sem aliquet, eu finibus diam scelerisque.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (35,62,7,'2021-11-11 06:13:41','Maecenas pulvinar ipsum vel magna ultrices semper.',2);
INSERT INTO BaoCaoNhaTro (ma_nd,ma_nt,ma_lbc,ngay,lydobaocao,trangthaibaocao) VALUES (39,38,7,'2021-11-05 06:38:53','Aliquam mollis nisl sed nulla vehicula tristique.',2);

INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (79,81,5,'2021-11-15 07:28:25','In ac lacus nec ex blandit auctor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (91,9,4,'2021-11-15 06:06:29','Vestibulum vitae mauris posuere, faucibus augue non, dictum risus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (44,90,7,'2021-12-04 11:45:27','Praesent in ipsum ultricies, congue ipsum sed, facilisis enim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (63,73,5,'2021-11-22 20:19:32','Proin feugiat magna a purus volutpat porttitor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (62,27,5,'2021-12-01 16:51:10','Praesent ultrices turpis ac nulla aliquam, fermentum vulputate justo efficitur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (76,72,5,'2021-12-10 21:32:50','Nam rhoncus risus a suscipit faucibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (62,18,4,'2021-11-27 21:42:46','Sed tristique nibh in mi commodo, et egestas velit tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (68,19,4,'2021-11-30 10:18:37','Ut imperdiet massa ut elit pharetra, a tempus risus iaculis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (40,37,4,'2021-11-17 10:37:21','Nulla in purus aliquam, convallis sapien ac, pretium elit.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (51,72,4,'2021-12-09 15:45:30','Duis consectetur diam et gravida scelerisque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (10,13,6,'2021-12-01 06:37:09','Praesent at mauris eget nulla ultrices maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (5,27,7,'2021-11-10 20:21:59','Sed fermentum metus eget elementum faucibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (29,15,4,'2021-12-10 14:21:42','Phasellus ac orci in libero faucibus finibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (93,41,7,'2021-12-10 14:24:52','Etiam consequat neque pellentesque metus ultricies placerat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (75,3,5,'2021-11-08 18:57:01','Fusce non ipsum consectetur, viverra mauris quis, dignissim orci.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (49,11,4,'2021-11-27 08:05:00','In posuere turpis condimentum pulvinar accumsan.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (16,22,5,'2021-11-22 17:35:05','Cras eget elit quis tellus aliquam tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (14,14,6,'2021-11-21 13:20:47','Praesent non nunc id erat imperdiet dignissim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,23,5,'2021-12-03 16:20:21','Mauris in risus eget lectus dapibus cursus in nec lacus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (7,2,6,'2021-11-23 10:36:37','Vestibulum id nisl volutpat, aliquam diam et, malesuada nisi.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (53,88,7,'2021-11-29 18:43:55','Aliquam pharetra purus nec orci tempor, eget interdum tellus facilisis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,40,4,'2021-12-01 14:49:55','Sed varius nisl et iaculis euismod.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (28,63,5,'2021-11-22 16:07:41','Cras nec sem tempus, scelerisque dolor non, volutpat nisi.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (31,80,4,'2021-11-13 18:14:50','Duis vitae nibh nec ligula dictum auctor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (17,54,5,'2021-11-14 15:44:30','Donec tincidunt quam non lacus imperdiet consequat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (6,32,5,'2021-12-10 13:14:44','Quisque ac nibh in diam viverra ultricies.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,24,7,'2021-11-18 10:55:47','Morbi ullamcorper augue eu lorem ultricies dignissim vitae vitae dui.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,64,7,'2021-11-08 18:23:37','Mauris id quam nec massa pharetra interdum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (75,68,4,'2021-12-07 09:40:19','Etiam mattis nibh vitae neque vehicula, eget blandit arcu malesuada.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (60,39,4,'2021-12-02 20:35:40','Vivamus at ante id mi scelerisque sollicitudin in at augue.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (24,8,4,'2021-11-18 12:02:10','Donec fringilla dui ut erat venenatis pretium.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (90,86,4,'2021-11-12 09:10:57','Sed finibus mauris nec velit ornare sodales.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (40,16,5,'2021-11-15 19:42:58','Curabitur nec metus eu neque ornare vehicula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (84,32,4,'2021-11-19 15:17:25','Proin facilisis massa sit amet mauris maximus pretium.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (84,60,4,'2021-12-07 20:02:59','Aenean maximus nulla in ante lobortis, eu posuere velit posuere.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,5,6,'2021-11-05 11:32:38','Integer sollicitudin lorem et quam interdum volutpat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (47,40,7,'2021-12-09 10:46:42','Quisque pulvinar nisl sed mauris lobortis dictum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,84,6,'2021-11-12 20:05:34','Fusce sit amet orci semper massa pellentesque commodo sit amet vel nunc.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (75,84,5,'2021-12-06 14:58:51','In sagittis quam eget sapien porta gravida.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (58,23,5,'2021-11-26 17:08:53','Fusce ac turpis at turpis consequat pellentesque et at eros.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (29,4,6,'2021-12-08 21:02:53','Nulla fermentum sapien vitae accumsan placerat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (31,68,4,'2021-11-23 16:13:44','Cras varius nulla vitae volutpat tempor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (68,56,4,'2021-12-03 19:47:08','Nullam auctor dui tincidunt ante euismod iaculis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (12,19,4,'2021-11-28 13:55:12','Etiam molestie odio quis purus eleifend, vitae auctor ante porta.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (37,21,4,'2021-11-16 19:21:56','Nam condimentum libero in eros lacinia, at consectetur dolor faucibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,26,6,'2021-12-11 06:50:24','Suspendisse auctor quam non magna ullamcorper euismod.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (25,25,6,'2021-11-13 06:01:52','Mauris in est id nibh volutpat dignissim quis in purus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (56,4,4,'2021-11-03 18:52:25','Quisque ornare elit at orci auctor vehicula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (46,23,5,'2021-11-07 21:20:01','Fusce sit amet sem a dolor gravida auctor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (87,2,4,'2021-12-08 17:56:15','Maecenas a nibh vitae mi tristique suscipit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,42,5,'2021-11-15 20:01:24','Morbi tempor turpis volutpat felis vulputate fringilla.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,21,4,'2021-12-10 15:37:26','Fusce placerat turpis sit amet convallis mollis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (37,1,5,'2021-12-04 14:03:50','Donec id ante vel sapien elementum convallis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,7,5,'2021-11-04 09:31:06','Curabitur at eros fermentum, imperdiet nisl non, pulvinar arcu.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (55,12,4,'2021-11-16 21:00:35','Nullam porttitor erat eu nunc suscipit facilisis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (89,33,7,'2021-11-15 11:20:24','Duis eu eros in mauris semper faucibus.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (85,31,4,'2021-12-11 08:16:57','Donec in erat id ex vehicula eleifend.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (59,83,4,'2021-11-27 20:02:41','Pellentesque porttitor velit et enim vestibulum tempor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (59,36,5,'2021-11-30 09:28:48','Proin ac ipsum at diam commodo placerat quis in erat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,4,6,'2021-11-03 07:00:29','Aliquam placerat est nec diam vestibulum, vitae pretium justo laoreet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (84,17,4,'2021-11-10 14:09:19','Integer at mauris in elit egestas ullamcorper a quis enim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (52,30,7,'2021-11-30 06:07:29','Nullam in augue in ipsum volutpat faucibus vel id turpis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (3,24,5,'2021-11-08 18:22:19','Pellentesque eu eros vitae lorem varius pellentesque ut a erat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (64,17,5,'2021-11-05 20:21:59','Mauris porttitor turpis quis venenatis maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,53,6,'2021-11-29 21:27:22','Mauris feugiat mauris a finibus bibendum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (85,38,7,'2021-11-03 16:35:28','Suspendisse a augue feugiat, tincidunt libero quis, venenatis orci.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,47,5,'2021-12-08 18:26:47','Aliquam non purus et justo finibus scelerisque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,14,4,'2021-11-23 09:40:19','In semper metus congue sapien accumsan, non auctor purus scelerisque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,50,6,'2021-12-08 19:07:58','Donec eget neque et urna tempus consequat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,25,7,'2021-11-23 18:49:58','Nunc sollicitudin arcu et justo fermentum, sit amet feugiat massa porttitor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (31,61,4,'2021-12-03 09:57:01','Curabitur rhoncus est eget metus faucibus mattis id vitae lectus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (58,50,5,'2021-11-06 09:46:05','Mauris at turpis at est porta efficitur ac id nisl.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (27,55,5,'2021-11-19 07:36:46','Donec mattis velit in nisl porttitor iaculis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (88,89,6,'2021-11-23 10:20:47','Pellentesque feugiat ante sit amet vehicula congue.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (26,13,4,'2021-11-20 09:25:29','Integer eu diam a metus euismod commodo ut sit amet elit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (52,92,6,'2021-11-26 14:17:05','Suspendisse ullamcorper risus sit amet orci iaculis imperdiet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (66,46,7,'2021-11-11 15:07:03','Nam iaculis neque quis vehicula posuere.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (80,72,4,'2021-11-30 07:00:03','In vitae ligula ornare, ullamcorper nulla sit amet, porta neque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (45,3,5,'2021-11-20 07:47:08','In sed ante id elit ultricies commodo eu molestie eros.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (23,56,7,'2021-11-12 18:48:14','Proin sed metus porta enim hendrerit dapibus.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (69,74,5,'2021-11-09 14:03:50','Sed commodo lacus et ligula facilisis bibendum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (22,24,6,'2021-11-02 20:20:07','Vestibulum elementum nibh sit amet nisl interdum molestie ut ut mi.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,29,5,'2021-12-02 11:59:43','Sed fermentum ante ac ligula finibus interdum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,24,7,'2021-12-09 12:50:24','Sed et orci et dui posuere convallis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,86,5,'2021-11-08 20:35:40','Donec ac nunc non orci tempus condimentum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,2,6,'2021-11-29 14:53:48','Praesent elementum lacus nec scelerisque consequat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,11,5,'2021-11-14 10:06:23','Integer nec lacus bibendum nibh bibendum pulvinar.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (17,73,5,'2021-12-04 11:17:05','Praesent nec velit malesuada, malesuada nulla vitae, convallis erat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (5,35,7,'2021-11-24 12:44:30','Duis at urna ac nunc elementum imperdiet eu id justo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,59,7,'2021-11-28 08:30:29','Sed sollicitudin eros sed mi tristique auctor id vel sapien.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (44,7,5,'2021-11-13 17:16:31','In feugiat sem et vestibulum scelerisque.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,37,6,'2021-11-12 12:31:06','Cras porta massa a tortor cursus, ac pharetra sapien dignissim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (69,60,7,'2021-11-15 06:25:55','Fusce eget libero quis tortor tempor lobortis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (46,57,6,'2021-12-10 06:08:47','Proin commodo quam vitae dolor tincidunt vestibulum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (80,78,4,'2021-11-26 20:27:27','Praesent lobortis nunc nec feugiat laoreet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (40,71,6,'2021-11-12 11:38:07','Aliquam quis ipsum quis quam ultrices commodo.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (7,34,6,'2021-11-03 20:27:10','Proin efficitur arcu quis arcu venenatis, at eleifend eros rhoncus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,61,4,'2021-12-09 12:05:20','Etiam iaculis ipsum ut lacus convallis vestibulum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (84,14,6,'2021-11-01 12:40:54','Nulla mollis dui et tincidunt pharetra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,1,6,'2021-12-02 18:30:58','Quisque gravida erat eu orci faucibus, in rutrum ligula vulputate.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (93,71,7,'2021-12-02 11:29:11','Morbi pharetra massa sed urna volutpat, eu molestie nisl imperdiet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (67,83,7,'2021-12-07 12:22:45','Nullam bibendum velit vitae urna posuere imperdiet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (71,49,5,'2021-12-02 12:19:52','Ut et libero lobortis, dignissim neque a, consectetur leo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (53,87,5,'2021-11-03 21:04:02','Sed mattis enim vitae felis condimentum, id fringilla est feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,9,5,'2021-11-20 09:21:36','Integer id dui pretium, lobortis magna ac, faucibus elit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (50,60,7,'2021-11-25 16:51:53','Aenean malesuada nibh non dui mattis, pharetra consequat tellus congue.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (34,74,7,'2021-12-09 18:02:18','Mauris pellentesque metus non nunc luctus, sed auctor massa vulputate.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (60,92,6,'2021-12-07 07:08:15','Ut venenatis metus in euismod finibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,45,6,'2021-11-14 21:16:16','Integer sollicitudin urna laoreet lacus bibendum volutpat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,27,6,'2021-11-23 15:56:36','Integer egestas nisi at est venenatis, vitae pharetra tortor suscipit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (74,31,5,'2021-11-22 06:03:01','Nam a sem et tortor dignissim rutrum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (69,8,7,'2021-11-13 13:35:20','Curabitur imperdiet enim vel blandit commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (11,92,7,'2021-11-23 06:40:54','Sed at nisl id dolor tempor dapibus consequat nec velit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (33,25,7,'2021-11-25 17:11:46','Nulla vel nisl semper, tristique tellus ut, scelerisque velit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (52,12,4,'2021-11-11 16:01:12','Nam vestibulum ligula pulvinar, vestibulum turpis in, aliquet lorem.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (24,17,6,'2021-11-16 17:32:47','Aenean sed nunc rutrum, tristique orci vel, viverra urna.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,29,4,'2021-11-07 18:22:02','Proin semper urna tincidunt nisl feugiat, eu dapibus leo tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (13,1,6,'2021-11-09 12:41:46','Ut quis magna auctor massa gravida dictum in eu eros.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (26,25,4,'2021-12-02 06:59:02','Integer ut orci interdum, auctor nisi eget, ultricies eros.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (4,46,4,'2021-11-23 11:10:11','Donec ac odio nec lorem fermentum fermentum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (70,4,4,'2021-12-02 21:14:33','Pellentesque consectetur magna non ligula fermentum scelerisque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (67,5,4,'2021-11-15 15:28:22','Duis ut odio sit amet turpis eleifend molestie in ac erat.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (62,16,6,'2021-11-16 07:41:40','Maecenas efficitur elit et dolor aliquam, a commodo tellus finibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,63,6,'2021-11-26 21:43:29','In facilisis leo in sagittis euismod.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (13,59,6,'2021-11-05 08:41:34','Nullam luctus justo eget massa pretium, vitae interdum odio pharetra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (86,61,6,'2021-11-24 13:14:53','Suspendisse at augue id erat sagittis pharetra sit amet vel urna.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (5,75,7,'2021-12-08 21:35:51','Praesent dictum nibh porta accumsan auctor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (71,24,4,'2021-11-16 09:39:45','Curabitur in nulla dictum, eleifend ligula in, porttitor purus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (14,3,5,'2021-11-22 13:35:02','Etiam semper urna et purus lacinia pharetra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,50,5,'2021-11-19 09:55:52','Aliquam lobortis nibh a orci porttitor accumsan.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (16,67,6,'2021-11-07 19:11:00','Mauris consequat libero ut odio luctus, ut placerat tortor facilisis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (19,36,5,'2021-11-10 16:47:17','Curabitur ut velit fermentum ex scelerisque dignissim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,47,7,'2021-12-03 20:11:28','Vivamus finibus eros in nibh lacinia maximus id sit amet arcu.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (89,45,4,'2021-11-27 06:00:17','Vestibulum a ex interdum, ultrices nunc gravida, venenatis lacus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (66,14,6,'2021-11-18 06:24:03','Etiam imperdiet purus vitae placerat convallis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (29,62,6,'2021-11-27 07:55:47','Nunc et neque quis tortor efficitur porta.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (41,15,4,'2021-11-23 14:38:41','Ut eu sapien a urna venenatis rutrum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,4,6,'2021-11-03 07:56:21','Ut suscipit risus vitae felis sodales, a semper enim interdum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,50,5,'2021-11-21 12:18:52','Maecenas rutrum elit sit amet enim ultricies posuere.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,57,4,'2021-11-14 16:04:39','Nam nec tortor semper, dictum massa mattis, volutpat risus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (92,29,6,'2021-11-30 06:05:46','Nunc lacinia purus eu est tincidunt, nec volutpat metus bibendum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,66,5,'2021-11-25 12:02:36','Nunc et sapien euismod, lobortis dolor at, pretium ligula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,14,7,'2021-11-26 10:52:28','Mauris quis nunc suscipit, gravida lectus nec, posuere diam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (15,64,5,'2021-11-08 21:22:02','Proin accumsan risus nec orci pulvinar mollis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (49,54,5,'2021-11-23 11:33:04','Donec consequat augue id ante faucibus, vel molestie dolor sagittis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (33,79,4,'2021-11-17 13:54:29','Nunc luctus mauris non ipsum consectetur, id pretium elit mattis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,67,6,'2021-11-11 17:29:20','Aliquam rhoncus turpis in scelerisque pellentesque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (5,8,6,'2021-11-11 08:45:27','Sed ut odio a nisi maximus tristique sed at velit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,10,5,'2021-11-24 17:59:08','Donec tempor dolor at tortor vulputate, sollicitudin scelerisque ex dignissim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,47,4,'2021-12-09 13:28:42','Aenean maximus dolor quis pulvinar ultrices.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (45,94,6,'2021-11-03 11:53:57','Sed auctor urna quis augue gravida, id accumsan nibh volutpat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (27,64,5,'2021-11-23 19:58:13','Praesent sodales diam ultricies, rhoncus neque sed, pellentesque turpis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (75,15,5,'2021-11-08 17:26:36','Mauris blandit nisl nec sapien imperdiet tempor ut at elit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (25,49,6,'2021-11-11 06:46:48','Vestibulum rhoncus lectus non euismod imperdiet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (3,35,7,'2021-11-12 09:44:56','Aenean non urna viverra odio tempor posuere sit amet ut risus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,85,7,'2021-11-02 15:14:59','Nullam non nulla vel sapien porta scelerisque vel in orci.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (44,74,4,'2021-12-02 11:15:22','Sed sit amet nulla luctus, finibus dolor at, aliquet ligula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (29,60,4,'2021-12-06 09:01:52','Proin tincidunt metus quis suscipit auctor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (37,80,7,'2021-12-04 09:45:04','In ut enim vel purus lobortis fermentum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,74,4,'2021-12-02 15:06:03','Nullam ut dui efficitur, pulvinar sem ut, ultricies ipsum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (60,88,7,'2021-12-07 07:28:34','Nam eu lorem ac eros rutrum feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (80,62,7,'2021-12-06 08:19:41','Vestibulum eget sem nec eros porttitor varius.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (8,14,5,'2021-11-08 07:52:36','Quisque dignissim eros quis posuere ultricies.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,72,7,'2021-11-30 07:08:59','Nulla vel nisi ac est porta cursus ut at magna.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,27,4,'2021-11-14 20:00:14','Mauris quis tortor eu elit ornare rhoncus et finibus nunc.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (77,82,5,'2021-11-24 17:48:46','Aliquam laoreet purus sit amet mollis consectetur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (44,13,4,'2021-11-01 21:57:01','Ut laoreet lorem nec tellus efficitur sollicitudin.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (28,10,5,'2021-12-05 12:50:15','Integer accumsan tellus ac dapibus interdum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (65,81,4,'2021-11-25 09:16:51','Mauris gravida nulla ac sodales hendrerit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (90,64,7,'2021-11-10 16:03:39','Mauris tincidunt dolor sed placerat dapibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (87,85,5,'2021-11-21 19:51:45','Phasellus vestibulum elit nec quam tempus ultricies.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (77,42,5,'2021-11-08 07:59:23','Pellentesque rutrum libero ac accumsan commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (4,17,4,'2021-11-10 18:35:34','Sed id arcu sed quam porta dictum ut ut tellus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (46,13,7,'2021-11-30 14:35:57','Aenean dictum ex tempus lectus interdum, sed semper lacus tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,15,5,'2021-11-16 16:05:23','Aliquam lacinia nisi sit amet suscipit lacinia.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (40,23,7,'2021-11-06 07:55:55','Nunc egestas nibh quis metus dapibus, vitae auctor dui feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,10,5,'2021-11-08 12:22:45','Curabitur facilisis dui eget pulvinar rutrum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (63,75,5,'2021-11-19 07:51:01','Aliquam porta erat ac fermentum efficitur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (42,49,4,'2021-12-07 13:37:55','Nam gravida lectus et ante tincidunt rutrum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,67,4,'2021-11-10 11:31:29','Mauris tincidunt nulla sed volutpat ultrices.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (12,73,7,'2021-11-30 20:44:53','Proin id purus non dolor convallis tincidunt eu in ligula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (85,29,4,'2021-11-20 09:09:04','Donec sit amet augue a ex viverra egestas.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,60,5,'2021-12-06 20:29:02','Integer consectetur ligula sit amet nunc gravida, eu tristique purus maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (60,69,6,'2021-11-05 13:35:11','Curabitur tincidunt odio pretium dictum mollis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,37,7,'2021-12-10 18:11:14','Nulla molestie urna rhoncus dui bibendum sollicitudin.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (21,43,6,'2021-11-14 16:26:50','Nullam placerat ex a massa fringilla, at aliquet elit mattis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,20,4,'2021-11-03 20:59:34','Aenean id mauris eu neque tincidunt aliquet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (75,21,7,'2021-11-29 11:31:12','Praesent nec mi feugiat purus eleifend rhoncus sit amet eu purus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (41,68,4,'2021-11-08 15:04:28','Proin faucibus neque at facilisis auctor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (12,54,6,'2021-11-30 09:28:13','Praesent aliquam ex sit amet elementum convallis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (64,86,5,'2021-11-13 11:00:58','Aenean sollicitudin felis eu augue vestibulum, sit amet rutrum dolor scelerisque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (79,42,5,'2021-12-09 16:03:13','Etiam eleifend ante ut odio convallis fringilla.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,78,5,'2021-11-10 13:30:26','Sed gravida risus sit amet tortor tincidunt vestibulum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (21,90,5,'2021-11-03 09:15:59','Nam blandit arcu vitae massa accumsan, eget volutpat ligula finibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (71,16,5,'2021-11-10 18:32:07','Nulla elementum dolor iaculis, ultrices eros a, aliquet nisl.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,85,5,'2021-11-12 20:06:00','Nunc vel ligula vitae velit accumsan pretium.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (58,25,6,'2021-11-19 21:11:48','Nam auctor diam non elit facilisis, vitae efficitur augue lacinia.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,13,6,'2021-11-08 20:35:57','Etiam imperdiet mauris nec orci commodo, in mattis eros hendrerit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (59,24,5,'2021-11-07 06:14:07','Nam in elit sagittis, condimentum nibh eu, efficitur ante.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (12,35,5,'2021-12-08 07:40:57','Donec consequat urna eget nulla commodo, auctor sodales sem facilisis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (35,40,6,'2021-11-26 12:28:13','In nec est dapibus, aliquet neque quis, semper odio.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (8,6,7,'2021-12-09 15:44:47','Proin non ex sed diam aliquet lobortis a id ante.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (44,14,5,'2021-11-09 17:00:58','Quisque gravida erat laoreet sem pretium, at accumsan felis varius.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (47,74,7,'2021-11-14 14:35:57','Vivamus condimentum nisi et lectus sollicitudin, vitae euismod lorem pretium.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,80,6,'2021-11-06 08:57:59','Sed tristique augue quis maximus lobortis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (23,30,5,'2021-11-29 12:39:53','Aliquam et neque sit amet urna rutrum porta.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (74,32,5,'2021-11-19 10:26:59','Morbi in nisl vestibulum, feugiat enim eget, feugiat libero.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (58,9,4,'2021-12-11 11:54:14','Mauris convallis velit sed condimentum efficitur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (40,80,4,'2021-11-16 08:27:19','Donec nec lectus sed magna tempor commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (66,26,4,'2021-11-20 09:52:16','Nulla nec lacus accumsan, accumsan mauris id, eleifend ex.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (26,91,6,'2021-11-25 08:59:25','Cras ultricies purus ac est pellentesque, vitae bibendum arcu vulputate.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (26,30,6,'2021-11-24 14:32:56','Nam hendrerit ex a blandit consectetur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (64,34,5,'2021-11-21 06:38:01','Ut ultrices magna eget mauris sodales, sit amet ultricies lectus commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (58,14,6,'2021-11-18 09:28:31','Duis dapibus elit fermentum, sagittis metus at, efficitur elit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (13,55,7,'2021-11-11 16:03:56','Donec suscipit elit eu facilisis porttitor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (7,3,4,'2021-11-28 09:44:56','Duis porta sapien non bibendum tincidunt.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,45,4,'2021-11-11 07:16:02','Proin egestas turpis ac ligula efficitur dictum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (76,93,6,'2021-11-09 20:48:20','In vel quam nec eros ultricies condimentum id quis orci.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (22,3,7,'2021-12-02 12:33:42','Morbi nec urna vitae sapien finibus efficitur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (66,11,4,'2021-11-16 09:13:32','Aenean vulputate risus vitae lectus lacinia, ac tincidunt leo blandit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (93,1,7,'2021-11-21 18:18:35','Mauris quis augue dictum, mollis ligula sed, porta elit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,11,5,'2021-11-05 17:28:19','Aliquam sed nibh nec nulla luctus maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,46,4,'2021-12-03 19:34:36','Nunc iaculis neque vitae tellus euismod fringilla.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,32,7,'2021-11-27 18:24:12','Aliquam nec dolor ut nisi blandit gravida ac in felis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (85,25,7,'2021-11-17 16:23:57','Nulla lobortis nulla et nisl faucibus congue.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,23,6,'2021-12-01 07:17:02','Nam commodo purus sit amet elit tempor sodales.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (91,31,5,'2021-11-21 16:49:18','Maecenas molestie dolor volutpat, tempor ligula vel, mattis odio.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (25,44,6,'2021-11-21 13:41:23','Mauris et elit sed massa vehicula ultricies.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (42,73,6,'2021-12-09 17:24:52','Maecenas egestas augue id dapibus commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (41,20,4,'2021-11-13 17:00:49','Nulla laoreet purus eget fringilla interdum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (69,8,4,'2021-11-06 18:27:39','Proin hendrerit massa vel sodales suscipit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (37,25,4,'2021-11-01 15:49:58','Vestibulum non urna eleifend, scelerisque augue vitae, dapibus nisi.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (35,92,4,'2021-11-10 12:11:48','Etiam feugiat magna a vulputate maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,26,4,'2021-12-04 10:26:24','Nam luctus ipsum consectetur velit pellentesque eleifend.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (51,66,6,'2021-11-01 06:49:06','Curabitur accumsan mauris a sem aliquet, non mattis elit varius.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (80,80,5,'2021-11-07 10:18:12','Maecenas venenatis nisi rutrum consectetur finibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (5,29,6,'2021-12-02 06:33:07','Aenean tincidunt justo at ipsum sagittis, pretium porta justo porttitor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (88,70,7,'2021-12-09 16:06:49','Sed nec arcu faucibus, maximus ante ullamcorper, varius dolor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (83,94,5,'2021-11-30 06:45:30','Vestibulum varius lectus vel enim gravida, non pharetra felis volutpat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (34,29,4,'2021-12-09 07:31:52','Nullam aliquet odio eget risus lobortis, ut dignissim eros dictum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (42,65,6,'2021-12-02 12:37:44','Curabitur rutrum velit eu lorem condimentum, in gravida velit mattis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (11,61,6,'2021-11-10 10:24:58','Donec semper nisl ut nunc ullamcorper congue.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (46,93,4,'2021-11-15 15:49:24','Nunc molestie est eu arcu pellentesque, nec tempus lacus fringilla.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (79,68,7,'2021-11-06 18:45:13','Aliquam ac velit eu massa sollicitudin tempor sed vitae dolor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (69,86,6,'2021-11-09 19:05:48','Fusce hendrerit lectus vitae ipsum venenatis, eu tincidunt leo efficitur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (50,40,6,'2021-11-29 20:26:53','Aenean in nibh euismod, facilisis ex vitae, aliquet orci.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (47,55,6,'2021-11-23 09:24:46','Etiam quis diam condimentum odio elementum fermentum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,80,5,'2021-12-02 11:07:09','Duis sit amet velit malesuada, rutrum metus ut, ultrices mi.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (76,37,4,'2021-11-29 16:35:37','Sed ac mi quis dolor malesuada tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (90,5,6,'2021-11-26 16:11:34','Sed faucibus ligula in lacus gravida venenatis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (56,79,5,'2021-11-08 16:06:06','Cras ultricies urna blandit, blandit metus non, dignissim felis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (74,12,4,'2021-12-10 20:04:34','Curabitur ultrices augue ut justo ornare gravida.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (31,23,7,'2021-11-29 09:46:31','In id erat ut sem vulputate sodales.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (83,82,4,'2021-11-29 07:54:12','Suspendisse feugiat magna vel molestie vestibulum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,92,7,'2021-11-24 17:08:10','Quisque lacinia leo ut libero finibus mattis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (40,38,7,'2021-11-20 15:53:51','Vestibulum luctus libero vitae ipsum cursus pharetra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (31,49,6,'2021-11-04 12:56:27','Curabitur ut nibh finibus, interdum felis ut, elementum erat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (18,27,5,'2021-11-12 11:38:07','Vivamus id purus id justo maximus aliquam vitae eget justo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (94,13,5,'2021-11-08 20:54:23','Donec luctus erat nec tortor suscipit, at mattis ligula pellentesque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,46,6,'2021-12-03 11:19:15','Nulla fringilla velit sed tincidunt placerat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (76,65,6,'2021-11-02 21:23:02','Donec ut orci id nisl dignissim faucibus sit amet ut lorem.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,14,5,'2021-11-28 21:35:34','Curabitur bibendum arcu ut orci sagittis maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (42,58,4,'2021-11-24 21:28:22','Etiam eget dui in magna pretium laoreet sed id metus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (59,23,5,'2021-12-02 13:41:31','Duis ac ligula placerat, facilisis sem eget, pharetra mauris.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (74,17,5,'2021-12-01 08:03:07','Curabitur quis est sit amet diam fringilla faucibus a non felis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (7,60,6,'2021-11-20 21:30:40','Sed lobortis libero vel orci auctor accumsan scelerisque eget lacus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (77,91,7,'2021-12-08 17:04:51','Sed quis mi sodales, ornare lectus eu, finibus turpis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (78,92,6,'2021-11-18 19:37:12','Mauris cursus risus vitae ligula laoreet, sed tempor elit vestibulum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (65,76,4,'2021-11-21 19:00:29','Aenean a risus id sapien lacinia pharetra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,44,7,'2021-11-01 06:32:59','Sed in nunc sollicitudin, pretium erat eu, aliquam enim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (15,46,7,'2021-11-08 17:10:02','Nullam nec ex a ipsum ullamcorper ullamcorper.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (84,6,4,'2021-12-07 07:42:49','Proin viverra urna et dui vulputate, ac dapibus turpis viverra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,52,6,'2021-12-09 18:59:28','Ut luctus erat facilisis suscipit varius.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (65,74,5,'2021-11-17 13:13:26','Pellentesque in metus et sapien tincidunt pellentesque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (19,86,6,'2021-12-06 10:46:08','Phasellus feugiat nisl sit amet hendrerit feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (59,16,7,'2021-12-06 14:14:12','Nulla sagittis massa eu nunc malesuada interdum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (22,24,5,'2021-11-20 16:18:37','Curabitur posuere massa quis luctus vehicula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (85,83,7,'2021-11-01 13:45:50','Quisque molestie neque ut consequat convallis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (87,69,5,'2021-11-16 13:27:42','Fusce scelerisque felis pretium, consectetur dolor a, laoreet sapien.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,78,5,'2021-12-11 06:09:04','Cras eget velit varius, varius ante eget, congue dui.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (78,62,4,'2021-11-11 12:49:06','In vitae metus at felis volutpat scelerisque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (94,6,4,'2021-12-06 09:12:14','Nullam sed diam sit amet nisl pellentesque vulputate.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (36,58,4,'2021-12-08 17:14:30','Aenean pellentesque mauris quis pretium pellentesque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (34,34,7,'2021-12-06 08:02:24','Curabitur ultricies augue nec ante hendrerit commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (41,70,6,'2021-11-23 06:22:45','Nulla eleifend odio cursus, bibendum turpis non, mattis nulla.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (6,21,4,'2021-12-09 19:52:54','Proin vel purus eget ligula blandit sollicitudin.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (89,6,4,'2021-11-12 17:15:13','Nunc sollicitudin magna nec justo euismod vestibulum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (83,28,5,'2021-12-06 16:15:53','Duis semper purus ac dui elementum maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (76,85,5,'2021-12-10 09:31:24','Duis tristique eros vel euismod ultrices.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (10,94,6,'2021-11-28 06:15:33','Sed non felis dapibus, interdum risus et, dignissim odio.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (55,72,6,'2021-11-14 08:43:52','Proin rutrum quam eu magna eleifend, non consequat massa malesuada.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (79,1,6,'2021-11-10 06:51:16','Fusce at odio nec nisi ultricies pellentesque et ut enim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (56,21,6,'2021-12-09 17:53:57','Nunc at augue ac mi auctor venenatis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (60,9,6,'2021-12-04 15:39:01','Nunc sit amet augue gravida ipsum sagittis ornare.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,93,4,'2021-11-29 16:59:40','Sed eu tellus at justo venenatis accumsan at vel nunc.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (65,76,6,'2021-12-09 08:53:57','Proin fringilla ex a lobortis tincidunt.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (65,57,6,'2021-12-11 08:17:40','Mauris vitae tellus quis dolor tristique consequat a vel turpis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (66,4,7,'2021-11-18 17:05:25','Donec at dolor at orci porttitor gravida.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (28,5,4,'2021-11-16 12:41:11','Morbi blandit lorem at ante sollicitudin convallis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (79,81,7,'2021-11-23 19:38:12','Pellentesque lacinia dolor non nulla dignissim, non efficitur magna cursus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (57,66,6,'2021-11-30 09:11:14','Etiam dictum velit vehicula elit rutrum viverra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (78,89,7,'2021-12-11 09:38:27','Morbi porttitor sapien quis maximus tempor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (15,42,6,'2021-11-06 10:32:36','Phasellus viverra elit non augue consequat feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (36,12,4,'2021-11-09 13:53:37','Maecenas convallis dui in eros molestie, ut consequat magna pretium.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (36,66,7,'2021-12-08 16:44:07','Proin porta augue sollicitudin, elementum nunc a, consequat tellus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,63,7,'2021-12-06 17:47:28','Pellentesque cursus dolor eget ultricies eleifend.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (26,47,4,'2021-12-04 15:28:22','In posuere eros non nibh pellentesque tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (84,11,4,'2021-11-24 14:38:33','Vestibulum sed lorem at ipsum congue hendrerit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (37,36,4,'2021-11-15 18:10:22','Vivamus finibus dolor sed enim accumsan, ac eleifend ligula malesuada.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (46,84,7,'2021-11-14 06:56:18','Fusce quis ex dignissim, tristique leo ut, consequat arcu.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (59,21,5,'2021-11-25 06:38:18','Donec pharetra mi non dolor tempus mattis.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (75,5,5,'2021-11-23 16:02:21','Sed et eros quis leo lacinia venenatis vitae ac libero.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (60,58,5,'2021-11-17 20:24:09','Nulla vestibulum enim quis odio pellentesque, quis congue erat accumsan.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (66,40,7,'2021-12-10 18:27:48','Vestibulum in diam eu erat rhoncus accumsan in sed quam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (70,34,4,'2021-11-03 15:40:02','Mauris vitae eros eu dolor dignissim pretium.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (29,44,7,'2021-12-05 07:26:59','Maecenas ac quam dictum, ultricies orci lobortis, facilisis massa.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (36,85,6,'2021-11-29 16:35:54','Proin bibendum tortor vel tellus euismod tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (18,25,6,'2021-11-15 12:47:57','Vivamus blandit lectus sit amet leo vulputate, sed tempus ante ullamcorper.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (4,94,4,'2021-11-22 09:56:18','Pellentesque et est mollis urna lobortis congue eget sit amet lacus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,83,4,'2021-11-19 06:47:57','Cras semper erat id placerat egestas.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (12,48,5,'2021-11-08 07:19:38','Sed quis ante a tortor rutrum molestie.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (92,8,4,'2021-11-18 12:21:36','In bibendum diam a dictum blandit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (25,72,7,'2021-11-18 15:48:14','Suspendisse accumsan erat vitae nunc condimentum elementum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (6,58,6,'2021-12-10 20:05:17','Aliquam dapibus dui sed arcu imperdiet fermentum.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (71,57,5,'2021-11-11 18:45:56','Morbi at metus vel arcu varius posuere.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (22,60,6,'2021-11-01 10:41:31','Integer placerat magna vel orci faucibus, eu tincidunt ipsum bibendum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,7,4,'2021-12-01 15:25:29','Quisque et ipsum at est consectetur egestas id ut mi.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (50,10,4,'2021-11-16 15:55:18','Mauris varius diam et turpis commodo dictum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,65,7,'2021-12-09 17:13:38','Pellentesque non leo eget quam pellentesque finibus.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,59,6,'2021-11-22 15:03:27','Quisque pharetra est vel bibendum ornare.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,89,7,'2021-11-11 06:37:52','Vivamus ac lacus rutrum, dignissim odio nec, volutpat sem.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,56,7,'2021-11-27 19:03:22','In imperdiet sem ac ex ultricies tempus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (3,32,6,'2021-11-12 20:13:47','Sed nec neque sit amet turpis fermentum sodales a non lectus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (44,92,7,'2021-12-02 16:50:01','Nulla nec est rutrum sapien ultrices scelerisque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,61,4,'2021-11-13 13:26:41','Nam condimentum dui ut velit vestibulum interdum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,90,7,'2021-11-20 17:29:54','Integer lacinia velit vel tincidunt posuere.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (14,36,5,'2021-11-24 10:20:56','Fusce commodo odio congue, feugiat purus a, tempor massa.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,57,4,'2021-11-08 12:10:57','Sed bibendum dolor aliquam volutpat feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,84,7,'2021-11-17 16:45:07','Pellentesque ac leo sit amet mauris venenatis egestas at quis mauris.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (63,46,6,'2021-11-20 11:48:20','In non tellus et ex mattis malesuada at imperdiet ante.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,22,4,'2021-11-13 19:22:22','Fusce quis lorem a nisi aliquet sagittis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (50,83,7,'2021-11-12 18:20:18','Maecenas vehicula orci in convallis rutrum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (68,27,6,'2021-11-13 14:04:42','Donec auctor erat vitae odio sodales convallis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,53,7,'2021-11-01 14:38:07','Fusce nec lorem feugiat, blandit massa quis, interdum nunc.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (8,29,4,'2021-11-28 15:34:16','Nulla luctus purus at justo condimentum, at consectetur ligula euismod.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (35,57,6,'2021-12-09 10:17:28','Etiam pretium nisi id risus condimentum, a rhoncus orci commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (74,58,7,'2021-12-03 13:21:13','Curabitur non ex vel nibh commodo fringilla quis eget diam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,18,4,'2021-11-15 13:17:02','Vestibulum consequat mi ornare, placerat lacus in, euismod quam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (25,34,4,'2021-11-10 07:42:49','Ut ultrices massa vel felis egestas bibendum eu in quam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (79,79,5,'2021-11-10 19:03:48','Aenean malesuada ligula sed augue placerat, in interdum elit finibus.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (28,89,7,'2021-11-11 07:37:55','Duis pretium est in libero tempus facilisis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (17,43,6,'2021-11-19 19:03:13','Donec vulputate tellus ac libero dapibus, eget molestie lectus maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,77,4,'2021-12-05 14:01:49','Sed aliquet mauris eu ullamcorper pharetra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (74,84,7,'2021-11-20 17:26:36','Aenean eget turpis non risus consequat iaculis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (24,88,4,'2021-11-09 10:47:08','Donec eu leo dapibus, porta ex eget, dapibus nulla.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (92,45,5,'2021-11-01 21:36:17','Duis nec ipsum sit amet arcu fermentum auctor id non libero.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (49,56,7,'2021-11-18 14:23:51','Sed interdum magna at posuere rutrum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (14,7,7,'2021-11-28 18:09:56','Sed imperdiet neque a accumsan tempor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (6,91,6,'2021-12-09 14:18:06','Mauris dapibus augue ut tortor aliquam dictum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (31,13,7,'2021-12-06 12:04:45','Ut viverra nibh at pellentesque blandit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (85,59,6,'2021-11-05 17:15:22','Donec quis neque sed sapien laoreet vehicula at non augue.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,11,6,'2021-11-02 14:22:08','Sed eu ipsum ut urna accumsan feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (68,70,4,'2021-12-08 09:16:51','Aliquam nec arcu sed magna varius vehicula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,58,5,'2021-11-05 20:27:27','Maecenas nec nunc semper, eleifend turpis eget, lobortis odio.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (18,79,5,'2021-11-21 20:24:52','Aliquam non augue mattis, pretium ante ac, hendrerit tellus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (54,61,7,'2021-11-28 10:42:06','Integer sagittis eros quis metus viverra sodales.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,81,6,'2021-12-09 08:01:58','Nullam non enim pulvinar, fermentum mi sed, ultricies urna.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (65,54,7,'2021-11-02 13:54:55','Praesent id odio congue, bibendum nulla id, posuere mauris.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (33,54,7,'2021-11-20 20:20:41','Morbi at eros nec ligula tincidunt ultrices vel vel justo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (56,25,5,'2021-11-11 11:52:48','Proin in odio lacinia, fringilla ante vitae, eleifend nisl.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (40,43,7,'2021-12-10 20:43:44','In vulputate ligula at lacus mattis laoreet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (43,18,5,'2021-12-06 06:25:47','Donec ut nunc a augue lobortis fringilla vel in mauris.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (20,10,4,'2021-11-05 10:56:12','Praesent ac leo scelerisque, volutpat sem nec, aliquam mi.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,23,6,'2021-11-24 15:58:28','Sed eget metus aliquet, mattis libero non, mollis eros.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (68,83,5,'2021-11-04 16:49:52','Maecenas porttitor est et ex mollis tincidunt.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (8,63,6,'2021-11-04 15:44:47','Praesent venenatis nisl eu nisi faucibus fermentum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (93,93,6,'2021-11-28 08:33:39','Aliquam pharetra diam sit amet quam varius, eu luctus ex placerat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (39,50,5,'2021-11-24 07:10:16','Nullam venenatis diam a diam rhoncus tempor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,49,4,'2021-12-03 19:37:38','Cras eu neque quis est volutpat luctus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (94,33,5,'2021-11-07 15:41:37','Praesent aliquam ex sed dapibus aliquam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (91,94,6,'2021-11-18 20:32:12','Nam ac nulla quis mi placerat ornare tempor porttitor ipsum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (47,43,7,'2021-11-29 13:40:22','Nam consectetur metus id volutpat convallis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (47,61,7,'2021-11-04 06:03:27','Nulla bibendum diam sed magna sagittis tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (4,50,4,'2021-12-01 21:58:54','Integer vitae justo ut quam interdum imperdiet quis eu neque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (19,63,6,'2021-12-02 14:59:51','Integer et enim varius, ornare sem vel, iaculis sapien.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (17,32,7,'2021-11-14 08:26:18','Donec bibendum libero et urna eleifend sagittis eget ut risus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (11,93,4,'2021-11-10 06:07:47','Sed ullamcorper ex vitae aliquet iaculis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,11,4,'2021-11-27 21:20:18','Mauris tristique purus non ex accumsan, vel pharetra justo ultricies.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (71,28,4,'2021-12-08 17:29:28','Sed lobortis urna posuere, molestie sem non, dignissim diam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (27,94,5,'2021-11-05 17:16:48','Maecenas gravida lorem ut magna mattis tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (5,22,6,'2021-12-05 14:53:31','Aliquam scelerisque lectus et nisl accumsan, in pulvinar dui iaculis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (24,25,7,'2021-11-13 15:08:38','Donec in lectus in lacus ornare dapibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (71,48,5,'2021-11-19 21:27:39','Donec varius elit sed tincidunt cursus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (57,5,5,'2021-11-26 20:32:21','Aliquam venenatis tortor tristique blandit cursus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,83,6,'2021-12-09 08:42:00','Etiam egestas arcu ut posuere mattis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (52,61,4,'2021-12-07 10:22:22','Nunc quis tortor facilisis dolor commodo tincidunt.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (80,22,6,'2021-11-30 14:42:17','Proin convallis ex vitae tortor efficitur, id malesuada est mattis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (25,38,6,'2021-12-03 18:45:39','Sed pretium neque eu tortor pulvinar, in efficitur arcu commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (5,83,6,'2021-11-10 17:33:56','Mauris aliquet nulla sed libero vehicula, in dapibus urna semper.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (47,30,5,'2021-11-08 14:59:34','Curabitur rutrum arcu at orci viverra, et mollis metus pellentesque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (54,27,5,'2021-12-02 09:45:39','Ut ac quam eu dui finibus venenatis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (37,54,4,'2021-11-09 13:46:34','Duis et metus mattis, vestibulum dolor eget, luctus est.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (16,70,6,'2021-11-02 21:04:45','Curabitur egestas tortor at porta ullamcorper.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (65,58,4,'2021-11-13 09:26:47','Nullam quis dui mollis, suscipit libero tempor, sagittis lectus.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (17,63,7,'2021-11-09 19:44:41','In semper mi vel diam elementum, id blandit lectus iaculis.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (52,92,5,'2021-12-03 21:13:24','Sed imperdiet nisl sed tortor suscipit commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (35,68,5,'2021-12-02 17:11:02','Nunc tempor purus ut ultricies molestie.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (54,31,4,'2021-12-08 06:30:23','Cras ultricies nisi ac ultrices tempus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (42,79,7,'2021-11-28 20:02:07','Praesent lobortis felis vel condimentum maximus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (9,44,7,'2021-11-17 15:23:46','Nullam non dolor lacinia, efficitur sem sed, lacinia tortor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (86,41,6,'2021-11-13 16:13:26','Duis luctus mauris a lorem luctus, non sagittis nisl porttitor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (35,84,4,'2021-11-28 18:23:46','Donec quis eros vel nunc efficitur auctor id quis ligula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (75,13,4,'2021-11-23 08:03:33','Nam tempor neque ut ante imperdiet, vitae vulputate dui gravida.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (74,59,6,'2021-12-11 10:43:58','Phasellus quis est ut sem convallis semper.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (22,16,5,'2021-11-22 14:57:16','Praesent sit amet odio gravida, ultricies eros sed, congue elit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (49,44,6,'2021-11-26 10:26:50','Pellentesque in lectus vel sapien vulputate dictum nec eleifend ligula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (64,46,6,'2021-11-06 07:36:46','Vestibulum accumsan ligula ut risus sollicitudin feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (54,78,6,'2021-12-06 15:42:37','Curabitur ullamcorper orci ac sem condimentum semper.',1);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (58,89,5,'2021-11-14 06:28:22','Mauris nec diam varius, posuere nibh a, vulputate sem.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (13,32,4,'2021-12-04 19:42:49','Donec ultricies augue non ipsum sodales, a hendrerit sem ornare.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (81,75,5,'2021-11-25 08:56:59','Phasellus aliquam tortor interdum augue elementum, at pellentesque dolor elementum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (66,87,5,'2021-11-16 12:44:04','Maecenas malesuada augue at lorem auctor, sit amet eleifend ipsum interdum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (62,69,4,'2021-11-07 17:37:32','Proin imperdiet sem sit amet nisl vestibulum pellentesque.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (51,18,5,'2021-12-11 14:18:23','Aliquam mattis neque in finibus accumsan.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (31,81,6,'2021-11-09 19:51:10','Pellentesque commodo tellus et quam consectetur, et blandit lacus dignissim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (94,17,6,'2021-11-16 09:27:56','Nunc hendrerit diam at nisi viverra pretium.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (89,15,4,'2021-11-30 12:14:15','Maecenas vitae mi quis elit eleifend dictum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (23,32,7,'2021-11-19 15:46:22','Etiam mollis erat eu orci fermentum, id interdum enim euismod.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (27,44,5,'2021-11-12 20:35:31','Donec in urna non massa gravida sodales id ut lectus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (29,2,7,'2021-12-11 17:24:09','Integer et tortor nec enim volutpat aliquam quis luctus eros.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (87,16,6,'2021-11-05 11:34:39','Aenean ac tellus sed massa ultricies commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (16,56,4,'2021-11-09 08:43:35','Fusce consectetur elit maximus, hendrerit justo sed, rhoncus ante.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,37,4,'2021-11-16 21:54:17','Cras auctor quam eget ligula sollicitudin, in vehicula ligula placerat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (13,20,5,'2021-11-17 16:55:12','Cras venenatis risus nec velit gravida, sed rhoncus ligula venenatis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (76,42,6,'2021-11-04 20:38:59','Cras sit amet elit vel felis commodo porttitor quis sed ex.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (4,51,4,'2021-11-30 13:53:20','Praesent eleifend mi et augue facilisis ultricies.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (56,16,7,'2021-11-04 10:13:44','Sed quis diam efficitur, fringilla neque ut, facilisis ante.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (94,57,7,'2021-11-05 09:53:34','Maecenas vestibulum tortor vel augue malesuada consectetur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,13,6,'2021-11-17 06:51:16','Donec finibus velit vel arcu sodales imperdiet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (51,10,5,'2021-11-13 18:03:36','Phasellus convallis lacus a lectus tristique efficitur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,73,4,'2021-11-01 19:56:47','Maecenas tristique felis at est aliquet eleifend.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (38,84,6,'2021-11-10 06:51:16','Fusce rhoncus est in fringilla blandit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (84,66,4,'2021-11-26 19:37:29','Donec laoreet quam dictum mi ultrices rutrum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (60,15,5,'2021-12-08 17:24:09','Aliquam ac justo in diam aliquet sagittis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (27,38,4,'2021-12-01 11:07:52','Pellentesque luctus eros at eros suscipit, sodales efficitur nibh blandit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (33,26,4,'2021-11-09 19:41:05','Nunc dignissim mi vel dictum iaculis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (21,94,5,'2021-11-11 19:07:58','Duis non odio nec odio pharetra elementum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (61,62,4,'2021-11-03 07:58:57','Sed a ante nec nibh maximus feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (71,14,4,'2021-11-12 07:10:25','Duis id metus elementum, luctus enim non, ultricies libero.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (66,23,4,'2021-11-01 15:28:31','Etiam suscipit lectus pulvinar diam fermentum, vel tincidunt lectus luctus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (24,19,4,'2021-11-22 11:54:14','Morbi vehicula mi vel mi convallis aliquam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (82,81,4,'2021-11-04 19:34:45','Suspendisse accumsan metus id varius venenatis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (24,46,5,'2021-11-24 06:24:29','Pellentesque hendrerit quam facilisis eleifend fermentum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (87,84,4,'2021-11-05 20:30:12','Fusce venenatis urna a nisi finibus maximus vel vitae nulla.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (68,82,6,'2021-11-19 11:45:01','Integer sit amet eros non augue viverra ultrices in commodo sapien.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (51,18,7,'2021-11-27 12:29:31','Nunc dictum ipsum at tortor commodo, a efficitur nulla tincidunt.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,60,5,'2021-11-24 16:32:10','Pellentesque vehicula turpis eget turpis vehicula tincidunt.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (76,16,4,'2021-11-20 09:54:52','Nam faucibus turpis id auctor egestas.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (69,67,6,'2021-11-24 16:36:37','Donec a mi porta, ornare tortor facilisis, tristique quam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (59,69,4,'2021-11-07 12:00:26','Etiam vulputate nisl rhoncus massa ornare commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (64,66,6,'2021-11-19 09:44:12','Praesent elementum libero id sapien fringilla fermentum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (5,50,5,'2021-11-12 16:10:16','Donec sodales eros eu fermentum molestie.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (30,91,7,'2021-11-11 13:59:23','Phasellus gravida nulla et leo tincidunt dapibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (57,27,5,'2021-11-08 08:43:35','Ut ac diam ornare, rutrum libero eget, viverra mi.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (49,15,7,'2021-12-10 07:09:50','Etiam id ante a urna posuere aliquet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (89,73,7,'2021-12-10 12:27:22','Nulla ultricies odio a nulla congue bibendum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (15,40,4,'2021-11-04 16:18:46','Etiam sit amet nisl faucibus, tincidunt mi eu, auctor enim.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (29,93,5,'2021-11-16 15:45:56','Nullam suscipit felis porta ipsum porta posuere.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,34,4,'2021-11-30 17:41:43','Etiam ac sem id mauris viverra fringilla vitae ut dolor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (90,83,5,'2021-11-11 16:07:32','Morbi euismod dolor vel magna fringilla, vel efficitur elit ullamcorper.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (17,7,5,'2021-11-18 08:36:49','Phasellus elementum ligula vel tincidunt tristique.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (78,94,6,'2021-11-26 14:35:14','Vivamus feugiat magna quis efficitur commodo.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,9,5,'2021-11-28 06:52:42','Cras rhoncus diam eu libero molestie, eu ultricies quam porta.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (4,59,5,'2021-11-29 06:21:10','Donec at lorem et odio auctor ultricies.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (53,29,4,'2021-11-30 12:13:58','Vivamus lacinia purus vitae lectus vestibulum, vel blandit sem vehicula.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (23,6,7,'2021-11-08 06:24:20','Pellentesque vulputate quam lacinia suscipit mattis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (6,25,5,'2021-11-22 10:39:22','Duis commodo turpis suscipit sagittis pharetra.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (49,32,7,'2021-12-10 14:52:05','Duis vitae mauris consequat, scelerisque mi a, cursus erat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (62,32,6,'2021-11-28 07:20:47','Integer fringilla dui gravida diam vehicula, nec mattis leo molestie.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (11,64,4,'2021-11-04 15:47:48','Integer ut massa finibus, auctor sem id, malesuada tellus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (86,36,5,'2021-11-11 19:34:54','Cras malesuada mi eget libero vestibulum efficitur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (59,73,6,'2021-12-06 07:19:21','Cras dignissim lacus vitae risus scelerisque iaculis.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (73,44,6,'2021-11-18 20:27:53','Mauris suscipit mauris in enim efficitur porttitor.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (29,28,7,'2021-11-21 13:05:14','Nulla at ex eu nisi auctor consectetur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (18,31,6,'2021-12-05 17:26:36','Sed eleifend quam sed quam vehicula, vel semper metus lacinia.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (1,74,4,'2021-11-12 12:16:34','Quisque tincidunt nisl id risus vehicula molestie.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (85,38,4,'2021-11-03 11:11:02','Donec feugiat odio non mollis tincidunt.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (68,67,6,'2021-12-05 20:04:51','Fusce mattis magna id tristique vestibulum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (83,83,6,'2021-12-02 19:06:40','Integer varius mi quis erat bibendum, in tristique felis consectetur.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (32,76,4,'2021-11-23 13:19:12','Nulla ut sapien euismod, malesuada ante ac, lobortis orci.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (19,29,7,'2021-11-03 21:02:27','Vivamus id eros sed lorem consequat aliquam.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (33,29,5,'2021-11-03 06:29:57','Ut euismod nisl vel massa sodales dictum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (14,57,6,'2021-11-12 19:28:34','Mauris convallis tortor at augue sodales sollicitudin.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (34,19,7,'2021-12-11 09:23:02','Pellentesque sit amet turpis scelerisque, malesuada tellus eu, tempor nunc.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (72,76,4,'2021-11-30 10:29:25','Fusce sit amet sem porttitor, ultrices orci ut, dignissim est.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (60,71,6,'2021-11-08 12:36:43','Nam vulputate sapien imperdiet, fermentum urna id, mollis ipsum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (41,87,5,'2021-12-02 12:29:23','Vivamus varius nisl sed enim molestie tincidunt.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (62,11,4,'2021-11-30 14:54:06','Proin et diam et risus rutrum gravida quis eget massa.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (94,39,5,'2021-12-11 21:49:41','Quisque non orci varius odio finibus varius quis ac risus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (28,69,4,'2021-11-07 08:18:32','Sed aliquet ante et augue pellentesque porta.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (10,40,7,'2021-11-01 20:44:36','Etiam convallis ligula semper, sollicitudin nulla accumsan, eleifend risus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (3,77,4,'2021-12-03 14:36:58','Aliquam ac odio tincidunt, vestibulum orci nec, cursus magna.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,73,6,'2021-11-16 08:09:45','Pellentesque a metus quis lacus consequat tincidunt quis pellentesque est.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (37,89,4,'2021-11-13 08:08:27','Curabitur sit amet est facilisis, congue sem sit amet, placerat metus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (54,74,5,'2021-11-28 21:12:14','Donec semper magna dictum quam hendrerit laoreet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (26,83,6,'2021-11-10 20:27:01','Curabitur at orci congue, gravida quam id, finibus orci.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (48,13,5,'2021-11-09 06:09:56','Nulla id mauris vitae dolor euismod eleifend sed sit amet urna.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (17,70,6,'2021-11-24 08:29:11','Sed eu orci gravida, volutpat quam sed, ornare ex.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (40,61,5,'2021-11-12 08:14:04','Phasellus lobortis mauris ullamcorper neque laoreet, eu congue risus lacinia.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (85,3,5,'2021-11-25 11:35:14','Nunc vestibulum nisl at semper aliquet.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (65,84,5,'2021-11-09 13:39:48','Aliquam et magna euismod, pretium ligula eget, iaculis est.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (69,18,5,'2021-12-10 10:14:36','Donec dapibus lectus sit amet fringilla finibus.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (14,37,4,'2021-11-23 19:20:12','Praesent quis ligula at lectus sodales gravida nec mollis dui.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (2,12,7,'2021-11-05 17:47:11','Fusce ut diam at orci sodales imperdiet quis id ex.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (27,45,4,'2021-11-03 08:45:45','Aenean id nunc ut justo tincidunt lacinia.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (14,3,7,'2021-11-12 17:37:58','Nulla rutrum nibh id ipsum tempus eleifend.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (63,47,4,'2021-11-13 18:44:38','Donec placerat tortor in mauris rutrum, vitae ornare odio feugiat.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (10,19,7,'2021-11-17 11:36:06','Nulla ultricies massa a massa viverra, id luctus turpis ullamcorper.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (26,29,4,'2021-11-07 17:35:05','Fusce mattis lectus et placerat hendrerit.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (68,13,7,'2021-11-23 12:22:19','Pellentesque vitae enim eget velit tempor bibendum.',2);
INSERT INTO BaoCaoNguoiDung (nguoi_bao_cao,nguoi_bi_bao_cao,ma_lbc,ngay,lydo,trangthai) VALUES (14,29,7,'2021-12-05 16:06:49','Nulla blandit urna quis sodales sagittis.',2);

INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (1,'2021-11-11 00:00:00',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (2,'2021-11-11 00:00:00',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-11-11 00:00:00',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-11-11 00:00:00',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (5,'2021-11-11 00:00:00',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (6,'2021-11-11 00:00:00',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-11 00:00:00',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-11-11 00:00:00',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (10,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (11,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-11-11 00:00:00',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-11-11 00:00:00',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-11 00:00:00',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (15,'2021-11-11 00:00:00',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-11-11 00:00:00',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (17,'2021-11-11 00:00:00',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-11-11 00:00:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (19,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-11 00:00:00',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (22,'2021-11-11 00:00:00',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (23,'2021-11-11 00:00:00',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-11 00:00:00',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (25,'2021-11-11 00:00:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-11-11 00:00:00',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (27,'2021-11-11 00:00:00',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (28,'2021-11-11 00:00:00',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-11-11 00:00:00',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (30,'2021-11-11 00:00:00',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (31,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (32,'2021-11-11 00:00:00',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (33,'2021-11-11 00:00:00',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-11 00:00:00',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (35,'2021-11-11 00:00:00',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (36,'2021-11-11 00:00:00',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (37,'2021-11-11 00:00:00',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (38,'2021-11-11 00:00:00',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (39,'2021-11-11 00:00:00',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (40,'2021-11-11 00:00:00',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-11 00:00:00',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (42,'2021-11-11 00:00:00',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-11-11 00:00:00',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (46,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-11-11 00:00:00',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-11-11 00:00:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (49,'2021-11-11 00:00:00',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (51,'2021-11-11 00:00:00',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (52,'2021-11-11 00:00:00',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-11-11 00:00:00',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (54,'2021-11-11 00:00:00',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-11-11 00:00:00',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (56,'2021-11-11 00:00:00',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (57,'2021-11-11 00:00:00',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (58,'2021-11-11 00:00:00',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (59,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (60,'2021-11-11 00:00:00',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (61,'2021-11-11 00:00:00',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (62,'2021-11-11 00:00:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (63,'2021-11-11 00:00:00',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (64,'2021-11-11 00:00:00',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (66,'2021-11-11 00:00:00',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (67,'2021-11-11 00:00:00',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-11 00:00:00',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (69,'2021-11-11 00:00:00',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (70,'2021-11-11 00:00:00',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (71,'2021-11-11 00:00:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-11 00:00:00',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (73,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (74,'2021-11-11 00:00:00',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (75,'2021-11-11 00:00:00',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-11-11 00:00:00',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (77,'2021-11-11 00:00:00',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-11-11 00:00:00',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (79,'2021-11-11 00:00:00',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-11 00:00:00',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (81,'2021-11-11 00:00:00',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-11-11 00:00:00',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (83,'2021-11-11 00:00:00',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (84,'2021-11-11 00:00:00',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-11-11 00:00:00',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (86,'2021-11-11 00:00:00',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (87,'2021-11-11 00:00:00',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (88,'2021-11-11 00:00:00',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-11 00:00:00',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (90,'2021-11-11 00:00:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-11-11 00:00:00',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (92,'2021-11-11 00:00:00',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (93,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (94,'2021-11-11 00:00:00',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-11 00:00:00',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (96,'2021-11-11 00:00:00',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (97,'2021-11-11 00:00:00',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (98,'2021-11-11 00:00:00',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-11-11 00:00:00',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-11-11 00:00:00',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (101,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (102,'2021-11-11 00:00:00',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-11-11 00:00:00',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (104,'2021-11-11 00:00:00',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-11-11 00:00:00',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (106,'2021-11-11 00:00:00',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (108,'2021-11-11 00:00:00',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-11 00:00:00',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (110,'2021-11-11 00:00:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (111,'2021-11-11 00:00:00',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-11-11 00:00:00',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (114,'2021-11-11 00:00:00',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (115,'2021-11-11 00:00:00',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-11-11 00:00:00',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-11-11 00:00:00',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-11 00:00:00',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (120,'2021-11-11 00:00:00',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (121,'2021-11-11 00:00:00',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (122,'2021-11-11 00:00:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (123,'2021-11-11 00:00:00',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-11-11 00:00:00',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (125,'2021-11-11 00:00:00',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-11-11 00:00:00',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (127,'2021-11-11 00:00:00',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (81,'2021-11-19 08:02:41',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-11-12 07:04:57',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-11-08 17:36:14',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-11-07 13:19:12',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (30,'2021-11-21 11:06:26',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-12-09 07:52:36',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-12-08 21:58:28',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (39,'2021-11-16 16:45:16',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-14 09:46:05',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-15 13:39:39',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (83,'2021-11-03 19:37:12',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-11-21 11:30:03',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (90,'2021-11-17 10:20:38',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (84,'2021-11-21 15:40:28',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-04 15:52:34',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-12-04 11:07:18',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-11-16 11:46:19',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-12-02 19:34:45',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-11-03 13:10:08',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (73,'2021-12-04 12:42:29',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-11-25 12:39:27',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-12-07 08:44:27',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (56,'2021-11-24 10:37:12',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-12-09 17:55:24',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-12-09 18:20:27',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (102,'2021-12-05 06:45:04',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (58,'2021-11-01 10:34:36',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-10 15:57:45',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-12-11 07:49:09',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-26 19:28:51',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-06 17:11:46',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (1,'2021-11-17 06:18:09',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-11-16 18:08:47',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-01 20:01:58',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-07 11:17:40',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-11-30 16:36:55',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-12-02 14:30:37',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (96,'2021-11-21 06:26:12',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-12-07 18:09:56',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (66,'2021-11-05 18:39:19',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (73,'2021-12-10 17:04:08',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-12-10 10:14:18',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-11-25 08:35:05',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (101,'2021-12-05 12:40:02',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-12-08 17:30:03',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-12-04 19:00:55',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (54,'2021-11-15 14:57:24',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (19,'2021-11-28 14:11:54',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-12-10 18:30:32',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-12-09 18:04:02',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-11-15 20:12:03',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (54,'2021-12-08 06:37:35',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-27 21:42:20',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (86,'2021-12-03 13:31:18',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-14 08:23:43',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-11-10 18:42:29',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-11-02 09:05:02',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-11-13 09:11:14',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (97,'2021-11-26 19:09:42',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-11-22 17:07:35',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (75,'2021-11-12 18:08:12',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (66,'2021-11-08 21:43:29',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (114,'2021-11-16 18:34:25',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (6,'2021-11-08 19:43:41',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-18 08:57:16',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-07 19:08:59',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-12-09 06:34:42',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (70,'2021-11-16 11:24:09',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-02 17:51:39',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (1,'2021-11-24 19:01:55',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (17,'2021-12-01 12:31:15',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-12-07 12:09:39',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-12-09 13:09:33',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-12-01 19:45:59',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (51,'2021-12-05 08:24:00',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (35,'2021-11-20 14:46:02',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-25 12:59:28',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-12-06 15:34:51',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-11-04 06:16:51',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (37,'2021-11-22 20:59:51',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-11-20 07:12:17',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-11-14 09:42:46',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-12-07 20:25:26',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-15 17:51:48',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (92,'2021-11-25 10:33:36',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-25 09:43:55',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (114,'2021-11-06 11:30:29',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-18 08:15:04',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (69,'2021-12-02 18:07:12',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-11-27 11:27:53',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (110,'2021-11-03 12:28:22',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-11-19 16:35:37',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-11-22 08:00:14',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (64,'2021-11-27 19:33:19',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-11-03 11:30:37',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-12-11 15:51:42',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (63,'2021-11-30 15:44:30',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (73,'2021-11-04 11:10:36',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-11-15 15:15:42',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (125,'2021-11-19 15:41:46',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-10 07:05:57',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (108,'2021-12-10 11:52:31',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-28 16:24:32',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (1,'2021-11-27 13:05:05',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (73,'2021-11-05 19:31:26',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-02 14:47:28',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-12-03 17:07:44',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (30,'2021-12-10 17:12:46',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (27,'2021-11-17 18:07:03',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-11-01 10:12:17',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-18 08:32:38',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (73,'2021-12-08 14:57:59',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (59,'2021-12-07 12:16:42',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (10,'2021-11-16 10:37:21',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (94,'2021-11-29 11:09:01',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (104,'2021-11-14 13:57:30',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-11-18 18:00:43',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (52,'2021-11-29 12:38:18',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-25 21:55:44',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-11-26 06:35:08',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (79,'2021-12-06 11:45:36',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (30,'2021-12-06 21:09:39',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (111,'2021-12-09 15:11:48',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-12-08 14:24:17',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-12-01 10:24:32',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (114,'2021-11-07 15:30:06',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-11-01 18:50:15',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (74,'2021-11-29 09:17:34',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (66,'2021-11-04 17:47:37',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-12-05 14:43:18',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (83,'2021-11-29 12:02:27',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-12-01 07:11:43',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (127,'2021-11-01 07:36:55',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-12-02 12:15:59',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (102,'2021-11-16 14:49:38',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-11-02 14:14:30',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (71,'2021-12-10 15:31:24',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (108,'2021-12-10 17:15:13',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-12-09 18:31:49',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-12 16:32:27',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-11-03 21:32:50',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-11-16 17:52:13',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-11-28 10:52:45',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-11-18 19:15:27',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (81,'2021-11-21 20:50:04',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (22,'2021-11-23 14:15:04',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-11-22 14:50:30',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (37,'2021-11-11 11:15:13',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (127,'2021-12-04 13:48:52',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (11,'2021-12-02 09:46:13',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-11-27 07:14:01',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (70,'2021-11-25 10:01:29',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-11-03 06:43:21',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-12-10 18:00:26',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-12-10 06:09:04',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-11-19 15:13:24',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-11-17 19:27:16',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (42,'2021-11-02 16:21:22',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (39,'2021-11-25 08:15:30',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (63,'2021-11-28 13:02:04',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (69,'2021-11-01 14:13:38',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-11-15 10:02:38',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-11-12 08:55:15',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (74,'2021-11-22 12:05:02',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-21 10:52:19',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (30,'2021-11-11 18:16:51',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-09 13:28:16',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-11-11 09:57:01',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-12-05 16:14:36',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-12-04 09:18:17',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (121,'2021-11-23 08:49:12',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-11-23 13:26:33',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-02 11:32:56',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-12-05 06:12:32',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (96,'2021-11-15 07:51:36',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (5,'2021-11-08 13:08:15',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-11-20 12:21:36',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (31,'2021-11-20 18:56:27',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-12-06 07:06:14',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-12-07 07:08:59',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (60,'2021-11-25 13:08:41',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-12-04 06:25:12',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-11-23 21:06:20',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (39,'2021-12-04 20:54:58',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (106,'2021-12-03 17:46:11',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-19 20:45:45',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (123,'2021-11-01 19:17:54',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-12-05 10:37:47',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (92,'2021-11-25 15:56:53',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-12-01 07:15:10',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (83,'2021-12-03 10:13:09',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (58,'2021-12-09 16:15:36',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-12-03 17:06:43',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-11-13 20:38:59',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-11-29 19:36:20',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (127,'2021-11-05 10:27:24',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-16 15:42:20',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-12-06 17:36:14',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (2,'2021-11-12 19:18:12',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (58,'2021-11-11 21:33:59',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-12-11 09:00:43',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (93,'2021-11-16 18:06:20',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (22,'2021-11-18 15:15:33',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-12-06 12:37:00',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-28 16:52:11',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-21 18:28:22',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-12-08 09:32:59',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-12-06 17:26:18',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (74,'2021-12-07 21:41:37',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-29 20:37:24',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-11-08 12:38:18',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-26 21:20:44',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-11-23 14:48:46',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-11-08 11:09:53',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-12 06:29:40',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-11-09 19:38:21',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (36,'2021-11-28 06:33:59',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-11-12 06:51:42',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-11-28 18:21:19',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (67,'2021-12-11 17:39:59',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-12-02 08:36:49',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-12-10 21:02:27',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (73,'2021-12-11 07:54:46',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (97,'2021-12-09 21:43:47',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-12-10 15:45:56',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (60,'2021-11-21 15:30:58',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-11-15 12:18:17',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-11-06 07:22:05',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-21 06:14:07',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-25 06:46:39',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-14 17:12:03',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-11-14 06:31:58',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-11-15 12:35:51',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (79,'2021-11-25 16:47:17',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-11-27 14:31:55',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-07 16:34:19',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-12-06 14:26:27',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (70,'2021-11-22 17:57:59',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (86,'2021-11-01 17:19:58',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-07 10:18:55',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-12-10 21:58:28',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (115,'2021-11-29 21:18:17',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-11-12 11:59:00',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (39,'2021-11-18 08:05:25',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-11 17:55:24',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-28 18:33:59',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (22,'2021-12-08 06:13:32',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-12-04 16:55:29',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (46,'2021-11-16 15:55:44',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (77,'2021-11-17 10:52:54',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-12-01 20:07:09',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-11-21 17:09:19',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-11-23 20:34:13',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (120,'2021-11-23 09:08:04',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-11-02 12:57:45',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (11,'2021-11-11 15:49:32',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-17 11:36:14',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-12-08 07:02:21',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (71,'2021-12-05 20:05:51',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-01 17:34:57',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (67,'2021-11-09 14:14:56',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-03 15:27:04',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (27,'2021-11-21 13:49:09',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (79,'2021-11-21 11:23:17',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-01 18:09:48',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-11-19 16:19:21',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-15 15:42:03',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-11-13 17:33:30',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-03 19:48:35',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-11-08 12:12:40',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-11-08 14:13:03',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (81,'2021-12-02 11:41:51',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-11-07 18:43:12',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (59,'2021-11-03 10:12:43',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-11-29 08:26:53',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (115,'2021-11-11 19:39:30',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-27 06:01:26',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-11-14 15:56:10',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (23,'2021-12-11 07:43:41',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (49,'2021-11-16 21:43:47',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (121,'2021-11-18 16:09:50',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-11-16 13:57:56',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (33,'2021-12-02 20:44:44',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-08 07:32:27',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-12-05 15:45:48',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-08 20:38:41',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-11-01 19:48:09',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (120,'2021-12-08 11:16:13',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-12-05 18:46:57',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (73,'2021-12-07 15:08:38',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (37,'2021-12-03 13:32:01',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-12-04 08:03:07',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (111,'2021-11-08 21:34:51',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-11-16 10:39:30',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-12-09 13:31:35',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (84,'2021-12-05 20:40:16',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-05 16:41:57',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (79,'2021-11-26 14:27:53',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-11-17 11:28:45',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-12-11 19:52:28',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-28 18:59:54',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-11-06 18:01:44',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-11-12 11:59:25',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-12-05 15:24:37',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-12-03 16:07:32',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (54,'2021-11-01 12:57:19',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-11-30 21:01:52',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (61,'2021-12-11 21:52:16',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (5,'2021-11-19 16:15:53',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (38,'2021-11-06 19:20:47',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-16 06:46:22',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (11,'2021-11-23 14:17:14',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-12-05 11:48:12',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-02 18:29:14',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-02 15:43:47',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-12-03 19:31:18',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (96,'2021-11-20 19:15:45',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-11-17 07:24:58',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-20 11:09:27',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-23 11:08:53',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-11-17 21:02:01',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-12-11 10:33:27',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-25 06:55:52',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (23,'2021-11-13 11:46:54',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-11-13 15:24:46',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-12-03 18:49:15',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (111,'2021-11-30 16:56:12',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-06 07:24:14',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (114,'2021-11-23 07:35:28',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-12-02 16:48:17',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-11-11 09:15:24',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (94,'2021-11-21 17:54:06',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-12-03 06:32:41',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-12-07 10:29:08',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-12-07 21:35:34',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-12-01 14:45:10',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (46,'2021-11-28 07:32:18',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-11-01 20:23:51',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-11-19 15:41:46',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (104,'2021-11-26 09:37:35',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-12-01 18:08:21',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (31,'2021-12-02 09:34:16',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-11-28 16:45:24',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-28 16:42:40',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (42,'2021-11-18 07:16:45',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (90,'2021-11-06 19:35:37',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-12-06 14:59:34',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-11-04 13:24:14',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-11-14 12:11:40',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-12-11 18:12:49',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (86,'2021-12-06 15:48:06',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (81,'2021-11-13 08:39:07',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (25,'2021-12-02 21:02:44',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (88,'2021-11-17 11:39:59',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (97,'2021-11-08 11:35:31',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-12-07 15:50:15',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (88,'2021-11-04 17:47:46',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (77,'2021-11-16 16:34:19',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (101,'2021-11-30 13:51:10',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-12-09 09:08:38',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (31,'2021-11-30 07:34:02',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (35,'2021-12-02 06:04:45',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (79,'2021-12-11 21:51:59',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (56,'2021-11-11 09:48:23',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (59,'2021-11-08 13:47:34',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (92,'2021-11-21 10:24:40',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-11-29 16:52:02',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-22 10:36:20',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (1,'2021-12-07 11:13:03',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-11-28 11:03:42',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-12-08 19:11:34',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-20 16:53:11',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-11-26 17:31:55',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-12-08 08:30:29',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-11-11 07:12:43',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (2,'2021-12-10 21:05:20',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (108,'2021-11-03 15:17:17',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-23 17:56:59',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-13 10:55:38',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (27,'2021-12-11 16:14:10',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-12-03 09:26:56',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-12-11 13:24:14',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (46,'2021-11-13 10:49:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-11-17 19:30:09',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (93,'2021-12-03 10:12:43',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (94,'2021-12-10 08:55:15',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-18 14:12:46',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (123,'2021-12-02 17:41:25',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (96,'2021-11-24 08:59:43',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-12-08 06:05:11',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-11-26 12:43:55',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-23 07:27:50',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-11-26 20:54:14',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-12-10 09:35:25',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (35,'2021-11-18 14:25:44',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (11,'2021-11-07 15:28:39',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (6,'2021-11-07 12:09:13',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (98,'2021-12-11 08:09:19',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (102,'2021-11-16 09:24:20',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (87,'2021-11-01 14:48:55',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-11-11 11:43:52',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (69,'2021-12-05 18:27:22',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-11-22 12:33:59',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (63,'2021-12-04 20:57:33',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-07 20:58:42',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (101,'2021-12-04 09:05:20',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-12-06 19:32:18',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (83,'2021-11-19 14:22:16',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (121,'2021-11-14 21:53:43',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-07 10:23:40',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-12-10 21:21:10',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (106,'2021-11-13 19:47:00',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (32,'2021-12-09 14:19:49',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-12-03 18:11:40',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (25,'2021-12-11 20:33:48',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-12-07 10:03:48',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (5,'2021-11-01 20:34:13',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (127,'2021-11-15 19:23:05',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (104,'2021-11-03 12:33:59',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-12-07 18:15:07',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-12-08 12:55:52',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (37,'2021-12-02 06:01:35',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (56,'2021-12-01 14:41:00',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-05 11:37:41',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (125,'2021-11-20 15:45:30',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-11-22 18:46:31',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (123,'2021-11-04 10:44:59',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (40,'2021-11-27 13:20:47',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-12-02 08:15:48',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (71,'2021-11-08 15:37:18',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-12-04 13:00:12',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-12-09 13:32:27',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (93,'2021-11-24 11:51:39',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (59,'2021-11-10 10:43:06',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (104,'2021-11-23 11:23:25',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (94,'2021-11-10 13:00:55',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-11-29 20:55:32',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-09 10:07:24',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (102,'2021-12-04 12:52:25',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-12-05 15:04:28',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (121,'2021-11-25 06:40:45',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-11-16 20:48:46',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-12-02 08:46:19',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (90,'2021-11-30 07:37:12',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-11-15 20:18:23',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-11-06 12:38:36',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (110,'2021-11-16 17:41:34',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-11-23 14:57:50',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-23 17:52:13',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-11-16 10:59:23',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (104,'2021-11-07 08:18:23',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-24 10:50:01',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-12-11 10:35:11',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-11-07 14:35:57',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-09 19:22:13',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-12-11 11:17:57',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-12-08 21:42:03',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-12-01 07:21:04',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-11-02 19:17:20',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-12-01 16:11:00',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (5,'2021-11-27 13:31:44',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (74,'2021-12-07 09:57:45',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-17 11:06:09',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-11-28 11:44:01',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-12-01 15:48:14',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-12 21:47:31',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-11-13 15:03:27',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (92,'2021-11-25 08:41:34',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (31,'2021-12-06 10:20:30',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (77,'2021-11-12 09:47:31',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-11-10 13:05:40',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-11-09 21:28:31',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-12-01 15:47:57',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-12-09 07:55:29',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (32,'2021-11-20 07:27:50',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-12-08 14:13:38',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (61,'2021-11-06 09:35:43',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (31,'2021-11-16 21:45:04',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (106,'2021-11-09 08:40:34',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (64,'2021-11-11 19:19:55',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-20 06:38:18',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-12-01 19:57:04',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (49,'2021-11-11 17:43:52',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (40,'2021-11-27 12:51:07',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (86,'2021-11-16 06:30:23',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (54,'2021-12-02 07:42:49',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (10,'2021-11-17 14:00:14',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (97,'2021-11-28 07:31:44',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-11-28 15:47:40',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (39,'2021-11-11 19:41:23',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-11-20 11:02:24',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (27,'2021-12-09 06:44:47',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-11-08 14:15:48',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (22,'2021-11-01 06:16:42',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-12-07 08:44:36',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-02 14:48:12',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (77,'2021-11-09 08:34:57',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (10,'2021-11-03 16:02:04',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-12-07 19:03:30',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-15 17:41:08',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (108,'2021-11-09 14:03:16',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (77,'2021-11-22 06:48:58',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-14 19:01:55',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (104,'2021-11-26 13:28:25',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (1,'2021-11-24 12:40:11',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-11-19 07:08:59',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (94,'2021-12-02 12:59:28',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (88,'2021-11-05 06:19:35',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-11-02 13:37:47',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-10 19:32:01',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-11-01 15:16:51',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-11-04 16:20:30',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-13 10:20:56',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (49,'2021-11-29 18:58:54',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-12-02 15:12:49',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-11-02 20:25:44',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-11-02 17:55:15',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-17 16:05:31',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-11-02 06:03:45',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-26 12:36:26',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-11-02 10:43:06',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-12-05 14:59:17',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (93,'2021-11-14 14:22:51',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (37,'2021-12-03 14:26:10',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-11-24 19:15:53',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (84,'2021-11-21 07:13:09',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (108,'2021-11-16 11:02:24',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-30 13:13:26',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (56,'2021-12-04 07:20:21',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (87,'2021-12-02 11:35:57',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (86,'2021-11-04 06:27:48',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-12-09 09:48:49',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-06 17:25:00',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-11 09:32:59',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-12-04 07:22:48',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-11-05 08:30:37',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-11-07 19:52:02',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-12-07 11:15:30',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (59,'2021-11-19 19:41:05',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-12-06 21:03:01',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-21 20:04:34',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-11-05 19:30:26',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (60,'2021-11-23 08:38:24',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-11-13 06:40:11',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (81,'2021-12-05 17:52:39',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-11-06 14:49:03',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (107,'2021-11-17 10:11:43',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (25,'2021-11-29 07:41:05',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-11-29 07:33:53',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (22,'2021-11-14 08:43:52',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (27,'2021-11-07 07:27:24',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (70,'2021-11-23 17:04:51',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-26 09:55:26',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (17,'2021-11-03 18:32:07',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-12-02 18:33:24',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (122,'2021-11-27 19:35:54',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (122,'2021-11-18 08:22:51',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (62,'2021-11-30 12:29:48',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-12-09 18:49:49',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-11-03 13:16:28',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (79,'2021-11-05 20:41:51',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-11-08 07:00:55',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-11-16 15:48:23',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (67,'2021-11-07 11:37:24',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (103,'2021-11-09 07:11:00',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (61,'2021-12-06 15:30:49',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-11-01 08:07:52',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-26 06:56:53',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-29 09:39:27',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (127,'2021-11-14 13:37:47',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-22 10:16:11',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (83,'2021-11-25 14:55:06',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (60,'2021-11-09 17:46:36',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (101,'2021-12-04 20:09:19',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (123,'2021-11-11 20:26:18',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (30,'2021-12-04 17:59:43',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-11-05 19:29:08',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-12-07 19:19:55',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (69,'2021-11-07 08:25:18',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-12-06 15:02:27',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (102,'2021-11-02 16:48:52',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (115,'2021-11-27 11:35:23',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (1,'2021-11-30 15:20:10',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (127,'2021-11-22 07:43:15',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-12-08 16:27:33',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-12-09 06:51:42',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (92,'2021-11-12 06:31:58',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-12-02 21:56:36',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-05 11:13:12',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (37,'2021-11-06 15:00:52',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (83,'2021-11-29 18:33:50',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-12-03 07:32:27',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-12-07 19:52:54',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (13,'2021-12-02 16:15:19',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-12-06 06:04:45',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-02 14:04:25',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (22,'2021-11-03 18:41:46',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (88,'2021-11-09 11:01:41',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (40,'2021-11-26 11:46:28',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (51,'2021-11-07 07:05:05',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-12-10 21:12:49',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (45,'2021-11-18 06:38:27',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-12-08 21:28:48',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (92,'2021-11-06 15:01:18',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-03 07:58:57',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-12-03 08:54:32',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-11-03 15:02:10',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-11-08 10:31:26',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (61,'2021-11-02 13:20:04',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (6,'2021-11-23 21:01:09',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (62,'2021-11-11 12:58:11',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (114,'2021-12-02 20:34:48',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-11-21 18:31:41',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (12,'2021-11-16 06:26:04',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-26 11:17:57',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-19 08:08:01',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (18,'2021-12-08 13:05:14',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-12-02 21:58:36',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-12-06 19:14:44',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-12-07 06:11:57',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (84,'2021-11-16 15:52:08',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-11-15 12:47:05',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-12-02 14:57:07',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-11-14 07:31:52',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-12-07 13:55:12',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (17,'2021-11-01 06:42:12',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (32,'2021-11-24 17:43:44',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-11 10:08:15',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-11-27 11:16:13',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (88,'2021-11-26 16:58:05',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (40,'2021-11-26 06:47:05',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-11-14 21:19:09',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (60,'2021-11-18 13:56:56',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (44,'2021-11-14 11:17:40',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-10 14:25:00',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-12-03 10:18:20',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-11-18 14:23:08',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-11-23 11:00:40',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-11-19 10:19:47',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-12-01 06:11:14',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (15,'2021-11-24 16:21:48',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (75,'2021-11-17 11:09:19',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (15,'2021-11-03 18:21:53',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-12-04 20:50:30',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (57,'2021-11-03 07:07:06',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-08 16:05:05',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-18 07:13:35',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (112,'2021-12-08 09:01:09',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (23,'2021-11-13 19:24:14',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (25,'2021-11-09 19:39:04',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (6,'2021-12-03 14:31:29',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (14,'2021-11-12 20:31:38',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (59,'2021-12-03 07:14:18',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (29,'2021-11-20 07:13:35',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (10,'2021-11-30 20:45:53',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (10,'2021-11-21 10:16:54',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (17,'2021-11-14 09:46:57',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (40,'2021-11-05 09:51:24',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-11-29 08:30:03',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (64,'2021-12-11 14:05:34',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-11-28 12:35:17',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (78,'2021-12-04 19:59:57',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-11-20 19:39:56',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (60,'2021-12-09 11:24:00',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-11-17 06:08:47',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (17,'2021-11-01 06:41:02',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-12-06 09:40:11',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-12-07 18:15:59',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (42,'2021-12-06 14:58:08',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-02 16:28:42',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (69,'2021-12-07 15:42:20',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (5,'2021-11-18 12:53:34',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-11-20 06:26:56',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (58,'2021-11-05 11:37:15',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (86,'2021-11-16 12:10:05',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-11-21 14:17:14',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-11-21 20:42:35',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (36,'2021-11-03 12:59:02',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (74,'2021-12-10 16:01:47',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (115,'2021-12-04 18:59:54',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (68,'2021-11-23 15:53:17',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-12-09 17:25:09',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (76,'2021-12-08 18:16:34',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-01 07:45:59',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-18 17:38:15',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (106,'2021-11-01 18:02:53',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (2,'2021-12-08 17:06:17',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (35,'2021-11-12 15:06:12',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-21 16:51:10',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (42,'2021-11-30 18:41:02',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-12-08 14:54:32',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-11-08 19:37:55',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (86,'2021-11-14 15:02:27',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-01 15:31:32',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (125,'2021-12-08 07:14:36',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (111,'2021-12-03 07:06:49',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (81,'2021-12-10 18:06:55',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-05 19:23:31',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-08 17:57:33',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (96,'2021-11-25 16:00:03',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (83,'2021-11-18 07:43:58',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (104,'2021-11-13 06:08:30',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-12-08 18:41:54',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (92,'2021-11-22 18:50:07',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (61,'2021-11-12 17:42:43',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (16,'2021-11-08 15:07:29',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-22 18:15:16',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (81,'2021-11-08 18:26:30',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (1,'2021-12-11 14:53:23',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (5,'2021-11-03 11:36:06',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (106,'2021-11-30 07:21:56',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-12-02 20:37:15',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (66,'2021-11-06 17:48:29',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (56,'2021-11-08 07:23:14',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-11-06 10:51:36',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-07 19:37:03',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (97,'2021-11-21 11:43:44',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (98,'2021-11-19 06:50:50',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (62,'2021-11-02 21:37:44',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (25,'2021-11-07 08:27:45',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (111,'2021-12-07 12:37:44',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-11-09 16:45:07',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (109,'2021-11-05 18:21:27',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-11-08 10:12:35',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (28,'2021-11-23 17:14:56',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-12-04 13:26:15',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (6,'2021-11-04 12:51:42',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (79,'2021-11-17 10:49:44',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-18 16:21:04',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-12-07 10:04:31',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (98,'2021-12-08 15:26:38',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (24,'2021-11-28 18:54:43',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-29 19:27:42',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (10,'2021-11-22 15:24:46',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (120,'2021-11-18 17:38:07',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (57,'2021-11-01 11:25:44',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-12-06 11:22:08',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (96,'2021-11-20 17:30:37',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (46,'2021-11-01 19:54:29',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (15,'2021-12-10 19:32:53',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (116,'2021-11-24 07:09:42',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (64,'2021-11-29 15:24:20',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-12-10 12:51:16',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (98,'2021-11-03 20:56:24',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-11-24 07:59:05',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (17,'2021-11-20 09:40:19',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (37,'2021-11-24 21:45:22',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (90,'2021-11-05 07:03:22',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (54,'2021-11-14 07:13:52',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (126,'2021-11-15 06:08:12',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (125,'2021-12-03 12:00:35',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (42,'2021-11-23 18:57:19',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (32,'2021-12-11 15:04:45',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-11-09 17:19:49',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (114,'2021-12-02 16:57:13',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (84,'2021-12-04 18:45:56',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (61,'2021-11-05 08:04:34',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (115,'2021-11-07 12:19:18',5000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (88,'2021-11-03 14:09:19',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (54,'2021-12-07 06:59:28',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (117,'2021-12-11 21:05:28',3000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (47,'2021-12-07 08:07:26',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-11-28 14:38:33',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-12-11 18:20:27',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (5,'2021-11-06 18:29:05',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (51,'2021-11-04 07:18:55',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (96,'2021-12-02 21:26:12',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-11-09 11:00:49',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (61,'2021-11-02 13:26:33',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-11-22 21:51:42',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (113,'2021-12-01 20:03:42',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-11-24 09:17:17',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (46,'2021-12-08 09:30:49',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (108,'2021-11-25 21:03:10',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (64,'2021-12-09 10:31:18',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (36,'2021-11-27 18:03:53',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (42,'2021-12-09 17:46:36',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (94,'2021-12-04 21:04:11',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (34,'2021-11-16 16:19:21',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-12-01 07:52:02',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (28,'2021-11-06 18:05:11',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-12-05 09:34:51',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (69,'2021-11-27 12:40:28',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-03 09:28:22',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (127,'2021-11-29 06:01:52',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (62,'2021-11-21 21:42:37',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (6,'2021-11-09 20:59:17',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-11-06 10:50:44',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (101,'2021-12-01 13:12:35',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-16 17:58:16',3000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (20,'2021-11-22 11:09:10',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (118,'2021-11-04 20:12:03',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (124,'2021-11-12 13:13:00',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (70,'2021-11-16 18:04:36',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (30,'2021-11-26 08:53:40',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-04 18:25:55',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (15,'2021-12-05 12:00:09',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (111,'2021-11-02 18:00:26',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-11-11 18:58:11',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (110,'2021-11-05 13:41:48',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (56,'2021-11-22 18:48:32',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (123,'2021-11-15 14:34:31',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (23,'2021-12-04 15:33:07',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (67,'2021-11-10 17:37:06',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (69,'2021-11-06 15:31:41',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-11-22 15:56:10',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (60,'2021-11-06 10:58:48',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-11-11 14:22:51',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (48,'2021-11-13 18:32:33',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (38,'2021-11-14 21:27:22',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (93,'2021-12-02 10:02:56',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (85,'2021-12-09 19:24:40',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (38,'2021-12-09 15:07:47',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-12-09 17:01:58',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (62,'2021-11-07 09:20:44',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-11 10:52:36',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-12-02 17:41:34',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (99,'2021-12-08 08:11:28',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-11-16 15:20:10',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (15,'2021-11-08 21:54:43',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (100,'2021-11-24 19:51:53',4000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-12-08 10:54:20',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (43,'2021-11-28 14:16:31',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (26,'2021-12-03 16:41:57',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (41,'2021-11-13 14:42:43',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (55,'2021-11-09 15:12:23',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (59,'2021-11-15 06:15:42',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-12-08 06:38:18',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (2,'2021-12-01 08:25:09',4000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (50,'2021-11-19 19:35:28',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (58,'2021-11-08 18:50:41',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (93,'2021-11-26 17:09:45',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (94,'2021-11-18 10:38:30',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (32,'2021-11-23 14:06:35',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (105,'2021-12-07 13:13:52',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (80,'2021-11-24 11:30:46',4000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (21,'2021-12-01 17:36:14',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-09 12:20:18',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (62,'2021-11-08 15:11:31',5000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-04 14:57:50',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (31,'2021-11-25 13:02:47',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-04 17:01:06',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (15,'2021-11-04 16:44:24',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (71,'2021-11-18 18:03:19',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-18 19:25:49',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-12-05 18:20:27',3000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-12-05 14:02:33',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (7,'2021-11-20 14:26:53',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (53,'2021-11-26 20:37:41',3000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (8,'2021-11-09 17:19:15',4000,13000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-25 13:11:00',5000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (65,'2021-11-09 06:58:11',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (91,'2021-11-28 09:39:10',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (10,'2021-11-26 07:27:24',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (89,'2021-11-10 20:06:43',3000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (114,'2021-11-27 12:08:38',4000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (119,'2021-11-19 19:46:42',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (115,'2021-11-20 11:47:28',5000,12000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (120,'2021-11-24 15:09:48',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (9,'2021-11-21 12:12:14',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (3,'2021-11-30 13:06:49',4000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (82,'2021-11-22 07:49:35',4000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (110,'2021-11-23 12:39:10',5000,14000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (39,'2021-11-23 07:02:38',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (72,'2021-11-15 14:31:03',5000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (4,'2021-12-10 07:59:23',3000,10000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (30,'2021-12-10 15:06:37',4000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (52,'2021-11-15 07:27:42',5000,8000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (95,'2021-11-25 14:02:59',3000,11000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (28,'2021-11-25 11:55:49',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (93,'2021-12-06 19:34:54',3000,9000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (2,'2021-12-07 17:59:51',5000,15000);
INSERT INTO CoTienDienNuoc (ma_nt,ngay,tiendien,tiennuoc) VALUES (75,'2021-12-06 17:18:32',4000,9000);

INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (1,'2021-11-11 00:00:00',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (3,'2021-11-11 00:00:00',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (4,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-11-11 00:00:00',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (6,'2021-11-11 00:00:00',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (7,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (9,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (10,'2021-11-11 00:00:00',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (11,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-11-11 00:00:00',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (13,'2021-11-11 00:00:00',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (14,'2021-11-11 00:00:00',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (15,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (17,'2021-11-11 00:00:00',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (18,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (19,'2021-11-11 00:00:00',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-11-11 00:00:00',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-11-11 00:00:00',1,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (23,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (24,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (27,'2021-11-11 00:00:00',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (28,'2021-11-11 00:00:00',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (30,'2021-11-11 00:00:00',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (31,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (32,'2021-11-11 00:00:00',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-11 00:00:00',1,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-11 00:00:00',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-11 00:00:00',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (38,'2021-11-11 00:00:00',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (39,'2021-11-11 00:00:00',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (40,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (41,'2021-11-11 00:00:00',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (42,'2021-11-11 00:00:00',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (43,'2021-11-11 00:00:00',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (44,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (45,'2021-11-11 00:00:00',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (46,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-11-11 00:00:00',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (50,'2021-11-11 00:00:00',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (51,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (52,'2021-11-11 00:00:00',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (53,'2021-11-11 00:00:00',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (55,'2021-11-11 00:00:00',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (56,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (57,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-11-11 00:00:00',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (59,'2021-11-11 00:00:00',1,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (60,'2021-11-11 00:00:00',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (61,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (62,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (63,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-11-11 00:00:00',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-11-11 00:00:00',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-11 00:00:00',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (67,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (68,'2021-11-11 00:00:00',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-11-11 00:00:00',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-11 00:00:00',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (71,'2021-11-11 00:00:00',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (72,'2021-11-11 00:00:00',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (73,'2021-11-11 00:00:00',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (74,'2021-11-11 00:00:00',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-11-11 00:00:00',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (76,'2021-11-11 00:00:00',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-11-11 00:00:00',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-11 00:00:00',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (80,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (81,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (82,'2021-11-11 00:00:00',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-11-11 00:00:00',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (84,'2021-11-11 00:00:00',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-11-11 00:00:00',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (86,'2021-11-11 00:00:00',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (87,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (88,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (89,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (90,'2021-11-11 00:00:00',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (91,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (92,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (95,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-11 00:00:00',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (97,'2021-11-11 00:00:00',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (98,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (99,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (100,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (102,'2021-11-11 00:00:00',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-11 00:00:00',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (104,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (105,'2021-11-11 00:00:00',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (107,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (108,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (109,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-11 00:00:00',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-11 00:00:00',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (112,'2021-11-11 00:00:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (113,'2021-11-11 00:00:00',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (114,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (115,'2021-11-11 00:00:00',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-11 00:00:00',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-11-11 00:00:00',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (119,'2021-11-11 00:00:00',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (120,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-11 00:00:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-11-11 00:00:00',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (123,'2021-11-11 00:00:00',1,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (124,'2021-11-11 00:00:00',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-11-11 00:00:00',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-11-11 00:00:00',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-11-11 00:00:00',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-12-08 12:38:10',1,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (102,'2021-11-08 18:11:57',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (62,'2021-11-26 10:07:41',6,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-11-01 07:56:47',4,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-11-24 12:18:52',5,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-12-01 09:05:46',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (30,'2021-11-23 13:26:07',5,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-11-10 18:32:24',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (50,'2021-12-11 18:17:00',1,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-11-06 10:29:17',6,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-11-22 14:09:45',2,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (14,'2021-11-24 15:32:33',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-12-10 16:52:45',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-11-19 11:26:10',4,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-12-10 21:08:38',3,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (120,'2021-12-04 07:35:37',1,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-06 13:45:42',4,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-29 19:26:41',3,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-11 16:05:05',6,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-11-01 12:33:07',5,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-15 06:27:30',3,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (76,'2021-11-15 15:07:47',4,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-26 19:32:53',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (17,'2021-11-21 19:43:06',3,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-11-18 11:09:36',3,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (9,'2021-11-05 18:58:36',2,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (30,'2021-11-15 08:43:18',5,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-05 09:40:19',1,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-11-30 16:08:07',2,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (114,'2021-12-03 18:35:17',2,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-11-22 17:43:35',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-11-14 14:45:45',6,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-12-04 19:22:48',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-11-26 16:23:31',2,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (52,'2021-11-19 14:03:07',5,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (113,'2021-11-06 19:35:46',3,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (13,'2021-12-10 17:17:23',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-11-14 10:44:50',4,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (123,'2021-12-08 13:30:52',2,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-11-05 13:21:48',5,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (115,'2021-12-01 10:53:28',3,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-11-03 19:12:09',5,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (15,'2021-11-19 06:22:36',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (4,'2021-11-30 19:51:27',6,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (44,'2021-11-29 08:23:08',3,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (41,'2021-11-21 09:22:28',4,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (86,'2021-11-07 19:48:09',3,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-11-20 12:17:34',4,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-12-02 13:49:26',2,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (112,'2021-11-11 09:44:30',5,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-11-08 15:06:20',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (56,'2021-11-21 18:51:59',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (52,'2021-12-02 09:38:27',5,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (43,'2021-11-15 18:28:57',6,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (11,'2021-11-28 20:01:32',2,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-11-01 11:17:40',4,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-11-11 15:13:32',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-28 10:01:21',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-11-30 18:55:52',6,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-11-02 12:47:05',4,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-12-10 07:33:27',2,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-11-13 08:23:34',3,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-12-03 20:40:08',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (60,'2021-11-21 19:39:39',2,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (31,'2021-12-11 06:42:29',5,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-14 21:19:26',6,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (19,'2021-12-01 07:34:54',2,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (80,'2021-12-05 12:29:48',3,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (87,'2021-11-15 07:09:33',1,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-04 06:06:29',3,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-11-29 16:29:25',3,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (86,'2021-12-08 06:22:28',1,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (45,'2021-11-27 10:11:17',6,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (90,'2021-11-01 20:50:56',5,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-12-10 09:23:11',3,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (90,'2021-11-10 10:24:23',4,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-11-27 11:11:20',5,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (46,'2021-12-08 07:11:17',5,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (80,'2021-12-05 20:11:46',6,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-30 13:10:51',5,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-10 17:25:52',3,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (31,'2021-11-22 08:38:24',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-11-24 10:01:21',6,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-11-02 17:31:55',2,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (41,'2021-12-08 10:42:58',4,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-24 18:10:48',1,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (31,'2021-12-09 06:57:36',4,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (46,'2021-12-06 13:03:39',3,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-11-24 16:54:46',3,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-01 14:00:06',6,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-11-19 11:06:00',4,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (9,'2021-11-02 18:25:03',1,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (119,'2021-12-06 19:02:38',5,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (115,'2021-11-18 20:41:08',4,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-12-05 18:41:54',5,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-11-13 07:55:55',5,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-26 21:16:34',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-25 08:05:08',6,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-11-23 20:10:54',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-12-08 18:02:27',4,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-11-24 20:11:11',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (28,'2021-12-01 08:51:48',4,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-11-22 16:41:05',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (7,'2021-11-08 06:44:47',4,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-12-05 13:22:48',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (108,'2021-11-27 10:52:54',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (92,'2021-11-26 08:00:40',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (15,'2021-11-06 20:33:48',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-11-18 07:14:18',5,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (1,'2021-11-02 13:01:12',2,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (38,'2021-12-01 08:08:53',2,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (97,'2021-12-07 17:27:27',3,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-12-09 06:31:32',2,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (53,'2021-11-16 15:47:40',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (51,'2021-11-16 13:00:29',4,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-12-09 14:54:40',4,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-17 10:57:30',5,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (76,'2021-11-03 17:05:43',3,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-11-29 12:58:45',2,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (73,'2021-11-16 12:28:57',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (13,'2021-11-05 13:03:39',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (92,'2021-11-30 08:19:32',6,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-23 18:56:01',5,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-12-06 07:56:47',5,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (3,'2021-12-09 19:02:21',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-10 14:54:06',2,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-12-11 09:33:07',4,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (86,'2021-11-08 14:20:15',6,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (115,'2021-11-17 06:35:08',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-12-10 12:18:00',1,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-13 20:00:40',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (92,'2021-11-05 19:23:14',1,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-11-17 16:03:13',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-11-17 09:35:00',6,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-17 06:07:47',3,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-12-08 21:23:11',5,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-12-06 12:02:36',5,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-11-26 18:13:32',6,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-11-26 11:23:25',1,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-13 17:04:51',1,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-11-07 06:04:02',6,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-11-07 09:42:03',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (23,'2021-12-03 20:53:40',4,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-12-07 21:27:22',6,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (43,'2021-11-23 11:49:55',1,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-11-05 17:11:20',2,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-12-02 21:05:20',2,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-11-16 07:36:29',3,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-11-10 15:05:37',2,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-12-07 10:40:13',4,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-11-22 08:47:28',3,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-11-02 12:38:01',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-20 17:29:37',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (76,'2021-11-09 08:29:20',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-11-05 17:32:21',6,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-11-10 06:51:42',3,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-11-16 15:56:36',4,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (55,'2021-11-17 12:37:44',4,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (40,'2021-11-20 20:28:36',2,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-12-08 11:20:07',4,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-09 14:04:25',6,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-11-14 07:24:23',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (43,'2021-11-15 11:08:27',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (41,'2021-12-03 18:47:05',3,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (120,'2021-11-17 08:34:31',6,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (80,'2021-11-02 06:09:04',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-12-04 07:00:12',6,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (107,'2021-11-27 08:15:56',1,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-11-29 13:32:44',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-11-06 15:59:02',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-11-25 19:36:03',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (74,'2021-11-29 09:51:50',4,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-12-11 20:41:00',6,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (3,'2021-11-29 13:55:38',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (95,'2021-11-14 18:38:27',5,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (27,'2021-12-08 15:48:23',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (105,'2021-11-24 09:20:36',6,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-11-21 08:55:49',6,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (86,'2021-11-23 12:58:19',4,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (67,'2021-12-08 08:50:47',4,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (102,'2021-12-01 21:15:07',3,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-11-16 14:39:24',3,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-11-22 06:29:23',4,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-11-05 06:43:47',3,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (100,'2021-11-30 13:46:34',2,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-17 08:29:02',1,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (73,'2021-12-09 19:53:11',4,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (10,'2021-11-25 15:16:08',5,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (51,'2021-11-05 13:08:33',4,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-11-28 06:32:50',2,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-16 17:58:51',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (18,'2021-11-19 09:35:43',1,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-11-17 13:57:22',5,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (30,'2021-12-10 19:30:35',2,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-25 17:43:52',5,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (114,'2021-11-23 13:08:33',6,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (104,'2021-11-28 14:56:33',1,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-12-02 07:00:12',6,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (60,'2021-11-17 14:42:00',6,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (95,'2021-11-14 18:35:25',5,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-12-09 12:55:00',4,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (15,'2021-11-07 15:19:44',2,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-09 09:25:38',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (104,'2021-12-03 08:50:56',5,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (17,'2021-11-22 07:37:29',2,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-11-01 07:38:30',4,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-12-11 06:43:21',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-12-06 10:47:00',5,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (31,'2021-11-06 14:19:49',5,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-12-04 11:55:41',3,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-19 15:11:40',4,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (99,'2021-11-18 21:46:31',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (28,'2021-12-05 11:24:26',3,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-11-28 11:39:16',2,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (10,'2021-11-15 20:52:22',3,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-21 08:02:07',5,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-07 18:34:08',4,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (97,'2021-11-18 17:21:50',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-11-10 10:03:22',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (82,'2021-11-13 12:48:06',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-12-06 16:18:20',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-11-30 10:28:08',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (112,'2021-11-05 08:37:32',1,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-19 13:13:00',4,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-03 14:40:34',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-12-04 10:40:57',2,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (91,'2021-11-14 20:55:49',1,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-12-09 13:30:43',6,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-11-08 15:10:22',2,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-12-04 11:24:35',3,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (87,'2021-11-14 10:41:40',3,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (27,'2021-11-12 20:51:56',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-12-03 10:04:13',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (42,'2021-11-26 16:18:29',4,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (97,'2021-11-26 09:00:52',3,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-11 16:34:19',6,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-08 09:59:20',3,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (84,'2021-12-06 17:06:35',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-12-11 19:48:43',3,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-11-15 12:50:59',5,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (67,'2021-11-17 10:42:40',5,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-14 20:47:20',1,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-12-02 19:06:06',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-11-13 21:22:45',6,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-01 19:29:43',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (82,'2021-11-11 18:06:12',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-12-04 19:12:09',5,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-17 10:59:05',5,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-12-05 13:03:56',6,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-12-04 17:52:05',4,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (68,'2021-12-10 20:27:19',3,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-27 06:42:03',5,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-11-20 10:16:54',6,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-11-29 12:29:14',2,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (97,'2021-11-29 10:45:59',1,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (30,'2021-11-24 20:58:51',3,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (74,'2021-11-24 17:53:05',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-12-08 19:05:05',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-11-04 13:57:30',4,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (74,'2021-11-15 16:33:53',6,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (23,'2021-12-06 06:34:51',5,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-11 21:12:23',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (60,'2021-12-11 07:25:49',5,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-11-30 21:42:37',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-30 18:50:07',2,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-09 11:18:58',6,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-08 18:44:21',4,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-12-05 20:14:47',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-14 09:12:23',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-11-22 08:28:36',5,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (24,'2021-11-09 15:21:10',5,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-04 14:12:03',3,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (95,'2021-12-09 16:26:15',6,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (113,'2021-12-07 07:22:48',6,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (76,'2021-11-15 08:08:18',3,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (115,'2021-11-14 21:50:33',3,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-16 15:23:46',3,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (73,'2021-11-24 12:06:20',6,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-11-02 11:08:53',4,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (23,'2021-11-07 07:43:49',1,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (73,'2021-11-20 10:57:48',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-01 09:15:07',4,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (4,'2021-11-09 14:03:50',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-04 16:42:23',2,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (99,'2021-11-01 19:22:22',4,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-11-02 13:47:34',2,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-19 12:18:35',6,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (3,'2021-11-20 20:50:04',2,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (82,'2021-12-06 07:27:24',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-11-05 08:14:30',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (120,'2021-11-11 07:56:38',6,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (56,'2021-11-01 11:32:38',4,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (41,'2021-11-12 07:54:03',2,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-07 11:14:38',2,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-11-28 14:02:50',4,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (67,'2021-11-20 21:56:01',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (13,'2021-11-13 09:58:36',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (27,'2021-11-26 13:43:06',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (6,'2021-12-07 18:10:05',6,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-12-02 12:14:07',3,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (31,'2021-11-29 11:44:27',6,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (108,'2021-11-04 15:47:40',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (72,'2021-11-10 06:17:17',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (123,'2021-11-20 18:59:20',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (60,'2021-11-27 14:17:57',3,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-11-22 18:26:38',5,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (61,'2021-11-24 12:34:34',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-12-03 12:21:45',5,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (4,'2021-11-25 11:54:40',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (99,'2021-11-09 06:43:38',6,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (40,'2021-11-24 11:46:54',5,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-11-26 11:24:17',3,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-09 09:27:13',4,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (60,'2021-11-29 19:22:05',1,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-17 06:12:23',2,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-12-01 13:56:04',1,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (46,'2021-11-08 15:34:16',6,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-04 21:14:07',5,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (46,'2021-11-04 21:56:44',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (4,'2021-11-24 07:21:56',5,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-11-25 18:00:17',5,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-12-02 20:18:32',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (99,'2021-12-06 08:55:41',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-12-07 14:28:19',5,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (119,'2021-11-01 11:10:36',3,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (13,'2021-11-23 14:20:41',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (43,'2021-11-29 18:20:53',5,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-11-15 18:02:18',2,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-11-26 07:14:01',3,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-11-28 15:58:54',4,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-11-20 21:25:47',4,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (124,'2021-11-22 07:55:47',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-12-01 18:01:00',3,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (32,'2021-11-16 06:36:17',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-11-02 08:50:30',4,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (14,'2021-11-25 21:45:13',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-11-26 18:48:58',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (6,'2021-12-11 14:28:54',2,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-11-22 11:03:24',6,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (89,'2021-12-11 06:33:59',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-23 06:20:18',5,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-16 18:34:42',5,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-11-30 06:45:30',5,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-11-01 16:13:35',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-11-05 14:11:11',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-23 17:33:04',4,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (50,'2021-11-25 21:23:20',6,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-11-15 21:05:37',5,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (92,'2021-11-15 20:24:35',4,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-11-15 14:42:43',4,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (42,'2021-11-09 15:44:30',4,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-04 17:43:26',5,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (51,'2021-11-01 06:05:46',2,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-10 08:58:34',5,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (23,'2021-11-11 10:47:25',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (1,'2021-11-13 06:15:59',2,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (39,'2021-11-10 08:41:25',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (57,'2021-12-05 07:28:08',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-28 12:54:00',4,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-12-04 12:01:44',5,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (24,'2021-11-13 17:30:12',4,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-05 11:21:33',6,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-11-02 17:29:02',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (100,'2021-11-23 07:09:24',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-11-19 06:33:07',2,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (72,'2021-11-26 21:44:38',2,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (84,'2021-11-27 20:32:30',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (44,'2021-11-28 06:14:07',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-12-04 09:34:34',5,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (105,'2021-11-13 08:03:42',2,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (57,'2021-11-20 13:41:57',6,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (92,'2021-12-06 09:34:16',5,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (7,'2021-11-11 18:53:43',3,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-11-04 14:50:12',6,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-11-06 17:52:13',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-11-19 17:25:00',5,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (73,'2021-11-02 17:28:36',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (102,'2021-11-27 07:17:28',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (11,'2021-12-07 12:01:52',5,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (115,'2021-11-21 18:52:42',1,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (9,'2021-11-15 10:55:03',6,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (98,'2021-11-06 14:54:32',4,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-12-03 14:20:41',2,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (113,'2021-11-11 20:12:03',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-30 08:40:25',1,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-11-29 15:24:46',6,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (71,'2021-11-04 12:27:30',3,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (112,'2021-11-06 13:28:34',5,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-12-04 21:39:53',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (46,'2021-11-13 19:07:58',3,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (57,'2021-11-03 17:10:28',5,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-05 19:18:29',5,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-12-10 09:44:12',6,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (14,'2021-11-13 18:02:53',4,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (45,'2021-11-23 16:33:10',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (38,'2021-12-01 17:03:33',3,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (44,'2021-11-08 11:44:10',1,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (113,'2021-12-08 14:01:15',5,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-11-07 21:42:12',3,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-11-10 13:32:18',2,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-11-14 17:27:53',3,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-02 14:36:14',2,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-11-18 10:16:54',6,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-11 07:27:50',4,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-11-26 10:56:30',3,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (13,'2021-11-15 18:56:27',4,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-11-29 16:05:05',6,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-20 18:41:37',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-12-02 13:25:58',5,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-04 09:58:02',1,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-11-10 16:54:55',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-28 10:12:35',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (17,'2021-12-06 09:48:23',3,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (113,'2021-12-08 11:18:58',1,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-12-03 16:32:18',3,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (76,'2021-11-21 20:12:46',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (32,'2021-12-01 12:42:37',6,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-11-28 07:43:58',3,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-11-24 20:40:34',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (11,'2021-11-06 20:30:12',2,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (32,'2021-11-11 08:14:21',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-12-01 13:49:26',6,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-12-04 06:00:43',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-11-19 07:00:37',6,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (7,'2021-11-01 20:47:46',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-11-02 17:07:26',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (86,'2021-11-03 15:01:35',1,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-12-08 09:04:19',3,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (109,'2021-11-13 17:05:51',2,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-11-13 17:31:38',4,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-11-09 06:14:33',6,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-11-12 10:21:04',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (56,'2021-11-02 10:17:37',4,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (6,'2021-11-09 16:39:30',3,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (107,'2021-12-06 20:45:53',4,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (95,'2021-11-26 19:49:00',6,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (98,'2021-11-25 17:57:07',1,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-21 07:35:11',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-11-19 17:00:49',5,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (108,'2021-12-01 11:17:05',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-12-11 20:30:46',2,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (24,'2021-12-06 18:35:43',6,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-26 14:46:11',3,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (57,'2021-11-27 07:43:15',3,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (97,'2021-11-18 10:10:16',4,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-12-11 15:07:47',6,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (27,'2021-11-13 19:13:00',1,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (7,'2021-11-20 17:27:27',4,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (1,'2021-12-01 11:08:01',4,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (63,'2021-11-02 17:25:26',6,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (43,'2021-11-26 21:45:22',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (95,'2021-11-10 09:08:21',6,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (95,'2021-12-05 17:27:01',6,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (107,'2021-11-29 21:04:54',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (18,'2021-12-05 08:34:05',4,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-13 08:54:49',5,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-12-08 11:02:07',2,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (107,'2021-11-19 20:51:56',4,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (107,'2021-11-23 08:20:41',3,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (63,'2021-11-18 17:57:07',2,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-11-13 08:50:04',4,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (80,'2021-11-02 19:35:37',2,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (76,'2021-11-14 16:36:12',5,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-08 17:46:36',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (53,'2021-11-01 08:36:49',2,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (52,'2021-12-01 12:18:09',5,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (71,'2021-12-04 13:34:11',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-23 18:57:53',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-11-20 14:17:57',2,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (7,'2021-11-07 17:18:14',4,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (63,'2021-11-23 10:17:28',1,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-06 21:16:34',3,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (84,'2021-11-08 19:44:33',4,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (112,'2021-11-26 17:22:08',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-07 18:14:59',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-11-27 13:12:09',1,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (100,'2021-12-04 12:56:01',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (87,'2021-11-07 21:47:14',5,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-05 13:39:30',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (115,'2021-11-01 16:30:43',1,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (51,'2021-11-16 08:20:07',6,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-25 09:02:44',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-11 10:27:16',6,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (14,'2021-12-06 08:58:08',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (67,'2021-11-15 09:41:28',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-11-17 09:45:48',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-11-18 12:21:36',4,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (24,'2021-11-05 09:03:01',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-05 08:12:29',3,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (81,'2021-11-07 14:52:13',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (105,'2021-11-11 10:05:05',2,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (52,'2021-11-06 17:59:51',3,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-25 17:16:22',5,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-22 08:42:17',2,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-05 08:41:43',6,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-12-03 14:19:49',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-11-14 12:45:22',2,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-11-26 12:53:43',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (18,'2021-11-26 08:21:42',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-12-11 10:56:04',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-11-21 09:32:50',3,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (71,'2021-12-01 21:06:29',6,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (105,'2021-11-10 14:51:56',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-03 11:20:24',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (63,'2021-11-05 13:53:11',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-11-12 12:11:40',6,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-11-29 15:42:20',5,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-11-03 12:17:08',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-07 20:21:07',3,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-04 10:39:56',1,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (90,'2021-11-15 12:43:55',6,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-11-28 14:08:18',6,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-11-24 13:43:32',3,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (51,'2021-11-27 11:57:42',2,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (108,'2021-11-21 14:06:26',6,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-11-16 16:28:16',6,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (38,'2021-11-16 20:37:15',5,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-12-05 18:54:43',5,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (39,'2021-11-21 11:48:37',4,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (84,'2021-11-18 06:15:07',6,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-12-06 18:32:59',4,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (7,'2021-12-08 13:14:36',3,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (82,'2021-11-30 09:37:00',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (31,'2021-11-19 09:32:15',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (15,'2021-11-26 08:37:32',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (114,'2021-11-25 09:03:01',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (24,'2021-11-07 14:47:37',4,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (30,'2021-11-29 11:28:02',5,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (10,'2021-12-07 08:17:23',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-12-09 12:50:59',3,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (89,'2021-11-14 09:07:29',6,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (50,'2021-12-02 20:23:00',5,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-11-27 12:58:19',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-12-09 14:52:13',1,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (11,'2021-11-20 16:48:17',3,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-12-10 07:01:29',4,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-12-06 17:50:47',6,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (119,'2021-11-05 12:53:00',5,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-10 15:32:33',3,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (18,'2021-11-28 18:02:01',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-12-06 14:17:40',3,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (62,'2021-11-05 09:20:36',5,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-25 08:03:16',3,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-11-20 20:17:23',4,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-11-07 06:25:03',3,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (4,'2021-11-24 08:26:10',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-11-25 10:09:59',2,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-12-08 11:54:23',2,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (124,'2021-12-06 17:45:45',3,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-12-10 15:34:25',4,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-29 08:28:19',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (59,'2021-12-06 11:27:36',6,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-12-04 14:54:23',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-11-19 15:00:26',1,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-11-06 17:00:49',6,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (30,'2021-11-07 10:55:29',4,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-12-08 06:15:59',6,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-11-05 21:27:39',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-06 14:59:08',6,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (78,'2021-11-14 15:07:38',4,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (3,'2021-12-10 11:02:15',1,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (10,'2021-11-14 17:29:28',4,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-12-10 19:05:14',6,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (90,'2021-11-02 09:31:06',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-12-05 06:46:39',4,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (87,'2021-11-19 19:10:16',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-05 12:30:40',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (63,'2021-12-06 20:28:19',4,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (72,'2021-11-20 17:24:00',2,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (46,'2021-11-28 15:21:27',1,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (55,'2021-12-03 07:36:03',6,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (107,'2021-11-01 17:44:18',6,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-12-10 11:35:40',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (46,'2021-11-28 21:03:45',3,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (88,'2021-11-03 14:54:49',5,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-12-04 14:26:18',4,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-19 10:09:07',4,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-17 13:07:58',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (42,'2021-12-10 11:14:12',3,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-11-22 17:40:42',5,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-17 06:26:47',4,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (87,'2021-11-26 06:47:23',6,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-28 06:18:00',5,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (55,'2021-11-15 18:14:24',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-11-22 14:48:46',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (92,'2021-11-17 18:59:02',4,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-11-17 12:54:52',3,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (24,'2021-12-03 13:04:05',2,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-07 10:09:59',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-11-10 07:32:53',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (6,'2021-11-21 09:45:48',4,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-11-29 14:07:26',4,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (123,'2021-12-03 10:57:04',4,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (55,'2021-11-22 13:38:56',1,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-11-06 17:46:02',3,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (67,'2021-11-23 19:43:06',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-13 10:51:45',4,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-29 19:27:16',3,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (114,'2021-11-12 15:27:04',3,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (91,'2021-11-10 17:49:47',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (98,'2021-11-02 15:01:44',2,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (102,'2021-11-28 16:50:27',5,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (95,'2021-11-04 18:20:18',1,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-11-09 10:44:50',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (28,'2021-11-22 10:32:27',5,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (90,'2021-12-04 07:18:55',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (15,'2021-11-16 17:44:18',5,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (80,'2021-11-23 15:29:48',3,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (14,'2021-11-27 08:42:00',1,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (39,'2021-11-21 12:31:41',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-12-08 07:07:15',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (68,'2021-11-17 10:40:57',5,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (1,'2021-12-06 18:37:18',4,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-12-03 10:14:44',3,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (44,'2021-11-24 13:31:00',2,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-29 10:49:00',6,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (121,'2021-11-12 21:24:20',6,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-11-13 20:03:16',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-11-18 19:14:44',6,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (37,'2021-11-14 07:39:48',4,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-12-04 06:21:19',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-10 15:40:36',2,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (115,'2021-11-10 07:15:19',2,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-11-06 17:15:48',1,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (89,'2021-11-05 16:52:45',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (52,'2021-12-10 11:32:38',2,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (44,'2021-12-08 14:36:14',4,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (82,'2021-11-07 06:48:49',4,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (120,'2021-11-06 10:20:12',2,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-15 09:29:23',2,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (14,'2021-11-05 09:22:02',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-11-23 07:12:17',6,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (86,'2021-12-01 12:35:25',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (62,'2021-12-10 07:43:49',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-18 20:34:48',4,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-11-04 15:16:34',3,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (105,'2021-11-03 08:25:00',1,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (14,'2021-11-13 09:02:27',2,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (32,'2021-12-04 08:09:27',5,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-12-03 09:34:25',4,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (38,'2021-11-23 07:34:11',3,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (23,'2021-12-10 21:45:30',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (39,'2021-11-04 11:00:14',4,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-11-30 19:41:57',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (28,'2021-11-08 17:32:21',4,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-01 19:39:39',3,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (13,'2021-12-04 06:48:40',1,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (48,'2021-11-13 19:34:45',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (114,'2021-11-03 20:44:44',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (68,'2021-11-30 15:35:34',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (41,'2021-12-07 12:19:26',5,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-11-04 12:15:07',6,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-11-30 07:18:12',6,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (102,'2021-11-07 06:35:00',2,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-15 08:51:39',4,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-02 19:58:48',6,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-28 06:21:53',3,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-09 06:32:33',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-12-03 21:38:10',3,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (91,'2021-11-22 16:49:35',4,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-11-15 12:34:34',1,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (62,'2021-11-14 15:21:36',4,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (109,'2021-11-20 07:02:56',4,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-11-21 17:11:28',5,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-03 08:57:24',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-11-27 06:32:15',1,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (108,'2021-11-06 13:50:18',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (24,'2021-11-01 18:56:53',2,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (81,'2021-11-28 20:20:33',2,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-11-05 11:44:01',5,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (71,'2021-11-09 13:19:47',6,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (94,'2021-12-03 06:00:00',1,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (40,'2021-11-19 12:01:35',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-12-03 08:33:13',6,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-19 09:15:59',6,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-12-08 19:00:29',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-02 07:47:00',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-11-06 18:38:44',1,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (75,'2021-11-28 17:47:46',2,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-11-24 14:35:40',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (82,'2021-11-29 07:06:49',3,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-11-16 13:04:48',6,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-03 08:56:15',5,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-11-17 16:43:24',1,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (125,'2021-11-29 18:34:25',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (39,'2021-12-09 20:11:46',4,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-11 08:54:58',6,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (42,'2021-11-10 08:40:51',5,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (81,'2021-11-11 08:33:56',5,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-11-06 09:51:59',5,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (3,'2021-12-11 17:32:56',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (89,'2021-11-08 07:53:28',6,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (53,'2021-11-23 14:36:58',6,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (88,'2021-11-09 16:19:47',4,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-12-09 15:54:26',6,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (45,'2021-11-05 10:36:55',5,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (4,'2021-11-28 21:22:54',4,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-11-04 18:10:39',6,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (119,'2021-11-25 13:17:54',1,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-23 16:03:04',5,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (53,'2021-11-07 18:06:29',2,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-30 06:47:48',1,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-11-09 09:06:03',5,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-11-27 20:25:26',4,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (20,'2021-11-27 09:21:19',3,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-11-11 12:51:42',6,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (32,'2021-12-05 07:40:57',5,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (90,'2021-12-04 12:42:29',6,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (127,'2021-11-16 07:42:49',5,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-12-07 21:29:31',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-11-15 07:41:57',2,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (104,'2021-11-11 18:02:18',4,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (88,'2021-11-28 12:28:57',2,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-11-18 18:30:49',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-25 08:21:59',6,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (77,'2021-11-09 06:58:02',3,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-16 13:23:05',3,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-12-09 20:38:41',3,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (6,'2021-11-06 18:17:25',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (85,'2021-11-27 18:59:28',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (119,'2021-11-18 19:33:19',4,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-11-24 08:45:01',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-12-07 15:32:07',2,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-12-09 16:56:21',2,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (4,'2021-12-09 08:27:01',1,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (41,'2021-11-04 06:07:21',3,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-21 07:50:01',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (1,'2021-12-03 06:45:48',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (84,'2021-11-20 13:34:45',3,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (123,'2021-11-18 07:33:36',5,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (18,'2021-11-26 12:43:12',4,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (30,'2021-11-15 16:41:14',6,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (44,'2021-11-30 21:08:47',4,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-11-20 19:01:47',3,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-11-14 16:20:47',1,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (56,'2021-11-25 12:19:09',3,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (105,'2021-11-16 20:33:30',5,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (91,'2021-11-02 16:57:39',5,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (91,'2021-11-16 12:20:01',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-13 07:17:46',6,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-12-01 09:45:04',6,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (91,'2021-12-10 16:15:01',2,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-12-04 12:40:28',5,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (3,'2021-12-05 08:18:23',6,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-12-01 09:29:14',5,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (36,'2021-11-17 12:04:19',5,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (84,'2021-12-11 18:47:31',1,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (105,'2021-11-24 20:38:41',6,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-11-27 10:20:04',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-11-28 14:28:36',3,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (82,'2021-12-09 09:54:00',3,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-11-14 11:05:43',5,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (2,'2021-11-07 13:21:39',5,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (114,'2021-11-18 06:04:36',4,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-12-04 14:17:48',2,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-27 21:45:30',6,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-07 13:20:30',4,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-11-28 14:46:54',3,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-12-07 13:18:46',1,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-12-07 19:11:43',2,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-11-03 14:35:40',1,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-11-01 12:37:26',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-02 21:28:57',5,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (39,'2021-12-09 12:18:26',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (33,'2021-11-22 20:27:36',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (81,'2021-12-11 07:36:37',3,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-11-21 21:41:46',6,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-11-11 16:39:22',5,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (38,'2021-11-04 16:20:38',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (43,'2021-11-03 17:02:24',4,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (34,'2021-12-08 18:19:44',4,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-11-17 07:47:51',6,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (31,'2021-11-01 07:10:16',2,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (68,'2021-11-06 07:21:13',2,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (53,'2021-12-06 12:45:13',5,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (72,'2021-11-17 13:21:13',3,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (119,'2021-11-12 18:56:10',1,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (87,'2021-12-08 07:14:53',4,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (90,'2021-12-07 21:42:37',1,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-12-06 20:46:45',2,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (17,'2021-11-30 19:26:41',3,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (71,'2021-11-27 11:07:26',5,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (107,'2021-11-14 15:41:46',4,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (32,'2021-12-06 18:46:13',4,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (118,'2021-12-07 18:50:24',2,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (123,'2021-11-06 12:25:12',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (124,'2021-11-10 06:00:00',5,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-11 13:40:05',1,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (56,'2021-12-06 20:47:46',2,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (66,'2021-11-18 06:43:12',3,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (79,'2021-11-18 20:46:28',4,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (111,'2021-11-01 10:56:04',2,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-11-18 16:31:35',2,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (12,'2021-12-10 21:15:50',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (7,'2021-11-27 10:17:28',6,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (120,'2021-11-16 14:13:47',3,500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (28,'2021-12-04 06:02:53',6,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-12-08 07:18:29',2,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-09 07:54:12',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (17,'2021-11-04 20:33:13',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-01 16:00:20',6,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-11-12 16:57:48',6,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-12-05 12:40:19',1,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (11,'2021-11-28 20:56:15',2,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (35,'2021-11-15 11:12:12',6,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-11-24 09:07:29',4,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-05 10:43:41',6,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-25 13:28:16',3,900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (103,'2021-11-17 20:53:31',1,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (122,'2021-11-13 18:40:28',3,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-12-06 10:56:04',2,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (58,'2021-11-24 15:01:18',1,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-12-09 09:13:49',2,1000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (9,'2021-11-20 19:22:31',6,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (112,'2021-11-22 21:26:30',5,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (64,'2021-11-17 14:59:00',3,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (18,'2021-11-04 20:56:15',1,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (18,'2021-11-01 10:38:04',1,2400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (116,'2021-12-03 20:08:01',6,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (92,'2021-12-11 06:44:12',2,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (53,'2021-12-06 16:45:24',4,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-11-29 11:25:09',3,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (15,'2021-11-05 13:40:13',3,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (87,'2021-12-04 10:23:57',2,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (21,'2021-12-03 19:31:00',3,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (49,'2021-11-07 21:18:35',4,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (104,'2021-12-04 20:22:16',5,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (102,'2021-11-19 13:47:17',3,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (98,'2021-12-09 14:01:32',4,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (101,'2021-11-30 10:58:48',6,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (25,'2021-12-07 09:11:05',6,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (32,'2021-11-18 17:16:57',3,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (38,'2021-12-09 21:41:20',1,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (108,'2021-11-08 13:49:26',3,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (119,'2021-11-11 19:28:25',2,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (54,'2021-11-05 06:28:05',3,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-11-12 10:25:15',4,1500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (29,'2021-11-17 20:52:22',6,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (110,'2021-11-10 21:01:35',1,2900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (16,'2021-12-05 06:14:41',4,2700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (76,'2021-11-19 06:59:46',2,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (89,'2021-12-04 12:03:45',1,1800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (93,'2021-11-06 11:39:59',6,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (27,'2021-11-26 13:29:00',5,2500000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (52,'2021-11-20 10:28:42',2,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (26,'2021-11-11 20:02:07',3,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (56,'2021-11-17 20:21:42',2,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (60,'2021-11-22 10:46:25',6,2300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (9,'2021-11-03 14:52:05',4,3000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (3,'2021-12-06 15:53:34',5,2000000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-11 19:30:43',3,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (84,'2021-11-24 10:15:01',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (9,'2021-11-26 13:35:20',6,1700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (8,'2021-11-20 17:09:45',2,700000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (81,'2021-12-09 06:23:11',6,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (106,'2021-11-15 12:28:39',3,2200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (83,'2021-12-01 15:11:40',4,2800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (96,'2021-11-13 09:36:26',4,1600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (65,'2021-11-12 14:43:35',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (72,'2021-12-05 17:20:24',1,1100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (69,'2021-12-11 13:07:41',1,1400000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (62,'2021-11-08 21:47:05',4,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (15,'2021-11-20 08:35:05',6,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (70,'2021-12-05 12:17:51',1,2100000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (5,'2021-12-04 07:37:38',3,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (22,'2021-11-01 14:02:15',2,1300000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (6,'2021-11-14 17:53:31',2,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (47,'2021-12-03 10:13:18',2,800000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (114,'2021-11-01 12:46:31',5,600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (117,'2021-11-05 11:42:52',2,2600000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (126,'2021-12-04 08:51:56',1,1900000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (88,'2021-11-23 15:34:25',2,1200000);
INSERT INTO CoGia (ma_nt,ngay,ma_lp,giaphong) VALUES (72,'2021-11-24 19:32:01',2,2200000);
