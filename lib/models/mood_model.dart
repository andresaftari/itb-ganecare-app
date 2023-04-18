class Mood {
  int moodId;
  String moodImage;
  String desc;
  int moodemotion;

  Mood({
    required this.moodId,
    required this.moodImage,
    required this.desc,
    required this.moodemotion,
  });
}

List<Mood> mockMood = [
  Mood(
      moodId: 1,
      moodImage: 'assets/emotes/a1.png',
      desc: 'Senang sekali',
      moodemotion: 10),
  Mood(
      moodId: 2,
      moodImage: 'assets/emotes/a2.png',
      desc: 'Senang',
      moodemotion: 7),
  Mood(
      moodId: 3,
      moodImage: 'assets/emotes/a3.png',
      desc: 'Kurang senang',
      moodemotion: 5),
  Mood(
      moodId: 4,
      moodImage: 'assets/emotes/a4.png',
      desc: 'Kurang senang sekali',
      moodemotion: 3),
  Mood(
      moodId: 5,
      moodImage: 'assets/emotes/a5.png',
      desc: 'Kecewa',
      moodemotion: 1),
];
