// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripProduct _$TripProductFromJson(Map<String, dynamic> json) => TripProduct(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  duration: json['duration'] as String,
  price: json['price'] as String,
  airline: json['airline'] as String,
  hotelGrade: json['hotelGrade'] as String,
  schedule: (json['schedule'] as List<dynamic>)
      .map((e) => DaySchedule.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TripProductToJson(TripProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'duration': instance.duration,
      'price': instance.price,
      'airline': instance.airline,
      'hotelGrade': instance.hotelGrade,
      'schedule': instance.schedule,
    };

DaySchedule _$DayScheduleFromJson(Map<String, dynamic> json) => DaySchedule(
  day: (json['day'] as num).toInt(),
  activities: (json['activities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$DayScheduleToJson(DaySchedule instance) =>
    <String, dynamic>{'day': instance.day, 'activities': instance.activities};
