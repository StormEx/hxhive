package hxhive.data.areas;

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
			case HiveAreaNames.RECTANGLE:
				HiveAreaType.RECTANGLE;
			case HiveAreaNames.CIRCLE:
				HiveAreaType.CIRCLE;
			case HiveAreaNames.RING:
				HiveAreaType.RING;
			case HiveAreaNames.ARC:
				HiveAreaType.ARC;
			default:
				HiveAreaType.POINT;
		}
	}

	public function toString():String {
		return switch(this) {
			case POINT:
				HiveAreaNames.POINT;
			case RECTANGLE:
				HiveAreaNames.RECTANGLE;
			case CIRCLE:
				HiveAreaNames.CIRCLE;
			case RING:
				HiveAreaNames.RING;
			case ARC:
				HiveAreaNames.ARC;
			default:
				HiveAreaNames.POINT;
		}
	}
}
