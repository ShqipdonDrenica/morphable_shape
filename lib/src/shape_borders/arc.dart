import 'package:morphable_shape/src/common_includes.dart';

///A rectangle with one side replaced by an arc with a certain height
class ArcShapeBorder extends OutlinedShapeBorder {
  final ShapeSide side;
  final Dimension arcHeight;
  final bool isOutward;

  const ArcShapeBorder({
    DynamicBorderSide border = DynamicBorderSide.none,
    this.side = ShapeSide.bottom,
    this.isOutward = true,
    this.arcHeight = const Length(20),
  }) : super(border: border);

  ArcShapeBorder.fromJson(Map<String, dynamic> map)
      : side = parseShapeSide(map['side']) ?? ShapeSide.bottom,
        isOutward = map["isOutward"],
        arcHeight = parseDimension(map["arcHeight"]) ?? Length(20),
        super(
            border: parseDynamicBorderSide(map["border"]) ??
                DynamicBorderSide.none);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> rst = {"type": "Arc"};
    rst.addAll(super.toJson());
    rst["arcHeight"] = arcHeight.toJson();
    rst["isOutward"] = isOutward;
    rst["side"] = side.toJson();

    return rst;
  }

  ArcShapeBorder copyWith({
    ShapeSide? side,
    bool? isOutward,
    Dimension? arcHeight,
    DynamicBorderSide? border,
  }) {
    return ArcShapeBorder(
      side: side ?? this.side,
      isOutward: isOutward ?? this.isOutward,
      arcHeight: arcHeight ?? this.arcHeight,
      border: border ?? this.border,
    );
  }

  bool isSameMorphGeometry(MorphableShapeBorder shape) {
    return shape is ArcShapeBorder && shape.side == this.side;
  }

  DynamicPath generateOuterDynamicPath(Rect rect) {
    final size = rect.size;

    double maximumSize = min(size.height, size.height) / 2;

    double arcHeight = 0;
    if (this.side.isHorizontal) {
      arcHeight =
          this.arcHeight.toPX(constraint: size.height).clamp(0, maximumSize);
    } else {
      arcHeight =
          this.arcHeight.toPX(constraint: size.width).clamp(0, maximumSize);
    }
    double theta1, theta2, theta3, radius;
    if (this.side.isHorizontal) {
      theta1 = atan(size.width / (2 * arcHeight));
      theta2 = atan((2 * arcHeight) / size.width);
      theta3 = theta1 - theta2;
      radius = size.width / 2 * tan(theta3) + arcHeight;
    } else {
      theta1 = atan(size.height / (2 * arcHeight));
      theta2 = atan((2 * arcHeight) / size.height);
      theta3 = theta1 - theta2;
      radius = size.height / 2 * tan(theta3) + arcHeight;
    }

    List<DynamicNode> nodes = [];

    if (arcHeight == 0) {
      nodes.add(DynamicNode(position: Offset(0, 0.0)));
      nodes.add(DynamicNode(position: Offset(size.width, 0.0)));
      nodes.add(DynamicNode(position: Offset(size.width, size.height)));
      nodes.add(DynamicNode(position: Offset(0, size.height)));
      return DynamicPath(nodes: nodes, size: size);
    }

    switch (this.side) {
      case ShapeSide.top:
        if (isOutward) {
          Rect circleRect = Rect.fromCenter(
              center: Offset(size.width / 2, radius),
              width: 2 * radius,
              height: 2 * radius);
          double startAngle = pi + theta3;
          double sweepAngle = pi - 2 * theta3;

          nodes.addArc(circleRect, startAngle, sweepAngle);
          nodes.add(DynamicNode(position: Offset(size.width, size.height)));
          nodes.add(DynamicNode(position: Offset(0.0, size.height)));
        } else {
          Rect circleRect = Rect.fromCenter(
              center: Offset(size.width / 2, arcHeight - radius),
              width: 2 * radius,
              height: 2 * radius);
          double startAngle = pi - theta3;
          double sweepAngle = pi - 2 * theta3;

          nodes.addArc(circleRect, startAngle, -sweepAngle);
          nodes.add(DynamicNode(position: Offset(size.width, size.height)));
          nodes.add(DynamicNode(position: Offset(0.0, size.height)));
        }
        break;
      case ShapeSide.bottom:
        if (isOutward) {
          Rect circleRect = Rect.fromCenter(
              center: Offset(size.width / 2, size.height - radius),
              width: 2 * radius,
              height: 2 * radius);
          double startAngle = theta3;
          double sweepAngle = pi - 2 * theta3;

          nodes.add(DynamicNode(position: Offset(0.0, 0.0)));
          nodes.add(DynamicNode(position: Offset(size.width, 0.0)));
          nodes.addArc(circleRect, startAngle, sweepAngle);
        } else {
          Rect circleRect = Rect.fromCenter(
              center: Offset(size.width / 2, size.height - arcHeight + radius),
              width: 2 * radius,
              height: 2 * radius);
          double startAngle = -theta3;
          double sweepAngle = pi - 2 * theta3;
          nodes.add(DynamicNode(position: Offset(0.0, 0.0)));
          nodes.add(DynamicNode(position: Offset(size.width, 0.0)));
          nodes.addArc(circleRect, startAngle, -sweepAngle);
        }
        break;
      case ShapeSide.left:
        if (isOutward) {
          Rect circleRect = Rect.fromCenter(
              center: Offset(radius, size.height / 2),
              width: 2 * radius,
              height: 2 * radius);
          double startAngle = pi / 2 + theta3;
          double sweepAngle = pi - 2 * theta3;
          nodes.add(DynamicNode(position: Offset(arcHeight, 0.0)));
          nodes.add(DynamicNode(position: Offset(size.width, 0.0)));
          nodes.add(DynamicNode(position: Offset(size.width, size.height)));
          nodes.addArc(circleRect, startAngle, sweepAngle);
        } else {
          Rect circleRect = Rect.fromCenter(
              center: Offset(arcHeight - radius, size.height / 2),
              width: 2 * radius,
              height: 2 * radius);
          double startAngle = pi / 2 - theta3;
          double sweepAngle = pi - 2 * theta3;
          nodes.add(DynamicNode(position: Offset(0.0, 0.0)));
          nodes.add(DynamicNode(position: Offset(size.width, 0.0)));
          nodes.add(DynamicNode(position: Offset(size.width, size.height)));
          nodes.addArc(circleRect, startAngle, -sweepAngle);
        }
        break;
      case ShapeSide.right: //right
        if (isOutward) {
          Rect circleRect = Rect.fromCenter(
              center: Offset(size.width - radius, size.height / 2),
              width: 2 * radius,
              height: 2 * radius);
          double startAngle = -(pi / 2 - theta3);
          double sweepAngle = pi - 2 * theta3;
          nodes.addArc(circleRect, startAngle, sweepAngle);
          nodes.add(DynamicNode(position: Offset(0.0, size.height)));
          nodes.add(DynamicNode(position: Offset(0.0, 0.0)));
        } else {
          Rect circleRect = Rect.fromCenter(
              center: Offset(size.width - arcHeight + radius, size.height / 2),
              width: 2 * radius,
              height: 2 * radius);
          double startAngle = -(pi / 2 + theta3);
          double sweepAngle = pi - 2 * theta3;
          nodes.addArc(circleRect, startAngle, -sweepAngle);
          nodes.add(DynamicNode(position: Offset(0.0, size.height)));
          nodes.add(DynamicNode(position: Offset(0.0, 0.0)));
        }
        break;
    }
    return DynamicPath(nodes: nodes, size: size);
  }
}
