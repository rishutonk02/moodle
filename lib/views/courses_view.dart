import 'package:flutter/material.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/course_card.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  final CourseService _courseService = CourseService();
  String _query = '';
  String _category = 'All';

  @override
  Widget build(BuildContext context) {
    final courses =
        _courseService.getCourses(query: _query, category: _category);
    final categories = _courseService.getCategories();

    return AppShell(
      title: 'My courses',
      body: ResponsivePage(
        children: [
          const PageHeader(
            title: 'My courses',
            subtitle: 'Search, filter and open course content dynamically.',
            icon: Icons.school_outlined,
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 620;
                final search = TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search courses',
                  ),
                  onChanged: (value) => setState(() => _query = value),
                );
                final filter = DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(labelText: 'Filter'),
                  items: categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _category = value);
                    }
                  },
                );
                if (!isWide) {
                  return Column(
                      children: [search, const SizedBox(height: 12), filter]);
                }
                return Row(
                  children: [
                    Expanded(flex: 2, child: search),
                    const SizedBox(width: 12),
                    Expanded(child: filter),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 900
                  ? 3
                  : constraints.maxWidth > 620
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: columns == 1 ? 1.55 : 1.05,
                ),
                itemBuilder: (context, index) =>
                    CourseCard(course: courses[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
