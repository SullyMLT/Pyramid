"
This class is used to define for moving child position in his parent between each child.
"
Class {
	#name : #PyramidSpecShortcutMoveChildUpInParent,
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
PyramidSpecShortcutMoveChildUpInParent >> defaultKeyCombination [
	"CTRL + Arrow up to activate this shortcut"

	keyCombination := Character arrowUp command mac
	                  | Character arrowUp control unix
	                  | Character arrowUp control win
]

{ #category : #initialization }
PyramidSpecShortcutMoveChildUpInParent >> initialize [

	self defaultKeyCombination.
	self defaultKeyCombination
]

{ #category : #'accessing - classes' }
PyramidSpecShortcutMoveChildUpInParent >> pluginFromPyramid: aPyramidEditor [

	plugin := aPyramidEditor findPlugin:
		                           PyramidMoveChildInParentPlugin
]

{ #category : #accessing }
PyramidSpecShortcutMoveChildUpInParent >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin
				  ifNil: [
					  self inform: 'Plugin MoveChildInParentPlugin is not installed' ]
				  ifNotNil: [ plugin moveChildIndexUpInParent ] ]
]
