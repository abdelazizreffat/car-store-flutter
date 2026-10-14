import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:car_store/features/favorites/presentation/views/favorites_view.dart';
import 'package:car_store/features/home/presentation/cubits/home_cubit.dart';
import 'package:car_store/features/home/presentation/cubits/search_cubit.dart';
import 'package:car_store/features/home/presentation/widgets/home_view_body.dart';
import 'package:car_store/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  static const _navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      activeIcon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (_) => sl<HomeCubit>()..loadHome()),
        BlocProvider<SearchCubit>(create: (_) => sl<SearchCubit>()),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go(AppRouter.kLoginView);
          }
        },
        child: Builder(
          builder: (context) => Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: const [HomeViewBody(), FavoritesView(), ProfileView()],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.darkGrey,
              backgroundColor: AppColors.white,
              type: BottomNavigationBarType.fixed,
              items: _navItems,
            ),
          ),
        ),
      ),
    );
  }
}
