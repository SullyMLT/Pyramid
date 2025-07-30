Class {
	#name : #PyramidSpecShortcutDefaultViewPosition,
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
PyramidSpecShortcutDefaultViewPosition >> defaultKeyCombination [
	"CTRL + N to activate this shortcut"

	keyCombination := $n command mac | $n control unix | $n control win
]

{ #category : #'accessing - classes' }
PyramidSpecShortcutDefaultViewPosition >> pluginFromPyramid: aPyramidEditor [

	plugin := aPyramidEditor findPlugin: PyramidSpaceMovePlugin
]

{ #category : #accessing }
PyramidSpecShortcutDefaultViewPosition >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin
				  ifNil: [ self inform: 'problem with the plugin' ]
				  ifNotNil: [ plugin defaultViewPosition ] ]
]
