package hxhive.data;

class HiveTreeNode {
    public var type:HiveNodeType = HiveNodeType.SYSTEM;
    public var id:Float;
    public var title:String = "empty node";
    public var description:String = "empty description";

    public var parent:HiveTreeNode = null;
    public var children:Array<HiveTreeNode> = [];

    public function new(title:String = "system", description:String = "", type:HiveNodeType = HiveNodeType.SYSTEM) {
        id = Math.random();
        this.title = title;
        this.description = description;
        this.type = type;
    }

    public function addSystem() {
        var system:HiveTreeNode = new HiveTreeNode("system", "subsystem");
        children.push(system);
    }

    public function addEmitter() {
        var emitter:HiveTreeNode = new HiveTreeNode("emitter", "", HiveNodeType.EMITTER);
        children.push(emitter);
    }

    public function isSystem():Bool {
        return type == HiveNodeType.SYSTEM;
    }

    public function isEmitter():Bool {
        return type == HiveNodeType.EMITTER;
    }
}
