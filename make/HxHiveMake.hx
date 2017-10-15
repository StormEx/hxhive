package ;

import hxmake.idea.IdeaPlugin;
import hxmake.haxelib.HaxelibPlugin;

using hxmake.haxelib.HaxelibPlugin;

class HxHiveMake extends hxmake.Module {
	function new() {
		config.classPath = ["src"];
		config.testPath = ["test"];
		config.dependencies = [
			"hxdispose" => "haxelib",
			"hxfireflies" => "haxelib",
			"hxphoton" => "haxelib",
			"angular.haxe" => "haxelib"
		];

		apply(HaxelibPlugin);
		apply(IdeaPlugin);
	}
}