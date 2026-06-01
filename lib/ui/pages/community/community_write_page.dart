import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/extensions/spacing_extension.dart';
import '../../../app/theme/app_theme.dart';
import '../../../services/community_service.dart';
import '../../common/app_components.dart';

const _categories = ['후기', '질문', '정보', '메이트'];
const _areas = ['전체', '성수', '홍대', '강남', '잠실', '이태원'];

class CommunityWritePage extends StatefulWidget {
  const CommunityWritePage({super.key});

  @override
  State<CommunityWritePage> createState() => _CommunityWritePageState();
}

class _CommunityWritePageState extends State<CommunityWritePage> {
  final _titleController = TextEditingController();
  final _popupTitleController = TextEditingController();
  final _bodyController = TextEditingController();

  String _selectedCategory = '후기';
  String _selectedArea = '전체';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _bodyController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _popupTitleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty) {
      context.showSnackbar('제목을 입력해주세요.', isError: true);
      return;
    }
    if (body.isEmpty) {
      context.showSnackbar('내용을 입력해주세요.', isError: true);
      return;
    }

    setState(() => _loading = true);
    try {
      await CommunityService.addPost(
        title: title,
        body: body,
        category: _selectedCategory,
        area: _selectedArea,
        popupTitle: _popupTitleController.text.trim(),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
      context.showSnackbar('게시글 저장에 실패했습니다.', isError: true);
      return;
    }

    if (!mounted) return;
    context.showSnackbar('게시글이 등록되었습니다.');
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: '커뮤니티 글 작성',
        showBack: true,
        actions: [
          TextButton(
            onPressed: _loading ? null : _onSubmit,
            child: _loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('등록'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: [
          _SectionLabel(label: '카테고리'),
          8.heightBox,
          _ChipSelector(
            options: _categories,
            selected: _selectedCategory,
            onSelected: (v) => setState(() => _selectedCategory = v),
          ),
          24.heightBox,
          _SectionLabel(label: '지역'),
          8.heightBox,
          _ChipSelector(
            options: _areas,
            selected: _selectedArea,
            onSelected: (v) => setState(() => _selectedArea = v),
          ),
          24.heightBox,
          LabelTextField(
            label: '제목',
            hint: '게시글 제목을 입력하세요.',
            controller: _titleController,
            icon: LucideIcons.pencil,
          ),
          24.heightBox,
          LabelTextField(
            label: '관련 팝업 (선택)',
            hint: '관련된 팝업 이름을 입력하세요.',
            controller: _popupTitleController,
            icon: LucideIcons.store,
          ),
          24.heightBox,
          LabelTextField(
            label: '내용',
            hint: '이곳에서의 경험을 자유롭게 기록해 보세요.',
            controller: _bodyController,
            icon: LucideIcons.fileText,
            maxLines: 10,
          ),
          8.heightBox,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_bodyController.text.length} / 1000',
              style: const TextStyle(color: AppColors.muted, fontSize: 12),
            ),
          ),
          32.heightBox,
          PrimaryButton(
            label: '게시글 등록',
            icon: LucideIcons.send,
            onPressed: _loading ? null : _onSubmit,
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.ink,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ChipSelector extends StatelessWidget {
  const _ChipSelector({
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = option == selected;
        return GestureDetector(
          onTap: () => onSelected(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.ink : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.ink : AppColors.border,
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.muted,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
