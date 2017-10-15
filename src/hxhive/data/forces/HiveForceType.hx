package hxhive.data.forces;

@:enum abstract HiveForceType(Int) {
	var GRAVITY       = 0;

	public static function random():HiveForceType {
		return Std.int(Math.random() * 0);
	}

	static public function fromString(value:String):HiveForceType {
		return switch(value) {
			case HiveForceNames.GRAVITY:
				HiveForceType.GRAVITY;
			default:
				HiveForceType.GRAVITY;
		}
	}

	public function toString():String {
		return switch(this) {
			case GRAVITY:
				HiveForceNames.GRAVITY;
			default:
				HiveForceNames.GRAVITY;
		}
	}
}
