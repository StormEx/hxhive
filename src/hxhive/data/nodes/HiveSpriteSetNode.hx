package hxhive.data.nodes;

class HiveSpriteSetNode extends HiveNode {
	public function new() {
		super("sprites", "set of sprites", HiveNodeType.SPRITES);

		isDeletable = false;
	}
}
