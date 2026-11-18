class StreamingService {
  const StreamingService({required this.id, required this.name});

  final String id;
  final String name;
}

const List<StreamingService> kStreamingServices = [
  StreamingService(id: 'netflix', name: 'Netflix'),
  StreamingService(id: 'prime_video', name: 'Prime Video'),
  StreamingService(id: 'disney_plus', name: 'Disney+'),
  StreamingService(id: 'now', name: 'NOW'),
  StreamingService(id: 'apple_tv_plus', name: 'Apple TV+'),
  StreamingService(id: 'paramount_plus', name: 'Paramount+'),
  StreamingService(id: 'raiplay', name: 'RaiPlay'),
  StreamingService(id: 'mubi', name: 'MUBI'),
];
