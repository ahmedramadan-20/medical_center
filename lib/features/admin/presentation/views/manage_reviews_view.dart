import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_reviews_cubit.dart';
import 'package:medical_center/generated/l10n.dart';

class ManageReviewsView extends StatelessWidget {
  const ManageReviewsView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AdminReviewsCubit()..getReviews(),
        child: Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            title: Text(
              S.of(context).manage_reviews,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: BlocBuilder<AdminReviewsCubit, AdminReviewsState>(
            builder: (context, state) {
              if (state is AdminReviewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AdminReviewsSuccess) {
                if (state.reviews.isEmpty) {
                  return CustomEmptyWidget(
                    title: S.of(context).no_reviews,
                    subtitle: S.of(context).no_reviews_to_display,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.reviews.length,
                  itemBuilder: (context, index) {
                    final review = state.reviews[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.userName,
                                      style: AppTextStyles.cairo400Style20
                                          .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deepBlue,
                                      ),
                                    ),
                                    Text(
                                      'For Doctor ID: ${review.doctorId}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    index < review.rating
                                        ? Icons.star_rounded
                                        : Icons.star_outline_rounded,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            review.comment,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('MMM dd, yyyy')
                                    .format(DateTime.parse(review.createdAt)),
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    _showDeleteDialog(context, review),
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is AdminReviewsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );

  void _showDeleteDialog(BuildContext context, dynamic review) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Review?'),
        content: const Text(
          "Are you sure you want to delete this review? This will also update the doctor's average rating.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<AdminReviewsCubit>().deleteReview(review);
              Navigator.pop(dialogContext);
            },
            child: Text(
              S.of(context).delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
