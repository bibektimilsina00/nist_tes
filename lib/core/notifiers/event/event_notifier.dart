import 'package:flutter/material.dart';
import 'package:nist_tes/core/apis/event_api.dart';
import 'package:nist_tes/core/utils/error_utils.dart';

import '../../model/event_model.dart';
import 'event_state.dart';

class EventNotifier extends ChangeNotifier {
  final EventApi _eventApi;
  EventState _state = const EventState();

  EventNotifier() : _eventApi = EventApi();

  String get error => _state.error;
  List<EventModel> get events => _state.events;
  bool get isLoading => _state.isLoading;
  EventState get state => _state;

  void clearError() {
    _state = _state.copyWith(error: '');
    notifyListeners();
  }

  Future<void> getEvents({bool refresh = false}) async {
    if (refresh) {
      _state = const EventState(isLoading: true);
    } else {
      _state = _state.copyWith(isLoading: true);
    }
    notifyListeners();

    try {
      final events = await _eventApi.getEvents(
        page: refresh ? 1 : _state.currentPage,
      );

      if (refresh) {
        _state = EventState(
          events: events,
          currentPage: 1,
          hasMore: events.length >= 10,
          isLoading: false,
        );
      } else {
        _state = _state.copyWith(
          events: [..._state.events, ...events],
          currentPage: _state.currentPage + 1,
          hasMore: events.length >= 10,
          isLoading: false,
        );
      }
    } on AppException catch (e) {
      _state = _state.copyWith(
        error: e.message,
        isLoading: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        error: 'An unexpected error occurred',
        isLoading: false,
      );
    }
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (!_state.isLoading && _state.hasMore) {
      await getEvents();
    }
  }

  Future<void> refresh() async {
    await getEvents(refresh: true);
  }
}
