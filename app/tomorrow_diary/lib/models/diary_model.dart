class DiaryData{
  String? _title;
  List<String>? _wish;
  String? _ty;
  String? _tmr;
  String? _surprise;

  
  DiaryData({required String title, required String ty, required String tmr, required String surprise, required List<String> wish}) {
    	this._title = title;
      this. _ty = ty;
      this. _tmr = tmr;
      this._surprise = surprise;
      this._wish = wish;
   	}
  
  String? get title => _title;
  List<String>? get wish => _wish;
  String? get ty => _ty;
  String? get tmr => _tmr;
  String? get surprise => _surprise;

  set setTitle(String? title) => _title = title;
  set setTy(String? ty) => _ty = ty;
  set setTmr(String? tmr) => _tmr = tmr;
  set setWish(List<String> wish) => _wish = wish;
  set setSurprise(String? surp) => _surprise = surp;

}