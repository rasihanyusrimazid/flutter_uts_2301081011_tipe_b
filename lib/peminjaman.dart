class Peminjaman {
  final String kode;
  final String nama;
  final String kodePeminjaman;
  final DateTime tanggal;
  final String kodeNasabah;
  final String namaNasabah;
  final double jumlahPinjaman;
  final int lamaPinjaman; // dalam bulan
  double bunga = 0;
  double angsuranPokok = 0;
  double angsuranPerBulan = 0;
  double totalHutang = 0;

  Peminjaman({
    required this.kode,
    required this.nama,
    required this.kodePeminjaman,
    required this.tanggal,
    required this.kodeNasabah,
    required this.namaNasabah,
    required this.jumlahPinjaman,
    required this.lamaPinjaman,
  }) {
    hitungAngsuran();
  }

  void hitungAngsuran() {
    angsuranPokok = jumlahPinjaman / lamaPinjaman;
    bunga = jumlahPinjaman * 0.12; // Bunga 12%
    totalHutang = jumlahPinjaman + bunga;
    angsuranPerBulan = (bunga / lamaPinjaman) + angsuranPokok;
  }
}
