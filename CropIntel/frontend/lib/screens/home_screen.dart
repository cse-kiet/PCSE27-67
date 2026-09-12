import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'settings_screen.dart';

import 'login_screen.dart';
import 'disease_screen.dart';
import 'price_screen.dart';
import 'weather_screen.dart';
import 'market_insights_screen.dart';
import 'government_schemes_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),

      body: Row(
        children: [

          _buildSidebar(context),

          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    _buildTopBar(),

                    const SizedBox(height: 24),

                    _buildHeroBanner(),

                    const SizedBox(height: 28),

                    const Text(
                      'Common Features',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF183D2B),
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildCommonFeatures(context),

                    const SizedBox(height: 30),

                    const Text(
                      'Advanced Features',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF183D2B),
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildAdvancedFeatures(context),

                    const SizedBox(height: 30),

                    _buildBottomInsights(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // ==================================================
  // SIDEBAR
  // ==================================================

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 245,

      color: const Color(0xFF123D2A),

      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 25,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Row(
            children: [

              Icon(
                Icons.eco,
                color: Colors.white,
                size: 32,
              ),

              SizedBox(width: 10),

              Text(
                'CropIntel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 45),


          // DASHBOARD

          _sidebarItem(
            Icons.dashboard_outlined,
            'Dashboard',
            true,
          ),


          // DISEASE

          _sidebarItem(
            Icons.medical_services_outlined,
            'Disease Detection',
            false,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const DiseaseScreen(),
                ),
              );
            },
          ),


          // PRICE

          _sidebarItem(
            Icons.trending_up,
            'Price Prediction',
            false,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const PriceScreen(),
                ),
              );
            },
          ),


          // WEATHER

          _sidebarItem(
            Icons.cloud_outlined,
            'Weather',
            false,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const WeatherScreen(),
                ),
              );
            },
          ),


          // MARKET INSIGHTS

          _sidebarItem(
            Icons.analytics_outlined,
            'Market Insights',
            false,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const MarketInsightsScreen(),
                ),
              );
            },
          ),


          const Spacer(),


          // GOVERNMENT SCHEMES

          _sidebarItem(
            Icons.account_balance_outlined,
            'Government Schemes',
            false,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const GovernmentSchemesScreen(),
                ),
              );
            },
          ),


          // SETTINGS

          _sidebarItem(
            Icons.settings_outlined,
            'Settings',
            false,
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
               builder: (_) => const SettingsScreen(),
              ),
            );
           },
          ),


          // HELP

          _sidebarItem(
            Icons.help_outline,
            'Help & Support',
            false,
          ),


          // LOGOUT

          _sidebarItem(
            Icons.logout,
            'Logout',
            false,

            onTap: () async {
              await ApiService.logout();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                      const LoginScreen(),
                ),

                (route) => false,
              );
            },
          ),


          const SizedBox(height: 15),

          const Divider(
            color: Colors.white24,
          ),

          const SizedBox(height: 15),


          // USER

          const Row(
            children: [

              CircleAvatar(
                radius: 19,

                backgroundColor:
                    Color(0xFF78B892),

                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),

              SizedBox(width: 10),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    'Farmer',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'CropIntel User',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  // ==================================================
  // SIDEBAR ITEM
  // ==================================================

  Widget _sidebarItem(
    IconData icon,
    String title,
    bool selected, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: selected
          ? const Color(0xFF2B6248)
          : Colors.transparent,

      borderRadius:
          BorderRadius.circular(10),

      child: ListTile(
        onTap: onTap,

        dense: true,

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10),
        ),

        leading: Icon(
          icon,
          color: Colors.white,
          size: 21,
        ),

        title: Text(
          title,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }


  // ==================================================
  // TOP BAR
  // ==================================================

  Widget _buildTopBar() {
    return Row(
      children: [

        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                'Good Morning 👋',

                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 4),

              Text(
                'Welcome to CropIntel',

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183D2B),
                ),
              ),
            ],
          ),
        ),


        // SEARCH

        Container(
          width: 260,
          height: 42,

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(12),
          ),

          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search...',

              prefixIcon:
                  Icon(Icons.search),

              border: InputBorder.none,
            ),
          ),
        ),


        const SizedBox(width: 15),


        // NOTIFICATION

        Container(
          padding:
              const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(12),
          ),

          child: const Icon(
            Icons.notifications_none,
            color: Color(0xFF183D2B),
          ),
        ),
      ],
    );
  }


  // ==================================================
  // HERO BANNER
  // ==================================================

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(30),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E593C),
            Color(0xFF347653),
          ],
        ),

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Row(
        children: [

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  'Smarter Farming,\nBrighter Tomorrow 🌱',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Use AI-powered insights to protect your crops\n'
                  'and make better farming decisions.',

                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'AI • Agriculture • Intelligence',

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),


          Container(
            width: 170,
            height: 130,

            decoration: BoxDecoration(
              color:
                  Colors.white.withOpacity(0.12),

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Icon(
              Icons.agriculture,
              size: 80,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }


  // ==================================================
  // COMMON FEATURES
  // ==================================================

  Widget _buildCommonFeatures(
    BuildContext context,
  ) {
    return Row(
      children: [

        Expanded(
          child: _featureCard(
            icon: Icons.local_florist,

            title:
                'Crop Disease Detection',

            description:
                'Upload a leaf image and detect possible crop diseases.',

            buttonText:
                'Detect Disease',

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const DiseaseScreen(),
                ),
              );
            },
          ),
        ),


        const SizedBox(width: 18),


        Expanded(
          child: _featureCard(
            icon: Icons.show_chart,

            title:
                'Crop Price Prediction',

            description:
                'Predict agricultural commodity prices using AI.',

            buttonText:
                'Predict Price',

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const PriceScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  // ==================================================
  // FEATURE CARD
  // ==================================================

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.04),

            blurRadius: 12,

            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            padding:
                const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color:
                  const Color(0xFFE7F3EA),

              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Icon(
              icon,

              color:
                  const Color(0xFF1E593C),

              size: 28,
            ),
          ),


          const SizedBox(height: 18),


          Text(
            title,

            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183D2B),
            ),
          ),


          const SizedBox(height: 8),


          Text(
            description,

            style: const TextStyle(
              color: Colors.grey,
              height: 1.4,
            ),
          ),


          const SizedBox(height: 18),


          SizedBox(
            width: double.infinity,

            child: ElevatedButton(
              onPressed: onTap,

              child: Text(
                buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }


  // ==================================================
  // ADVANCED FEATURES
  // ==================================================

  Widget _buildAdvancedFeatures(
    BuildContext context,
  ) {
    return Row(
      children: [

        Expanded(
          child: _advancedCard(
            Icons.cloud,

            'Weather Insights',

            'Get weather information for better crop planning.',

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const WeatherScreen(),
                ),
              );
            },
          ),
        ),


        const SizedBox(width: 15),


        Expanded(
          child: _advancedCard(
            Icons.storefront,

            'Market Insights',

            'Explore market trends and agricultural prices.',

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const MarketInsightsScreen(),
                ),
              );
            },
          ),
        ),


        const SizedBox(width: 15),


        Expanded(
          child: _advancedCard(
            Icons.account_balance,

            'Government Schemes',

            'Discover useful agriculture schemes and support.',

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const GovernmentSchemesScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  // ==================================================
  // ADVANCED CARD
  // ==================================================

  Widget _advancedCard(
    IconData icon,
    String title,
    String description, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(16),

        child: Container(
          padding:
              const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(16),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Icon(
                icon,

                color:
                    const Color(0xFF28704B),

                size: 30,
              ),


              const SizedBox(height: 14),


              Text(
                title,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF183D2B),
                ),
              ),


              const SizedBox(height: 7),


              Text(
                description,

                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // ==================================================
  // BOTTOM INSIGHTS
  // ==================================================

  Widget _buildBottomInsights() {
    return Row(
      children: [

        Expanded(
          child: Container(
            padding:
                const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(16),
            ),

            child: const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  'Quick Farming Tip 💡',

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  'Regularly check your crops for early signs '
                  'of disease to prevent major crop loss.',

                  style: TextStyle(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),


        const SizedBox(width: 18),


        Expanded(
          child: Container(
            padding:
                const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color:
                  const Color(0xFFE7F3EA),

              borderRadius:
                  BorderRadius.circular(16),
            ),

            child: const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  'CropIntel AI 🤖',

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  'Your intelligent agriculture companion '
                  'for smarter decisions.',

                  style: TextStyle(
                    color: Color(0xFF4C6657),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}