// feature/report with date/widgets/report2_models.dart
enum AlertLevel { warning, neutral }

class ReportAlertItem {
  const ReportAlertItem({required this.title, required this.level});

  final String title;
  final AlertLevel level;
}
