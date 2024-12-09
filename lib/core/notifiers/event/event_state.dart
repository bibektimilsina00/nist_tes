import '../../model/event_model.dart';

class EventState {
  final bool isLoading;
  final String error;
  final List<EventModel> events;
  final bool hasMore;
  final int currentPage;

  const EventState({
    this.isLoading = false,
    this.error = '',
    this.events = const [],
    this.hasMore = true,
    this.currentPage = 1,
  });

  EventState copyWith({
    bool? isLoading,
    String? error,
    List<EventModel>? events,
    bool? hasMore,
    int? currentPage,
  }) {
    return EventState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      events: events ?? this.events,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
