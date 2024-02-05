import 'package:flutter/material.dart';

/// This class has 4 initialize method like Border class.
/// You can create different borders or define them all in one place.
/// [dashLength] is the length of the dashes
class DashedBorder extends Border {
  /// You can define sides for each corner.
  const DashedBorder({
    super.top = BorderSide.none,
    super.right = BorderSide.none,
    super.bottom = BorderSide.none,
    super.left = BorderSide.none,
    this.isOnlyCorner = false,
    this.strokeCap = StrokeCap.square,
    required this.dashLength,
  });

  /// You can define same side for all corner.
  const DashedBorder.fromBorderSide({
    required BorderSide side,
    this.isOnlyCorner = false,
    this.strokeCap = StrokeCap.square,
    required this.dashLength,
  }) : super(bottom: side, top: side, left: side, right: side);

  /// You can define symetric sides for each direction.
  const DashedBorder.symmetric({
    BorderSide vertical = BorderSide.none,
    BorderSide horizontal = BorderSide.none,
    this.isOnlyCorner = false,
    this.strokeCap = StrokeCap.square,
    required this.dashLength,
  }) : super(
      bottom: horizontal,
      top: horizontal,
      left: vertical,
      right: vertical);

  /// You can define sides property for all sides.
  factory DashedBorder.all({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    dynamic strokeAlign = BorderSide.strokeAlignInside,
    bool isOnlyCorner = false,
    StrokeCap strokeCap = StrokeCap.square,
    required double dashLength,
  }) {
    final BorderSide side = BorderSide(
        color: color, width: width, style: style, strokeAlign: strokeAlign);
    return DashedBorder.fromBorderSide(
        side: side,
        dashLength: dashLength,
        isOnlyCorner: isOnlyCorner,
        strokeCap: strokeCap);
  }

  final double dashLength;
  final StrokeCap strokeCap;
  final bool isOnlyCorner;

  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        TextDirection? textDirection,
        BoxShape shape = BoxShape.rectangle,
        BorderRadius? borderRadius,
      }) {
    if (borderRadius != null) {
      Path path = Path()..addRRect(borderRadius.toRRect(rect));
      _drawRadiusPath(canvas, path, rect, borderRadius);
    } else {
      Path path = Path()..addRect(rect);
      _drawPath(canvas, path, rect);
    }
  }

  /// This method will work and draw for borders whose corner is not radius.
  /// It will draw centered by calculating the corner points.
  _drawPath(Canvas canvas, Path source, Rect rect) {
    var metric = source.computeMetrics().first;

    var leftHeight = rect.height;
    var rightHeight = rect.height;
    var topWidth = rect.width;
    var bottomWidth = rect.width;

    //region calculate spacing and draw top border
    int partNumber = (topWidth) ~/ dashLength;
    if (partNumber % 2 == 1) {
      partNumber -= 1;
    }
    var topSpacing =
        (topWidth - (partNumber / 2 * dashLength)) / (partNumber / 2);
    double distance = 0;

    while (distance < (topWidth)) {
      double target = 0;
      double diff = 0;
      if (distance == (0)) {
        diff = distance + dashLength / 2 <= (topWidth)
            ? dashLength / 2
            : (topWidth) - distance;
        target = distance + diff;
      } else {
        diff = distance + dashLength <= (topWidth)
            ? dashLength
            : (topWidth) - distance;
        target = distance + diff;
      }
      canvas.drawPath(
          metric.extractPath(distance % metric.length, target % metric.length),
          top.toPaint()..strokeCap = strokeCap);
      if (isOnlyCorner && distance < (topWidth) - diff) {
        distance = (topWidth) - diff;
      } else {
        distance = target + topSpacing;
      }
    }
    //endregion

    //region calculate spacing and draw right border
    partNumber = (rightHeight) ~/ dashLength;
    if (partNumber % 2 == 1) {
      partNumber -= 1;
    }
    var rightSpacing =
        (rightHeight - (partNumber / 2 * dashLength)) / (partNumber / 2);
    distance = (topWidth);

    while (distance < (metric.length - bottomWidth - leftHeight)) {
      double target = 0;
      double diff = 0;
      if (distance == (topWidth)) {
        diff = distance + dashLength / 2 <=
            (metric.length - bottomWidth - leftHeight)
            ? dashLength / 2
            : (metric.length - bottomWidth - leftHeight) - distance;
        target = distance + diff;
      } else {
        diff =
        distance + dashLength <= (metric.length - bottomWidth - leftHeight)
            ? dashLength
            : (metric.length - bottomWidth - leftHeight) - distance;
        target = distance + diff;
      }
      canvas.drawPath(
          metric.extractPath(distance % metric.length, target % metric.length),
          right.toPaint()..strokeCap = strokeCap);
      if (isOnlyCorner &&
          distance < (metric.length - bottomWidth - leftHeight) - diff) {
        distance = (metric.length - bottomWidth - leftHeight) - diff;
      } else {
        distance = target + rightSpacing;
      }
    }
    //endregion

    //region calculate spacing and draw bottom border
    partNumber = (bottomWidth) ~/ dashLength;
    if (partNumber % 2 == 1) {
      partNumber -= 1;
    }
    var bottomSpacing =
        (bottomWidth - (partNumber / 2 * dashLength)) / (partNumber / 2);
    distance = (metric.length - bottomWidth - leftHeight);

    while (distance < metric.length - leftHeight) {
      double target = 0;
      double diff = 0;
      if (distance == (metric.length - bottomWidth - leftHeight)) {
        diff = distance + dashLength / 2 <= metric.length - leftHeight
            ? dashLength / 2
            : metric.length - leftHeight - distance;
        target = distance + diff;
      } else {
        diff = distance + dashLength <= metric.length - leftHeight
            ? dashLength
            : metric.length - leftHeight - distance;
        target = distance + diff;
      }
      canvas.drawPath(
          metric.extractPath(distance % metric.length, target % metric.length),
          bottom.toPaint()..strokeCap = strokeCap);
      if (isOnlyCorner && distance < metric.length - leftHeight - diff) {
        distance = metric.length - leftHeight - diff;
      } else {
        distance = target + bottomSpacing;
      }
    }
    //endregion

    //region calculate spacing and draw left border
    partNumber = (leftHeight) ~/ dashLength;
    if (partNumber % 2 == 1) {
      partNumber -= 1;
    }
    var leftSpacing =
        ((leftHeight) - (partNumber / 2 * dashLength)) / (partNumber / 2);
    distance = metric.length - leftHeight;
    while (distance < metric.length) {
      double target = 0;
      double diff = 0;
      if (distance == metric.length - leftHeight) {
        diff = distance + dashLength / 2 <= metric.length
            ? dashLength / 2
            : (metric.length) - distance;
        target = distance + diff;
      } else {
        diff = distance + dashLength <= metric.length
            ? dashLength
            : (metric.length) - distance;
        target = distance + diff;
      }

      canvas.drawPath(
          metric.extractPath(distance % metric.length,
              target == metric.length ? metric.length : target % metric.length),
          left.toPaint()..strokeCap = strokeCap);
      if (isOnlyCorner && distance < metric.length - diff) {
        distance = metric.length - diff;
      } else {
        distance = target + leftSpacing;
      }
    }
    //endregion
  }

  /// This method will work and draw for borders whose corner is radius.
  /// It will draw centered by calculating the corner points.
  _drawRadiusPath(
      Canvas canvas, Path source, Rect rect, BorderRadius? borderRadius) {
    var metric = source.computeMetrics().first;
    var leftHeight = rect.height;
    var rightHeight = rect.height;
    var topWidth = rect.width;
    var bottomWidth = rect.width;
    var bottomLeftCorner = 0.0;
    var topLeftCorner = 0.0;
    var topRightCorner = 0.0;
    var bottomRightCorner = 0.0;

    //region calculate center point of each corner
    if (borderRadius != null) {
      leftHeight -= borderRadius.topLeft.y + borderRadius.bottomLeft.y;
      rightHeight -= borderRadius.topRight.y + borderRadius.bottomRight.y;
      topWidth -= borderRadius.topRight.x + borderRadius.topLeft.x;
      bottomWidth -= borderRadius.bottomRight.x + borderRadius.bottomLeft.x;

      var tempRadius = BorderRadius.only(bottomLeft: borderRadius.bottomLeft);
      var tempPath = Path()..addRRect(tempRadius.toRRect(rect));
      bottomLeftCorner = tempPath.computeMetrics().first.length -
          (leftHeight +
              borderRadius.topLeft.y +
              bottomWidth +
              borderRadius.bottomRight.x +
              rect.height +
              rect.width);

      tempRadius = BorderRadius.only(topLeft: borderRadius.topLeft);
      tempPath = Path()..addRRect(tempRadius.toRRect(rect));
      topLeftCorner = tempPath.computeMetrics().first.length -
          (leftHeight +
              borderRadius.bottomLeft.y +
              topWidth +
              borderRadius.topRight.x +
              rect.height +
              rect.width);

      tempRadius = BorderRadius.only(topRight: borderRadius.topRight);
      tempPath = Path()..addRRect(tempRadius.toRRect(rect));
      topRightCorner = tempPath.computeMetrics().first.length -
          (topWidth +
              borderRadius.topLeft.x +
              rightHeight +
              borderRadius.bottomRight.y +
              rect.height +
              rect.width);

      tempRadius = BorderRadius.only(bottomRight: borderRadius.bottomRight);
      tempPath = Path()..addRRect(tempRadius.toRRect(rect));
      bottomRightCorner = tempPath.computeMetrics().first.length -
          (bottomWidth +
              borderRadius.bottomLeft.x +
              rightHeight +
              borderRadius.topRight.y +
              rect.height +
              rect.width);
    }
    //endregion

    //region calculate spacing and draw left border
    int partNumber =
        (leftHeight + bottomLeftCorner / 2 + topLeftCorner / 2) ~/ dashLength;
    if (partNumber % 2 == 1) {
      partNumber -= 1;
    }
    var leftSpacing = ((leftHeight + bottomLeftCorner / 2 + topLeftCorner / 2) -
        (partNumber / 2 * dashLength)) /
        (partNumber / 2);
    double distance = -bottomLeftCorner / 2;
    while (distance < leftHeight + topLeftCorner / 2) {
      double target = 0;
      double diff = 0;
      if (distance == -bottomLeftCorner / 2) {
        diff = distance + dashLength / 2 <= leftHeight + topLeftCorner / 2
            ? dashLength / 2
            : (leftHeight + topLeftCorner / 2) - distance;
        target = distance + diff;
      } else {
        diff = distance + dashLength <= leftHeight + topLeftCorner / 2
            ? dashLength
            : (leftHeight + topLeftCorner / 2) - distance;
        target = distance + diff;
      }

      if (distance.isNegative && !target.isNegative) {
        canvas.drawPath(
            metric.extractPath(distance % metric.length, metric.length),
            left.toPaint()..strokeCap = strokeCap);
        canvas.drawPath(metric.extractPath(0, target),
            left.toPaint()..strokeCap = strokeCap);
      } else {
        canvas.drawPath(
            metric.extractPath(
                distance % metric.length, target % metric.length),
            left.toPaint()..strokeCap = strokeCap);
      }
      if (isOnlyCorner && distance < leftHeight + topLeftCorner / 2 - diff) {
        distance = leftHeight + topLeftCorner / 2 - diff;
      } else {
        distance = target + leftSpacing;
      }
    }
    //endregion

    //region calculate spacing and draw top border
    partNumber =
        (topWidth + topRightCorner / 2 + topLeftCorner / 2) ~/ dashLength;
    if (partNumber % 2 == 1) {
      partNumber -= 1;
    }
    var topSpacing = (topWidth +
        topRightCorner / 2 +
        topLeftCorner / 2 -
        (partNumber / 2 * dashLength)) /
        (partNumber / 2);
    distance = (leftHeight + topLeftCorner / 2);

    while (distance <
        (leftHeight + topWidth) + topLeftCorner + topRightCorner / 2) {
      double target = 0;
      double diff = 0;
      if (distance == (leftHeight + topLeftCorner / 2)) {
        diff = distance + dashLength / 2 <=
            (leftHeight + topWidth) + topLeftCorner + topRightCorner / 2
            ? dashLength / 2
            : (leftHeight + topWidth) +
            topLeftCorner +
            topRightCorner / 2 -
            distance;
        target = distance + diff;
      } else {
        diff = distance + dashLength <=
            (leftHeight + topWidth) + topLeftCorner + topRightCorner / 2
            ? dashLength
            : (leftHeight + topWidth) +
            topLeftCorner +
            topRightCorner / 2 -
            distance;
        target = distance + diff;
      }
      canvas.drawPath(
          metric.extractPath(distance % metric.length, target % metric.length),
          top.toPaint()..strokeCap = strokeCap);
      if (isOnlyCorner &&
          distance <
              (leftHeight + topWidth) +
                  topLeftCorner +
                  topRightCorner / 2 -
                  diff) {
        distance =
            (leftHeight + topWidth) + topLeftCorner + topRightCorner / 2 - diff;
      } else {
        distance = target + topSpacing;
      }
    }

    //endregion

    //region calculate spacing and draw right border
    partNumber = (rightHeight + topRightCorner / 2 + bottomRightCorner / 2) ~/
        dashLength;
    if (partNumber % 2 == 1) {
      partNumber -= 1;
    }
    var rightSpacing = (rightHeight +
        topRightCorner / 2 +
        bottomRightCorner / 2 -
        (partNumber / 2 * dashLength)) /
        (partNumber / 2);
    distance = (leftHeight + topWidth) + topLeftCorner + topRightCorner / 2;

    while (distance <
        (metric.length -
            bottomWidth -
            bottomLeftCorner -
            (bottomRightCorner / 2))) {
      double target = 0;
      double diff = 0;
      if (distance ==
          (leftHeight + topWidth) + topLeftCorner + topRightCorner / 2) {
        diff = distance + dashLength / 2 <=
            (metric.length -
                bottomWidth -
                bottomLeftCorner -
                (bottomRightCorner / 2))
            ? dashLength / 2
            : (metric.length -
            bottomWidth -
            bottomLeftCorner -
            (bottomRightCorner / 2)) -
            distance;
        target = distance + diff;
      } else {
        diff = distance + dashLength <=
            (metric.length -
                bottomWidth -
                bottomLeftCorner -
                (bottomRightCorner / 2))
            ? dashLength
            : (metric.length -
            bottomWidth -
            bottomLeftCorner -
            (bottomRightCorner / 2)) -
            distance;
        target = distance + diff;
      }
      canvas.drawPath(
          metric.extractPath(distance % metric.length, target % metric.length),
          right.toPaint()..strokeCap = strokeCap);
      if (isOnlyCorner &&
          distance <
              (metric.length -
                  bottomWidth -
                  bottomLeftCorner -
                  (bottomRightCorner / 2)) -
                  diff) {
        distance = (metric.length -
            bottomWidth -
            bottomLeftCorner -
            (bottomRightCorner / 2)) -
            diff;
      } else {
        distance = target + rightSpacing;
      }
    }
    //endregion

    //region calculate spacing and draw bottom border
    partNumber = (bottomWidth + bottomRightCorner / 2 + bottomLeftCorner / 2) ~/
        dashLength;
    if (partNumber % 2 == 1) {
      partNumber -= 1;
    }
    var bottomSpacing = (bottomWidth +
        bottomRightCorner / 2 +
        bottomLeftCorner / 2 -
        (partNumber / 2 * dashLength)) /
        (partNumber / 2);
    distance = (metric.length -
        bottomWidth -
        bottomLeftCorner -
        (bottomRightCorner / 2));

    while (distance < metric.length - bottomLeftCorner / 2) {
      double target = 0;
      double diff = 0;
      if (distance ==
          (metric.length -
              bottomWidth -
              bottomLeftCorner -
              (bottomRightCorner / 2))) {
        diff = distance + dashLength / 2 <= metric.length - bottomLeftCorner / 2
            ? dashLength / 2
            : metric.length - bottomLeftCorner / 2 - distance;
        target = distance + diff;
      } else {
        diff = distance + dashLength <= metric.length - bottomLeftCorner / 2
            ? dashLength
            : metric.length - bottomLeftCorner / 2 - distance;
        target = distance + diff;
      }
      canvas.drawPath(
          metric.extractPath(distance % metric.length, target % metric.length),
          bottom.toPaint()..strokeCap = strokeCap);
      if (isOnlyCorner &&
          distance < metric.length - bottomLeftCorner / 2 - diff) {
        distance = metric.length - bottomLeftCorner / 2 - diff;
      } else {
        distance = target + bottomSpacing;
      }
    }
  }
//endregion
}