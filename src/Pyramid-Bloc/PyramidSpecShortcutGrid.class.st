"
This class define the shortcut to show or hide the grid on the space.

the grid is define in the plugin-space-extension -> PyramidMainExtension
"
Class {
	#name : #PyramidSpecShortcutGrid,
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
PyramidSpecShortcutGrid >> defaultKeyCombination [
	"CTRL + G to activate this shortcut"

	keyCombination := $g command mac | $g control unix | $g control win
]

{ #category : #initialization }
PyramidSpecShortcutGrid >> initialize [

	self defaultKeyCombination
]

{ #category : #'accessing - classes' }
PyramidSpecShortcutGrid >> pluginFromPyramid: aPyramidEditor [

	| spacePlugin listOfSpaceExtension pyramidMainExtensionSet |
	spacePlugin := aPyramidEditor findPlugin: PyramidSpacePlugin.

	listOfSpaceExtension := spacePlugin builder extensions.

	pyramidMainExtensionSet := listOfSpaceExtension select: [ :extensions |
		                           extensions isKindOf: PyramidMainExtension ].
	pyramidMainExtensionSet size = 1 ifFalse: [ ^ self ].
	plugin := pyramidMainExtensionSet asArray first
]

{ #category : #accessing }
PyramidSpecShortcutGrid >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin workplacePropertiesView visibilityButton toggleState ]
]
