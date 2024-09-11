import 'dart:convert';

TodaysaData todaysDataFromJson(String str) => TodaysaData.fromJson(json.decode(str));
String todaysDataToJson(TodaysaData data) => json.encode(data.toJson());

class TodaysaData {
  List<Datum> data;

  TodaysaData({required this.data});

  factory TodaysaData.fromJson(Map<String, dynamic> json) => TodaysaData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String item;
  String number;

  Datum({
    required this.id,
    required this.item,
    required this.number,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        item: json["item"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item,
        "number": number,
      };
}