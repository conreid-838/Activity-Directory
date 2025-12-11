import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/activity.dart';
import '../providers/activities_provider.dart';
import '../theme/app_theme.dart';

class ActivityDetailScreen extends StatefulWidget {
  final Activity activity;

  const ActivityDetailScreen({super.key, required this.activity});

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Track view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ActivitiesProvider>()
          .trackActivityView(widget.activity.id);
    });
  }

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchMaps() async {
    final query = Uri.encodeComponent(widget.activity.address);
    final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$query');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _visitWebsite() async {
    if (widget.activity.website != null) {
      // Track website click
      await context
          .read<ActivitiesProvider>()
          .trackWebsiteClick(widget.activity.id);
      
      await _launchUrl(widget.activity.website!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const Divider(height: 1),
              _buildDetails(),
              if (widget.activity.inclusionHighlights.isNotEmpty) ...[
                const Divider(height: 1),
                _buildInclusionHighlights(),
              ],
              const Divider(height: 1),
              _buildContactSection(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomCTA(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.activity.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCategoryBadge(widget.activity.categoryName),
              _buildBadge(widget.activity.seasonDisplay),
              if (widget.activity.isDiverse) _buildDiverseBadge(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: AppTheme.textLight,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.activity.location,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.activity.address,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: widget.activity.isFree
                      ? AppTheme.accentGreen
                      : AppTheme.primaryBlue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  widget.activity.priceDisplay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    size: 16,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.activity.viewCount} views',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            widget.activity.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          _buildDetailRow(
            Icons.child_care,
            'Age Groups',
            widget.activity.ageGroupsDisplay,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.calendar_today,
            'Timeframe',
            widget.activity.seasonDisplay,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.primaryBlue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInclusionHighlights() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppTheme.accentGreen.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.public,
                color: AppTheme.accentGreen,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Inclusion Highlights',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.accentGreen,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...widget.activity.inclusionHighlights.map(
            (highlight) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 20,
                    color: AppTheme.accentGreen,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      highlight,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.phone, color: AppTheme.primaryBlue),
            title: const Text('Phone'),
            subtitle: Text(widget.activity.phoneNumber),
            contentPadding: EdgeInsets.zero,
            onTap: () => _launchPhone(widget.activity.phoneNumber),
          ),
          ListTile(
            leading: const Icon(Icons.email, color: AppTheme.primaryBlue),
            title: const Text('Email'),
            subtitle: Text(widget.activity.email),
            contentPadding: EdgeInsets.zero,
            onTap: () => _launchEmail(widget.activity.email),
          ),
          ListTile(
            leading: const Icon(Icons.map, color: AppTheme.primaryBlue),
            title: const Text('View on Map'),
            subtitle: Text(widget.activity.address),
            contentPadding: EdgeInsets.zero,
            onTap: _launchMaps,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCTA() {
    if (widget.activity.website == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton.icon(
          onPressed: _visitWebsite,
          icon: const Icon(Icons.open_in_new),
          label: const Text('Visit Website'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.getCategoryColor(text).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.getCategoryColor(text)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: AppTheme.getCategoryColor(text),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: AppTheme.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDiverseBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.accentGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGreen),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.public,
            size: 14,
            color: AppTheme.accentGreen,
          ),
          const SizedBox(width: 4),
          const Text(
            'Diverse',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.accentGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
