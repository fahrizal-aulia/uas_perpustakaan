class Buku {
  final int id;
  final String judul;
  final int harga_buku;
  final int stok;
  final String status;

  Buku({
    required this.id,
    required this.judul,
    required this.harga_buku,
    required this.stok,
    required this.status,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'],
      judul: json['judul'],
      harga_buku: json['harga_buku'],
      stok: json['stok'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'harga_buku': harga_buku,
      'stok': stok,
      'status': status,
    };
  }
}
