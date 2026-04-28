class Kost {
  final String id;
  final String name;
  final String location;
  final int price;
  final double rating;
  final String imageUrl;
  final String type;

  Kost({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.type,
  });
}

final List<Kost> mockKosts = [
  Kost(
    id: '1',
    name: 'Kost Nyaman Setiabudi',
    location: 'Setiabudi, Jakarta Selatan',
    price: 1800000,
    rating: 4.8,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Campuran',
  ),
  Kost(
    id: '2',
    name: 'Kost Putri Mandiri',
    location: 'Depok, Jawa Barat',
    price: 1500000,
    rating: 4.7,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Putri',
  ),
  Kost(
    id: '3',
    name: 'Kost Modern Tebet',
    location: 'Tebet, Jakarta Selatan',
    price: 1600000,
    rating: 4.6,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Campuran',
  ),
  Kost(
    id: '4',
    name: 'Kost Minimalis Jaksel',
    location: 'Kebayoran, Jakarta Selatan',
    price: 1700000,
    rating: 4.5,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Putra',
  ),
  Kost(
    id: '5',
    name: 'Kost Hemat Bogor',
    location: 'Bogor, Jawa Barat',
    price: 900000,
    rating: 4.2,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Campuran',
  ),
  Kost(
    id: '6',
    name: 'Kost Elite Menteng',
    location: 'Menteng, Jakarta Pusat',
    price: 2500000,
    rating: 4.9,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Putra',
  ),
  Kost(
    id: '7',
    name: 'Kost Cozy Bandung',
    location: 'Bandung, Jawa Barat',
    price: 1200000,
    rating: 4.4,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Campuran',
  ),
  Kost(
    id: '8',
    name: 'Kost Nyaman Surabaya',
    location: 'Surabaya, Jawa Timur',
    price: 1100000,
    rating: 4.3,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Putra',
  ),
  Kost(
    id: '9',
    name: 'Kost Strategis Semarang',
    location: 'Semarang, Jawa Tengah',
    price: 1000000,
    rating: 4.0,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Campuran',
  ),
  Kost(
    id: '10',
    name: 'Kost Dekat Kampus',
    location: 'Depok, Jawa Barat',
    price: 1300000,
    rating: 4.1,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Putra',
  ),
];

final List<Kost> nearbyKosts = [
  Kost(
    id: 'n1',
    name: 'Kost Mahasiswa A',
    location: 'Dekat Universitas Indonesia',
    price: 900000,
    rating: 4.2,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Putra',
  ),
  Kost(
    id: 'n2',
    name: 'Kost Mahasiswa B',
    location: 'Dekat Universitas Indonesia',
    price: 1000000,
    rating: 4.3,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Putri',
  ),
  Kost(
    id: 'n3',
    name: 'Kost Mahasiswa C',
    location: 'Dekat Universitas Indonesia',
    price: 850000,
    rating: 4.0,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Campuran',
  ),
  Kost(
    id: 'n4',
    name: 'Kost Mahasiswa D',
    location: 'Dekat Universitas Indonesia',
    price: 1200000,
    rating: 4.4,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Campuran',
  ),
  Kost(
    id: 'n5',
    name: 'Kost Mahasiswa E',
    location: 'Dekat Universitas Indonesia',
    price: 950000,
    rating: 4.1,
    imageUrl: 'assets/images/kamar_kost.jpg',
    type: 'Putra',
  ),
];
