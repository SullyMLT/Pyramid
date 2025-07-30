"
Class use to create the shortcut undo / redo.

Use the history feature from the package Pyramid.
"
Class {
	#name : #PyramidSpecShortcutUndo,
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
PyramidSpecShortcutUndo >> defaultKeyCombination [
	"CTRL + Z to activate this shortcut"

	keyCombination := $z command mac | $z control unix | $z control win
]

{ #category : #initialization }
PyramidSpecShortcutUndo >> initialize [

	self defaultKeyCombination
]

{ #category : #'accessing - classes' }
PyramidSpecShortcutUndo >> pluginFromPyramid: aPyramidEditor [

	plugin := aPyramidEditor findPlugin: PyramidHistoryPlugin
]

{ #category : #accessing }
PyramidSpecShortcutUndo >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction shortcut: keyCombination;
		                  action: [ 
			                  plugin
				                  ifNil: [
					                  self inform:
							                  'Plugin undo/redo is not installed' ]
				                  ifNotNil: [
					                  plugin history undo.
					                  plugin projectModel
						                  informElementsChanged ] ]
]
