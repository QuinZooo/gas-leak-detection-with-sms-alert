import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const HomeScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    const bool isSafe = false;
    const int gasLevel = 900;

    return Scaffold(
      backgroundColor: isSafe ? const Color(0xFFEAF9D8) : const Color(0xFFFFECEC),
      body: SafeArea(
        child: Column(
          children: [
            _topHeader(title: 'GasGuard', onLogout: onLogout),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                child: Column(
                  children: [
                    _notificationBanner(isSafe: isSafe),
                    const SizedBox(height: 16),
                    _gasStatusCard(isSafe: isSafe, gasLevel: gasLevel),
                    const SizedBox(height: 16),
                    _quickInfoCard(),
                    const SizedBox(height: 16),
                    _actionCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationBanner({required bool isSafe}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isSafe ? const Color(0xFFDDF7D5) : const Color(0xFFFFD9D9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSafe ? const Color(0xFF47A447) : const Color(0xFFE53935),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor:
            isSafe ? const Color(0xFF47A447) : const Color(0xFFE53935),
            child: Icon(
              isSafe ? Icons.check_rounded : Icons.notifications_active_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isSafe
                  ? 'System update: Gas level is normal and area is currently safe.'
                  : 'Alert sent: Dangerous gas level detected. SMS notification triggered.',
              style: const TextStyle(
                fontSize: 14,
                height: 1.35,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gasStatusCard({required bool isSafe, required int gasLevel}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isSafe
                    ? [const Color(0xFF8DE969), const Color(0xFF4CAF50)]
                    : [const Color(0xFFFF7A7A), const Color(0xFFE53935)],
              ),
            ),
            child: Icon(
              isSafe ? Icons.verified_rounded : Icons.warning_amber_rounded,
              color: Colors.white,
              size: 38,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Current Gas Level',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$gasLevel PPM',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: isSafe ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSafe ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color:
                  isSafe ? const Color(0xFF43A047) : const Color(0xFFE53935),
                ),
                const SizedBox(width: 8),
                Text(
                  isSafe ? 'SAFE' : 'DANGER',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color:
                    isSafe ? const Color(0xFF43A047) : const Color(0xFFE53935),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: const [
              Icon(Icons.schedule_rounded, size: 18, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                'Last Updated: 5 seconds ago',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0C7A7A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'System Preview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'This is a static app preview for monitoring gas level, alerts, logs, and SMS status before Arduino integration.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFFFF3E0),
            child: Icon(
              Icons.sms_rounded,
              color: Colors.orange,
              size: 26,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              'SMS alert module is ready for testing UI flow.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topHeader({required String title, required VoidCallback onLogout}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: const BoxDecoration(
        color: Color(0xFF0C7A7A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white24,
            child: Icon(Icons.local_fire_department_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'GasGuard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}