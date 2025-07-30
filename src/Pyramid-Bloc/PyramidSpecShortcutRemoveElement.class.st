"
This class define the shortcut to delete a selected element in the space.

it use the plugin-navigation in this package.
"
Class {
	#name : #PyramidSpecShortcutRemoveElement,
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
PyramidSpecShortcutRemoveElement >> defaultKeyCombination [
	"CTRL + R to activate this shortcut"

	keyCombination := $d command mac | $d control unix | $d control win
]

{ #category : #initialization }
PyramidSpecShortcutRemoveElement >> initialize [

	self defaultKeyCombination
]

{ #category : #'accessing - classes' }
PyramidSpecShortcutRemoveElement >> pluginFromPyramid: aPyramidEditor [

	plugin := aPyramidEditor findPlugin:
		                    PyramidNavigationPlugin
]

{ #category : #accessing }
PyramidSpecShortcutRemoveElement >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin
				  ifNil: [ self inform: 'Plugin navigation is not installed' ]
				  ifNotNil: [ plugin removeSelectedElements ] ]
]
