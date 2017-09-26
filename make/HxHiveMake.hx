package ;

import hxmake.idea.IdeaPlugin;
import hxmake.haxelib.HaxelibPlugin;

using hxmake.haxelib.HaxelibPlugin;

class HxHiveMake extends hxmake.Module {
	function new() {
		config.classPath = ["src"];
		config.testPath = ["test"];
		config.devDependencies = [
			"hxdispose" => "haxelib",
			"hxfireflies" => "haxelib"
		];

		apply(HaxelibPlugin);
		apply(IdeaPlugin);
	}
}