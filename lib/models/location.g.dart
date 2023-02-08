// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
      userItinerarySummary: json['userItinerarySummary'] as String?,
      tourPackageName: json['tourPackageName'] as String?,
      facts: (json['facts'] as List<dynamic>?)
          ?.map((e) => LocationFact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'userItinerarySummary': instance.userItinerarySummary,
      'tourPackageName': instance.tourPackageName,
      'facts': instance.facts,
    };
