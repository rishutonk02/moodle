import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/submission.dart';
import 'package:moodle/services/auth_service.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/services/submission_service.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class AssignmentView extends StatefulWidget {
  const AssignmentView({super.key, required this.assignmentId});

  final String assignmentId;

  @override
  State<AssignmentView> createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  final SubmissionService _submissionService = SubmissionService();
  final TextEditingController _textController = TextEditingController();
  String _attachmentName = '';
  AssignmentSubmission? _submission;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSubmission();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _loadSubmission() async {
    final submission = await _submissionService.getSubmission(
      assignmentId: widget.assignmentId,
      userId: AuthService().currentUserId(),
    );
    setState(() {
      _submission = submission;
      _textController.text = submission?.text ?? '';
      _attachmentName = submission?.attachmentName ?? '';
      _loading = false;
    });
  }

  Future<void> _pickAttachment() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      setState(() => _attachmentName = result.files.single.name);
    }
  }

  Future<void> _submit() async {
    final submission = AssignmentSubmission(
      assignmentId: widget.assignmentId,
      userId: AuthService().currentUserId(),
      text: _textController.text.trim(),
      attachmentName: _attachmentName,
      submittedAt: DateTime.now(),
    );
    await _submissionService.saveSubmission(submission);
    setState(() => _submission = submission);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assignment submitted locally')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final assignment = CourseService().getAssignmentById(widget.assignmentId);

    return AppShell(
      title: 'Assignment',
      body: ResponsivePage(
        children: [
          PageHeader(
            title: assignment.title,
            subtitle:
                'Due ${assignment.dueDate.day}/${assignment.dueDate.month}/${assignment.dueDate.year} at ${assignment.dueDate.hour}:00',
            icon: Icons.assignment_turned_in_outlined,
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(assignment.description),
                const SizedBox(height: 12),
                Chip(
                  avatar: Icon(
                    _submission == null ? Icons.pending_outlined : Icons.check,
                    size: 18,
                  ),
                  label:
                      Text(_submission == null ? 'Not submitted' : 'Submitted'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _textController,
                        minLines: 5,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          labelText: 'Online text submission',
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          FilledButton.icon(
                            onPressed: _pickAttachment,
                            icon: const Icon(Icons.attach_file),
                            label: const Text('Choose attachment'),
                          ),
                          if (_attachmentName.isNotEmpty)
                            Chip(
                              avatar:
                                  const Icon(Icons.insert_drive_file, size: 18),
                              label: Text(_attachmentName),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.cloud_upload_outlined),
                        label: const Text('Submit assignment'),
                      ),
                      if (_submission != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Last submitted ${_submission!.submittedAt.day}/${_submission!.submittedAt.month}/${_submission!.submittedAt.year}',
                          style: const TextStyle(color: moodleTextMuted),
                        ),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
