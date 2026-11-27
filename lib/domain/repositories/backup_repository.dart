class BackupImportSummary {
  const BackupImportSummary({
    required this.mediaCount,
    required this.entryCount,
    required this.eventCount,
    required this.dismissedCount,
    this.listCount = 0,
  });

  final int mediaCount;
  final int entryCount;
  final int eventCount;
  final int dismissedCount;
  final int listCount;

  int get totalItems =>
      mediaCount + entryCount + eventCount + dismissedCount + listCount;
}

abstract interface class BackupRepository {
  Future<String> exportJson();

  /// Sostituisce i dati utente con quelli del backup.
  Future<BackupImportSummary> importJson(String json);

  /// Cancella tutto, inclusa la cache; le preferenze tornano ai valori iniziali.
  Future<void> clearAll();
}
