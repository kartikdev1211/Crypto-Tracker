import 'package:crypto_tracker/pages/favourites.dart';
import 'package:crypto_tracker/pages/markets.dart';
import 'package:crypto_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    viewController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Crypto Today",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      themeProvider.toggletheme();
                    },
                    padding: const EdgeInsets.all(0),
                    icon: (themeProvider.themeMode == ThemeMode.light)
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              TabBar(
                controller: viewController,
                tabs: const [
                  Tab(
                    child: Text("Markets"),
                  ),
                  Tab(
                    child: Text("Favourites"),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: viewController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: const [Markets(), Favourites()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
