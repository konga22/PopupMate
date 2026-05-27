import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/extensions/spacing_extension.dart';
import '../../../app/theme/app_theme.dart';
import '../../common/app_components.dart';

import '../../../app/router/app_page.dart';
import '../../../services/community_service.dart';

class CommunityWritePage extends StatefulWidget {
  const CommunityWritePage({super.key});

  @override
  State<CommunityWritePage> createState() => _CommunityWritePageState();
}

class _CommunityWritePageState extends State<CommunityWritePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String? _selectedCategory;
  String _selectedArea = '성수';

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (_titleController.text.trim().isEmpty) {
      context.showSnackbar('제목을 입력해주세요.', isError: true);
      return;
    }
    if (_selectedCategory == null) {
      context.showSnackbar('카테고리를 선택해주세요.', isError: true);
      return;
    }
    if (_bodyController.text.trim().isEmpty) {
      context.showSnackbar('내용을 입력해주세요.', isError: true);
      return;
    }

    try {
      await CommunityService.addPost(
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        category: _selectedCategory!,
        area: _selectedArea,
        popupTitle: '성수동 에디토리얼 팝업', // 실제로는 선택된 팝업 정보를 받아와야 함
      );
      if (mounted) {
        context.showSnackbar('게시글이 등록되었습니다.');
        context.pop();
      }
    } catch (e) {
      if (mounted) context.showSnackbar('오류가 발생했습니다: $e', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: '커뮤니티 글 작성',
        showBack: true,
        actions: [TextButton(onPressed: _onSubmit, child: const Text('저장'))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          const SectionHeader(title: '카테고리 선택', caption: 'Category'),
          8.heightBox,
          FilterChipBar(
            labels: const ['메이트', '후기', '교환', '질문'],
            selected: _selectedCategory ?? '',
            onSelected: (val) => setState(() => _selectedCategory = val),
          ),
          24.heightBox,
          const SectionHeader(title: '지역 선택', caption: 'Area'),
          8.heightBox,
          FilterChipBar(
            labels: const ['성수', '연남', '강남', '한남'],
            selected: _selectedArea,
            onSelected: (val) => setState(() => _selectedArea = val),
          ),
          24.heightBox,
          LabelTextField(
            label: '제목',
            hint: '제목을 입력해 주세요.',
            controller: _titleController,
            icon: LucideIcons.type,
          ),
          20.heightBox,
          LabelTextField(
            label: '상세 내용',
            hint: '이곳에서의 경험을 기록해 보세요.',
            controller: _bodyController,
            icon: LucideIcons.penLine,
            maxLines: 8,
          ),
          10.heightBox,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_bodyController.text.length} / 1000',
              style: const TextStyle(color: AppColors.muted),
            ),
          ),
          32.heightBox,
          PrimaryButton(
            label: '게시글 등록하기',
            icon: LucideIcons.send,
            onPressed: _onSubmit,
          ),
        ],
      ),
    );
  }
}
