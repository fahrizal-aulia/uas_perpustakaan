// lib/models/sewa.dart

class Sewa {
  final int id;
  final int?
      id_member; // Ubah menjadi nullable karena bisa saja pelanggan belum login
  final int id_buku;
  final String?
      judul_buku; // Ubah menjadi nullable karena bisa saja pelanggan belum login
  final int?
      harga_buku; // Ubah menjadi nullable karena bisa saja pelanggan belum login
  final String?
      tgl_kembali; // Ubah menjadi nullable karena bisa saja pelanggan belum login

  Sewa({
    required this.id,
    this.id_member,
    required this.id_buku,
    this.judul_buku,
    this.harga_buku,
    this.tgl_kembali,
  });

  factory Sewa.fromJson(Map<String, dynamic> json) {
    return Sewa(
      id: json['id'],
      id_member: json['id_member'],
      id_buku: json['id_buku'],
      judul_buku: json['judul_buku'],
      harga_buku: json['harga_buku'],
      tgl_kembali: json['tgl_kembali'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_member': id_member,
      'id_buku': id_buku,
      'judul_buku': judul_buku,
      'harga_buku': harga_buku,
      'tgl_kembali': tgl_kembali,
    };
  }
}
