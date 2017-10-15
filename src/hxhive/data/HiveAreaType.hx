package hxhive.data;

@:enum abstract HiveAreaType(Int) from Int to Int {
	var POINT       = 0;
	var RECTANGLE   = 1;
	var CIRCLE      = 2;
	var RING        = 3;
	var ARC         = 4;

	public static function random():HiveAreaType {
		return Std.int(Math.random() * 5);
	}

	static public function fromString(value:String):HiveAreaType {
		return switch(value) {
			case "rectangle":
				HiveAreaType.RECTANGLE;
			case "circle":
				HiveAreaType.CIRCLE;
			case "ring":
				HiveAreaType.RING;
			case "arc":
				HiveAreaType.ARC;
			default:
				HiveAreaType.POINT;
		}
	}

	public function toString():String {
		trace('to string');
		return switch(this) {
			case POINT:
				"point";
			case RECTANGLE:
				"rectangle";
			case CIRCLE:
				"circle";
			case RING:
				"ring";
			case ARC:
				"arc";
			default:
				"point";
		}
	}
}
