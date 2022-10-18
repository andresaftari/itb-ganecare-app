import 'dart:math';

class Schedule {
  late List<List<bool>> data;

  Schedule() {
    data = List<List<bool>>.generate(
        7, (i) => List<bool>.generate(15, (j) => false));
  }

  factory Schedule.random() {
    Schedule schedule = Schedule();
    schedule.data = List<List<bool>>.generate(
        7, (i) => List<bool>.generate(15, (j) => Random().nextBool()));
    return schedule;
  }

  factory Schedule.fromSchedule(Schedule otherSchedule) {
    Schedule schedule = Schedule();

    schedule.data = List<List<bool>>.generate(
      7,
      (i) => List<bool>.generate(
        15,
        (j) => otherSchedule.data[i][j],
      ),
    );

    return schedule;
  }

  factory Schedule.fromJsonDecoded(Map<String, dynamic> jsonDecoded) {
    // print(jsonDecoded['Senin'].toString());
    try {
      var schedule = Schedule();
      final listOfDays = [
        'Senin',
        'Selasa',
        'Rabu',
        'Kamis',
        'Jumat',
        'Sabtu',
        'Minggu'
      ];

      for (var i = 0; i < listOfDays.length; i++) {
        List<dynamic> listOfHourValues = jsonDecoded[listOfDays[i]];
        for (var j = 0; j < listOfHourValues.length; j++) {
          schedule.data[i][j] =
              listOfHourValues[j].toString() == '1' ? true : false;
        }
      }

      // print(schedule.data[0].toString());
      return schedule;
    } catch (exception) {
      return Schedule();
    }
  }

  Map toJson() => {
        'Senin': data[0].map((e) => e ? 1 : 0).toList(),
        'Selasa': data[1].map((e) => e ? 1 : 0).toList(),
        'Rabu': data[2].map((e) => e ? 1 : 0).toList(),
        'Kamis': data[3].map((e) => e ? 1 : 0).toList(),
        'Jumat': data[4].map((e) => e ? 1 : 0).toList(),
        'Sabtu': data[5].map((e) => e ? 1 : 0).toList(),
        'Minggu': data[6].map((e) => e ? 1 : 0).toList(),
      };

  bool isEqualTo(Schedule otherSchedule) {
    bool result = true;

    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data[i].length; j++) {
        if (data[i][j] != otherSchedule.data[i][j]) {
          result = false;
          break;
        }
      }
    }

    return result;
  }

  //pagi 7-12
  //siang 12-17
  //malam 17-21

  Map get parsedData {
    Map? stringMap = <String, Map<String, List<String>>>{};

    final listOfDays = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    final listOfTimes = [
      'Pagi',
      'Siang',
      'Malam',
    ];

    final listOfHours = [
      '07:00',
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00',
      '20:00',
      '21:00',
      '22:00',
    ];

    data.asMap().forEach((dayIndex, dayValues) {
      List<String> pagi = [];
      List<String> siang = [];
      List<String> malam = [];

      bool lastPagiValue = false;
      bool lastSiangValue = false;
      bool lastMalamValue = false;

      dayValues.asMap().forEach((hourIndex, hourValues) {
        //set untuk pagi
        if (hourIndex >= 0 && hourIndex < 5) {
          if (hourValues) {
            if (lastPagiValue) {
              pagi.last = pagi.last.toString().split(' - ').first +
                  ' - ' +
                  listOfHours[hourIndex + 1];
            } else {
              if (stringMap[listOfDays[dayIndex]] == null) {
                stringMap[listOfDays[dayIndex]] = <String, List<String>>{};
              }

              pagi.add(
                  listOfHours[hourIndex] + ' - ' + listOfHours[hourIndex + 1]);

              lastPagiValue = true;
            }

            stringMap[listOfDays[dayIndex]][listOfTimes[0]] = pagi;
          } else {
            lastPagiValue = false;
          }
        }
        //set untuk siang
        else if (hourIndex >= 5 && hourIndex < 10) {
          if (hourValues) {
            if (lastSiangValue) {
              siang.last = siang.last.toString().split(' - ').first +
                  ' - ' +
                  listOfHours[hourIndex + 1];
            } else {
              if (stringMap[listOfDays[dayIndex]] == null) {
                stringMap[listOfDays[dayIndex]] = <String, List<String>>{};
              }
              siang.add(
                  listOfHours[hourIndex] + ' - ' + listOfHours[hourIndex + 1]);
              lastSiangValue = true;
            }

            stringMap[listOfDays[dayIndex]][listOfTimes[1]] = siang;
          } else {
            lastSiangValue = false;
          }
        }
        //set untuk malam
        else if (hourIndex >= 10 && hourIndex < 15) {
          if (hourValues) {
            if (lastMalamValue) {
              malam.last = malam.last.toString().split(' - ').first +
                  ' - ' +
                  listOfHours[hourIndex + 1];
            } else {
              if (stringMap[listOfDays[dayIndex]] == null) {
                stringMap[listOfDays[dayIndex]] = <String, List<String>>{};
              }
              malam.add(
                  listOfHours[hourIndex] + ' - ' + listOfHours[hourIndex + 1]);
              lastMalamValue = true;
            }

            stringMap[listOfDays[dayIndex]][listOfTimes[2]] = malam;
          } else {
            lastMalamValue = false;
          }
        }
      });
    });
    // print(json.encode(stringMap).toString());

    return stringMap;
  }
}
