-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 16, 2025 at 07:47 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_manajemen_rumah_sakit`
--

-- --------------------------------------------------------

--
-- Table structure for table `apotek`
--

CREATE TABLE `apotek` (
  `ID_Apotek` int(11) NOT NULL,
  `Nama_Obat` varchar(100) NOT NULL,
  `Stok` int(11) NOT NULL,
  `Harga` decimal(10,2) NOT NULL,
  `Tanggal_Kadaluarsa` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dokter`
--

CREATE TABLE `dokter` (
  `ID_Dokter` int(11) NOT NULL,
  `Nama` varchar(100) NOT NULL,
  `SIP` varchar(50) NOT NULL,
  `Spesialisasi` varchar(100) NOT NULL,
  `No_Telepon` varchar(15) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Jadwal_Praktik` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jadwalkonsultasi`
--

CREATE TABLE `jadwalkonsultasi` (
  `ID_Jadwal` int(11) NOT NULL,
  `ID_Dokter` int(11) NOT NULL,
  `ID_Pasien` int(11) NOT NULL,
  `Tanggal` date NOT NULL,
  `Waktu` time NOT NULL,
  `Ruangan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keuangan`
--

CREATE TABLE `keuangan` (
  `ID_Transaksi` int(11) NOT NULL,
  `ID_Pasien` int(11) NOT NULL,
  `Jenis_Transaksi` enum('Pendaftaran','Konsultasi','Pembelian Obat','Lainnya') NOT NULL,
  `Jumlah` decimal(10,2) NOT NULL,
  `Tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laboratorium`
--

CREATE TABLE `laboratorium` (
  `ID_Lab` int(11) NOT NULL,
  `Jenis_Tes` varchar(50) NOT NULL,
  `Hasil_Tes` text NOT NULL,
  `Tanggal_Tes` date NOT NULL,
  `ID_Pasien` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `ID_Pasien` int(11) NOT NULL,
  `Nama` varchar(100) NOT NULL,
  `NIK` char(16) NOT NULL,
  `Tanggal_Lahir` date NOT NULL,
  `Jenis_Kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `Alamat` text NOT NULL,
  `No_Telepon` varchar(15) NOT NULL,
  `Status_Asuransi` enum('BPJS','Asuransi Swasta','Umum') NOT NULL,
  `Nomor_Rekam_Medis` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `perawat`
--

CREATE TABLE `perawat` (
  `ID_Perawat` int(11) NOT NULL,
  `Nama` varchar(100) NOT NULL,
  `STR` varchar(50) NOT NULL,
  `Departemen` varchar(100) NOT NULL,
  `No_Telepon` varchar(15) NOT NULL,
  `Shift_Jadwal` text NOT NULL,
  `ID_Ruangan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `perawat_dokter`
--

CREATE TABLE `perawat_dokter` (
  `ID_Perawat` int(11) NOT NULL,
  `ID_Dokter` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `perawat_pasien`
--

CREATE TABLE `perawat_pasien` (
  `ID_Perawat` int(11) NOT NULL,
  `ID_Pasien` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rekammedis`
--

CREATE TABLE `rekammedis` (
  `ID_Rekam` int(11) NOT NULL,
  `ID_Pasien` int(11) NOT NULL,
  `ID_Dokter` int(11) NOT NULL,
  `Diagnosa` text NOT NULL,
  `Obat_Diberikan` text NOT NULL,
  `Tindakan` enum('Operasi','Rawat Jalan','Rawat Inap') NOT NULL,
  `Tanggal_Pemeriksaan` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `ID_Ruangan` int(11) NOT NULL,
  `Nama_Ruangan` varchar(100) NOT NULL,
  `Kapasitas` int(11) NOT NULL,
  `Status_Ketersediaan` enum('Tersedia','Penuh') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apotek`
--
ALTER TABLE `apotek`
  ADD PRIMARY KEY (`ID_Apotek`);

--
-- Indexes for table `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`ID_Dokter`),
  ADD UNIQUE KEY `SIP` (`SIP`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `jadwalkonsultasi`
--
ALTER TABLE `jadwalkonsultasi`
  ADD PRIMARY KEY (`ID_Jadwal`),
  ADD KEY `ID_Dokter` (`ID_Dokter`),
  ADD KEY `ID_Pasien` (`ID_Pasien`);

--
-- Indexes for table `keuangan`
--
ALTER TABLE `keuangan`
  ADD PRIMARY KEY (`ID_Transaksi`),
  ADD KEY `ID_Pasien` (`ID_Pasien`);

--
-- Indexes for table `laboratorium`
--
ALTER TABLE `laboratorium`
  ADD PRIMARY KEY (`ID_Lab`),
  ADD KEY `ID_Pasien` (`ID_Pasien`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`ID_Pasien`),
  ADD UNIQUE KEY `NIK` (`NIK`),
  ADD UNIQUE KEY `Nomor_Rekam_Medis` (`Nomor_Rekam_Medis`);

--
-- Indexes for table `perawat`
--
ALTER TABLE `perawat`
  ADD PRIMARY KEY (`ID_Perawat`),
  ADD UNIQUE KEY `STR` (`STR`),
  ADD KEY `ID_Ruangan` (`ID_Ruangan`);

--
-- Indexes for table `perawat_dokter`
--
ALTER TABLE `perawat_dokter`
  ADD PRIMARY KEY (`ID_Perawat`,`ID_Dokter`),
  ADD KEY `ID_Dokter` (`ID_Dokter`);

--
-- Indexes for table `perawat_pasien`
--
ALTER TABLE `perawat_pasien`
  ADD PRIMARY KEY (`ID_Perawat`,`ID_Pasien`),
  ADD KEY `ID_Pasien` (`ID_Pasien`);

--
-- Indexes for table `rekammedis`
--
ALTER TABLE `rekammedis`
  ADD PRIMARY KEY (`ID_Rekam`),
  ADD KEY `ID_Pasien` (`ID_Pasien`),
  ADD KEY `ID_Dokter` (`ID_Dokter`);

--
-- Indexes for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`ID_Ruangan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apotek`
--
ALTER TABLE `apotek`
  MODIFY `ID_Apotek` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dokter`
--
ALTER TABLE `dokter`
  MODIFY `ID_Dokter` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jadwalkonsultasi`
--
ALTER TABLE `jadwalkonsultasi`
  MODIFY `ID_Jadwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keuangan`
--
ALTER TABLE `keuangan`
  MODIFY `ID_Transaksi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `laboratorium`
--
ALTER TABLE `laboratorium`
  MODIFY `ID_Lab` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `ID_Pasien` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `perawat`
--
ALTER TABLE `perawat`
  MODIFY `ID_Perawat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rekammedis`
--
ALTER TABLE `rekammedis`
  MODIFY `ID_Rekam` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ruangan`
--
ALTER TABLE `ruangan`
  MODIFY `ID_Ruangan` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jadwalkonsultasi`
--
ALTER TABLE `jadwalkonsultasi`
  ADD CONSTRAINT `jadwalkonsultasi_ibfk_1` FOREIGN KEY (`ID_Dokter`) REFERENCES `dokter` (`ID_Dokter`),
  ADD CONSTRAINT `jadwalkonsultasi_ibfk_2` FOREIGN KEY (`ID_Pasien`) REFERENCES `pasien` (`ID_Pasien`);

--
-- Constraints for table `keuangan`
--
ALTER TABLE `keuangan`
  ADD CONSTRAINT `keuangan_ibfk_1` FOREIGN KEY (`ID_Pasien`) REFERENCES `pasien` (`ID_Pasien`);

--
-- Constraints for table `laboratorium`
--
ALTER TABLE `laboratorium`
  ADD CONSTRAINT `laboratorium_ibfk_1` FOREIGN KEY (`ID_Pasien`) REFERENCES `pasien` (`ID_Pasien`);

--
-- Constraints for table `perawat`
--
ALTER TABLE `perawat`
  ADD CONSTRAINT `perawat_ibfk_1` FOREIGN KEY (`ID_Ruangan`) REFERENCES `ruangan` (`ID_Ruangan`);

--
-- Constraints for table `perawat_dokter`
--
ALTER TABLE `perawat_dokter`
  ADD CONSTRAINT `perawat_dokter_ibfk_1` FOREIGN KEY (`ID_Perawat`) REFERENCES `perawat` (`ID_Perawat`),
  ADD CONSTRAINT `perawat_dokter_ibfk_2` FOREIGN KEY (`ID_Dokter`) REFERENCES `dokter` (`ID_Dokter`);

--
-- Constraints for table `perawat_pasien`
--
ALTER TABLE `perawat_pasien`
  ADD CONSTRAINT `perawat_pasien_ibfk_1` FOREIGN KEY (`ID_Perawat`) REFERENCES `perawat` (`ID_Perawat`),
  ADD CONSTRAINT `perawat_pasien_ibfk_2` FOREIGN KEY (`ID_Pasien`) REFERENCES `pasien` (`ID_Pasien`);

--
-- Constraints for table `rekammedis`
--
ALTER TABLE `rekammedis`
  ADD CONSTRAINT `rekammedis_ibfk_1` FOREIGN KEY (`ID_Pasien`) REFERENCES `pasien` (`ID_Pasien`),
  ADD CONSTRAINT `rekammedis_ibfk_2` FOREIGN KEY (`ID_Dokter`) REFERENCES `dokter` (`ID_Dokter`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
