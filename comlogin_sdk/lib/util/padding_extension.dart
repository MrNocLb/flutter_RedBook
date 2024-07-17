import 'package:flutter/cupertino.dart';

// 拓展int double
extension IntFix on int {
  SizedBox get paddingHeight {
    return SizedBox(height: toDouble());
  }

  SizedBox get paddingWidth {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension DoubleFix on double {
  SizedBox get paddingHeight {
    return SizedBox(
      height: this,
    );
  }

  SizedBox get paddingWight {
    return SizedBox(
      width: this,
    );
  }
}

extension TextFix on String {
  Text get t {
    return Text(this);
  }
}
