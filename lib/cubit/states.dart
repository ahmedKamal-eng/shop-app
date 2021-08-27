abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

// business States
class NewsLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final error;
  NewsGetBusinessErrorState({this.error});
}
//  end business States

// Science States
class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final error;
  NewsGetScienceErrorState({this.error});
}
//  end science States

// sports States
class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final error;
  NewsGetSportsErrorState({this.error});
}
//  end sports States

// search States
class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final error;
  NewsGetSearchErrorState({this.error});
}
//  end sports States

class NewsChangeModeState extends NewsStates {}
