import 'package:flutter/material.dart';
import 'peminjaman.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Peminjaman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Hitung Peminjaman'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PeminjamanDetailScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Tentang'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TentangScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Selamat datang di Aplikasi Peminjaman!'),
      ),
    );
  }
}

class PeminjamanDetailScreen extends StatefulWidget {
  @override
  _PeminjamanDetailScreenState createState() => _PeminjamanDetailScreenState();
}

class _PeminjamanDetailScreenState extends State<PeminjamanDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaPeminjamController = TextEditingController();
  final _kodePeminjamanController = TextEditingController();
  final _kodeNasabahController = TextEditingController();
  final _tanggalPeminjamanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Peminjam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Nama Peminjam
                TextFormField(
                  controller: _namaPeminjamController,
                  decoration: InputDecoration(labelText: 'Nama Peminjam'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan nama peminjam';
                    }
                    return null;
                  },
                ),
                // Kode Peminjaman
                TextFormField(
                  controller: _kodePeminjamanController,
                  decoration: InputDecoration(labelText: 'Kode Peminjaman'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan kode peminjaman';
                    }
                    return null;
                  },
                ),
                // Kode Nasabah
                TextFormField(
                  controller: _kodeNasabahController,
                  decoration: InputDecoration(labelText: 'Kode Nasabah'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan kode nasabah';
                    }
                    return null;
                  },
                ),
                // Tanggal Peminjaman
                TextFormField(
                  controller: _tanggalPeminjamanController,
                  decoration: InputDecoration(labelText: 'Tanggal Peminjaman (YYYY-MM-DD)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan tanggal peminjaman';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Pindah ke halaman berikutnya dengan membawa data input pengguna
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PeminjamanRincianScreen(
                            namaPeminjam: _namaPeminjamController.text,
                            kodePeminjaman: _kodePeminjamanController.text,
                            kodeNasabah: _kodeNasabahController.text,
                            tanggalPeminjaman: _tanggalPeminjamanController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Lanjutkan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PeminjamanRincianScreen extends StatefulWidget {
  final String namaPeminjam;
  final String kodePeminjaman;
  final String kodeNasabah;
  final String tanggalPeminjaman;

  PeminjamanRincianScreen({
    required this.namaPeminjam,
    required this.kodePeminjaman,
    required this.kodeNasabah,
    required this.tanggalPeminjaman,
  });

  @override
  _PeminjamanRincianScreenState createState() => _PeminjamanRincianScreenState();
}

class _PeminjamanRincianScreenState extends State<PeminjamanRincianScreen> {
  final _formKey = GlobalKey<FormState>();
  final _jumlahPinjamanController = TextEditingController();
  final _lamaPinjamanController = TextEditingController();

  double? _angsuranPerBulan;
  double? _totalHutang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rincian Peminjaman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Jumlah Pinjaman
                TextFormField(
                  controller: _jumlahPinjamanController,
                  decoration: InputDecoration(labelText: 'Jumlah Pinjaman'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan jumlah pinjaman';
                    }
                    return null;
                  },
                ),
                // Lama Pinjaman
                TextFormField(
                  controller: _lamaPinjamanController,
                  decoration: InputDecoration(labelText: 'Lama Pinjaman (bulan)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan lama pinjaman';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double jumlahPinjaman = double.parse(_jumlahPinjamanController.text);
                      int lamaPinjaman = int.parse(_lamaPinjamanController.text);

                      Peminjaman peminjaman = Peminjaman(
                        kode: widget.kodePeminjaman,
                        nama: widget.namaPeminjam,
                        kodePeminjaman: widget.kodePeminjaman,
                        tanggal: DateTime.parse(widget.tanggalPeminjaman),
                        kodeNasabah: widget.kodeNasabah,
                        namaNasabah: widget.namaPeminjam,
                        jumlahPinjaman: jumlahPinjaman,
                        lamaPinjaman: lamaPinjaman,
                      );

                      setState(() {
                        _angsuranPerBulan = peminjaman.angsuranPerBulan;
                        _totalHutang = peminjaman.totalHutang;
                      });
                    }
                  },
                  child: Text('Hitung'),
                ),
                SizedBox(height: 20),
                if (_angsuranPerBulan != null && _totalHutang != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama Peminjam: ${widget.namaPeminjam}'),
                      Text('Kode Peminjaman: ${widget.kodePeminjaman}'),
                      Text('Kode Nasabah: ${widget.kodeNasabah}'),
                      Text('Tanggal Peminjaman: ${widget.tanggalPeminjaman}'),
                      Text('Angsuran Per Bulan: Rp $_angsuranPerBulan'),
                      Text('Total Hutang: Rp $_totalHutang'),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TentangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang'),
      ),
      body: Center(
        child: Text('Aplikasi ini dibuat untuk menghitung peminjaman.'),
      ),
    );
  }
}
