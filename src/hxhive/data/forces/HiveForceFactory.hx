package hxhive.data.forces;

import hxfireflies.forces.ForceGravity;
import hxfireflies.forces.IForce;

class HiveForceFactory {
	public static function create(type:HiveForceType):IForce {
		return switch(type) {
			case HiveForceType.GRAVITY:
				createGravity();
			default:
				null;
		}
	}

	public static function createByName(name:HiveForceNames):IForce {
		return switch(name) {
			case HiveForceNames.GRAVITY:
				createGravity();
			default:
				null;
		}
	}

	function createGravity():IForce {
		var res:IForce = new ForceGravity();

		return res;
	}
}
