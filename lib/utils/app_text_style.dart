import 'package:flutter/material.dart';
import 'package:flutter_test_maha/utils/app_color.dart';

class AppTextStyle {
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;

  static TextStyle h1 = TextStyle(
    decoration: TextDecoration.none,
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: 0.5,
  );
  static TextStyle h2 = TextStyle(
    decoration: TextDecoration.none,
    color: AppColors.black,
    fontSize: 18,
    fontWeight: semiBold,
    height: 1.2,
    letterSpacing: 0.5,
  );
  static TextStyle h3 = TextStyle(
    decoration: TextDecoration.none,
    color: AppColors.black,
    fontSize: 16,
    fontWeight: semiBold,
    height: 1.2,
    letterSpacing: 0.5,
  );
  static TextStyle h4 = TextStyle(
    decoration: TextDecoration.none,
    color: AppColors.black,
    fontSize: 14,
    fontWeight: semiBold,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static TextStyle regularStyle = TextStyle(
    decoration: TextDecoration.none,
    color: AppColors.black,
    fontSize: 14,
    fontWeight: regular,
    height: 1.2,
    letterSpacing: 0.5,
  );
}
