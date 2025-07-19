import 'package:crafty_bay_project/app/app_colors.dart';
import 'package:crafty_bay_project/features/review/ui/screen/create_review.dart';
import 'package:flutter/material.dart';

import '../widget/review_card.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productId});

  static const String name = '/reviews';
  final String productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Reviews', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ReviewCard();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        color: AppColors.themeColor.withOpacity(0.15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews (1000)',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    CreateReview.name,
                    arguments: '123',
                  );
                },
                shape: CircleBorder(),
                mini: true,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
