Class {
	#name : #PyramidShortcutPresenterTest,
	#superclass : #SpPresenter,
	#instVars : [
		'stampPresenterLabel'
	],
	#category : #'Pyramid-Bloc-plugin-shortcut-manager'
}

{ #category : #layout }
PyramidShortcutPresenterTest >> defaultLayout [ 

	| defaultLayout stampPresenterLabelLine |
	defaultLayout := SpBoxLayout newVertical spacing: 6; yourself.
	
	stampPresenterLabelLine:= SpBoxLayout newHorizontal hAlignStart; yourself.
	stampPresenterLabelLine add: stampPresenterLabel.
	
	defaultLayout add: stampPresenterLabelLine expand: false.
	
	^ defaultLayout
]

{ #category : #'initialization - deprecated' }
PyramidShortcutPresenterTest >> initializePresenter [ 

	stampPresenterLabel := SpLabelPresenter new 
							displayBold: [ true ];
							label: 'Selected element stamp :';
							yourself.
]

{ #category : #initialization }
PyramidShortcutPresenterTest >> initializeWindow: aWindow [

	"| keyMap keyMap2 keyMap3 keyMapCategory |
	keyMap := KMKeymap new.
	keyMap shortcut: $s command mac | $s control unix | $s control win.
	keyMap action: [ self inform: 'Salut' ].

	keyMap2 := KMKeymap new.
	keyMap2 shortcut: $v command mac | $v control unix | $v control win.
	keyMap2 action: [ self inform: 'ça va ?' ].

	keyMap3 := KMKeymap new.
	keyMap3 shortcut: $c command mac | $c control unix | $c control win.
	keyMap3 action: [ self inform: 'Oui' ].

	keyMapCategory := KMCategory new.
	keyMapCategory addKeymapEntry: keyMap.
	keyMapCategory addKeymapEntry: keyMap2.
	keyMapCategory addKeymapEntry: keyMap3.

	super initializeWindow: aWindow.

	aWindow contextKeyBindings: keyMapCategory."
	aWindow
		bindKeyCombination:
		$s command mac | $s control unix | $s control win
		toAction: [ self inform: 'hi' ].
	aWindow
		bindKeyCombination:
		$v command mac | $v control unix | $v control win
		toAction: [ self inform: 'paste' ].
	aWindow
		bindKeyCombination:
		$c command mac | $c control unix | $c control win
		toAction: [ self inform: 'copy' ].

	"aWindow inspect"
]
