import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/core/config/app_config.dart';
import 'package:foreign_emp_scam_checker/core/errors/exceptions.dart';
import 'package:foreign_emp_scam_checker/features/checker/data/models/agency_model.dart';

abstract interface class AgencyRemoteDataSource {
  Future<List<AgencyModel>> getAgenciesData(String token);
}

class AgencyRemoteDataSourceImpl implements AgencyRemoteDataSource {
  final Dio _client;
  AgencyRemoteDataSourceImpl(
    this._client,
  );

  @override
  Future<List<AgencyModel>> getAgenciesData(String token) async {
    try {
      var response = await _client.get(
        '$host/agencies',
        options: Options(
          headers: {
            tokenHeader: token,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data == null) throw ServerException('No data available');

      List agenciesData = response.data;

      final agenciesList = agenciesData
          .map(
            (agency) => AgencyModel.fromJson(jsonEncode(agency)),
          )
          .toList();

      debugPrint('Agencies:\n ${agenciesList.length}');
      return agenciesList;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
