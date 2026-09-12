import 'package:flutter/material.dart';

class GovernmentSchemesScreen extends StatefulWidget {
  const GovernmentSchemesScreen({super.key});

  @override
  State<GovernmentSchemesScreen> createState() =>
      _GovernmentSchemesScreenState();
}

class _GovernmentSchemesScreenState
    extends State<GovernmentSchemesScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> schemes = [
    {
      'title': 'PM-KISAN',
      'category': 'Financial Support',
      'description':
          'Financial assistance for eligible farmer families '
          'through direct income support.',
      'icon': Icons.currency_rupee,
      'color': Color(0xFFE7F3EA),
    },
    {
      'title': 'Pradhan Mantri Fasal Bima Yojana',
      'category': 'Insurance',
      'description':
          'Crop insurance support against crop losses caused '
          'by natural calamities and other risks.',
      'icon': Icons.shield_outlined,
      'color': Color(0xFFFFF3E0),
    },
    {
      'title': 'Kisan Credit Card',
      'category': 'Loans',
      'description':
          'Provides farmers access to affordable credit for '
          'agricultural and related activities.',
      'icon': Icons.credit_card_outlined,
      'color': Color(0xFFE8F0FE),
    },
    {
      'title': 'Soil Health Card',
      'category': 'Agriculture',
      'description':
          'Provides information about soil nutrients and '
          'helps farmers make better fertilizer decisions.',
      'icon': Icons.grass_outlined,
      'color': Color(0xFFE7F3EA),
    },
    {
      'title': 'PM Krishi Sinchai Yojana',
      'category': 'Irrigation',
      'description':
          'Supports efficient irrigation and improved water '
          'management for agricultural land.',
      'icon': Icons.water_drop_outlined,
      'color': Color(0xFFE3F2FD),
    },
    {
      'title': 'National Agriculture Market',
      'category': 'Market',
      'description':
          'Helps connect agricultural markets and provides '
          'farmers better access to market information.',
      'icon': Icons.storefront_outlined,
      'color': Color(0xFFF3E5F5),
    },
  ];

  final List<String> categories = [
    'All',
    'Financial Support',
    'Insurance',
    'Loans',
    'Agriculture',
    'Irrigation',
    'Market',
  ];

  List<Map<String, dynamic>> get filteredSchemes {
    if (selectedCategory == 'All') {
      return schemes;
    }

    return schemes
        .where(
          (scheme) =>
              scheme['category'] == selectedCategory,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),

      appBar: AppBar(
        backgroundColor: const Color(0xFF123D2A),
        foregroundColor: Colors.white,
        title: const Text(
          'Government Schemes',
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // =========================
                // HEADER
                // =========================

                const Text(
                  'Government Schemes 🏛️',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Explore government schemes and support '
                  'programs available for farmers.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // INFO BANNER
                // =========================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E593C),
                        Color(0xFF347653),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            Colors.white24,
                        child: Icon(
                          Icons.account_balance,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),

                      SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Support for Farmers',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              'Find financial, insurance, irrigation '
                              'and agricultural support programs.',
                              style: TextStyle(
                                color: Colors.white70,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // SEARCH
                // =========================

                Container(
                  height: 50,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(12),
                  ),

                  child: const TextField(
                    decoration: InputDecoration(
                      hintText:
                          'Search government schemes...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF28704B),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =========================
                // CATEGORY FILTER
                // =========================

                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 42,

                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,

                    itemCount: categories.length,

                    separatorBuilder:
                        (_, __) =>
                            const SizedBox(width: 10),

                    itemBuilder: (context, index) {
                      final category =
                          categories[index];

                      final isSelected =
                          selectedCategory ==
                              category;

                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,

                        onSelected: (_) {
                          setState(() {
                            selectedCategory =
                                category;
                          });
                        },

                        selectedColor:
                            const Color(0xFF28704B),

                        backgroundColor:
                            Colors.white,

                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(
                                  0xFF183D2B,
                                ),
                          fontWeight:
                              FontWeight.w600,
                        ),

                        side: BorderSide(
                          color: isSelected
                              ? const Color(
                                  0xFF28704B,
                                )
                              : const Color(
                                  0xFFDCE8DF,
                                ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // =========================
                // SCHEMES TITLE
                // =========================

                Row(
                  children: [
                    const Text(
                      'Available Schemes',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(0xFF183D2B),
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '${filteredSchemes.length} Schemes',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // =========================
                // SCHEME GRID
                // =========================

                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 1.45,
                  ),

                  itemCount: filteredSchemes.length,

                  itemBuilder: (context, index) {
                    final scheme =
                        filteredSchemes[index];

                    return _schemeCard(
                      title: scheme['title'],
                      category:
                          scheme['category'],
                      description:
                          scheme['description'],
                      icon: scheme['icon'],
                      iconBackground:
                          scheme['color'],
                    );
                  },
                ),

                const SizedBox(height: 30),

                // =========================
                // IMPORTANT NOTE
                // =========================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(
                        0xFFDCE8DF,
                      ),
                    ),
                  ),

                  child: const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color(0xFF28704B),
                        size: 26,
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Important Information',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 17,
                                color:
                                    Color(0xFF183D2B),
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              'Eligibility, benefits and application '
                              'requirements may vary. Always verify '
                              'the latest information through official '
                              'government sources before applying.',
                              style: TextStyle(
                                color: Colors.grey,
                                height: 1.5,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================================================
  // SCHEME CARD
  // ==================================================

  Widget _schemeCard({
    required String title,
    required String category,
    required String description,
    required IconData icon,
    required Color iconBackground,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(11),

                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Icon(
                  icon,
                  color:
                      const Color(0xFF28704B),
                  size: 26,
                ),
              ),

              const Spacer(),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color:
                      const Color(0xFFE7F3EA),
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  category,
                  style: const TextStyle(
                    color:
                        Color(0xFF28704B),
                    fontSize: 10,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            title,
            maxLines: 2,
            overflow:
                TextOverflow.ellipsis,

            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183D2B),
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Text(
              description,
              maxLines: 3,
              overflow:
                  TextOverflow.ellipsis,

              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 36,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF28704B),
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(9),
                ),
              ),

              child: const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  Text(
                    'View Details',
                    style: TextStyle(
                      color:
                          Color(0xFF28704B),
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  SizedBox(width: 5),

                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color:
                        Color(0xFF28704B),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}