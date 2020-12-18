String formatText(String text) {
  var _listText = text.split(' ');
  String _aux = '';
  int count = 0;

  if (_listText.length == 1) return text;

  if (_listText.length == 2 && (_listText[1] != 'I' && _listText[1] != 'II'))
    return _listText[0] + '\n' + _listText[1];

  if (_listText.length == 3 && (_listText[2] == 'I' || _listText[2] == 'II'))
    return _listText[0] + '\n' + _listText[1] + ' ' + _listText[2];

  if (_listText.length > 3) {
    _listText.forEach((subString) {
      count++;
      if (count == 1) {
        _aux += subString + ' ';
      }
      if (count == 2) {
        _aux += subString + '\n';
        count = 0;
      }
    });
    return _aux;
  }

  _listText.forEach((subString) {
    if (subString.length < 4)
      _aux += subString + '\n';
    else
      _aux += subString + ' ';
  });

  return _aux;
}
