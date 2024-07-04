class Sewa {
  final int id;
  final int id_member;
  final int id_buku;
  final String judul_buku; // Menambahkan judul buku
  final int harga_buku;
  final String tgl_kembali;

  Sewa({
    required this.id,
    required this.id_member,
    required this.id_buku,
    required this.judul_buku, // Menambahkan judul buku
    required this.harga_buku,
    required this.tgl_kembali,
  });

  factory Sewa.fromJson(Map<String, dynamic> json) {
    return Sewa(
      id: json['id'],
      id_member: json['id_member'],
      id_buku: json['id_buku'],
      judul_buku: json['judul_buku'], // Menambahkan judul buku
      harga_buku: json['harga_buku'],
      tgl_kembali: json['tgl_kembali'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_member': id_member,
      'id_buku': id_buku,
      'judul_buku': judul_buku, // Menambahkan judul buku
      'harga_buku': harga_buku,
      'tgl_kembali': tgl_kembali,
    };
  }
}
