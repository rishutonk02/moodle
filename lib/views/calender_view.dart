import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/calendar_event.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final CourseService _courseService = CourseService();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final events = _courseService.getCalendarEvents();
    final filteredEvents = _selectedDate == null
        ? events
        : events
            .where((event) => _isSameDate(event.date, _selectedDate!))
            .toList();

    return AppShell(
      title: 'Calendar',
      body: ResponsivePage(
        children: [
          const PageHeader(
            title: 'Calendar',
            subtitle:
                'Filter Moodle deadlines, tutorials and coursework dates.',
            icon: Icons.calendar_month_outlined,
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? events.first.date,
                      firstDate: DateTime(2026),
                      lastDate: DateTime(2027, 12, 31),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                  icon: const Icon(Icons.event_outlined),
                  label: Text(
                    _selectedDate == null
                        ? 'Filter by date'
                        : 'Filtered: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: _selectedDate == null
                      ? null
                      : () => setState(() => _selectedDate = null),
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear filter'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (filteredEvents.isEmpty)
            const SectionCard(
              child: Text('No calendar events found for the selected date.'),
            )
          else
            ...filteredEvents.map(
              (event) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SectionCard(child: _EventTile(event: event)),
              ),
            ),
        ],
      ),
    );
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: _colorFor(event.type).withValues(alpha: 0.12),
        child: Icon(_iconFor(event.type), color: _colorFor(event.type)),
      ),
      title: Text(event.title),
      subtitle: Text(
        '${event.courseCode} - ${event.date.day}/${event.date.month}/${event.date.year} at ${event.date.hour.toString().padLeft(2, '0')}:${event.date.minute.toString().padLeft(2, '0')}',
      ),
      trailing: Chip(label: Text(event.type.name)),
    );
  }

  IconData _iconFor(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.deadline:
        return Icons.flag_outlined;
      case CalendarEventType.lecture:
        return Icons.co_present_outlined;
      case CalendarEventType.tutorial:
        return Icons.groups_outlined;
      case CalendarEventType.feedback:
        return Icons.rate_review_outlined;
    }
  }

  Color _colorFor(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.deadline:
        return Colors.red.shade700;
      case CalendarEventType.lecture:
        return moodleBlue;
      case CalendarEventType.tutorial:
        return moodlePurple;
      case CalendarEventType.feedback:
        return Colors.green.shade700;
    }
  }
}
