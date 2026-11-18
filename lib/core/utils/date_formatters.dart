const List<String> _shortMonths = [
  'gen',
  'feb',
  'mar',
  'apr',
  'mag',
  'giu',
  'lug',
  'ago',
  'set',
  'ott',
  'nov',
  'dic',
];

const List<String> _longMonths = [
  'gennaio',
  'febbraio',
  'marzo',
  'aprile',
  'maggio',
  'giugno',
  'luglio',
  'agosto',
  'settembre',
  'ottobre',
  'novembre',
  'dicembre',
];

String formatShortDate(DateTime? date) {
  if (date == null) return '';
  return '${date.day} ${_shortMonths[date.month - 1]} ${date.year}';
}

String formatLongDate(DateTime date) {
  return '${date.day} ${_longMonths[date.month - 1]} ${date.year}';
}

String yearLabel(DateTime? date) => date == null ? 'Anno sconosciuto' : '${date.year}';

String daysSinceLabel(DateTime date, {DateTime? now}) {
  final days = (now ?? DateTime.now()).difference(date).inDays;
  if (days <= 0) return 'oggi';
  if (days == 1) return 'ieri';
  if (days < 30) return '$days giorni fa';
  final months = days ~/ 30;
  if (months == 1) return 'un mese fa';
  return '$months mesi fa';
}

String daysSinceShort(DateTime date, {DateTime? now}) {
  final days = (now ?? DateTime.now()).difference(date).inDays;
  if (days <= 0) return 'Oggi';
  if (days == 1) return 'Ieri';
  return '$days giorni';
}

String capitalize(String value) {
  if (value.isEmpty) return value;
  return '${value[0].toUpperCase()}${value.substring(1)}';
}

String pluralize(int count, String singular, String plural) {
  return count == 1 ? singular : plural;
}
