-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 05 Agu 2023 pada 13.16
-- Versi server: 10.5.20-MariaDB
-- Versi PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mgc`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(15) NOT NULL,
  `user_id` int(15) NOT NULL,
  `product_id` int(15) NOT NULL,
  `product` varchar(50) NOT NULL,
  `category` varchar(15) NOT NULL,
  `qty` int(3) NOT NULL,
  `price` int(8) NOT NULL,
  `total` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `product_id`, `product`, `category`, `qty`, `price`, `total`) VALUES
(238, 5, 56, 'XIAOMI REDMIBOOK 15 - I3 1115G4', 'Laptop Consumer', 1, 5400000, 5400000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `checkout`
--

CREATE TABLE `checkout` (
  `order_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `products` text NOT NULL,
  `payment` int(8) NOT NULL,
  `bukti_pay` varchar(50) NOT NULL,
  `status_pengiriman` varchar(16) NOT NULL,
  `tgl` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `checkout`
--

INSERT INTO `checkout` (`order_id`, `user_id`, `products`, `payment`, `bukti_pay`, `status_pengiriman`, `tgl`) VALUES
(156, 5, 'LAPTOP AXIOO SLIMBOOK 14 S1 RYZEN 5 3500, 3x Rp5,450,000', 16350000, 'qr.PNG', 'dalam perjalanan', '2023-07-24'),
(162, 5, 'XIAOMI REDMIBOOK 15 - I3 1115G4, 1x Rp5,400,000', 5400000, 'icon_mgc.PNG', 'dalam perjalanan', '2023-07-25'),
(163, 5, 'XIAOMI REDMIBOOK 15 - I3 1115G4, 1x Rp5,400,000', 5400000, 'Capture.PNG', 'dibatalkan', '2023-07-27'),
(165, 5, 'Acer Aspire One, 1x Rp4,500,000', 4500000, 'IMG_20230727_220908.jpg', 'diterima', '2023-07-31'),
(166, 5, 'LENOVO IDEAPAD SLIM 3i IP 3-14ITL6 J2ID, 1x Rp6,700,000', 6700000, 'IMG_20230727_220908.jpg', 'dikirim', '2023-07-31'),
(167, 5, 'ASUS E402, 2x Rp4,000,000', 8000000, 'IMG_20230727_220908.jpg', 'dikirim', '2023-07-31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `order_id` int(15) NOT NULL,
  `user_id` int(15) NOT NULL,
  `products` text NOT NULL,
  `payment` int(8) NOT NULL,
  `bukti_pay` varchar(50) NOT NULL,
  `tgl` date NOT NULL,
  `status_kirim` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `products`, `payment`, `bukti_pay`, `tgl`, `status_kirim`) VALUES
(164, 5, 'XIAOMI REDMIBOOK 15 - I3 1115G4, 2x Rp5,400,000, ASUS E402, 1x Rp4,000,000', 14800000, 'IMG_20230727_220908.jpg', '2023-07-29', 'dikemas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `product_id` int(15) NOT NULL,
  `product` varchar(50) NOT NULL,
  `stok` int(2) NOT NULL,
  `category` varchar(15) NOT NULL,
  `descriptions` text NOT NULL,
  `price` int(8) NOT NULL,
  `img` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`product_id`, `product`, `stok`, `category`, `descriptions`, `price`, `img`) VALUES
(50, 'ASUS E402', 10, 'Laptop Konsumer', 'Asus E402 adalah salah varian laptop seri VivoBook yang didesain untuk penggunaan sehari-hari. Dengan harga yang terjangkau, laptop satu ini sangat pas untuk para pelajar dan mahasiswa. Laptop ini memiliki layar seluas 14 inci, penyimpanan yang cukup besar, dan kinerja komputasi yang tidak terlalu mengecewakan. Jika berbicara tentang performa, laptop kelas low-end ini memang didesain agar dapat menjalankan tugas-tugas komputasi dasar saja seperti mengetik, browsing, hingga streaming.', 4000000, 'fg.png'),
(51, 'ASUS ROG', 20, 'Laptop Gaming', 'ini adalah laptop yang dikenal untuk bermain game sangat lancar ditahun 2023', 19500000, 'ASUS_ROG.jpg'),
(52, 'Acer Aspire One', 15, 'Laptop Consumer', 'Laptop yang umum digunakan untuk bekerja dibidang akuntansi, dengan laptop acer Aspire One pekerjaan yang berkaitan dengan word excel power point, dapat segera diselesaikan dengan cepat,\r\nram 6 ssd 128, processor amd', 4500000, 'zenfone_m1.jpg'),
(53, 'Apple Macbook Air 13inch M1 2021', 20, 'Laptop Consumer', 'Macbook Air M1 13inch produksi 2020 Spec :\r\ntersedia 8/256 dan 8/512\r\nChip M1\r\nlayar 13.3 inch\r\nDua port Thunderbolt/USB 4\r\nMagic Keyboard berlampu latar\r\n\r\nMacbook Air M2 13inch produksi 2022 Spec :\r\ntersedia 8/256 dan 8/512\r\nChip Terbaru M2\r\nlayar 13,6 Inch\r\nDua port Thunderbolt / USB 4 dengan dukungan untuk pengisian daya, DisplayPort, Thunderbolt 3 (hingga 40 Gbps), USB 4 hingga 40 Gbps), USB 3.1 Gen 2 (hingga 10 Gbps)\r\nMacOS Monterey', 11700000, 'aple mac book.png'),
(54, 'ASUS VIVOBOOK 14X M1403QA RYZEN 5 5600H', 15, 'Laptop Consumer', 'Military grade : US MIL-STD 810H military-grade standard\r\nTouch Panel : N/A\r\nDisplay : 14.0-inch WUXGA (1920 x 1200) 16:10 aspect ratio LED Backlit IPS-level Panel 300nits 45% NTSC color gamut Anti-glare display\r\nScreen-to-body ratio : 86 ％\r\n\r\nProcessor : AMD Ryzen™ 5 5600H Mobile Processor (6-core/12-thread, 19MB cache, up to 4.2 GHz max boost)\r\nIntergrated GPU : AMD Radeon™ Vega 7 Graphics\r\nTotal System Memory : 8GB DDR4 on board , Upgradeable up to 16GB\r\nOn board memory : 8GB DDR4 on board\r\nStorage : 512GB M.2 NVMe™ PCIe® 3.0 SSD\r\n\r\nHow to upgrade memory : Upgradable - Need to remove bottom/top case\r\nExpansion Slot(includes used) :\r\n1x DDR4 SO-DIMM slot\r\n1x M.2 2280 PCIe 3.0x4\r\n\r\nOptical Drive : N/A\r\nFront-facing camera : 720p HD camera With privacy shutter\r\nWireless : Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth 5\r\nKeyboard type : Backlit Chiclet Keyboard\r\nNumberPad :N/A\r\nScreenPad™ : N/A\r\nFingerPrint : FingerPrint\r\n\r\nI/O ports :\r\n1x USB 2.0 Type-A\r\n1x USB 3.2 Gen 1 Type-C\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 1.4\r\n1x 3.5mm Combo Audio Jack\r\n1x DC-in\r\n\r\nAudio :\r\nSonicMaster\r\nBuilt-in speaker\r\nBuilt-in array microphone\r\nVoice control : with Cortana and Alexa voice-recognition support\r\n\r\nAC Adapter : ø4.5, 90W AC Adapter, Output: 19V DC, 4.74A, 90W, Input: 100~240V AC 50/60Hz universal\r\nBattery : 50WHrs, 3S1P, 3-cell Li-ion\r\nReplaceable Battery : No\r\nDimension (WxHxD) : 31.71 x 22.20 x 1.99 ~ 1.99 cm\r\nWeight (with Battery) : 1.60 kg\r\nWeight (without Battery) : 1.22 kg\r\nIncluded in the Box : Backpack', 8000000, 'vivobok.png'),
(55, 'LENOVO IDEAPAD SLIM 3i IP 3-14ITL6 J2ID', 10, 'Laptop Consumer', 'Processor : Intel Core i3-1115G4 (2C / 4T, 3.0 / 4.1GHz, 6MB)\r\n\r\nType Grafis : Integrated Intel UHD Graphics\r\n\r\nChipset : Intel SoC Platform\r\n\r\nPenyimpanan : 512GB SSD M.2 2280 PCIe 3.0x4 NVMe\r\nStorage Support\r\nModel with 38Wh battery: up to two drives, 1x 2.5\" HDD + 1x M.2 SSD\r\n2.5\" HDD up to 1TB\r\nM.2 2242 SSD up to 512GB\r\nM.2 2280 SSD up to 512GB\r\n\r\nMemory RAM : 8GB Soldered DDR4-3200, dual-channel capable. Up to 16GB (8GB soldered + 8GB SO-DIMM) DDR4-3200 offering\r\n\r\nUkuran Layar : 14\" FHD (1920x1080) TN 250nits Anti-glare, 45% NTSC\r\n\r\nKeyboard : Backlit, English\r\n\r\nCard Reader : 4-in-1 Card Reader\r\n\r\nAudio Chip : High Definition (HD) Audio, Realtek ALC3287 codec\r\n\r\nSpeakers : Stereo speakers, 1.5W x2, Dolby Audio\r\n\r\nCamera : HD 720p with Privacy Shutter\r\n\r\nMicrophone : 2x, Array\r\n\r\nWLAN + Bluetooth : 11ac, 2x2 + BT5.0\r\n\r\nStandard Ports:\r\n1x USB 2.0\r\n1x USB 3.2 Gen 1\r\n1x USB-C 3.2 Gen 1 (support data transfer only)\r\n1x HDMI 1.4b\r\n1x Card reader\r\n1x Headphone / microphone combo jack (3.5mm)\r\n1x Power connector\r\n\r\nBattery : Integrated 38Wh\r\n\r\nPower Adapter : 65W Round Tip (2-pin, Wall-mount)\r\n\r\nCase Color : Arctic Grey\r\n\r\nWeight : Starting at 1.41 kg (3.1 lbs)\r\n\r\nOS : Windows 11 Home + Office Home Student 2021\r\n\r\nWarranty : 2Y Premium Care -IPENTRY (ESS) (5WS0X58233)', 6700000, 'lenovo ideapad.jpg'),
(56, 'XIAOMI REDMIBOOK 15 - I3 1115G4', 20, 'Laptop Consumer', 'SSD 256GB bawaan nya (SEGEL)\r\nSSD 512GB CUSTOM (bawaan 256gb di custom menjadi 512gb/1tb) dan TIDAK SEGEL. CUSTOM hanya bisa claim melalui seller ya. Terima kasih\r\n\r\nSpesifikasi :\r\n\r\n- Prosessor : Intel Core i3 1115G4\r\n- Memory : 8 GB DDR4\r\n- Storage : 512 GB SSD\r\n- Graphics : Intel UHD Graphics\r\n- Display : 15.6 inch 1920x1080 FHD\r\n- OS : Windows 10 Home\r\n\r\nGaransi Resmi XIAOMI 2 Tahun\r\n\r\n\r\nKET BUNDLE :\r\n\r\n- Non Bundle : Unit only BNIB\r\n- Bundle Standart : Screen Protector only\r\n- Bundle Extra : Screen Protector + Laminating Body + Cleaning kit', 5400000, 'redmibook15.jpg'),
(57, 'HP 14S EM0014AU RYZEN 3 7320U', 15, 'Laptop Consumer', 'Variant :\r\nEM0014AU : Silver (Backlite Keyboard)\r\nEM0032AU : Black (Non Backlite Keyboard)\r\nEM0033AU : Gold (Backlite Keyboard)\r\n+Screen Protect : Include Screen Protector\r\n\r\nSpesifikasi :\r\n• Prosesor : AMD Ryzen™ 3-7320U Quad Core processor 2.40 GHz Up to 4.1GHz CPU Cores 4, Threads\r\n• Memory : 8GB LPDDR5 (onboard)\r\n• Storage : 512 GB PCIe® NVMe™ M.2 SSD\r\n• Display : 14\" diagonal,FHD (1920 x 1080), Antiglare SVA 250 nits\r\n• Graphics : AMD Radeon™ 610M\r\n• Operating System : Windows 11 Home\r\n• Office : Home and Student 2021\r\n\r\n• Ports :\r\n1 SuperSpeed USB Type-C® 5Gbps signaling rate;\r\n2 SuperSpeed USB Type-A 5Gbps signaling rate;\r\n1 HDMI 1.4b;\r\n1 AC smart pin;\r\n1 headphone/microphone combo\r\n\r\n• Expansion Slots : 1 multi-format SD media card reader\r\n• Audio Features : Dual speakers\r\n• Webcam : HP True Vision 1080p FHD camera with temporal noise reduction and integrated dual array digital microphones\r\n• Keyboard : Full-size, backlit, natural silver keyboard\r\n• Wireless : Realtek RTL8822CE 802.11a/b/g/n/ac (2x2) Wi-Fi® and Bluetooth® 5 combo\r\n• Battery Type : 3-cell, 41 Wh Li-ion\r\n• Dimensions Without Stand (W X D X H) : 32.4 x 22.5 x 1.79 cm', 6400000, 'hp14s.jpg'),
(59, 'LAPTOP AXIOO SLIMBOOK 14 S1 RYZEN 5 3500', 15, 'Laptop Consumer', 'Processor : AMD RYZEN 5 3500u\r\nMemory : 8GB dual channel (terdapat 1 slot ram kosong bisa di tambah)\r\nStorage : 256 SSD (terdapat 1 slot ssd kosong bisa di tambah)\r\nGraphics : VEGA 8\r\nOperating System : Windows 10 PRO\r\nDisplay : 14.0\" FHD\r\n\r\nKelengkapan : Unit Laptop, Dus Laptop, Charger Laptop, Kartu Garansi,Sleve Axioo\r\n\r\nGaransi 5 hari tukar unit baru\r\nGaransi Resmi Axioo Indonesia 1 Tahun\r\n\r\n\r\nVARIAN BUNDLING HEMAT :\r\n\r\n+ANTIGORES : mendapatkan laptop dan anti gores layar dan belakang layar agar laptop tidak\r\nlecet2 dan free cleaning kit (free instalasi).\r\n\r\n+FLASHDISK : mendapatkan laptop dan flashdisk 16gb dari sandisk ORIGINAL.\r\n\r\n+CARBONSLVCASE : mendapatkan laptop dan sleevecase carbon original bahan tebal dan waterproof warna brown, blue, grey.\r\n\r\n+OFFICE365 1 atau 3 THN : mendapatkan laptop dan office 365 resmi original masa berlaku 1 atau 3 tahun microsoft product key letter of certification.non retail pack, tinggal masukan code product key langsung aktif', 5450000, 'LAPTOP AXIOO SLIMBOOK.jpg'),
(60, 'MSI Modern 14 C5M Ryzen 7 5825U', 10, 'Laptop Consumer', 'Modern 14 C5M-0033ID - 16GB\r\n\r\nWarna : Classic Black\r\nDisplay : 14\" FHD (1920*1080), IPS-Level,Thin Bezel\r\nCamera : HD type (30fps@720p)\r\nVGA, V-RAM : AMD Radeon™ Graphics\r\nCPU : Ryzen 7 5825U\r\nKeyboard : Single backlight KB (White)\r\nMemory : DDR IV 8GB / DDR IV 16GB (3200MHz)\r\nStorage : 512GB NVMe PCIe Gen3x4 SSD\r\nWLAN : AMD Wi-Fi 6E RZ608 + BT5.1\r\nOS : Windows11 Home\r\nBattery : 3 cell, 39.3Whr\r\nI/O Ports :\r\n1x Type-C USB3.2 Gen2 with PD charging\r\n1x Type-A USB3.2 Gen2\r\n1x (4K @ 30Hz) HDMI\r\n1x Micro SD Card Reader\r\n2x Type-A USB2.0\r\n\r\nWarranty : 2 years\r\nWeight (w/ battery) : 1.4 kg\r\nDimension (WxDxH) : 223 x 319.9 x 19.35 mm\r\nBundle : MSI Sleeve Bag_GP\r\n\r\nCooler Boost: Solusi termal khusus, Cooler Boost bekerja dengan meminimalisir panas dan memaksimalkan aliran udara untuk performa yang maksimal.\r\n\r\nThin Bezel IPS-Level Panel: Design bezel yang tipis dan dibekali dengan layar IPS-level panel untuk menghadirkan akurasi warna yang lebih tajam.\r\n\r\nUltra Light: Laptop ultra portable dengan bobot hanya 1.4 kg dan tebal hanya 19.35mm.\r\n\r\nHi-Res Audio: Benamkan diri Anda dalam musik dan nikmati kualitas suara premium dengan Hi-Resolution.\r\n\r\nMSI Center: Fitur pintar yang dapat membantu untuk mengontrol dan menyesuaikan laptop MSI sesuai kebutuhan anda.\r\n\r\nMilitary-Grade Durability: Sudah memenuhi standar militer MIL-STD-810G untuk keandalan dan ketahanan.', 9100000, 'MSI Modern 14 C5M Ryzen 7 5825U.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(5) NOT NULL,
  `email` varchar(50) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `telp` varchar(13) NOT NULL,
  `alamat` text NOT NULL,
  `role` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `email`, `nama`, `password`, `telp`, `alamat`, `role`) VALUES
(5, 'y@gmail.com', 'Yosep Doni Saputra', 'c4ca4238a0b923820dcc509a6f75849b', '085821807128', 'Pontianak Timur,Jl Paralel Tol, belakang kantor lurah kontrakan biru no 4\r\n', 'admin'),
(38, 'tes@gmail.com', 'coba testing', 'c4ca4238a0b923820dcc509a6f75849b', '085753613718', 'Sintang', 'user');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indeks untuk tabel `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`order_id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239;

--
-- AUTO_INCREMENT untuk tabel `checkout`
--
ALTER TABLE `checkout`
  MODIFY `order_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
