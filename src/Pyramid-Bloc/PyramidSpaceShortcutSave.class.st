"
This class used to create shortcut for saving in Pyramid space.

Used the plugin-save in this package.
"
Class {
	#name : #PyramidSpaceShortcutSave,
	#superclass : #PyramidSpaceShortcutManagerPlugin,
	#traits : 'TPyramidShortcutSpace',
	#classTraits : 'TPyramidShortcutSpace classTrait',
	#instVars : [
		'plugin',
		'shortcut',
		'keyCombination'
	],
	#category : #'Pyramid-Bloc-plugin-shortcut-manager'
}

{ #category : #accessing }
PyramidSpaceShortcutSave >> defaultKeyCombination [
	"CTRL + S to activate this shortcut"

	keyCombination := (BlKeyCombination builder primary key:
		                       KeyboardKey S) build
]

{ #category : #'accessing - classes' }
PyramidSpaceShortcutSave >> pluginFromPyramid: aPyramidEditor [

	plugin := aPyramidEditor findPlugin: PyramidSavePlugin
]

{ #category : #accessing }
PyramidSpaceShortcutSave >> shortcutAction [

	^ shortcutAction := BlShortcutWithAction new
		                  name: 'Pyramid edition shortcut save';
		                  combination: keyCombination;
		                  action: [ :event |
			                  plugin
				                  ifNil: [
					                  self inform: 'Plugin save is not installed' ]
				                  ifNotNil: [ plugin saveAction ] ]
]
