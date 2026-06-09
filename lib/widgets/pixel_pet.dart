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
    final pixels = _pixelsForPet(petId, mood);

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

  List<String> _pixelsForPet(String petId, String mood) {
    final mouth = mood == 'encouraging' ? '6' : '5';
    final mouthLine = (StringBuffer('12222')
      ..write(mouth)
      ..write(mouth)
      ..write('222221'))
        .toString();
    final base = <String>[
      '00011000011000',
      '00122111122100',
      '01222222222210',
      '12222222222221',
      '12223322332221',
      '12224422442221',
      '12222222222221',
      mouthLine,
      '01222222222210',
      '00122222222100',
      '00012222221000',
      '00011222211000',
      '00110011001100',
      '01100011000110',
    ];

    if (petId == 'bean') {
      return <String>[
        '00001111110000',
        '00012222221000',
        '00122222222100',
        '01222222222210',
        '12223322332221',
        '12224422442221',
        '12222222222221',
        mouthLine,
        '01222222222210',
        '00122222222100',
        '00012222221000',
        '00011222211000',
        '00110011001100',
        '01100011000110',
      ];
    }

    if (petId == 'mochi') {
      return <String>[
        '00011111111000',
        '00122222222100',
        '01222222222210',
        '12222222222221',
        '12223322332221',
        '12224422442221',
        '12222222222221',
        mouthLine,
        '01222222222210',
        '00122222222100',
        '00012222221000',
        '00011222211000',
        '00110011001100',
        '01100011000110',
      ];
    }

    return base;
  }

  Map<String, Color> _paletteForPet(String petId) {
    switch (petId) {
      case 'mochi':
        return const <String, Color>{
          '0': Colors.transparent,
          '1': Color(0xFF6A4C93),
          '2': Color(0xFFEBDDFE),
          '3': Color(0xFF33234E),
          '4': Color(0xFFFFA6C8),
          '5': Color(0xFFB46CF2),
          '6': Color(0xFF8C79A8),
        };
      case 'bean':
        return const <String, Color>{
          '0': Colors.transparent,
          '1': Color(0xFF24745A),
          '2': Color(0xFFA7F3C4),
          '3': Color(0xFF123B2F),
          '4': Color(0xFFFFD166),
          '5': Color(0xFF20A66B),
          '6': Color(0xFF6A8A7D),
        };
      default:
        return const <String, Color>{
          '0': Colors.transparent,
          '1': Color(0xFF8A4F2B),
          '2': Color(0xFFFFC97A),
          '3': Color(0xFF3A2418),
          '4': Color(0xFFFF8FA3),
          '5': Color(0xFFFF7A59),
          '6': Color(0xFFB07752),
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
