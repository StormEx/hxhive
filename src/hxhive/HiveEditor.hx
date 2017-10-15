package hxhive;

import hxhive.data.HiveModel;
import hxhive.controllers.HivePropertiesController;
import hxhive.view.HiveMainView;
import hxhive.controllers.HiveEditorController;
import angular.Angular;
import js.jquery.JQuery;

class HiveEditor {
	public function new() {
		trace("PsEditor launched");

		Angular.module("pseditor", ['treeControl'])
		.controller("HiveEditorController", HiveEditorController.new)
		.controller("HivePropertiesController", HivePropertiesController.new)
		.factory(HiveMainView.new)
		.factory(HiveModel.new);

		var jqBody = new JQuery("body");
		Angular.bootstrap(jqBody[0], ["pseditor"]);
	}
}
