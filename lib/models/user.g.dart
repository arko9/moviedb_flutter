// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..value = json['value'] as int
    ..message = json['message'] as String
    ..namaLengkap = json['namaLengkap'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..photo = json['photo'] as String
    ..createdDate = json['createdDate'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'namaLengkap': instance.namaLengkap,
      'email': instance.email,
      'phone': instance.phone,
      'photo': instance.photo,
      'createdDate': instance.createdDate,
    };
