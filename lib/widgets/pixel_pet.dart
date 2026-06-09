import 'package:flutter/material.dart';

/// 程序化生成的像素宠物。
///
/// 这是一套原创像素矩阵，用代码生成首版 demo 资产；后续可以替换为正式 PNG。
class PixelPet extends StatelessWidget {
  const PixelPet({
    super.key,
    required this.petId,
    required this.mood,
    this.size = 132,
  });

  final String petId;
  final String mood;
  final double size;

  @override
  Widget build(BuildContext context) {
    final palette = _paletteForPet(petId);
    final pixels = _pixelsForMood(mood);

    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _PixelPetPainter(
          pixels: pixels,
          palette: palette,
        ),
      ),
    );
  }

  List<String> _pixelsForMood(String mood) {
    final smile = mood == 'encouraging' ? '6' : '5';
    final mouthLine = StringBuffer('1222')
      ..write(smile)
      ..write(smile)
      ..write('222100');
    return <String>[
      '000111100000',
      '001111110000',
      '011222211000',
      '112222221100',
      '122323322100',
      '122222222100',
      mouthLine.toString(),
      '011222211000',
      '001444410000',
      '000144100000',
      '000100100000',
      '001100110000',
    ];
  }

  Map<String, Color> _paletteForPet(String petId) {
    switch (petId) {
      case 'mochi':
        return const <String, Color>{
          '0': Colors.transparent,
          '1': Color(0xFF4B3D73),
          '2': Color(0xFFE6D9FF),
          '3': Color(0xFF2B2442),
          '4': Color(0xFFFFC7D8),
          '5': Color(0xFF8B5CF6),
          '6': Color(0xFF6D5B8D),
        };
      case 'bean':
        return const <String, Color>{
          '0': Colors.transparent,
          '1': Color(0xFF2F5D50),
          '2': Color(0xFF9BE7C0),
          '3': Color(0xFF12362D),
          '4': Color(0xFFFFD166),
          '5': Color(0xFF227C5A),
          '6': Color(0xFF54786E),
        };
      default:
        return const <String, Color>{
          '0': Colors.transparent,
          '1': Color(0xFF6A3B2A),
          '2': Color(0xFFFFC078),
          '3': Color(0xFF2E1A12),
          '4': Color(0xFFFFE0A3),
          '5': Color(0xFFE76F51),
          '6': Color(0xFF9B6B4E),
        };
    }
  }
}

class _PixelPetPainter extends CustomPainter {
  const _PixelPetPainter({
    required this.pixels,
    required this.palette,
  });

  final List<String> pixels;
  final Map<String, Color> palette;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final cell = size.width / pixels.first.length;

    for (var y = 0; y < pixels.length; y++) {
      for (var x = 0; x < pixels[y].length; x++) {
        final color = palette[pixels[y][x]] ?? Colors.transparent;
        if (color == Colors.transparent) {
          continue;
        }
        paint.color = color;
        canvas.drawRect(
          Rect.fromLTWH(x * cell, y * cell, cell, cell),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PixelPetPainter oldDelegate) {
    return oldDelegate.pixels != pixels || oldDelegate.palette != palette;
  }
}
