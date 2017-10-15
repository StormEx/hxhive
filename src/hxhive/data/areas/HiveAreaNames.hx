package hxhive.data.areas;

@:enum abstract HiveAreaNames(String) from String to String {
	var POINT           = "point";
	var RECTANGLE       = "rectangle";
	var CIRCLE          = "circle";
	var RING            = "ring";
	var ARC             = "arc";
}
