package hxhive.data.nodes;

class HiveSystemNode extends HiveNode {
    public function new() {
        super("system", "subsystem", HiveNodeType.SYSTEM);
    }
}
