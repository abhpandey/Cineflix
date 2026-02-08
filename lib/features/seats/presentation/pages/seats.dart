import 'package:flutter/material.dart';

class SeatsScreen extends StatefulWidget {
  const SeatsScreen({super.key});

  @override
  State<SeatsScreen> createState() => _SeatsScreenState();
}

class _SeatsScreenState extends State<SeatsScreen> {
  static const available = Color(0xFF3A3A3A);
  static const selected = Color(0xFF2ECC71);
  static const reserved = Color(0xFFB0B0B0);

  static const maxSelection = 10;

  late List<List<Color>> rows;

  final rowLabels = ["A", "B", "C", "D", "E", "F"];

  @override
  void initState() {
    super.initState();
    rows = [
      [available, available, available, available, available, available, available, available],
      [available, available, available, available, available, available, available, available],
      [available, available, available, available, available, available, available, available],
      [available, available, available, available, available, available, available, available],
      [available, available, available, available, available, available, available, available],
      [available, available, available, available, available, available, available, available],
    ];
  }

  int get selectedCount =>
      rows.expand((row) => row).where((seat) => seat == selected).length;

  void _toggleSeat(int rowIndex, int seatIndex) {
    final color = rows[rowIndex][seatIndex];

    if (color == reserved) return;

    setState(() {
      // unselect
      if (color == selected) {
        rows[rowIndex][seatIndex] = available;
        return;
      }

      // select (respect max limit)
      if (selectedCount >= maxSelection) {
        // Optional: show message (remove if you don't want it)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You can select up to 10 seats only."),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      rows[rowIndex][seatIndex] = selected;
    });
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Text("Cancel Selection?"),
          content: const Text(
            "Are you sure you want to clear all selected seats?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
              },
              child: const Text("Continue"),
            ),
            ElevatedButton(
              style: _primaryButtonStyle(Colors.orange),
              onPressed: () {
                setState(() {
                  for (int r = 0; r < rows.length; r++) {
                    for (int c = 0; c < rows[r].length; c++) {
                      if (rows[r][c] == selected) {
                        rows[r][c] = available;
                      }
                    }
                  }
                });
                Navigator.pop(context); // close dialog
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  Widget _seat({
    required int rowIndex,
    required int seatIndex,
  }) {
    final color = rows[rowIndex][seatIndex];

    return GestureDetector(
      onTap: () => _toggleSeat(rowIndex, seatIndex),
      child: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          "${seatIndex + 1}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _seatRow(int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 18,
          child: Text(
            rowLabels[rowIndex],
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 8),
        ...List.generate(
          rows[rowIndex].length,
          (seatIndex) => _seat(rowIndex: rowIndex, seatIndex: seatIndex),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 18,
          child: Text(
            rowLabels[rowIndex],
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  ButtonStyle _primaryButtonStyle(Color bg) {
    return ElevatedButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 38, 38),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 164, 59, 59),
        title: const Text(
          "Select Seats",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "SCREEN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const _ScreenArc(),
            const SizedBox(height: 40),
            ...List.generate(
              rows.length,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _seatRow(i),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _LegendItem(text: "Available", color: available),
                _LegendItem(text: "Selected", color: selected),
                _LegendItem(text: "Reserved", color: reserved),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Seats selected: $selectedCount / $maxSelection",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 40),

            // Book Now (always enabled, always green + white)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _primaryButtonStyle(Colors.green),
                onPressed: () {},
                child: const Text("Book Now"),
              ),
            ),

            const SizedBox(height: 12),

            // Cancel (orange + white, same style)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _primaryButtonStyle(Colors.orange),
                onPressed: _showCancelDialog,
                child: const Text("Cancel"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreenArc extends StatelessWidget {
  const _ScreenArc();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: CustomPaint(
        painter: _ScreenArcPainter(),
      ),
    );
  }
}

class _ScreenArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path()
      ..moveTo(size.width * 0.08, size.height * 0.9)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.05,
        size.width * 0.92,
        size.height * 0.9,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
