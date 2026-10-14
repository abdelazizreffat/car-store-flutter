import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/widgets/custom_button.dart';
import 'package:car_store/features/cars/data/models/filter_options_model.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarFilterParams {
  final String? brand;
  final String? condition;
  final String? minPrice;
  final String? maxPrice;
  final String? city;
  final String? sort;

  const CarFilterParams({
    this.brand,
    this.condition,
    this.minPrice,
    this.maxPrice,
    this.city,
    this.sort,
  });

  bool get isEmpty =>
      brand == null &&
      condition == null &&
      minPrice == null &&
      maxPrice == null &&
      city == null &&
      sort == null;

  CarFilterParams copyWith({
    Object? brand = _sentinel,
    Object? condition = _sentinel,
    Object? minPrice = _sentinel,
    Object? maxPrice = _sentinel,
    Object? city = _sentinel,
    Object? sort = _sentinel,
  }) =>
      CarFilterParams(
        brand: brand == _sentinel ? this.brand : brand as String?,
        condition:
            condition == _sentinel ? this.condition : condition as String?,
        minPrice: minPrice == _sentinel ? this.minPrice : minPrice as String?,
        maxPrice: maxPrice == _sentinel ? this.maxPrice : maxPrice as String?,
        city: city == _sentinel ? this.city : city as String?,
        sort: sort == _sentinel ? this.sort : sort as String?,
      );

  static const _sentinel = Object();
}

// Shows the filter bottom sheet and returns the selected CarFilterParams (or null if cancelled).
Future<CarFilterParams?> showFilterBottomSheet(
  BuildContext context, {
  required CarsRepository repo,
  CarFilterParams? current,
}) {
  return showModalBottomSheet<CarFilterParams>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => _FilterSheet(repo: repo, current: current),
  );
}

class _FilterSheet extends StatefulWidget {
  final CarsRepository repo;
  final CarFilterParams? current;

  const _FilterSheet({required this.repo, this.current});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  FilterOptionsModel _options = const FilterOptionsModel();
  bool _loading = true;

  late String? _brand;
  late String? _condition;
  late String? _city;
  late String? _sort;
  final _minCtrl = TextEditingController();
  final _maxCtrl = TextEditingController();

  static const _sortOptions = [
    _SortOption('Price: Low to High', 'price_asc'),
    _SortOption('Price: High to Low', 'price_desc'),
    _SortOption('Newest First', 'newest'),
  ];

  @override
  void initState() {
    super.initState();
    final c = widget.current;
    _brand = c?.brand;
    _condition = c?.condition;
    _city = c?.city;
    _sort = c?.sort;
    _minCtrl.text = c?.minPrice ?? '';
    _maxCtrl.text = c?.maxPrice ?? '';
    _loadOptions();
  }

  @override
  void dispose() {
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadOptions() async {
    final result = await widget.repo.getFilterOptions();
    if (!mounted) return;
    result.fold(
      (_) => setState(() => _loading = false),
      (opts) => setState(() {
        _options = opts;
        _loading = false;
      }),
    );
  }

  void _apply() {
    final min = _minCtrl.text.trim();
    final max = _maxCtrl.text.trim();
    Navigator.of(context).pop(CarFilterParams(
      brand: _brand,
      condition: _condition,
      city: _city,
      sort: _sort,
      minPrice: min.isNotEmpty ? min : null,
      maxPrice: max.isNotEmpty ? max : null,
    ));
  }

  void _reset() {
    setState(() {
      _brand = null;
      _condition = null;
      _city = null;
      _sort = null;
      _minCtrl.clear();
      _maxCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder: (_, ctrl) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            // Handle
            const SizedBox(height: 12),
            Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 12),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.filter,
                      style: AppStyles.textStyle20SemiBoldBlack),
                  TextButton(
                      onPressed: _reset,
                      child: Text(AppStrings.reset,
                          style: const TextStyle(color: AppColors.primary))),
                ],
              ),
            ),
            const Divider(),

            if (_loading)
              const Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primary)))
            else
              Expanded(
                child: ListView(
                  controller: ctrl,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Condition
                    _SectionLabel(AppStrings.condition),
                    _ChipSelector(
                      options: [
                        null,
                        ..._options.conditions.isNotEmpty
                            ? _options.conditions
                            : ['new', 'used']
                      ],
                      labels: {
                        null: AppStrings.allConditions,
                        'new': AppStrings.conditionNew,
                        'used': AppStrings.conditionUsed,
                      },
                      selected: _condition,
                      onSelected: (v) => setState(() => _condition = v),
                    ),

                    // Brand
                    if (_options.brands.isNotEmpty) ...[
                      _SectionLabel(AppStrings.brand),
                      DropdownButtonFormField<String>(
                        initialValue: _brand,
                        decoration: _inputDecoration('All brands'),
                        items: [
                          const DropdownMenuItem(
                              value: null, child: Text('All brands')),
                          ..._options.brands.map((b) =>
                              DropdownMenuItem(value: b, child: Text(b))),
                        ],
                        onChanged: (v) => setState(() => _brand = v),
                      ),
                    ],

                    // City
                    if (_options.cities.isNotEmpty) ...[
                      _SectionLabel(AppStrings.city),
                      DropdownButtonFormField<String>(
                        initialValue: _city,
                        decoration: _inputDecoration('All cities'),
                        items: [
                          const DropdownMenuItem(
                              value: null, child: Text('All cities')),
                          ..._options.cities.map((c) =>
                              DropdownMenuItem(value: c, child: Text(c))),
                        ],
                        onChanged: (v) => setState(() => _city = v),
                      ),
                    ],

                    // Price
                    _SectionLabel(AppStrings.priceRange),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _minCtrl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: _inputDecoration('Min price'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _maxCtrl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: _inputDecoration('Max price'),
                          ),
                        ),
                      ],
                    ),

                    // Sort
                    _SectionLabel(AppStrings.sortBy),
                    DropdownButtonFormField<String>(
                      initialValue: _sort,
                      decoration: _inputDecoration('Default'),
                      items: [
                        const DropdownMenuItem(
                            value: null, child: Text('Default')),
                        ..._sortOptions.map((s) => DropdownMenuItem(
                            value: s.value, child: Text(s.label))),
                      ],
                      onChanged: (v) => setState(() => _sort = v),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

            // Apply button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: CustomButton(
                buttonLabel: AppStrings.apply,
                minHeight: 52,
                onPressed: _apply,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.lightGrey,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppStyles.borderRadiusCircular10,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      );
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(label, style: AppStyles.textStyle14MediumBlack),
      );
}

class _ChipSelector extends StatelessWidget {
  final List<String?> options;
  final Map<String?, String> labels;
  final String? selected;
  final ValueChanged<String?> onSelected;

  const _ChipSelector(
      {required this.options,
      required this.labels,
      required this.selected,
      required this.onSelected});

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8,
        children: options
            .map((o) => ChoiceChip(
                  label: Text(labels[o] ?? o ?? 'All'),
                  selected: selected == o,
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: selected == o ? AppColors.white : AppColors.black,
                  ),
                  onSelected: (_) => onSelected(o),
                ))
            .toList(),
      );
}

class _SortOption {
  final String label;
  final String value;
  const _SortOption(this.label, this.value);
}