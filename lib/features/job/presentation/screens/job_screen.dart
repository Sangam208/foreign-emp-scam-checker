import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/core/utils/show_toast.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/screens/security_check_screen.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  static const _checkTypes = ['Job Post', 'Message'];
  static const _placeholders = [
    'Paste URL or text here...',
    'Paste recruiter message here...',
  ];
  static const _prompts = [
    'Paste the listing or message',
    'Paste the recruiter message',
  ];

  final _textController = TextEditingController();
  int _selectedType = 0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _runSecurityCheck() {
    if (_textController.text.trim().isEmpty) {
      showToast('Paste a listing or message to check');
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SecurityCheckPage(
          content: _textController.text.trim(),
          checkType: _checkTypes[_selectedType],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New Check',
            style: TextStyle(
              color: Color(0xFF17233F),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          _buildCheckTypeSelector(),
          const SizedBox(height: 20),
          Text(
            _prompts[_selectedType],
            style: const TextStyle(
              color: Color(0xFF4D5668),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _textController,
            minLines: 5,
            maxLines: 7,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: _placeholders[_selectedType],
              hintStyle: const TextStyle(
                color: Color(0xFF8C929E),
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE6E8ED)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF4855B8)),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Runs entirely on this device — nothing is uploaded.',
            style: TextStyle(
              color: Color(0xFF687184),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 26),
          _buildRunButton(),
        ],
      ),
    );
  }

  Widget _buildCheckTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (var index = 0; index < _checkTypes.length; index++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _buildCheckTypeTab(index),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCheckTypeTab(int index) {
    final isSelected = _selectedType == index;

    return Semantics(
      button: true,
      selected: isSelected,
      label: _checkTypes[index],
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF1D2A50).withValues(alpha: 0.08),
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            _checkTypes[index],
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF344384)
                  : const Color(0xFF626B7A),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRunButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF293A91), Color(0xFF4454B5)],
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _runSecurityCheck,
            borderRadius: BorderRadius.circular(11),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 9),
                Text(
                  'Run Security Check',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
