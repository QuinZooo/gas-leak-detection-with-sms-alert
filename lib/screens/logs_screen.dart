import 'package:flutter/material.dart';

class LogsScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const LogsScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final logs = [
      {
        'date': '2026/03/19',
        'time': '09:15 AM',
        'status': 'Gas Leak',
        'ppm': '900 PPM',
        'danger': true,
      },
      {
        'date': '2026/03/18',
        'time': '04:20 PM',
        'status': 'Safe',
        'ppm': '270 PPM',
        'danger': false,
      },
      {
        'date': '2026/03/18',
        'time': '01:50 PM',
        'status': 'Safe',
        'ppm': '250 PPM',
        'danger': false,
      },
      {
        'date': '2026/03/17',
        'time': '08:10 PM',
        'status': 'Gas Leak',
        'ppm': '840 PPM',
        'danger': true,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Column(
          children: [
            _topHeader(onLogout: onLogout),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  const Text(
                    'Activity Logs',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Recent gas level history and alert records.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ...logs.map((log) {
                    final danger = log['danger'] as bool;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: danger
                                ? const Color(0xFFFFEBEE)
                                : const Color(0xFFE8F5E9),
                            child: Icon(
                              danger
                                  ? Icons.warning_amber_rounded
                                  : Icons.verified_rounded,
                              color: danger
                                  ? const Color(0xFFE53935)
                                  : const Color(0xFF43A047),
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${log['date']} • ${log['time']}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  log['status'] as String,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: danger
                                        ? const Color(0xFFE53935)
                                        : const Color(0xFF43A047),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            log['ppm'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topHeader({required VoidCallback onLogout}) {
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
            child: Icon(Icons.receipt_long_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'GasGuard Logs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
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