///### MIXER_PAUSE_MIXING_CYCLE
///-  Name: **Mixer Pause Mixing Cycle**
///-  Data Length: **1 byte**
///-  ----------------------
class ERD0x5300 {
  String address = "0x5300";
  final String rawValue;
  var recipeExecutionId;
  var currentCookStepIndex;
  var cavityStatus;
  ERD0x5300(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data recieved from 0x9304');
    }
    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

 splitBytes() {
  //example erd e0 a0 44 c9 31 90 3c c5 a6 37 d6 cf 10 1c 4a 57 ba a4 9c 3a 00 05 00
    var bytes = this.rawValue;
    //Recipe execution ID is bytes 0-39
    recipeExecutionId = bytes.substring(0, 40);
    //Current cook step index is bytes 20-21
    currentCookStepIndex = int.parse(bytes.substring(40, 44), radix: 16);
    //Cavity status is bytes 22
    cavityStatus = int.parse(bytes.substring(44, 46), radix: 16);
  }

  //to string
  @override
  String toString() {
    return 'ERD0x5300{recipeExecutionId: $recipeExecutionId, currentCookStepIndex: $currentCookStepIndex, cavityStatus: $cavityStatus}';
  }
}
