import 'dart:math' as math;

class CommonFunctions {
  //Ouputs Radians Based On Degree Input
  static double degreesToRadians(double degree) {
    return degree / (180 / math.pi);
  }

  //Formats Numbers (1.23M   4.56K   789)
  static String numFormatter(int num) {
    if (num >= 1000000) {
      String result = (num / 1000000).toStringAsFixed(3);
      return '${result.substring(0, result.length - 1)}M';
    } else if (num >= 1000) {
      String result = (num / 1000).toStringAsFixed(3);
      return '${result.substring(0, result.length - 1)}K';
    } else {
      return num.toString();
    }
  }
}
