import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

class LangDropDown extends StatefulWidget {
  const LangDropDown({super.key});

  @override
  State<LangDropDown> createState() => _LangDropDownState();
}

class _LangDropDownState extends State<LangDropDown> {
  String? selectedLangValue;
  final localization = FlutterLocalization.instance;

  @override
  void initState() {
    selectedLangValue = localization.currentLocale!.languageCode == 'en'
        ? langList[0]
        : langList[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        items: langList
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
        value: selectedLangValue,
        alignment: Alignment.centerRight,
        onChanged: (value) {
          setState(() {
            selectedLangValue =
                langList[langList.indexWhere((element) => element == value)];
          });
          localization.translate(value! == 'English' ? 'en' : 'ar');
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 140,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: kLightBlue,
            ),
            color: kBeige,
          ),
          elevation: 2,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: kBeige,
          ),
          offset: const Offset(0, 50),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
      ),
    );
  }
}
