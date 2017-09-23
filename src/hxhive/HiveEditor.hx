package hxhive;

import hxhive.controllers.HiveEditorController;
import angular.Angular;
import js.jquery.JQuery;

class HiveEditor {
    public function new() {
        trace("PsEditor launched");

        Angular.module("pseditor", ['treeControl'])
        .controller("PsEditorController", HiveEditorController.new);

        var jqBody = new JQuery("body");
        Angular.bootstrap(jqBody[0], ["pseditor"]);
    }
}
