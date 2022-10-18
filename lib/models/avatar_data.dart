import 'dart:math';

class AvatarData {
  int faceType;
  int frontHairType;
  int backHairType;
  int eyesType;
  int eyeBrowsType;
  int mouthType;
  bool wearHijab;
  bool wearHat1;
  bool wearHat2;
  bool wearHairRibbon;
  bool wearGlasses;
  bool wearMask;
  bool wearBowTie;
  int faceColor;
  int neckColor;
  int hairColor;
  int hijabColor;
  int eyeColor;
  int hat1Color;
  int hat2Color;
  int hairRibbonColor;
  int glassesColor;
  int maskColor;
  int bowTieColor;
  int shirtColor;

  AvatarData({
    required this.faceType,
    required this.frontHairType,
    required this.backHairType,
    required this.eyesType,
    required this.eyeBrowsType,
    required this.mouthType,
    required this.wearHijab,
    required this.wearHat1,
    required this.wearHat2,
    required this.wearHairRibbon,
    required this.wearGlasses,
    required this.wearMask,
    required this.wearBowTie,
    required this.faceColor,
    required this.neckColor,
    required this.hairColor,
    required this.hijabColor,
    required this.eyeColor,
    required this.hat1Color,
    required this.hat2Color,
    required this.hairRibbonColor,
    required this.glassesColor,
    required this.maskColor,
    required this.bowTieColor,
    required this.shirtColor,
  });

  factory AvatarData.random() {
    Random rand = Random();

    return AvatarData(
      faceType: rand.nextInt(6),
      frontHairType: rand.nextInt(6),
      backHairType: rand.nextInt(12),
      eyesType: rand.nextInt(6),
      eyeBrowsType: rand.nextInt(6),
      mouthType: rand.nextInt(6),
      wearHijab: rand.nextBool(),
      wearHat1: rand.nextBool(),
      wearHat2: rand.nextBool(),
      wearHairRibbon: rand.nextBool(),
      wearGlasses: rand.nextBool(),
      wearMask: rand.nextBool(),
      wearBowTie: rand.nextBool(),
      faceColor: rand.nextInt(6),
      neckColor: rand.nextInt(6),
      hairColor: rand.nextInt(6),
      hijabColor: rand.nextInt(6),
      eyeColor: rand.nextInt(6),
      hat1Color: rand.nextInt(6),
      hat2Color: rand.nextInt(6),
      hairRibbonColor: rand.nextInt(6),
      glassesColor: rand.nextInt(6),
      maskColor: rand.nextInt(6),
      bowTieColor: rand.nextInt(6),
      shirtColor: rand.nextInt(3),
    );
  }

  factory AvatarData.copy(AvatarData avatarData) {
    return AvatarData(
      faceType: avatarData.faceType,
      frontHairType: avatarData.frontHairType,
      backHairType: avatarData.backHairType,
      eyesType: avatarData.eyesType,
      eyeBrowsType: avatarData.eyeBrowsType,
      mouthType: avatarData.mouthType,
      wearHijab: avatarData.wearHijab,
      wearHat1: avatarData.wearHat1,
      wearHat2: avatarData.wearHat2,
      wearHairRibbon: avatarData.wearHairRibbon,
      wearGlasses: avatarData.wearGlasses,
      wearMask: avatarData.wearMask,
      wearBowTie: avatarData.wearBowTie,
      faceColor: avatarData.faceColor,
      neckColor: avatarData.neckColor,
      hairColor: avatarData.hairColor,
      hijabColor: avatarData.hijabColor,
      eyeColor: avatarData.eyeColor,
      hat1Color: avatarData.hat1Color,
      hat2Color: avatarData.hat2Color,
      hairRibbonColor: avatarData.hairRibbonColor,
      glassesColor: avatarData.glassesColor,
      maskColor: avatarData.maskColor,
      bowTieColor: avatarData.bowTieColor,
      shirtColor: avatarData.shirtColor,
    );
  }

  factory AvatarData.fromCode(String code) {
    return code.length == 25
        ? AvatarData(
            faceType: int.parse(code[0], radix: 16),
            frontHairType: int.parse(code[1], radix: 16),
            backHairType: int.parse(code[2], radix: 16),
            eyesType: int.parse(code[3], radix: 16),
            eyeBrowsType: int.parse(code[4], radix: 16),
            mouthType: int.parse(code[5], radix: 16),
            wearHijab: int.parse(code[6]) == 0 ? false : true,
            wearHat1: int.parse(code[7]) == 0 ? false : true,
            wearHat2: int.parse(code[8]) == 0 ? false : true,
            wearHairRibbon: int.parse(code[9]) == 0 ? false : true,
            wearGlasses: int.parse(code[10]) == 0 ? false : true,
            wearMask: int.parse(code[11]) == 0 ? false : true,
            wearBowTie: int.parse(code[12]) == 0 ? false : true,
            faceColor: int.parse(code[13], radix: 16),
            neckColor: int.parse(code[14], radix: 16),
            hairColor: int.parse(code[15], radix: 16),
            hijabColor: int.parse(code[16], radix: 16),
            eyeColor: int.parse(code[17], radix: 16),
            hat1Color: int.parse(code[18], radix: 16),
            hat2Color: int.parse(code[19], radix: 16),
            hairRibbonColor: int.parse(code[20], radix: 16),
            glassesColor: int.parse(code[21], radix: 16),
            maskColor: int.parse(code[22], radix: 16),
            bowTieColor: int.parse(code[23], radix: 16),
            shirtColor: int.parse(code[24], radix: 16),
          )
        : AvatarData.random();
  }

  String get code {
    return faceType.toRadixString(16) +
        frontHairType.toRadixString(16) +
        backHairType.toRadixString(16) +
        eyesType.toRadixString(16) +
        eyeBrowsType.toRadixString(16) +
        mouthType.toRadixString(16) +
        (wearHijab ? '1' : '0') +
        (wearHat1 ? '1' : '0') +
        (wearHat2 ? '1' : '0') +
        (wearHairRibbon ? '1' : '0') +
        (wearGlasses ? '1' : '0') +
        (wearMask ? '1' : '0') +
        (wearBowTie ? '1' : '0') +
        faceColor.toRadixString(16) +
        neckColor.toRadixString(16) +
        hairColor.toRadixString(16) +
        hijabColor.toRadixString(16) +
        eyeColor.toRadixString(16) +
        hat1Color.toRadixString(16) +
        hat2Color.toRadixString(16) +
        hairRibbonColor.toRadixString(16) +
        glassesColor.toRadixString(16) +
        maskColor.toRadixString(16) +
        bowTieColor.toRadixString(16) +
        shirtColor.toRadixString(16);
  }
}
