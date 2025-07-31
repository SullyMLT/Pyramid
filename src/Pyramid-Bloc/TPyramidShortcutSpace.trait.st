Trait {
	#name : #TPyramidShortcutSpace,
	#instVars : [
		'shortcutAction',
		'keyCombination',
		'plugin'
	],
	#category : #'Pyramid-Bloc-plugin-shortcut-manager'
}

{ #category : #accessing }
TPyramidShortcutSpace >> defaultKeyCombination [

	
]

{ #category : #initialization }
TPyramidShortcutSpace >> initialize [

	self defaultKeyCombination
]

{ #category : #accessing }
TPyramidShortcutSpace >> keyCombination: aKeyCombination [

	^ keyCombination := aKeyCombination
]

{ #category : #'accessing - classes' }
TPyramidShortcutSpace >> pluginFromPyramid: aPyramidEditor [
	
	| listOfPlugins pluginSorted |
	
	listOfPlugins := aPyramidEditor plugins.
	pluginSorted := listOfPlugins select: [ :extensions | "extensions isKindOf: PyramidHistoryPlugin" ].
	pluginSorted size = 1
	ifFalse: [^ self].
	plugin := pluginSorted asArray first
]

{ #category : #accessing }
TPyramidShortcutSpace >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin
				  ifNil: [ self inform: 'problem with the plugin' ]
				  ifNotNil: [ "Action here" ] ]
]
