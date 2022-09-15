import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class PlayerCustomizer {
  Widget? get row1col1;
  Widget? get row1col2;
  Widget? get row2col1;
  Widget? get row2col2;
  Widget? get row2col3;
  Widget? get row2col4;
  Widget? get row3col1;
  Widget? get row3col2;
  Widget? get row3col3;
  Widget? get row3col4;
  Widget? get row4col1;
  Widget? get row4col2;
  Widget? get row5col1;
  Widget? get row5col2;
  Widget? get row5col3;
  Widget? get row5col4;

  @nonVirtual
  bool get row1Exists {
    return row1col1 != null || row1col2 != null;
  }

  @nonVirtual
  bool get row2Exists {
    return row2col1 != null || row2col2 != null
        || row2col3 != null || row2col4 != null;
  }

  @nonVirtual
  bool get row3Exists {
    return row3col1 != null || row3col2 != null
        || row3col3 != null || row3col4 != null;
  }

  @nonVirtual
  bool get row4Exists {
    return row4col1 != null || row4col2 != null;
  }

  @nonVirtual
  bool get row5Exists {
    return row5col1 != null || row5col2 != null
        || row5col3 != null || row5col4 != null;
  }


}