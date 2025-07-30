"
This class used to create shortcut for saving in Pyramid space.

Used the plugin-save in this package.
"
Class {
	#name : #PyramidSpecShortcutSave,
	#superclass : #PyramidSpecShortcutManagerPlugin,
	#traits : 'TPyramidShortcutSpec',
	#classTraits : 'TPyramidShortcutSpec classTrait',
	#instVars : [
		'plugin',
		'keyCombination',
		'shortcutAction'
	],
	#category : #'Pyramid-Bloc-plugin-shortcut-manager'
}

{ #category : #accessing }
PyramidSpecShortcutSave >> defaultKeyCombination [
	"CTRL + S to activate this shortcut"

	keyCombination := $s command mac | $s control unix | $s control win
]

{ #category : #initialization }
PyramidSpecShortcutSave >> initialize [

	self defaultKeyCombination
]

{ #category : #'accessing - classes' }
PyramidSpecShortcutSave >> pluginFromPyramid: aPyramidEditor [

	plugin := aPyramidEditor findPlugin: PyramidSavePlugin
]

{ #category : #accessing }
PyramidSpecShortcutSave >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin
				  ifNil: [ self inform: 'Plugin save is not installed' ]
				  ifNotNil: [
					  
					  plugin saveAction ] ]
]
