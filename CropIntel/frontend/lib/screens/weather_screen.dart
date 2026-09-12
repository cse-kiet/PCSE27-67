import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF123D2A),
        foregroundColor: Colors.white,
        title: const Text(
          'Weather Insights',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // HEADER
                // =========================

                const Text(
                  'Weather Insights 🌦️',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Stay informed about weather conditions '
                  'to make smarter farming decisions.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // LOCATION
                // =========================

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF28704B),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        'Your Location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        'Jaipur, Rajasthan',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(width: 8),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_location_alt_outlined,
                          color: Color(0xFF28704B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // =========================
                // CURRENT WEATHER
                // =========================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E593C),
                        Color(0xFF347653),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              '28°C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'Partly Cloudy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              'Good conditions for farming activities.',
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.wb_cloudy_outlined,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // =========================
                // WEATHER STATS
                // =========================

                Row(
                  children: [
                    Expanded(
                      child: _weatherStat(
                        Icons.water_drop_outlined,
                        'Humidity',
                        '65%',
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _weatherStat(
                        Icons.air,
                        'Wind Speed',
                        '14 km/h',
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _weatherStat(
                        Icons.umbrella_outlined,
                        'Rain Chance',
                        '20%',
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _weatherStat(
                        Icons.wb_sunny_outlined,
                        'UV Index',
                        'Moderate',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // =========================
                // FORECAST TITLE
                // =========================

                const Text(
                  '5-Day Forecast',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 16),

                // =========================
                // FORECAST CARDS
                // =========================

                Row(
                  children: [
                    Expanded(
                      child: _forecastCard(
                        'Today',
                        Icons.wb_cloudy_outlined,
                        '28°C',
                        '22°C',
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _forecastCard(
                        'Tomorrow',
                        Icons.wb_sunny_outlined,
                        '30°C',
                        '23°C',
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _forecastCard(
                        'Mon',
                        Icons.cloud_outlined,
                        '27°C',
                        '21°C',
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _forecastCard(
                        'Tue',
                        Icons.grain,
                        '25°C',
                        '20°C',
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _forecastCard(
                        'Wed',
                        Icons.wb_sunny_outlined,
                        '29°C',
                        '22°C',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // =========================
                // FARMING RECOMMENDATION
                // =========================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F3EA),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFC5DDCC),
                    ),
                  ),
                  child: const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFF28704B),
                        size: 30,
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Farming Recommendation',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF183D2B),
                              ),
                            ),

                            SizedBox(height: 7),

                            Text(
                              'Current weather conditions look '
                              'suitable for regular field activities. '
                              'Keep monitoring rainfall and humidity '
                              'for disease prevention.',
                              style: TextStyle(
                                color: Color(0xFF4C6657),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // =========================
                // FARMING WEATHER TIPS
                // =========================

                const Text(
                  'Weather-Based Farming Tips',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _tipCard(
                        Icons.water_drop_outlined,
                        'Irrigation',
                        'Check soil moisture before '
                            'irrigating your crops.',
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _tipCard(
                        Icons.medical_services_outlined,
                        'Disease Risk',
                        'High humidity can increase '
                            'the risk of crop diseases.',
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _tipCard(
                        Icons.agriculture_outlined,
                        'Field Work',
                        'Plan field activities according '
                            'to upcoming weather conditions.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================================================
  // WEATHER STAT
  // ==================================================

  Widget _weatherStat(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF28704B),
            size: 28,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183D2B),
            ),
          ),
        ],
      ),
    );
  }

  // ==================================================
  // FORECAST CARD
  // ==================================================

  Widget _forecastCard(
    String day,
    IconData icon,
    String high,
    String low,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF183D2B),
            ),
          ),

          const SizedBox(height: 15),

          Icon(
            icon,
            size: 32,
            color: const Color(0xFF28704B),
          ),

          const SizedBox(height: 12),

          Text(
            high,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            low,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ==================================================
  // FARMING TIP CARD
  // ==================================================

  Widget _tipCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF28704B),
            size: 28,
          ),

          const SizedBox(height: 12),

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
    );
  }
}