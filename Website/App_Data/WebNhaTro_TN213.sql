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
	(N'Người nhà trọ không tồn tại'),
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
insert into AnhNhaTro(ma_nt, STT, ten_anh, mota_anh)
values
	(1, 1, '/Content/ckfinder/userfiles/images/ductin/anh1.jpg', N'Nhà trọ An Gia'),
	(1, 2, '/Content/ckfinder/userfiles/images/ductin/anh2.jpg', N'Nhà trọ An Gia'),
	(2, 1, '/Content/ckfinder/userfiles/images/angia/anh3.jpg', N'Nhà trọ Thới Hưng');
go
insert into Ngay(ngay)
values
	('11/11/2021');
go
insert into CoTienDienNuoc(ngay, ma_nt, tiennuoc, tiendien)
values
	('11/11/2021', 1, 15000, 5000),
	('11/11/2021', 2, 13000, 5000),
	('11/11/2021', 3, 9000, 4000),
	('11/11/2021', 4, 9000, 5000),
	('11/11/2021', 5, 14000, 3000),
	('11/11/2021', 6, 15000, 4000),
	('11/11/2021', 7, 9000, 5000),
	('11/11/2021', 8, 12000, 4000),
	('11/11/2021', 9, 11000, 3000),
	('11/11/2021', 10, 12000, 4000),
	('11/11/2021', 11, 13000, 4000),
	('11/11/2021', 12, 14000, 3000),
	('11/11/2021', 13, 8000, 3000),
	('11/11/2021', 14, 10000, 4000),
	('11/11/2021', 15, 11000, 5000),
	('11/11/2021', 16, 15000, 3000),
	('11/11/2021', 17, 14000, 4000),
	('11/11/2021', 18, 13000, 3000),
	('11/11/2021', 19, 13000, 4000),
	('11/11/2021', 20, 11000, 4000),
	('11/11/2021', 21, 12000, 4000),
	('11/11/2021', 22, 14000, 5000),
	('11/11/2021', 23, 15000, 4000),
	('11/11/2021', 24, 11000, 4000),
	('11/11/2021', 25, 13000, 3000),
	('11/11/2021', 26, 9000, 4000),
	('11/11/2021', 27, 10000, 3000),
	('11/11/2021', 28, 8000, 5000),
	('11/11/2021', 29, 9000, 5000),
	('11/11/2021', 30, 8000, 3000),
	('11/11/2021', 31, 13000, 4000),
	('11/11/2021', 32, 13000, 5000),
	('11/11/2021', 33, 12000, 5000),
	('11/11/2021', 34, 10000, 4000),
	('11/11/2021', 35, 10000, 5000),
	('11/11/2021', 36, 9000, 5000),
	('11/11/2021', 37, 14000, 4000),
	('11/11/2021', 38, 11000, 5000),
	('11/11/2021', 39, 9000, 3000),
	('11/11/2021', 40, 10000, 3000),
	('11/11/2021', 41, 12000, 3000),
	('11/11/2021', 42, 9000, 3000),
	('11/11/2021', 43, 12000, 4000),
	('11/11/2021', 44, 8000, 4000),
	('11/11/2021', 45, 12000, 4000),
	('11/11/2021', 46, 12000, 4000),
	('11/11/2021', 47, 9000, 3000),
	('11/11/2021', 48, 13000, 3000),
	('11/11/2021', 49, 8000, 3000),
	('11/11/2021', 50, 12000, 4000),
	('11/11/2021', 51, 11000, 4000),
	('11/11/2021', 52, 11000, 4000),
	('11/11/2021', 53, 9000, 3000),
	('11/11/2021', 54, 9000, 4000),
	('11/11/2021', 55, 12000, 3000),
	('11/11/2021', 56, 12000, 3000),
	('11/11/2021', 57, 11000, 3000),
	('11/11/2021', 58, 8000, 4000),
	('11/11/2021', 59, 12000, 4000),
	('11/11/2021', 60, 14000, 3000),
	('11/11/2021', 61, 15000, 4000),
	('11/11/2021', 62, 13000, 3000),
	('11/11/2021', 63, 10000, 3000),
	('11/11/2021', 64, 13000, 5000),
	('11/11/2021', 65, 13000, 4000),
	('11/11/2021', 66, 13000, 5000),
	('11/11/2021', 67, 11000, 3000),
	('11/11/2021', 68, 14000, 5000),
	('11/11/2021', 69, 9000, 4000),
	('11/11/2021', 70, 15000, 4000),
	('11/11/2021', 71, 13000, 3000),
	('11/11/2021', 72, 10000, 3000),
	('11/11/2021', 73, 12000, 4000),
	('11/11/2021', 74, 15000, 3000),
	('11/11/2021', 75, 10000, 4000),
	('11/11/2021', 76, 15000, 4000),
	('11/11/2021', 77, 15000, 3000),
	('11/11/2021', 78, 12000, 5000),
	('11/11/2021', 79, 10000, 4000),
	('11/11/2021', 80, 8000, 5000),
	('11/11/2021', 81, 15000, 3000),
	('11/11/2021', 82, 14000, 4000),
	('11/11/2021', 83, 14000, 5000),
	('11/11/2021', 84, 9000, 3000),
	('11/11/2021', 85, 11000, 3000),
	('11/11/2021', 86, 15000, 3000),
	('11/11/2021', 87, 14000, 5000),
	('11/11/2021', 88, 10000, 3000),
	('11/11/2021', 89, 11000, 5000),
	('11/11/2021', 90, 13000, 3000),
	('11/11/2021', 91, 14000, 3000),
	('11/11/2021', 92, 8000, 4000),
	('11/11/2021', 93, 13000, 4000),
	('11/11/2021', 94, 10000, 3000),
	('11/11/2021', 95, 8000, 5000),
	('11/11/2021', 96, 9000, 3000),
	('11/11/2021', 97, 8000, 5000),
	('11/11/2021', 98, 11000, 5000),
	('11/11/2021', 99, 12000, 5000),
	('11/11/2021', 100, 8000, 5000),
	('11/11/2021', 101, 13000, 4000),
	('11/11/2021', 102, 12000, 3000),
	('11/11/2021', 103, 10000, 5000),
	('11/11/2021', 104, 10000, 3000),
	('11/11/2021', 105, 15000, 3000),
	('11/11/2021', 106, 8000, 5000),
	('11/11/2021', 107, 13000, 4000),
	('11/11/2021', 108, 12000, 5000),
	('11/11/2021', 109, 15000, 5000),
	('11/11/2021', 110, 13000, 3000),
	('11/11/2021', 111, 10000, 5000),
	('11/11/2021', 112, 14000, 5000),
	('11/11/2021', 113, 12000, 4000),
	('11/11/2021', 114, 11000, 4000),
	('11/11/2021', 115, 10000, 5000),
	('11/11/2021', 116, 13000, 4000),
	('11/11/2021', 117, 15000, 5000),
	('11/11/2021', 118, 10000, 5000),
	('11/11/2021', 119, 12000, 5000),
	('11/11/2021', 120, 13000, 5000),
	('11/11/2021', 121, 9000, 3000),
	('11/11/2021', 122, 12000, 4000),
	('11/11/2021', 123, 14000, 3000),
	('11/11/2021', 124, 9000, 3000),
	('11/11/2021', 125, 13000, 4000),
	('11/11/2021', 126, 10000, 5000),
	('11/11/2021', 127, 9000, 4000);
go
insert into CoGia(ngay, ma_nt, ma_lp, giaphong)
values
	('11/11/2021', 1, 1, 1300000),
	('11/11/2021', 2, 1, 1500000),
	('11/11/2021', 3, 1, 500000),
	('11/11/2021', 4, 1, 900000),
	('11/11/2021', 5, 1, 800000),
	('11/11/2021', 6, 1, 1100000),
	('11/11/2021', 7, 1, 1200000),
	('11/11/2021', 8, 1, 1400000),
	('11/11/2021', 9, 1, 1500000),
	('11/11/2021', 10, 1, 600000),
	('11/11/2021', 11, 1, 700000),
	('11/11/2021', 12, 1, 2000000),
	('11/11/2021', 13, 1, 1000000),
	('11/11/2021', 14, 1, 1300000),
	('11/11/2021', 15, 1, 1200000),
	('11/11/2021', 16, 1, 700000),
	('11/11/2021', 17, 1, 1000000),
	('11/11/2021', 18, 1, 1400000),
	('11/11/2021', 19, 1, 600000),
	('11/11/2021', 20, 1, 1000000),
	('11/11/2021', 21, 1, 1700000),
	('11/11/2021', 22, 1, 1500000),
	('11/11/2021', 23, 1, 1600000),
	('11/11/2021', 24, 1, 1600000),
	('11/11/2021', 25, 1, 700000),
	('11/11/2021', 26, 1, 1600000),
	('11/11/2021', 27, 1, 1100000),
	('11/11/2021', 28, 1, 1300000),
	('11/11/2021', 29, 1, 1400000),
	('11/11/2021', 30, 1, 800000),
	('11/11/2021', 31, 1, 1600000),
	('11/11/2021', 32, 1, 500000),
	('11/11/2021', 33, 1, 1400000),
	('11/11/2021', 34, 1, 1700000),
	('11/11/2021', 35, 1, 1600000),
	('11/11/2021', 36, 1, 1100000),
	('11/11/2021', 37, 1, 1900000),
	('11/11/2021', 38, 1, 800000),
	('11/11/2021', 39, 1, 500000),
	('11/11/2021', 40, 1, 900000),
	('11/11/2021', 41, 1, 1800000),
	('11/11/2021', 42, 1, 600000),
	('11/11/2021', 43, 1, 1900000),
	('11/11/2021', 44, 1, 900000),
	('11/11/2021', 45, 1, 1900000),
	('11/11/2021', 46, 1, 700000),
	('11/11/2021', 47, 1, 1400000),
	('11/11/2021', 48, 1, 1500000),
	('11/11/2021', 49, 1, 800000),
	('11/11/2021', 50, 1, 2000000),
	('11/11/2021', 51, 1, 1600000),
	('11/11/2021', 52, 1, 600000),
	('11/11/2021', 53, 1, 2000000),
	('11/11/2021', 54, 1, 700000),
	('11/11/2021', 55, 1, 1800000),
	('11/11/2021', 56, 1, 1600000),
	('11/11/2021', 57, 1, 900000),
	('11/11/2021', 58, 1, 500000),
	('11/11/2021', 59, 1, 1700000),
	('11/11/2021', 60, 1, 1800000),
	('11/11/2021', 61, 1, 1500000),
	('11/11/2021', 62, 1, 1400000),
	('11/11/2021', 63, 1, 1600000),
	('11/11/2021', 64, 1, 1000000),
	('11/11/2021', 65, 1, 1000000),
	('11/11/2021', 66, 1, 1900000),
	('11/11/2021', 67, 1, 1400000),
	('11/11/2021', 68, 1, 500000),
	('11/11/2021', 69, 1, 2000000),
	('11/11/2021', 70, 1, 500000),
	('11/11/2021', 71, 1, 1900000),
	('11/11/2021', 72, 1, 800000),
	('11/11/2021', 73, 1, 1000000),
	('11/11/2021', 74, 1, 1000000),
	('11/11/2021', 75, 1, 600000),
	('11/11/2021', 76, 1, 500000),
	('11/11/2021', 77, 1, 1300000),
	('11/11/2021', 78, 1, 2000000),
	('11/11/2021', 79, 1, 1200000),
	('11/11/2021', 80, 1, 1400000),
	('11/11/2021', 81, 1, 1200000),
	('11/11/2021', 82, 1, 600000),
	('11/11/2021', 83, 1, 600000),
	('11/11/2021', 84, 1, 500000),
	('11/11/2021', 85, 1, 1100000),
	('11/11/2021', 86, 1, 2000000),
	('11/11/2021', 87, 1, 1200000),
	('11/11/2021', 88, 1, 1200000),
	('11/11/2021', 89, 1, 1600000),
	('11/11/2021', 90, 1, 2000000),
	('11/11/2021', 91, 1, 700000),
	('11/11/2021', 92, 1, 1500000),
	('11/11/2021', 93, 1, 900000),
	('11/11/2021', 94, 1, 1600000),
	('11/11/2021', 95, 1, 1500000),
	('11/11/2021', 96, 1, 1300000),
	('11/11/2021', 97, 1, 1800000),
	('11/11/2021', 98, 1, 1500000),
	('11/11/2021', 99, 1, 1200000),
	('11/11/2021', 100, 1, 700000),
	('11/11/2021', 101, 1, 1600000),
	('11/11/2021', 102, 1, 1900000),
	('11/11/2021', 103, 1, 1100000),
	('11/11/2021', 104, 1, 1400000),
	('11/11/2021', 105, 1, 1800000),
	('11/11/2021', 106, 1, 900000),
	('11/11/2021', 107, 1, 1200000),
	('11/11/2021', 108, 1, 1500000),
	('11/11/2021', 109, 1, 900000),
	('11/11/2021', 110, 1, 1300000),
	('11/11/2021', 111, 1, 600000),
	('11/11/2021', 112, 1, 1500000),
	('11/11/2021', 113, 1, 1000000),
	('11/11/2021', 114, 1, 1400000),
	('11/11/2021', 115, 1, 1300000),
	('11/11/2021', 116, 1, 800000),
	('11/11/2021', 117, 1, 700000),
	('11/11/2021', 118, 1, 1100000),
	('11/11/2021', 119, 1, 1200000),
	('11/11/2021', 120, 1, 900000),
	('11/11/2021', 121, 1, 700000),
	('11/11/2021', 122, 1, 1800000),
	('11/11/2021', 123, 1, 1700000),
	('11/11/2021', 124, 1, 1400000),
	('11/11/2021', 125, 1, 1800000),
	('11/11/2021', 126, 1, 1600000),
	('11/11/2021', 127, 1, 900000);
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
insert into DanhGia(ma_nt, ma_nd, ngay, danhgia, sosao)
values
	(1, 2, '2021-11-13 21:40:00', N'Tốt', 5);
insert into DanhGia(ma_nt, ma_nd, ngay, danhgia, sosao)
values
	(1, 3, '2021-11-12 11:23:00', N'Bình thường', 3);
insert into DanhGia(ma_nt, ma_nd, ngay, danhgia, sosao)
values
	(1, 4, '2021-11-13 15:00:50', N'Tệ', 1);
insert into DanhGia(ma_nt, ma_nd, ngay, danhgia, sosao)
values
	(2, 5, '2021-11-13 21:40:00', N'Tốt', 5);
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