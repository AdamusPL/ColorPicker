import 'dart:math';

class ColorConverter {
  static List<String> rgbToHsv(int r, int g, int b) {
    var rp = r / 255.0;
    var gp = g / 255.0;
    var bp = b / 255.0;
    var cmax = max(rp, max(gp, bp));
    var cmin = min(rp, min(gp, bp));
    var delta = cmax - cmin;
    var h = 0.0;
    if (delta == 0.0) {
      h = 0.0;
    } else if (cmax == rp) {
      h = 60.0 * (((gp - bp) / delta) % 6.0);
    } else if (cmax == gp) {
      h = 60.0 * (((bp - rp) / delta) + 2.0);
    } else if (cmax == bp) {
      h = 60.0 * (((rp - gp) / delta) + 4.0);
    }
    var s = cmax == 0.0 ? 0.0 : delta / cmax;
    return [
      h.toStringAsFixed(2),
      (s * 100).toStringAsFixed(2),
      (cmax * 100).toStringAsFixed(2)
    ];
  }

  static List<String> rgbToCmyk(int r, int g, int b) {
    var rp = r / 255.0;
    var gp = g / 255.0;
    var bp = b / 255.0;
    var k = 1 - max(rp, max(gp, bp));
    if (k == 1.0) {
      return ["0", "0", "0", "100"];
    }
    var c = (1 - rp - k) / (1 - k);
    var m = (1 - gp - k) / (1 - k);
    var y = (1 - bp - k) / (1 - k);
    return [
      (c * 100).toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), ''),
      (m * 100).toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), ''),
      (y * 100).toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), ''),
      (k * 100).toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), '')
    ];
  }

  static String rgbToHex(int r, int g, int b) {
    var hex = r.toRadixString(16).padLeft(2, '0');
    hex += g.toRadixString(16).padLeft(2, '0');
    hex += b.toRadixString(16).padLeft(2, '0');
    return hex;
  }

  static List<int> hsvToRgb(double h, double s, double v) {
    var ss = s / 100;
    var vs = v / 100;
    var c = vs * ss;
    var x = c * (1 - ((h / 60) % 2 - 1).abs());
    var m = vs - c;
    var rp, gp, bp;
    if (h < 60) {
      rp = c;
      gp = x;
      bp = 0.0;
    } else if (h < 120) {
      rp = x;
      gp = c;
      bp = 0.0;
    } else if (h < 180) {
      rp = 0.0;
      gp = c;
      bp = x;
    } else if (h < 240) {
      rp = 0.0;
      gp = x;
      bp = c;
    } else if (h < 300) {
      rp = x;
      gp = 0.0;
      bp = c;
    } else {
      rp = c;
      gp = 0.0;
      bp = x;
    }
    var r = ((rp + m) * 255).round();
    var g = ((gp + m) * 255).round();
    var b = ((bp + m) * 255).round();
    return [r, g, b];
  }

  static List<int> cmykToRgb(int c, int m, int y, int k) {
    var rp = 255 * (1 - c / 100.0) * (1 - k / 100.0);
    var gp = 255 * (1 - m / 100.0) * (1 - k / 100.0);
    var bp = 255 * (1 - y / 100.0) * (1 - k / 100.0);
    return [rp.round(), gp.round(), bp.round()];
  }

  static List<int> hexToRgb(String hex) {
    var r = int.parse(hex.substring(0, 2), radix: 16);
    var g = int.parse(hex.substring(2, 4), radix: 16);
    var b = int.parse(hex.substring(4, 6), radix: 16);
    return [r, g, b];
  }
}