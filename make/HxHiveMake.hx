package ;

import hxmake.haxelib.HaxelibExt;
import hxmake.test.TestTask;
import hxmake.idea.IdeaPlugin;
import hxmake.haxelib.HaxelibPlugin;

using hxmake.haxelib.HaxelibPlugin;

class HxFirefliesMake extends hxmake.Module {
	function new() {
		config.classPath = ["src"];
		config.testPath = ["test"];
		config.devDependencies = [
			"utest" => "haxelib",
			"hxdispose" => "haxelib",
			"hxfireflies" => "haxelib"
		];

		apply(HaxelibPlugin);
		apply(IdeaPlugin);

		library(
			function(ext:HaxelibExt) {
				ext.config.description = "particles editor, based on hxfireflies";
				ext.config.contributors = ["storm_ex"];
				ext.config.url = "https://github.com/StormEx/hxhive";
				ext.config.license = "MIT";
				ext.config.version = "0.0.1";
				ext.config.releasenote = "Initial release";
				ext.config.tags = ["particles editor"];

				ext.pack.includes = ["src", "haxelib.json", "README.md"];
			}
		);

		var tt = new TestTask();
		tt.targets = ["neko", "swf", "js", "node", "cpp", "java", "cs", "php"];
		tt.libraries = ["hxfireflies", "hxdispose", "hxhive"];
		task("test", tt);
	}
}