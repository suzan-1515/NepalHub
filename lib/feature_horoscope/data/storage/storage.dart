import 'package:flutter/material.dart';

mixin Storage {
  Future saveDefaultHoroscopeSign({@required int signIndex});
  int loadDefaultHoroscopeSignIndex();
}
