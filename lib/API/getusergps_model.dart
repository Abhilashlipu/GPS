// To parse this JSON data, do
//
//     final getUserGpsModel = getUserGpsModelFromJson(jsonString);

import 'dart:convert';

GetUserGpsModel getUserGpsModelFromJson(String str) => GetUserGpsModel.fromJson(json.decode(str));

String getUserGpsModelToJson(GetUserGpsModel data) => json.encode(data.toJson());

class GetUserGpsModel {
    GetUserGpsModel({
        required this.status,
        required this.message,
        required this.gpsData,
    });

    int status;
    String message;
    GpsData gpsData;

    factory GetUserGpsModel.fromJson(Map<String, dynamic> json) => GetUserGpsModel(
        status: json["status"],
        message: json["message"],
        gpsData: GpsData.fromJson(json["gps_data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "gps_data": gpsData.toJson(),
    };
}

class GpsData {
    GpsData({
        required this.id,
        required this.imei,
        required this.longitude,
        required this.latitude,
        required this.speed,
        required this.datetime,
    });

    int id;
    String imei;
    String longitude;
    String latitude;
    int speed;
    String datetime;

    factory GpsData.fromJson(Map<String, dynamic> json) => GpsData(
        id: json["id"],
        imei: json["imei"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        speed: json["speed"],
        datetime: json["datetime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imei": imei,
        "longitude": longitude,
        "latitude": latitude,
        "speed": speed,
        "datetime": datetime,
    };
}
