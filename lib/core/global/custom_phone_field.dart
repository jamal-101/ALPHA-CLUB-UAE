import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../utils/app_color/app_color.dart';

class CustomPhoneField extends StatelessWidget {
  final ValueChanged<PhoneNumber>? onNumberChanged;
  final String? initialValue;
  final String hintText;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final Color? fillColor;

  const CustomPhoneField({
    super.key,
    this.onNumberChanged,
    this.initialValue,
    required this.hintText,
    this.textController,
    this.validator,
    this.fillColor = AppColors.whiteFoundation,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: textController,
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (phone) {
        if (validator != null) {
          return validator!(phone?.completeNumber);
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // disableLengthCheck: true,
      flagsButtonPadding: EdgeInsets.only(left: 10.w),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.blue1.withValues(alpha: 0.5),
          fontSize: 14.sp,
          fontFamily: 'SFPro',
        ),
        filled: true,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          // borderSide: BorderSide(color: AppColors.blue1.withValues(alpha: 0.2)),
          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          // borderSide: BorderSide(color: AppColors.blue1.withValues(alpha: 0.2)),
          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.blue1, width: 1.5),
        ),
      ),
      initialCountryCode: 'AE',
      disableLengthCheck: false,
      dropdownIconPosition: IconPosition.trailing,
      dropdownTextStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'SFPro',
        color: AppColors.blue1,
      ),
      onChanged: onNumberChanged,
      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: Colors.white,
        countryNameStyle: TextStyle(fontSize: 14.sp, fontFamily: 'SFPro'),
        searchFieldInputDecoration: InputDecoration(
          labelText: 'Search Country',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
      ),
    );
  }
}