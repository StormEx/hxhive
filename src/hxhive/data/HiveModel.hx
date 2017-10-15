package hxhive.data;

import hxphoton.Signal.Signal1;
import hxhive.data.nodes.HiveNode;

class HiveModel {
	public var node(default, set):HiveNode = null;
	public var nodeChanged(default, null):Signal1<HiveNode> = null;

	public function new() {
		nodeChanged = new Signal1();
	}

	function set_node(value:HiveNode):HiveNode {
		if(node != value) {
			node = value;

			nodeChanged.emit(node);
		}

		return node;
	}
}
