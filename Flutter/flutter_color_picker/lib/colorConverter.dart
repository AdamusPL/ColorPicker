import 'dart:math';

class ColorConverter {
  static List<Double> rgbToHsv(int r, int g, int b) {
    double rp = r / 255.0;
    double gp = g / 255.0;
    double bp = b / 255.0;
    double cmax = max(rp, max(gp, bp));
    double cmin = min(rp, min(gp, bp));
    double delta = cmax - cmin;
    double h = 0.0;
    if (delta == 0.0) {
      h = 0.0;
    } else if (cmax == rp) {
      h = 60.0 * (((gp - bp) / delta) % 6.0);
    } else if (cmax == gp) {
      h = 60.0 * (((bp - rp) / delta) + 2.0);
    } else if (cmax == bp) {
      h = 60.0 * (((rp - gp) / delta) + 4.0);
    }
    double s = cmax == 0.0 ? 0.0 : delta / cmax;
    return [
      h.toStringAsFixed(2),
      (s * 100).toStringAsFixed(2),
      (cmax * 100).toStringAsFixed(2)
    ];
  }

  static List<String> rgbToCmyk(int r, int g, int b) {
    double rp = r / 255.0;
    double gp = g / 255.0;
    double bp = b / 255.0;
    double k = 1 - max(rp, max(gp, bp));
    if (k == 1.0) {
      return ["0", "0", "0", "100"];
    }
    double c = (1 - rp - k) / (1 - k);
    double m = (1 - gp - k) / (1 - k);
    double y = (1 - bp - k) / (1 - k);
    return [
      (c * 100).toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), ''),
      (m * 100).toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), ''),
      (y * 100).toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), ''),
      (k * 100).toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), '')
    ];
  }

  static String rgbToHex(int r, int g, int b) {
    String hex = r.toRadixString(16).padLeft(2, '0');
    hex += g.toRadixString(16).padLeft(2, '0');
    hex += b.toRadixString(16).padLeft(2, '0');
    return hex;
  }

  static List<int> hsvToRgb(double h, double s, double v) {
    double ss = s / 100;
    double vs = v / 100;
    double c = vs * ss;
    double x = c * (1 - ((h / 60) % 2 - 1).abs());
    double m = vs - c;
    double rp, gp, bp;
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
    int r = ((rp + m) * 255).round();
    int g = ((gp + m) * 255).round();
    int b = ((bp + m) * 255).round();
    return [r, g, b];
  }

  static List<int> cmykToRgb(int c, int m, int y, int k) {
    double rp = 255 * (1 - c / 100.0) * (1 - k / 100.0);
    double gp = 255 * (1 - m / 100.0) * (1 - k / 100.0);
    double bp = 255 * (1 - y / 100.0) * (1 - k / 100.0);
    return [rp.round(), gp.round(), bp.round()];
  }

  static List<int> hexToRgb(String hex) {
    int r = int.parse(hex.substring(0, 2), radix: 16);
    int g = int.parse(hex.substring(2, 4), radix: 16);
    int b = int.parse(hex.substring(4, 6), radix: 16);
    return [r, g, b];
  }
}