package hxhive.data.nodes;

@:enum abstract HiveNodeType(Int) {
	var SYSTEM      = 0;
	var EMITTER     = 1;
	var AREA        = 2;
	var SPRITES     = 3;
	var FORCE_SET   = 4;
	var FORCE       = 5;
}
