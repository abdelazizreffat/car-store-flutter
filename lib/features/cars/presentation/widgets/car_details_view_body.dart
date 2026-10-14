import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/widgets/custom_button.dart';
import 'package:car_store/core/widgets/favorite_button.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/presentation/cubits/car_details_cubit.dart';
import 'package:car_store/features/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsViewBody extends StatefulWidget {
  const CarDetailsViewBody({super.key});

  @override
  State<CarDetailsViewBody> createState() => _CarDetailsViewBodyState();
}

class _CarDetailsViewBodyState extends State<CarDetailsViewBody> {
  int _selectedImage = 0;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarDetailsCubit, CarDetailsState>(
      builder: (context, state) {
        if (state is CarDetailsLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (state is CarDetailsError) {
          return Scaffold(
            appBar: AppBar(backgroundColor: AppColors.background),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () =>
                        context.read<CarDetailsCubit>().loadDetails(
                          (context.read<CarDetailsCubit>().state
                                  as CarDetailsError)
                              .message,
                        ),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is CarDetailsSuccess) {
          return _buildSuccess(context, state.car);
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        );
      },
    );
  }

  Widget _buildSuccess(BuildContext context, CarModel car) {
    final images = car.images;
    debugPrint('Car images: ${images.map((image) => image.url).toList()}');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: AppColors.white,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.black),
              ),
            ),
            actions: [
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) => Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: FavoriteButton(
                    car: car,
                    isFavorite: favState.isFavorite(car.id),
                    onToggle: () =>
                        context.read<FavoritesCubit>().toggleFavorite(car),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  // Main image — BoxFit.contain so the full car is always visible
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: AppColors.lightGrey,
                      child: images.isNotEmpty
                          ? Image.network(
                              images[_selectedImage].url ?? '',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.directions_car,
                                size: 64,
                                color: AppColors.grey,
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.directions_car,
                                size: 64,
                                color: AppColors.grey,
                              ),
                            ),
                    ),
                  ),
                  // Thumbnail strip
                  if (images.length > 1)
                    SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        itemCount: images.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (_, i) => GestureDetector(
                          onTap: () => setState(() => _selectedImage = i),
                          child: Container(
                            width: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _selectedImage == i
                                    ? AppColors.primary
                                    : AppColors.grey,
                                width: _selectedImage == i ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.lightGrey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.network(
                                images[i].url ?? '',
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) => const Icon(
                                  Icons.image_not_supported,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${car.brand ?? ''} ${car.model ?? ''}',
                          style: AppStyles.textStyle20SemiBoldBlack,
                        ),
                      ),
                      if (car.ratingValue != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              car.ratingValue!.toStringAsFixed(1),
                              style: AppStyles.textStyle14MediumBlack.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Price
                  if (car.price != null)
                    Text(
                      'Rs. ${car.price}',
                      style: AppStyles.textStyle18SemiBoldPrimary,
                    ),

                  const SizedBox(height: 16),

                  // Description
                  if (car.description != null && car.description!.isNotEmpty)
                    _ExpandableText(
                      text: car.description!,
                      expanded: _expanded,
                      onToggle: () => setState(() => _expanded = !_expanded),
                    ),

                  const SizedBox(height: 20),

                  // Specifications
                  Text(
                    AppStrings.specifications,
                    style: AppStyles.textStyle20SemiBoldBlack,
                  ),
                  const SizedBox(height: 12),
                  _SpecsGrid(car: car),

                  // Features chips
                  if (car.features.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      AppStrings.features,
                      style: AppStyles.textStyle20SemiBoldBlack,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: car.features
                          .map(
                            (f) => Chip(
                              label: Text(
                                f,
                                style: AppStyles.textStyle14RegularBlack
                                    .copyWith(color: AppColors.white),
                              ),
                              backgroundColor: AppColors.primary,
                              side: BorderSide.none,
                            ),
                          )
                          .toList(),
                    ),
                  ],

                  // Seller info
                  if (car.seller != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      AppStrings.sellerInfo,
                      style: AppStyles.textStyle20SemiBoldBlack,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.lightGrey,
                          child: Icon(Icons.person, color: AppColors.darkGrey),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car.seller!.fullName,
                              style: AppStyles.textStyle14MediumBlack,
                            ),
                            if (car.location != null)
                              Text(
                                car.location!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: CustomButton(
            buttonLabel: AppStrings.buyNow,
            minHeight: 56,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class _ExpandableText extends StatelessWidget {
  final String text;
  final bool expanded;
  final VoidCallback onToggle;

  const _ExpandableText({
    required this.text,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppStyles.textStyle14RegularBlack,
          maxLines: expanded ? null : 3,
          overflow: expanded ? null : TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: onToggle,
          child: Text(
            expanded ? AppStrings.readLess : AppStrings.readMore,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _SpecsGrid extends StatelessWidget {
  final CarModel car;

  const _SpecsGrid({required this.car});

  @override
  Widget build(BuildContext context) {
    final specs = <_Spec>[
      if (car.year != null) _Spec('Year', '${car.year}'),
      if (car.condition != null) _Spec('Condition', car.condition!),
      if (car.fuelType != null) _Spec('Fuel', car.fuelType!),
      if (car.transmission != null) _Spec('Transmission', car.transmission!),
      if (car.engineSize != null) _Spec('Engine', car.engineSize!),
      if (car.horsepower != null) _Spec('HP', '${car.horsepower}'),
      if (car.mileage != null) _Spec('Mileage', '${car.mileage} km'),
      if (car.driveType != null) _Spec('Drive', car.driveType!),
      if (car.doors != null) _Spec('Doors', '${car.doors}'),
      if (car.seats != null) _Spec('Seats', '${car.seats}'),
      if (car.color != null) _Spec('Color', car.color!),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3,
      children: specs
          .map(
            (s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  Text(
                    s.value,
                    style: AppStyles.textStyle14MediumBlack,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Spec {
  final String label;
  final String value;
  const _Spec(this.label, this.value);
}
