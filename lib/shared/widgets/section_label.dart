import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final style = context.theme.typography.body;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: style.sm.copyWith(fontWeight: FontWeight.w600)),
    );
  }
}
