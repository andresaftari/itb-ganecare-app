import 'package:flutter/material.dart';

///all lists of assets and colors of avatar attributes
///this is the easiest way: using static constant class member. good readability too.
///but this is not the safest nor the most optimal.
///the best way is using inherited widget as flutter architectures
///but this is way too complicated for simple lists of const values.
class AvatarAssets {
  static const Map<String, String> categoryIcon = {
    'face': 'assets/icons/icon kepala.png',
    'hair': 'assets/icons/icon rambut.png',
    'eyes': 'assets/icons/icon mata.png',
    'mouth': 'assets/icons/icon mulut.png',
    "accessories": 'assets/icons/icon aksesoris.png',
  };

  static const Map<int, String> faceIcon = {
    0: 'assets/icons/kepala1.png',
    1: 'assets/icons/kepala2.png',
    2: 'assets/icons/kepala3.png',
    3: 'assets/icons/kepala4.png',
    4: 'assets/icons/kepala5.png',
    5: 'assets/icons/kepala6.png',
  };

  static const Map<int, String> frontHairIcon = {
    0: 'assets/icons/poni1.png',
    1: 'assets/icons/poni2.png',
    2: 'assets/icons/poni3.png',
    3: 'assets/icons/poni4.png',
    4: 'assets/icons/poni5.png',
    5: 'assets/icons/poni6.png',
  };

  static const Map<int, String> backHairIcon = {
    0: 'assets/icons/rambut m1.png',
    1: 'assets/icons/rambut m2.png',
    2: 'assets/icons/rambut m3.png',
    3: 'assets/icons/rambut m4.png',
    4: 'assets/icons/rambut m5.png',
    5: 'assets/icons/rambut m6.png',
    6: 'assets/icons/rambut wm1.png',
    7: 'assets/icons/rambut wm2.png',
    8: 'assets/icons/rambut wm3.png',
    9: 'assets/icons/rambut wm4.png',
    10: 'assets/icons/rambut wm5.png',
    11: 'assets/icons/rambut wm6.png',
  };

  static const Map<int, String> eyesIcon = {
    0: 'assets/icons/mata1.png',
    1: 'assets/icons/mata2.png',
    2: 'assets/icons/mata3.png',
    3: 'assets/icons/mata4.png',
    4: 'assets/icons/mata5.png',
    5: 'assets/icons/mata6.png',
  };

  static const Map<int, String> eyeBrowsIcon = {
    0: 'assets/icons/alis1.png',
    1: 'assets/icons/alis2.png',
    2: 'assets/icons/alis3.png',
    3: 'assets/icons/alis4.png',
    4: 'assets/icons/alis5.png',
    5: 'assets/icons/alis6.png',
  };

  static const Map<int, String> mouthIcon = {
    0: 'assets/icons/mulut1.png',
    1: 'assets/icons/mulut2.png',
    2: 'assets/icons/mulut3.png',
    3: 'assets/icons/mulut4.png',
    4: 'assets/icons/mulut5.png',
    5: 'assets/icons/mulut6.png',
  };

  static const Map<String, String> accsesoriesIcon = {
    'bow_tie': 'assets/icons/aksesoris1.png',
    'hair_ribbon': 'assets/icons/aksesoris2.png',
    'glasses': 'assets/icons/aksesoris3.png',
    'hat1': 'assets/icons/aksesoris4.png',
    'hat2': 'assets/icons/aksesoris5.png',
    'mask': 'assets/icons/aksesoris6.png',
    'hijab': 'assets/icons/kerudung.png',
  };

  static const Map<int, String> faceAssets = {
    0: 'assets/images/kepala1.png',
    1: 'assets/images/kepala2.png',
    2: 'assets/images/kepala3.png',
    3: 'assets/images/kepala4.png',
    4: 'assets/images/kepala5.png',
    5: 'assets/images/kepala6.png',
  };

  static const Map<String, String> neckAssets = {
    'neck': 'assets/images/leher.png',
  };

  static const Map<int, String> frontHairAssets = {
    0: 'assets/images/poni1.png',
    1: 'assets/images/poni2.png',
    2: 'assets/images/poni3.png',
    3: 'assets/images/poni4.png',
    4: 'assets/images/poni5.png',
    5: 'assets/images/poni6.png',
  };

  static const Map<int, String> backHairAssets = {
    0: 'assets/images/rambut m1.png',
    1: 'assets/images/rambut m2.png',
    2: 'assets/images/rambut m3.png',
    3: 'assets/images/rambut m4.png',
    4: 'assets/images/rambut m5.png',
    5: 'assets/images/rambut m6 (botak).png',
    6: 'assets/images/rambut wm1.png',
    7: 'assets/images/rambut wm2.png',
    8: 'assets/images/rambut wm3.png',
    9: 'assets/images/rambut wm4.png',
    10: 'assets/images/rambut wm5.png',
    11: 'assets/images/rambut wm6.png',
  };

  static const Map<String, String> shirtAssets = {
    'shirt': 'assets/images/baju.png',
  };

  static const Map<int, String> eyesAssets = {
    0: 'assets/images/mata.png',
    1: 'assets/images/mata2.png',
    2: 'assets/images/mata3.png',
    3: 'assets/images/mata4.png',
    4: 'assets/images/mata5.png',
    5: 'assets/images/mata6.png',
  };

  static const Map<int, String> eyeBrowsAssets = {
    0: 'assets/images/alis1.png',
    1: 'assets/images/alis2.png',
    2: 'assets/images/alis3.png',
    3: 'assets/images/alis4.png',
    4: 'assets/images/alis5.png',
    5: 'assets/images/alis6.png',
  };

  static const Map<int, String> mouthAssets = {
    0: 'assets/images/mulut1.png',
    1: 'assets/images/mulut2.png',
    2: 'assets/images/mulut3.png',
    3: 'assets/images/mulut4.png',
    4: 'assets/images/mulut5.png',
    5: 'assets/images/mulut6.png',
  };

  static const Map<String, String> accessoriesAssets = {
    'back_hijab': 'assets/images/kerudung blkg.png',
    'front_hijab': 'assets/images/kerudung dpn.png',
    'hat1': 'assets/images/aksesoris4.png',
    'hat2': 'assets/images/aksesoris5.png',
    'hair_ribbon': 'assets/images/aksesoris2.png',
    'glasses': 'assets/images/aksesoris3.png',
    'mask': 'assets/images/aksesoris6.png',
    'bow_tie': 'assets/images/aksesoris1.png',
  };

  static const Map<int, Color> faceColors = {
    0: Color(0xfffff7ea),
    1: Color(0xfffec79e),
    2: Color(0xffe49d6d),
    3: Color(0xffa25b3d),
    4: Color(0xffbb6069),
    5: Color(0xff956fb8)
  };

  static const Map<int, Color> neckColors = {
    0: Color(0xffe3b292),
    1: Color(0xffe7ae93),
    2: Color(0xffc6796a),
    3: Color(0xff7a3632),
    4: Color(0xff944c62),
    5: Color(0xff604a97)
  };

  static const Map<int, Color> hairColors = {
    0: Color(0xff43414f),
    1: Color(0xff6c273d),
    2: Color(0xff594233),
    3: Color(0xffdf8232),
    4: Color(0xfffff4a9),
    5: Color(0xff294468)
  };

  static const Map<int, Color> eyeColors = {
    0: Color(0xff43414f),
    1: Color(0xff6f4727),
    2: Color(0xff6c273d),
    3: Color(0xff6b3381),
    4: Color(0xff056b9a),
    5: Color(0xff455d38)
  };

  static const Map<int, Color> accessoriesColors = {
    0: Color(0xffffffff),
    1: Color(0xff2a1f32),
    2: Color(0xff4c9792),
    3: Color(0xffaa9fca),
    4: Color(0xffb62c43),
    5: Color(0xffdc6128)
  };

  static const Map<int, Color> backgroundColors = {
    0: Color(0xffe6e6e6),
    1: Color(0xffffc146),
    2: Color(0xff66deff),
  };

  static const Map<int, Color> shirtColors = {
    0: Color(0xffc5c5c5), //mahasiswa
    1: Color(0xffff9000), //pendengar
    2: Color(0xff007db7), //konselor
  };
}
