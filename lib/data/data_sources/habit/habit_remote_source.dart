import 'dart:convert';

import 'package:diana/core/constants/_constants.dart';
import 'package:diana/core/errors/exception.dart';
import 'package:diana/data/remote_models/habit/habit_response.dart';
import 'package:diana/data/remote_models/habit/habit_result.dart';
import 'package:http/http.dart' as http;

abstract class HabitRemoteSource {
  Future<HabitResponse> getHabits(int offset);

  Future<HabitResult> insertHabit(
    String name,
    List<int> days,
    String time,
  );

  Future<HabitResult> editHabit(
    String habitId,
    String name,
    List<int> days,
    String time,
  );

  Future<bool> deleteHabit(String habitId);
}

class HabitRemoteSourceImpl extends HabitRemoteSource {
  final http.Client client;

  HabitRemoteSourceImpl({this.client});

  @override
  Future<HabitResponse> getHabits(int offset) async {
    final response = await client.get(
      '$baseUrl/habit/?limit=10&offset=$offset',
      headers: {
        'Authorization': 'Bearer $kToken',
      },
    );

    if (response.statusCode == 200) {
      return HabitResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw UnAuthException();
    } else {
      throw UnknownException(message: response.body);
    }
  }

  @override
  Future<HabitResult> insertHabit(
      String name, List<int> days, String time) async {
    final response = await client.post(
      '$baseUrl/habit/',
      headers: {
        'Authorization': 'Bearer $kToken',
      },
      body: {
        "name": name,
        "days": days,
        "time": time,
      },
    );

    if (response.statusCode == 201) {
      return HabitResult.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw UnAuthException();
    } else if (response.statusCode == 400) {
      throw FieldsException(body: response.body);
    } else {
      throw UnknownException(message: response.body);
    }
  }

  @override
  Future<HabitResult> editHabit(
      String habitId, String name, List<int> days, String time) async {
    final response = await client.put(
      '$baseUrl/habit/$habitId/',
      headers: {
        'Authorization': 'Bearer $kToken',
      },
      body: {
        "name": name,
        "days": days,
        "time": time,
      },
    );

    if (response.statusCode == 200) {
      return HabitResult.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw UnAuthException();
    } else if (response.statusCode == 400) {
      throw FieldsException(body: response.body);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw UnknownException(message: response.body);
    }
  }

  @override
  Future<bool> deleteHabit(String habitId) async {
    final response = await client.delete(
      '$baseUrl/habit/$habitId/',
      headers: {
        'Authorization': 'Bearer $kToken',
      },
    );

    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 401) {
      throw UnAuthException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw UnknownException(message: response.body);
    }
  }
}
