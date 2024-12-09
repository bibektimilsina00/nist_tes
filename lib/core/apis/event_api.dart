import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nist_tes/app/routes/api_routes.dart';
import 'package:nist_tes/core/model/event_model.dart';
import 'package:nist_tes/core/services/service_locator.dart';
import 'package:nist_tes/core/utils/error_utils.dart';
import 'package:nist_tes/core/utils/logger_utils.dart';

class EventApi {
  final _apiClient = ServiceLocator.apiClient;
  final _connectivityService = ServiceLocator.connectivity;
  final _cacheService = ServiceLocator.cacheService;

  Future<List<EventModel>> getEvents({int page = 1}) async {
    try {
      if (!await _connectivityService.isConnected()) {
        final cachedEvent = await _cacheService.getEvent();
        if (cachedEvent != null) {
          logger.i('Fetching events from cache');
          return (jsonDecode(cachedEvent) as List)
              .map((event) => EventModel.fromJson(event))
              .toList();
        }
        throw const NoInternetException();
      }

      logger.i('Fetching events from API');
      final response = await _apiClient.get(ApiRoutes.events);

      if (response.data == null) {
        throw const ServerException('Invalid response from server');
      }

      final eventList = (response.data as List)
          .map((event) => EventModel.fromJson(event))
          .toList();

      // Cache the events
      logger.i('Caching events data');
      await _cacheService.storeEvent(
        jsonEncode(eventList.map((event) => event.toJson()).toList()),
      );

      return eventList;
    } on DioException catch (e) {
      logger.e('DioException while fetching events: ${e.message}');
      throw handleDioException(e);
    } on AppException {
      rethrow; // Propagate known exceptions
    } catch (e) {
      logger.e('Unexpected error while fetching events: $e');
      throw ServerException('Failed to fetch events: ${e.toString()}');
    }
  }
}
