import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CountryPicker extends StatefulWidget {
  const CountryPicker({Key? key}) : super(key: key);

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  var selectedCountry = '🇨🇮 +255';
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          showCountryPicker(
            context: context,
            showPhoneCode: true, // optional. Shows phone code before the country name.
            onSelect: (Country country) {
              print(country.flagEmoji);
              setState(() {
                selectedCountry  =country.flagEmoji+ ' '+  '+' +country.phoneCode;
              });
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(18),
          width: 100,
         
          decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(selectedCountry)),
        ),
      ),
    );
  }
}
