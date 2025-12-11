import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'location_selection_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildHeroSection(context),
              _buildSocialProof(context),
              _buildFeatureHighlights(context),
              _buildTrustSignals(context),
              _buildFinalCTA(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Image.asset(
            'assets/icon/app_icon.png',
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 12),
          Text(
            'KidsList',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    // Above-the-fold optimization: F-pattern layout with gradient background
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryBlue.withValues(alpha: 0.08),
            AppTheme.accentGreen.withValues(alpha: 0.05),
            Colors.white,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.accentGreen.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryBlue.withValues(alpha: 0.08),
              ),
            ),
          ),
          // Content
          Container(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          // Headline - Most prominent element
          Text(
            'Find the Perfect Activities for Your Kids',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: AppTheme.textDark,
                ),
          ),
          const SizedBox(height: 20),
          
          // Value proposition
          Text(
            'Discover camps, classes, childcare and enrichment programs across the nation—all in one place.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  height: 1.6,
                  color: AppTheme.textLight,
                ),
          ),
          const SizedBox(height: 40),
          
          // Primary CTA - Most important action
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LocationSelectionScreen(isInitialSetup: true),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentGreen,
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Get Started - Find Activities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Secondary value prop
          Center(
            child: Text(
              'Free to search • No signup required',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textLight,
                    fontSize: 14,
                  ),
            ),
          ),
        ],
      ),
    ),
        ],
      ),
    );
  }

  Widget _buildSocialProof(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppTheme.primaryBlue.withValues(alpha: 0.05),
            Colors.white,
            AppTheme.primaryBlue.withValues(alpha: 0.05),
          ],
        ),
        border: Border(
          top: BorderSide(
            color: AppTheme.primaryBlue.withValues(alpha: 0.2),
            width: 2,
          ),
          bottom: BorderSide(
            color: AppTheme.primaryBlue.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Search Activities Nationwide',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard(
                context,
                '10,000+',
                'Activities',
                Icons.local_activity,
              ),
              _buildStatCard(
                context,
                '12',
                'Major Cities',
                Icons.location_city,
              ),
              _buildStatCard(
                context,
                'Free',
                'To Search',
                Icons.search,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String number,
    String label,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 28,
              color: AppTheme.accentGreen,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            number,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                  fontSize: 26,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textLight,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlights(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            AppTheme.cardBackground,
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 50),
      child: Column(
        children: [
          // Section badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.accentGreen.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              'HOW IT WORKS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.accentGreen,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Everything You Need to Find the Right Fit',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 35),
          _buildFeatureCard(
            context,
            Icons.search,
            'Comprehensive Search',
            'Browse thousands of activities across camps, classes, sports, arts, childcare, and enrichment programs.',
            AppTheme.primaryBlue,
          ),
          const SizedBox(height: 24),
          _buildFeatureCard(
            context,
            Icons.public,
            'Diversity-Focused Filters',
            'Find programs that celebrate your family\'s culture and values with our dedicated multicultural filter.',
            AppTheme.accentGreen,
          ),
          const SizedBox(height: 24),
          _buildFeatureCard(
            context,
            Icons.attach_money,
            'Free & Paid Options',
            'Filter by price range or find completely free programs. We believe every family deserves access to quality activities.',
            const Color(0xFFE67E22),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 32,
              color: color,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        fontSize: 15,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustSignals(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 45, 24, 45),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.accentGreen.withValues(alpha: 0.08),
            AppTheme.accentGreen.withValues(alpha: 0.03),
          ],
        ),
        border: Border(
          top: BorderSide(
            color: AppTheme.accentGreen.withValues(alpha: 0.2),
            width: 3,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.verified_user,
                color: AppTheme.accentGreen,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Why Parents Trust KidsList',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTrustItem(
            context,
            Icons.check_circle,
            'Verified Providers',
            'All activities are reviewed to ensure quality and safety',
          ),
          const SizedBox(height: 16),
          _buildTrustItem(
            context,
            Icons.check_circle,
            'Inclusive & Diverse',
            'Celebrating programs that welcome all families and backgrounds',
          ),
          const SizedBox(height: 16),
          _buildTrustItem(
            context,
            Icons.check_circle,
            'Always Free',
            'No fees to search, browse, or contact activity providers',
          ),
          const SizedBox(height: 16),
          _buildTrustItem(
            context,
            Icons.check_circle,
            'Local & National',
            'Find activities in major metros and custom locations nationwide',
          ),
        ],
      ),
    );
  }

  Widget _buildTrustItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppTheme.accentGreen,
          size: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinalCTA(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            AppTheme.primaryBlue.withValues(alpha: 0.05),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 40),
      child: Column(
        children: [
          Text(
            'Ready to Find the Perfect Activities?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Discover amazing programs for your kids across the nation',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textLight,
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LocationSelectionScreen(isInitialSetup: true),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentGreen,
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Get Started Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'It\'s free and takes less than 30 seconds',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textLight,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }
}
