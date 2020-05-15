import 'networking.dart';

const apiKey = '551D54A6-31E5-40EF-AC74-18E99040E557';
const coiniourl = 'https://rest.coinapi.io/v1/exchangerate';

class Rate {
  Future getexchangerate(String cryptoCurrency, String selectedCurrecy) {
    NetworkHelper networkHelper = NetworkHelper(
        '$coiniourl/$cryptoCurrency/$selectedCurrecy?apikey=$apiKey');
    var exchangeratedata = networkHelper.getData();

    return exchangeratedata;
  }
}
