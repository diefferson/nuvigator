// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// NextGenerator
// **************************************************************************

extension FriendRequestArgsParser on FriendRequestArgs {
  FriendRequestArgs _$parseParameters(Map<String, dynamic> map) {
    return FriendRequestArgs()
      ..numberOfRequests = map['numberOfRequests'] is String
          ? int.tryParse(map['numberOfRequests'])
          : map['numberOfRequests']
      ..precision = map['precision'] is String
          ? double.tryParse(map['precision'])
          : map['precision']
      ..name = map['name'];
  }
}
