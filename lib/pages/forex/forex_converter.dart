import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/forex/forex_converter_item.dart';
import 'package:samachar_hub/pages/forex/forex_store.dart';

class ForexConverter extends StatefulWidget {
  const ForexConverter({
    Key key,
    @required this.items,
    @required this.defaultForex,
    @required this.store,
  }) : super(key: key);

  final List<ForexModel> items;
  final ForexModel defaultForex;
  final ForexStore store;

  @override
  _ForexConverterState createState() => _ForexConverterState();
}

class _ForexConverterState extends State<ForexConverter> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  ForexModel _selectedFromForex;
  ForexModel _selectedToForex;

  @override
  void initState() {
    _selectedFromForex = widget.defaultForex;
    _selectedToForex = widget.items.first;

    _fromController.addListener(() {
      final fromText = _fromController.text;
      if (fromText != null && fromText.isNotEmpty) {
        double from = double.parse(fromText);
        double toNp =
            (from * _selectedFromForex.buying) / _selectedFromForex.unit;
        double toAmount =
            ((_selectedToForex.unit / _selectedToForex.buying) * toNp);
        _toController.text = '${toAmount.toStringAsFixed(2)}';
      }
    });
    _fromController.text = '1.0';

    super.initState();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          Text(
            'Currency Converter',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 8,
          ),
          ForexConverterItem(
            controller: _fromController,
            currency: _selectedFromForex.currency,
            currencyCode: _selectedFromForex.code,
            items: widget.items,
            onChanged: (value) {
              setState(() {
                _selectedFromForex =
                    widget.items.firstWhere((element) => element.code == value);
                _fromController.text = '1.0';
              });
            },
          ),
          ForexConverterItem(
            controller: _toController,
            currency: _selectedToForex.currency,
            currencyCode: _selectedToForex.code,
            items: widget.items,
            onChanged: (value) {
              setState(() {
                _selectedToForex =
                    widget.items.firstWhere((element) => element.code == value);
                _toController.text = '1.0';
              });
            },
          ),
        ],
      ),
    );
  }
}
