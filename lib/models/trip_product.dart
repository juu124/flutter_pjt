import 'package:json_annotation/json_annotation.dart';

part 'trip_product.g.dart';

@JsonSerializable()
class TripProduct {
  final int id;
  final String name;
  final String duration;
  final String price;
  final String airline;
  final String hotelGrade;
  final List<DaySchedule> schedule;

  const TripProduct({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.airline,
    required this.hotelGrade,
    required this.schedule,
  });

  factory TripProduct.fromJson(Map<String, dynamic> json) => _$TripProductFromJson(json);
  Map<String, dynamic> toJson() => _$TripProductToJson(this);
}

@JsonSerializable()
class DaySchedule {
  final int day;
  final List<String> activities;

  const DaySchedule({
    required this.day,
    required this.activities,
  });

  factory DaySchedule.fromJson(Map<String, dynamic> json) => _$DayScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$DayScheduleToJson(this);
}