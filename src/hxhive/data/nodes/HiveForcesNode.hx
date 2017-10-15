package hxhive.data.nodes;

class HiveForcesNode extends HiveNode {
	public function new() {
		super("forces", "set of forces", HiveNodeType.FORCES);

		isDeletable = false;
	}
}
