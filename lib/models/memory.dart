class Memory{
  static const operations = ['%','/','X','-','+','='];

  String _value = '0';
  final _buffer=[0.0, 0.0];
  late String _operation;
  int _bufferIndex = 0;
  bool _wipeValue = false;
  late String _LastCommand;
  
  void applyCommand(String command){

    if(command == 'AC'){
      _allClear();
    }else if(operations.contains(command)){
      _setOperation(command);
    }else{
      _addDigit(command);
    }

  }

_setOperation(String newOperation){
  bool isEqualSign = newOperation == '=';
  if(_bufferIndex == 0){
    if(!isEqualSign){
      _operation = newOperation;
      _bufferIndex = 1;
      _wipeValue = true;
    }
    
  } else {
    _buffer[0] = _calculate();
    _buffer[1] = 0.0;
    _value = _buffer[0].toString();
    _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

    
  _operation = isEqualSign ? null.toString() : newOperation;
  _bufferIndex = isEqualSign ? 0 : 1;
  }
  _wipeValue = true;
  
}



_addDigit(String digit){
  final isDot =  digit == '.';
  final wipeValue = (_value == '0' && !isDot) || _wipeValue;

  if(isDot && _value.contains('.') && !wipeValue){
    return;
  }

  final emptyValue = isDot ? '0' : '';
  final currentValue = wipeValue ? emptyValue : _value;
  _value = currentValue + digit;
  _wipeValue = false;


  _buffer[_bufferIndex] = double.tryParse(_value)?? 0;
  print(_buffer);
}
  _allClear(){
    _value = '0';
    _buffer.setAll(0,[0.0,0.0]);
    _bufferIndex = 0;
    _operation = null.toString();
    _wipeValue = false;
  }

_calculate(){
  switch(_operation){
    case '%': return _buffer[0] % _buffer[1];
    case '/': return _buffer[0] / _buffer[1];
    case 'X': return _buffer[0] * _buffer[1];
    case '-': return _buffer[0] - _buffer[1];
    case '+': return _buffer[0] + _buffer[1];
    default: return _buffer[0];
  }
}
  String get Value{
    return _value;
  }
}
