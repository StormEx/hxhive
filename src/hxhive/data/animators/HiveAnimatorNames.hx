package hxhive.data.animators;

@:enum abstract HiveAnimatorNames(String) from String to String {
	static var names:Array<HiveAnimatorNames> = [
		NONE,
		LINEAR,
		IN,
		OUT
	];

	var NONE = "none";
	var LINEAR = "linear";
	var IN = "in";
	var OUT = "out";
}
