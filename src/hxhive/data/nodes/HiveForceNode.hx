package hxhive.data.nodes;

class HiveForceNode extends HiveNode {
	public function new() {
		super("force", "unknown", HiveNodeType.FORCE);

		isDeletable = true;
	}
}
