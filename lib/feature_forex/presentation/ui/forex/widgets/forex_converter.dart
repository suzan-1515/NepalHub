import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/widgets/forex_converter_item.dart';

class ForexConverter extends StatefulWidget {
  const ForexConverter({
    Key key,
    @required this.items,
    @required this.defaultForex,
  }) : super(key: key);

  final List<ForexUIModel> items;
  final ForexUIModel defaultForex;

  @override
  _ForexConverterState createState() => _ForexConverterState();
}

class _ForexConverterState extends State<ForexConverter> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  ForexUIModel _selectedFromForex;
  bool _shouldFromTextChnage = true;
  bool _shouldToTextChnage = true;

  @override
  void initState() {
    _selectedFromForex = widget.defaultForex;

    _fromController.addListener(() {
      _convertToNepali();
    });

    _fromController.text = _selectedFromForex.entity.unit.toString();

    super.initState();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  _convertToNepali() {
    if (!_shouldFromTextChnage) {
      _shouldFromTextChnage = true;
      return;
    }
    final fromText = _fromController.text;
    if (fromText != null && fromText.isNotEmpty) {
      double from = double.parse(fromText);
      double to = (from * _selectedFromForex.entity.selling) /
          _selectedFromForex.entity.unit;
      _shouldToTextChnage = false;
      _toController.text = '${to.toStringAsFixed(2)}';
    }
  }

  _convertFromNepali() {
    if (!_shouldToTextChnage) {
      _shouldToTextChnage = true;
      return;
    }
    final fromText = _toController.text;
    if (fromText != null && fromText.isNotEmpty) {
      double from = double.parse(fromText);
      double to = ((from * _selectedFromForex.entity.unit) /
          _selectedFromForex.entity.selling);
      _shouldFromTextChnage = false;
      _fromController.text = '${to.toStringAsFixed(2)}';
    }
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
          const SizedBox(height: 8),
          Text(
            'Currency Converter',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 8,
          ),
          ForexConverterItem(
            controller: _fromController,
            selectedForexModel: _selectedFromForex,
            items: widget.items,
            onChanged: (value) {
              setState(() {
                _selectedFromForex = widget.items
                    .firstWhere((element) => element.entity.id == value);
                _fromController.text =
                    _selectedFromForex.entity.unit.toString();
                _convertToNepali();
              });
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: 'https://www.countryflags.io/np/flat/48.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, progress) =>
                      Icon(FontAwesomeIcons.image),
                  placeholder: (context, reloadImage) =>
                      Icon(FontAwesomeIcons.image),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Nepali Rupee',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _toController,
                  onChanged: (value) => _convertFromNepali(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
