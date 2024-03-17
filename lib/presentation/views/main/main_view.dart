import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/presentation/blocs/main/main_cubit.dart';
import 'package:bloc_clean_architecture/presentation/views/main/cart/cart_view.dart';
import 'package:bloc_clean_architecture/presentation/views/main/home/home_view.dart';
import 'package:bloc_clean_architecture/presentation/views/main/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void dispose() {
    context.read<MainCubit>().update(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MainCubit, int>(
            builder: (context, state) {
              return AnimatedContainer(
                duration: const Duration(
                  seconds: 1,
                ),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: context.read<MainCubit>().controller,
                  children: const <Widget>[
                    HomeView(),
                    CartView(),
                    SettingView(),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 18,
            right: 18,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: BlocBuilder<MainCubit, int>(
                builder: (context, state) {
                  return SnakeNavigationBar.color(
                    behaviour: SnakeBarBehaviour.floating,
                    snakeShape: SnakeShape.indicator,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(48)),
                    ),
                    backgroundColor: Colors.black87,
                    snakeViewColor: Colors.black87,
                    height: 68,
                    elevation: 4,
                    selectedItemColor: SnakeShape.circle == SnakeShape.indicator
                        ? Colors.black87
                        : null,
                    unselectedItemColor: Colors.white,
                    selectedLabelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                    showUnselectedLabels: false,
                    showSelectedLabels: true,
                    currentIndex: state,
                    onTap: (index) => setState(() {
                      context.read<MainCubit>().controller.animateToPage(index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.linear);
                      context.read<MainCubit>().update(index);
                    }),
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          activeIcon: Icon(
                            Icons.home,
                            color: AppColor.greenDarkMossColor,
                          ),
                          label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart),
                          activeIcon: Icon(
                            Icons.shopping_cart,
                            color: AppColor.greenDarkMossColor,
                          ),
                          label: 'Cart'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          activeIcon: Icon(
                            Icons.settings,
                            color: AppColor.greenDarkMossColor,
                          ),
                          label: 'Setting'),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
