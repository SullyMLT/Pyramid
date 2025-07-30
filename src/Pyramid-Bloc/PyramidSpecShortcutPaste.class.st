"
This class is used to create the shortcut for copy and paste -> use the plugin-copy-paste from this package.

It use the editor to get the collection of selected object from project model in Pyramid space.
"
Class {
	#name : #PyramidSpecShortcutPaste,
	#superclass : #PyramidSpecShortcutManagerPlugin,
	#traits : 'TPyramidShortcutSpec',
	#classTraits : 'TPyramidShortcutSpec classTrait',
	#instVars : [
		'plugin',
		'keyCombination',
		'shortcutAction',
		'navigationPlugin',
		'elementCollectionSelected'
	],
	#category : #'Pyramid-Bloc-plugin-shortcut-manager'
}

{ #category : #accessing }
PyramidSpecShortcutPaste >> defaultKeyCombination [
	"CTRL + V to activate this shortcut"

	keyCombination := $v command mac | $v control unix | $v control win
]

{ #category : #accessing }
PyramidSpecShortcutPaste >> elementCollectionSelected: aPyramidEditor [

	elementCollectionSelected := aPyramidEditor projectModel selection
		                             collection
]

{ #category : #initialization }
PyramidSpecShortcutPaste >> initialize [

	self defaultKeyCombination.
]

{ #category : #action }
PyramidSpecShortcutPaste >> pasteElement [

	elementCollectionSelected isEmpty ifTrue: [
		plugin pasteFromClipboardOnFirstLevelElements ].
	elementCollectionSelected size = 1 ifTrue: [
		plugin pasteFromClipboardOnSelection:
			elementCollectionSelected first ]
]

{ #category : #'accessing - classes' }
PyramidSpecShortcutPaste >> pluginFromPyramid: aPyramidEditor [
	"Connect selection array"

	self elementCollectionSelected: aPyramidEditor.
	"get copyPastePlugin"
	plugin := aPyramidEditor findPlugin: PyramidCopyPastePlugin.
	"Get navigationPlugin"
	navigationPlugin := aPyramidEditor findPlugin:
		                    PyramidNavigationPlugin
]

{ #category : #accessing }
PyramidSpecShortcutPaste >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin
				  ifNil: [ self inform: 'Plugin Copy/Paste is not installed' ]
				  ifNotNil: [ self pasteElement ] ]
]
