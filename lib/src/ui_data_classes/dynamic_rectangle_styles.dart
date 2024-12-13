import 'package:morphable_shape/src/common_includes.dart';

///classes for configuring the border and corner of a rectangle
class RectangleCornerStyles {
  final CornerStyle topLeft;
  final CornerStyle bottomLeft;
  final CornerStyle topRight;
  final CornerStyle bottomRight;

  const RectangleCornerStyles.only({
    this.topLeft = CornerStyle.rounded,
    this.bottomLeft = CornerStyle.rounded,
    this.topRight = CornerStyle.rounded,
    this.bottomRight = CornerStyle.rounded,
  });

  const RectangleCornerStyles.all(CornerStyle style)
      : topLeft = style,
        bottomLeft = style,
        topRight = style,
        bottomRight = style;

  static RectangleCornerStyles fromJson(Map map) {
    return RectangleCornerStyles.only(
        topLeft: parseCornerStyle(map['topLeft']) ?? CornerStyle.rounded,
        bottomLeft: parseCornerStyle(map['bottomLeft']) ?? CornerStyle.rounded,
        topRight: parseCornerStyle(map['topRight']) ?? CornerStyle.rounded,
        bottomRight:
            parseCornerStyle(map['bottomRight']) ?? CornerStyle.rounded);
  }

  Map<String, dynamic> toJson() {
    return {
      "topLeft": topLeft.toJson(),
      "bottomLeft": bottomLeft.toJson(),
      "topRight": topRight.toJson(),
      "bottomRight": bottomRight.toJson()
    };
  }

  RectangleCornerStyles copyWith({
    CornerStyle? topLeft,
    CornerStyle? bottomLeft,
    CornerStyle? topRight,
    CornerStyle? bottomRight,
  }) {
    return RectangleCornerStyles.only(
      topLeft: topLeft ?? this.topLeft,
      topRight: topRight ?? this.topRight,
      bottomLeft: bottomLeft ?? this.bottomLeft,
      bottomRight: bottomRight ?? this.bottomRight,
    );
  }
}

class RectangleBorderSides {
  final DynamicBorderSide top;
  final DynamicBorderSide bottom;
  final DynamicBorderSide left;
  final DynamicBorderSide right;

  const RectangleBorderSides.only({
    this.top = DynamicBorderSide.none,
    this.bottom = DynamicBorderSide.none,
    this.left = DynamicBorderSide.none,
    this.right = DynamicBorderSide.none,
  });

  const RectangleBorderSides.all(DynamicBorderSide border)
      : top = border,
        bottom = border,
        left = border,
        right = border;

  const RectangleBorderSides.symmetric(
      {DynamicBorderSide horizontal = DynamicBorderSide.none,
      DynamicBorderSide vertical = DynamicBorderSide.none})
      : top = horizontal,
        bottom = horizontal,
        left = vertical,
        right = vertical;

  static RectangleBorderSides fromJson(Map map) {
    return RectangleBorderSides.only(
      top: parseDynamicBorderSide(map['top']) ?? DynamicBorderSide.none,
      bottom: parseDynamicBorderSide(map['bottom']) ?? DynamicBorderSide.none,
      left: parseDynamicBorderSide(map['left']) ?? DynamicBorderSide.none,
      right: parseDynamicBorderSide(map['right']) ?? DynamicBorderSide.none,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "top": top.toJson(),
      "bottom": bottom.toJson(),
      "left": left.toJson(),
      "right": right.toJson()
    };
  }

  RectangleBorderSides copyWith({
    DynamicBorderSide? top,
    DynamicBorderSide? bottom,
    DynamicBorderSide? left,
    DynamicBorderSide? right,
  }) {
    return RectangleBorderSides.only(
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
      left: left ?? this.left,
      right: right ?? this.right,
    );
  }
}
