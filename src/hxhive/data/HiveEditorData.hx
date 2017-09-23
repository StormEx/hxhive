package hxhive.data;

class HiveEditorData {
	public var treeData:Array<HiveTreeNode> = [];

	var _changedCallback:Void->Void = null;

	var _selectedNode:HiveTreeNode = null;
	var _isLoaded:Bool = true;

	public function new(changed:Void->Void) {
		_changedCallback = changed;
	}

	public function reset() {
		treeData = [];
		var root:HiveTreeNode = new HiveTreeNode();
		root.title = "particle system";
		root.description = "root";
		treeData.push(root);
		selectNode(treeData[0], true);
	}

	public function selectNode(node:HiveTreeNode, selected:Bool) {
		if(_selectedNode != node) {
			_selectedNode = node;
			changed();
		}
	}

	public function deleteNode(node:HiveTreeNode) {
	}

	public function isLoaded():Bool {
		return _isLoaded;
	}

	function changed() {
		if(_changedCallback != null) {
			trace("data changed");
			_changedCallback();
		}
	}
}
