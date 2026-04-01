import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LogsScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const LogsScreen({super.key, required this.onLogout});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final DatabaseReference _logsRef =
      FirebaseDatabase.instance.ref('gasguard/logs');

  List<Map<String, dynamic>> logs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _logsRef.orderByChild('timestamp').onValue.listen((event) {
      final data = event.snapshot.value;
      final List<Map<String, dynamic>> fetched = [];

      if (data != null && data is Map) {
        data.forEach((key, value) {
          if (value is Map) {
            fetched.add({
              'date': value['date'] ?? '',
              'time': value['time'] ?? '',
              'status': value['status'] ?? '',
              'ppm': '${value['ppm'] ?? 0} PPM',
              'danger': value['danger'] as bool? ?? false,
            });
          }
        });
        // Most recent first
        fetched.sort((a, b) => b['date'].compareTo(a['date']));
      }

      setState(() {
        logs = fetched;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Column(
          children: [
            _topHeader(onLogout: widget.onLogout),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF0C7A7A)))
                  : logs.isEmpty
                      ? const Center(
                          child: Text(
                            'No log entries yet.\nWaiting for sensor data...',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black45),
                          ),
                        )
                      : ListView(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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