"
This class is used to create the shortcut for copy and paste -> use the plugin-copy-paste from this package.

It use the editor to get the collection of selected object from project model in Pyramid space.
"
Class {
	#name : #PyramidSpecShortcutCut,
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

{ #category : #'as yet unclassified' }
PyramidSpecShortcutCut >> copySelectedElementInSpace [

	elementCollectionSelected isEmpty ifTrue: [ ^ self ].
	elementCollectionSelected size = 1
		ifTrue: [
			plugin copyAsStonInClipboard:
				elementCollectionSelected first.
			^ 1 ]
		ifFalse: [ self inform: 'Can not copy multiple element' ]
]

{ #category : #accessing }
PyramidSpecShortcutCut >> defaultKeyCombination [
	"CTRL + X to activate this shortcut"

	keyCombination := $x command mac | $x control unix | $x control win
]

{ #category : #accessing }
PyramidSpecShortcutCut >> elementCollectionSelected: aPyramidEditor [

	elementCollectionSelected := aPyramidEditor projectModel selection
		                             collection
]

{ #category : #initialization }
PyramidSpecShortcutCut >> initialize [

	self defaultKeyCombination.
]

{ #category : #'accessing - classes' }
PyramidSpecShortcutCut >> pluginFromPyramid: aPyramidEditor [
	"Connect selection array"

	self elementCollectionSelected: aPyramidEditor.
	"get copyPastePlugin"
	plugin := aPyramidEditor findPlugin: PyramidCopyPastePlugin.
	"Get navigationPlugin"
	navigationPlugin := aPyramidEditor findPlugin:
		                    PyramidNavigationPlugin
]

{ #category : #accessing }
PyramidSpecShortcutCut >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin
				  ifNil: [ self inform: 'Plugin Copy/Paste is not installed' ]
				  ifNotNil: [
					  self copySelectedElementInSpace = 1 ifTrue: [
							  navigationPlugin removeSelectedElements ] ] ]
]
