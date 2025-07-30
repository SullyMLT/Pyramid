Trait {
	#name : #TPyramidShortcutSpec,
	#instVars : [
		'shortcutAction',
		'keyCombination',
		'plugin'
	],
	#category : #'Pyramid-Bloc-plugin-shortcut-manager'
}

{ #category : #accessing }
TPyramidShortcutSpec >> defaultKeyCombination [
]

{ #category : #initialization }
TPyramidShortcutSpec >> initialize [

	self defaultKeyCombination
]

{ #category : #accessing }
TPyramidShortcutSpec >> keyCombination: aKeyCombination [

	^ keyCombination := aKeyCombination
]

{ #category : #'accessing - classes' }
TPyramidShortcutSpec >> pluginFromPyramid: aPyramidEditor [
]

{ #category : #accessing }
TPyramidShortcutSpec >> shortcutAction [

	shortcutAction := PyramidSpecShortcutActionObject new.
	^ shortcutAction
		  shortcut: keyCombination;
		  action: [
			  plugin
				  ifNil: [ self inform: 'problem with the plugin' ]
				  ifNotNil: [ "Action here" ] ]
]
