String formatText(String text) {
  var _listText = text.split(' ');
  String _aux = '';

  if (_listText.length == 1) return text;
  if (_listText.length == 2) {
    return _listText[0] + '\n' + _listText[1];
  }

  _listText.forEach((subString) {
    if (subString.length < 4)
      _aux += subString + '\n';
    else
      _aux += subString + ' ';
  });

  return _aux;
}
