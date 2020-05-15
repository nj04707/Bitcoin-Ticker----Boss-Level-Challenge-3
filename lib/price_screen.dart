import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'rate.dart';

const kexchangetextBox = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
);

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double exchangerate;
  int finalexchangerateBTC;
  int finalexchangerateETH;
  int finalexchangerateLTC;
  String selectedcurrency;
  String selectedcryptocurrency;
  DropdownButton<String> getandroidDropdown() {
    List<DropdownMenuItem<String>> currencies = [];
    for (String currency in currenciesList) {
      currencies.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton(
        value: selectedcurrency,
        items: currencies,
        onChanged: (value) {
          setState(() {
            selectedcurrency = value;
          });
        });
  }

  CupertinoPicker getiosPicker() {
    List<Widget> pickeritemslist = [];
    for (String currency in currenciesList) {
      pickeritemslist.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedindex) {
        print(selectedindex);
        print(currenciesList[selectedindex]);
      },
      children: pickeritemslist,
    );
  }

  void extractdata() async {
    try {
      Rate rate = Rate();
      var exchangeratedata =
          await rate.getexchangerate('BTC', selectedcurrency);

      exchangerate = exchangeratedata['rate'];
      setState(
        () {
          finalexchangerateBTC = exchangerate.toInt();
        },
      );
      exchangeratedata = await rate.getexchangerate('ETH', selectedcurrency);

      exchangerate = exchangeratedata['rate'];
      setState(
        () {
          finalexchangerateETH = exchangerate.toInt();
        },
      );
      exchangeratedata = await rate.getexchangerate('LTC', selectedcurrency);

      exchangerate = exchangeratedata['rate'];
      setState(
        () {
          finalexchangerateBTC = exchangerate.toInt();
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    extractdata();
  }

  @override
  Widget build(BuildContext context) {
    extractdata();

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.blueGrey.shade500,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $finalexchangerateBTC $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: kexchangetextBox,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.blueGrey.shade500,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $finalexchangerateETH $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: kexchangetextBox,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.blueGrey.shade500,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $finalexchangerateLTC $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: kexchangetextBox,
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blueGrey.shade900,
            child: Platform.isAndroid ? getandroidDropdown() : getiosPicker(),
          ),
        ],
      ),
    );
  }
}
