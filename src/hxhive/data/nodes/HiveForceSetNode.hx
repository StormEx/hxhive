package hxhive.data.nodes;

import hxfireflies.forces.ForceCollection;

class HiveForceSetNode extends HiveNode {
	public var force:ForceCollection = null;

	public function new() {
		super("forces", "set of forces", HiveNodeType.FORCE_SET);

		isDeletable = false;
		force = new ForceCollection();
	}

	override function onForceAdded(node:HiveNode) {
		trace('force added');
		force.clear();
		for(c in children) {
			var f:HiveForceNode = Std.instance(c, HiveForceNode);
			if(f != null) {
				force.add(f.force);
			}
		}

		performChange();
	}
}
