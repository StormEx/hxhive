package hxhive.data.nodes;

import hxhive.data.forces.HiveForceFactory;
import hxfireflies.forces.IForce;
import hxhive.data.forces.HiveForceType;

class HiveForceNode extends HiveNode {
	public var forceType:HiveForceType = HiveForceType.GRAVITY;
	public var force:IForce = null;

	public function new() {
		super("force", "unknown", HiveNodeType.FORCE);

		isDeletable = true;
		random();
	}

	public function random() {
		forceType = HiveForceType.random();
		force = HiveForceFactory.create(forceType);

		changeText();
		performChange();
	}

	function changeText() {
		switch(forceType) {
			case HiveForceType.GRAVITY:
				title = "force";
				description = "gravity";
			default:
				title = "force";
				description = "unknown";
		}
	}

	override public function getForceNode():HiveForceNode {
		return this;
	}
}
