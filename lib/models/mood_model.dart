class Mood {
  int moodId;
  String moodImage;
  String desc;

  Mood({
    required this.moodId,
    required this.moodImage,
    required this.desc,
  });
}

List<Mood> mockMood = [
  Mood(moodId: 1, moodImage: 'assets/emotes/a1.png', desc: 'Senang sekali'),
  Mood(moodId: 2, moodImage: 'assets/emotes/a2.png', desc: 'Senang'),
  Mood(moodId: 3, moodImage: 'assets/emotes/a3.png', desc: 'Kurang senang'),
  Mood(moodId: 4, moodImage: 'assets/emotes/a4.png', desc: 'Kurang senang sekali'),
  Mood(moodId: 5, moodImage: 'assets/emotes/a5.png', desc: 'Kecewa'),
];
