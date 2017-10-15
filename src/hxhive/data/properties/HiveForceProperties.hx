package hxhive.data.properties;

import hxfireflies.forces.ForceGravity;
import hxhive.data.forces.HiveForceType;
import hxhive.data.nodes.HiveForceNode;
import angular.service.Scope;

class HiveForceProperties extends HiveProperties {
	public var force(default, set):HiveForceNode = null;

	public var forceType:HiveForceType = HiveForceType.GRAVITY;

	public var gravityX:Float;
	public var gravityY:Float;

	public function new(scope:Scope) {
		super(scope);
	}

	override public function update() {
		switch(forceType) {
			case HiveForceType.GRAVITY:
				var gf:ForceGravity = Std.instance(force.force, ForceGravity);
				@:privateAccess gf._xVelocity = gravityX;
				@:privateAccess gf._yVelocity = gravityY;
			default:
		}
	}

	function fillProperties() {
		switch(forceType) {
			case HiveForceType.GRAVITY:
				var gf:ForceGravity = Std.instance(force.force, ForceGravity);
				@:privateAccess gravityX = gf._xVelocity;
				@:privateAccess gravityY = gf._yVelocity;
			default:
		}
	}

	public function isGravity():Bool {
		return forceType == HiveForceType.GRAVITY;
	}

	override public function isActive():Bool {
		return super.isActive() && force != null;
	}

	function set_force(value:HiveForceNode):HiveForceNode {
		if(force != value) {
			force = value;

			if(force != null) {
				forceType = force.forceType;
				fillProperties();
			}
		}

		return value;
	}
}
