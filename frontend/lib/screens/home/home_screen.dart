import 'package:flutter/material.dart';
import 'package:frontend/screens/home/widgets/fashion_banner/fashion_banner.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_sale_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showFashionSaleBanner = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (showFashionSaleBanner)
              FashionBanner(
                widthScreen: width,
                setShowFrashionSaleBanner: (state) =>
                    setState(() => showFashionSaleBanner = state),
              ),
            if (!showFashionSaleBanner)
              FashionSaleList(
                widthScreen: width,
              )
          ],
        ),
      ),
    );
  }
}
