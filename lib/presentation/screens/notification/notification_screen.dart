import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/loading_widget.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);

    if (state.isLoading) {
      return const CupertinoPageScaffold(
        backgroundColor: AppColors.cream,
      
        child: LoadingWidget(),
      );
    }

    return state.showIntro
        ? const _IntroView()
        : const _NotificationListView();
  }
}

// ── Intro screen ─────────────────────────────────────────────
class _IntroView extends ConsumerWidget {
  const _IntroView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.cream,
        border: null,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            CupertinoIcons.back,
            color: AppColors.primaryBrown,
          ),
        ),
        middle: Text(
          AppStrings.notification,
          style: AppTextStyles.titleMedium,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.pagePaddingH,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Bell badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBrown,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBrown.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.bell_fill,
                      color: AppColors.textOnDark,
                      size: 48,
                    ),
                  ),
                  Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.sp8,
                        vertical: AppDimensions.sp4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(
                            AppDimensions.radiusFull),
                      ),
                      child: Text(
                        ref
                            .watch(notificationProvider)
                            .unreadCount
                            .toString(),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textOnDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.sp40),

              Text(
                AppStrings.readNotifications,
                style: AppTextStyles.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.sp12),
              Text(
                AppStrings.notifSubtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              AppButton(
                label: AppStrings.continueBtn,
                onTap: () => ref
                    .read(notificationProvider.notifier)
                    .proceedToList(),
              ),
              const SizedBox(height: AppDimensions.sp40),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Notification list ─────────────────────────────────────────
class _NotificationListView extends ConsumerWidget {
  const _NotificationListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.cream,
        border: null,
        leading: GestureDetector(
          onTap: () => notifier.resetToIntro(),
          child: const Icon(
            CupertinoIcons.back,
            color: AppColors.primaryBrown,
          ),
        ),
        middle: Text(
          AppStrings.notification,
          style: AppTextStyles.titleMedium,
        ),
        trailing: state.unreadCount > 0
            ? GestureDetector(
                onTap: notifier.markAllAsRead,
                child: Text(
                  AppStrings.markAllRead,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryBrown,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : null,
      ),
      child: SafeArea(
        child: state.notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.bell_slash,
                      size: 56,
                      color: AppColors.lightBrown,
                    ),
                    const SizedBox(height: AppDimensions.sp16),
                    Text(
                      AppStrings.noNotifications,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.mediumBrown,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
                itemCount: state.notifications.length,
                itemBuilder: (_, i) {
                  final item = state.notifications[i];
                  return _NotifTile(
                    item: item,
                    onTap: () => notifier.markAsRead(item.id),
                    onDismiss: () => notifier.remove(item.id),
                  );
                },
              ),
      ),
    );
  }
}

// ── Single notification tile ──────────────────────────────────
class _NotifTile extends StatelessWidget {
  final NotificationEntity item;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotifTile({
    required this.item,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppDimensions.sp20),
        margin: const EdgeInsets.only(bottom: AppDimensions.sp10),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppDimensions.radius16),
        ),
        child: const Icon(
          CupertinoIcons.trash,
          color: AppColors.textOnDark,
          size: 24,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(bottom: AppDimensions.sp10),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.sp14,
            vertical: AppDimensions.sp14,
          ),
          decoration: BoxDecoration(
            color: item.isRead
                ? AppColors.beige.withOpacity(0.55)
                : AppColors.beige,
            borderRadius: BorderRadius.circular(AppDimensions.radius16),
            border: item.isRead
                ? null
                : Border.all(
                    color: AppColors.lightBrown.withOpacity(0.5),
                    width: 1,
                  ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBrown
                    .withOpacity(item.isRead ? 0.04 : 0.09),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Container(
                width: AppDimensions.avatarSize,
                height: AppDimensions.avatarSize,
                decoration: BoxDecoration(
                  color: item.isRead
                      ? AppColors.mediumBrown.withOpacity(0.4)
                      : AppColors.primaryBrown,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.person_fill,
                  color: AppColors.textOnDark,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppDimensions.sp12),

              // Message
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: item.isRead
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                      height: 1.4,
                    ),
                    children: [
                      if (item.senderName != null)
                        TextSpan(
                          text: '${item.senderName} ',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700),
                        ),
                      TextSpan(text: item.message),
                    ],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppDimensions.sp8),

              // Unread dot
              if (!item.isRead)
                Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBrown,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
