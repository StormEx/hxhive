package hxhive.data.nodes;

class HiveForceSetNode extends HiveNode {
	public function new() {
		super("forces", "set of forces", HiveNodeType.FORCE_SET);

		isDeletable = false;
	}
}
