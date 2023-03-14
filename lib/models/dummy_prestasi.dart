class DummyPrestasi {
  final int id;
  final String title;
  final String subtitle;
  final String date;
  final String image;

  DummyPrestasi(this.id, this.title, this.subtitle, this.date, this.image);
}

List<DummyPrestasi> mockPrestasi = [
  DummyPrestasi(
    1,
    'Penghargaan Nobel',
    'Lorem',
    '12-11-2021',
    'assets/images/achievement.png',
  ),
  DummyPrestasi(
    2,
    'Penghargaan Youtube',
    'Ipsum',
    '12-11-2025',
    'assets/images/achievement.png',
  ),
  DummyPrestasi(
    3,
    'Penghargaan Presma',
    'Domet',
    '12-11-2076',
    'assets/images/achievement.png',
  ),
];
