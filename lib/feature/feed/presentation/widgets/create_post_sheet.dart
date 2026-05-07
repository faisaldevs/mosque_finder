import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../models/feed_models.dart';
import 'feed_widgets.dart';

class CreatePostSheet extends StatefulWidget {
  final String? initialType;
  final List<PostTypeOption> postTypes;
  final void Function(Post) onPost;

  const CreatePostSheet({
    super.key,
    this.initialType,
    required this.postTypes,
    required this.onPost,
  });

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  final _ctrl = TextEditingController();
  final _typeCtrl = TextEditingController();
  String? _selectedType;
  String _privacy = 'Public';
  bool _hasPhoto = false;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _typeCtrl.dispose();
    super.dispose();
  }

  bool get _canPost =>
      _ctrl.text.trim().isNotEmpty ||
      (_selectedType != null && _typeCtrl.text.trim().isNotEmpty);

  String _typeHint() {
    switch (_selectedType) {
      case 'quran':
        return 'Enter Quran verse and reference...';
      case 'hadith':
        return 'Enter Hadith and source...';
      case 'checkin':
        return 'Enter mosque or location name...';
      case 'prayer':
        return 'Which prayer? (e.g. Fajr, Dhuhr...)';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.kBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Sheet header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.kGreenLight,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Create Post',
                        style: TextStyle(
                          color: AppColors.kText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _canPost ? _submitPost : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _canPost
                            ? AppColors.kPrimary
                            : AppColors.kPrimary.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Post',
                        style: TextStyle(
                          color: AppColors.kTextWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.kBorder),

            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: EdgeInsets.zero,
                children: [
                  // User row + privacy
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: Row(
                      children: [
                        buildAvatar('🧑', 44),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Faisal Ahmed',
                              style: TextStyle(
                                color: AppColors.kText,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: _showPrivacyPicker,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kBg,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: AppColors.kBorder),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _privacy == 'Public'
                                          ? Icons.public_rounded
                                          : Icons.lock_outline_rounded,
                                      color: AppColors.kSubText,
                                      size: 13,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _privacy,
                                      style: const TextStyle(
                                        color: AppColors.kSubText,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: AppColors.kSubText,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Main text input
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: TextField(
                      controller: _ctrl,
                      maxLines: null,
                      autofocus: _selectedType == null,
                      style: const TextStyle(
                        color: AppColors.kText,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      decoration: const InputDecoration(
                        hintText: "What's on your mind?",
                        hintStyle: TextStyle(
                          color: AppColors.kSubText,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),

                  // Post type specific input
                  if (_selectedType != null && _selectedType != 'photo') ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.kBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.kPrimary.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.postTypes
                                      .firstWhere((t) => t.id == _selectedType)
                                      .emoji,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.postTypes
                                      .firstWhere((t) => t.id == _selectedType)
                                      .label,
                                  style: TextStyle(
                                    color: AppColors.kGreenLight,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedType = null),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    color: AppColors.kSubText,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _typeCtrl,
                              maxLines: null,
                              autofocus: true,
                              style: const TextStyle(
                                color: AppColors.kText,
                                fontSize: 14,
                                height: 1.5,
                                fontStyle: FontStyle.italic,
                              ),
                              decoration: InputDecoration(
                                hintText: _typeHint(),
                                hintStyle: const TextStyle(
                                  color: AppColors.kSubText,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Photo placeholder
                  if (_hasPhoto || _selectedType == 'photo') ...[
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppColors.kBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.kBorder),
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('🖼️', style: TextStyle(fontSize: 48)),

                                SizedBox(height: 8),
                                Text(
                                  'Tap to add photo',
                                  style: TextStyle(
                                    color: AppColors.kSubText,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => setState(() {
                                _hasPhoto = false;
                                _selectedType = null;
                              }),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black54,
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: AppColors.kText,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Type selector row
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Text(
                      'Add to your post',
                      style: TextStyle(
                        color: AppColors.kSubText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: widget.postTypes.map((t) {
                        final sel = _selectedType == t.id;
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedType = sel ? null : t.id;
                            if (t.id == 'photo') _hasPhoto = !sel;
                          }),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: sel
                                  ? hexToColor(
                                      t.colorHex,
                                    ).withValues(alpha: 0.2)
                                  : AppColors.kBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: sel
                                    ? hexToColor(t.colorHex)
                                    : AppColors.kBorder,
                                width: sel ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  t.emoji,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  t.label,
                                  style: TextStyle(
                                    color:
                                        //  sel
                                        //     ? hexToColor(t.colorHex)
                                        //     :
                                        AppColors.kSubText,
                                    fontSize: 13,
                                    fontWeight: sel
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPrivacyPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Who can see this?',
            style: TextStyle(
              color: AppColors.kText,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...['Public', 'Friends', 'Community'].map(
            (opt) => ListTile(
              leading: Icon(
                opt == 'Public'
                    ? Icons.public_rounded
                    : opt == 'Friends'
                    ? Icons.group_rounded
                    : Icons.mosque_rounded,
                color: opt == _privacy
                    ? AppColors.kGreenLight
                    : AppColors.kSubText,
              ),
              title: Text(
                opt,
                style: TextStyle(
                  color: opt == _privacy
                      ? AppColors.kGreenLight
                      : AppColors.kText,
                ),
              ),
              trailing: opt == _privacy
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.kGreenLight,
                    )
                  : null,
              onTap: () {
                setState(() => _privacy = opt);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _submitPost() {
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userName: 'Faisal Ahmed',
      userEmoji: '🧑',
      timeAgo: 'Just now',
      text: _ctrl.text.trim().isNotEmpty ? _ctrl.text.trim() : null,
      imageAsset: _hasPhoto ? '🖼️' : null,
      postType: _selectedType,
      typeContent: _typeCtrl.text.trim().isNotEmpty
          ? _typeCtrl.text.trim()
          : null,
      privacy: _privacy,
    );
    widget.onPost(newPost);
    Navigator.pop(context);
  }
}
