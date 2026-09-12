import 'package:intl/intl.dart';

/// Utility formatters for currency, dates, and numbers.
class AppFormatters {
  AppFormatters._();

  static final _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  static final _numberFormat = NumberFormat('#,###', 'id_ID');

  static final _dateFormat = DateFormat('dd MMM yyyy', 'id_ID');
  static final _dateTimeFormat = DateFormat('dd MMM yyyy, HH:mm', 'id_ID');
  static final _timeFormat = DateFormat('HH:mm', 'id_ID');

  /// Format number as Indonesian Rupiah
  static String currency(num amount) => _currencyFormat.format(amount);

  /// Format number with thousand separator
  static String number(num value) => _numberFormat.format(value);

  /// Format points display: "1.250 Poin"
  static String points(int value) => '${_numberFormat.format(value)} Poin';

  /// Format date: "09 Sep 2026"
  static String date(DateTime dt) => _dateFormat.format(dt);

  /// Format date time: "09 Sep 2026, 14:30"
  static String dateTime(DateTime dt) => _dateTimeFormat.format(dt);

  /// Format time: "14:30"
  static String time(DateTime dt) => _timeFormat.format(dt);

  /// Format relative time: "2 jam lalu", "Kemarin", etc.
  static String relativeTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays < 2) return 'Kemarin';
    if (diff.inDays < 7) return '${diff.inDays} hari lalu';
    return date(dt);
  }

  /// Member ID format: "FVR-XXXXXXXX"
  static String memberId(String id) {
    if (id.length >= 8) {
      return 'FVR-${id.substring(0, 8).toUpperCase()}';
    }
    return 'FVR-${id.toUpperCase()}';
  }
}
