Class {
	#name : #PyramidDynamicResizer,
	#superclass : #Object,
	#instVars : [
		'pyramidSelectionWidgetExtension',
		'pyramidPositionExtension',
		'projectModel',
		'editor',
		'positionOriginRight',
		'currentTranslationRight',
		'rightDynamicSize',
		'overlayElement',
		'moveEventRight',
		'bottomDynamicSize',
		'moveEventBottom',
		'currentTranslationBottom',
		'positionOriginBottom',
		'resizeElementSize',
		'bottomAndRightDynamicSize',
		'moveEventBottomAndRight',
		'currentTranslationBottomAndRight',
		'positionOriginBottomAndRight',
		'resizeElementColor',
		'resizeContainer'
	],
	#category : #'Pyramid-Bloc-plugin-space-extensions'
}

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createBottomAndRightResizerElement: aBlElement [

	| bottomAndRightResizer |
	bottomAndRightResizer := BlElement new.
	bottomAndRightResizer
		background: resizeElementColor;
		id: 'bottomAndRightResizer';
		size: resizeElementSize;
		zIndex: 1005.
	bottomAndRightResizer constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignBottom ].

	bottomAndRightResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt |
				 aBlElement userData at: #pyramidPreviousDynamicResize put: (aBlElement size).
				 self positionOriginBottomAndRight: aBlElement position.
				 pyramidSelectionWidgetExtension elementAtEvents addEventHandler:
					 moveEventBottomAndRight.
				 evt consumed: true ]).

	^ bottomAndRightResizer
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createBottomResizerElement: aBlElement [

	| bottomResizer |
	bottomResizer := BlElement new.
	bottomResizer
		background: resizeElementColor;
		id: 'bottomResizer';
		size: resizeElementSize;
		zIndex: 1005.
	bottomResizer constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].

	bottomResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt |
				 aBlElement userData at: #pyramidPreviousDynamicResize put: (aBlElement size).
				 self positionOriginBottom: aBlElement position.
				 pyramidSelectionWidgetExtension elementAtEvents addEventHandler:
					 moveEventBottom.
				 evt consumed: true ]).

	^ bottomResizer
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createRightResizerElement: aBlElement [

	| rightResizer |
	rightResizer := BlElement new.
	rightResizer
		background: resizeElementColor;
		id: 'rightResizer';
		size: resizeElementSize;
		zIndex: 1005.
	rightResizer constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].

	rightResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt |
				 aBlElement userData at: #pyramidPreviousDynamicResize put: (aBlElement size).
				 self positionOriginRight: aBlElement position.
				 pyramidSelectionWidgetExtension elementAtEvents addEventHandler:
					 moveEventRight.
				 evt consumed: true ]).

	^ rightResizer
]

{ #category : #accessing }
PyramidDynamicResizer >> currentTranslationBottom [

	^ currentTranslationBottom
]

{ #category : #accessing }
PyramidDynamicResizer >> currentTranslationBottom: aPosition [

	currentTranslationBottom := aPosition
]

{ #category : #accessing }
PyramidDynamicResizer >> currentTranslationBottomAndRight [

	^ currentTranslationBottomAndRight
]

{ #category : #accessing }
PyramidDynamicResizer >> currentTranslationBottomAndRight: aPosition [

	currentTranslationBottomAndRight := aPosition 
]

{ #category : #accessing }
PyramidDynamicResizer >> currentTranslationRight [

	^ currentTranslationRight
]

{ #category : #accessing }
PyramidDynamicResizer >> currentTranslationRight: aPosition [

	currentTranslationRight := aPosition
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> dynamicResizer: eventElement originElement: aBlElement [

	resizeContainer := BlElement new.
	resizeContainer
		id: 'dynamicResizer';
		zIndex: 1001.
	resizeContainer layout: BlFrameLayout new.
	resizeContainer constraints horizontal matchParent.
	resizeContainer constraints vertical matchParent.

	moveEventRight := self moveSpaceEventRight: aBlElement.
	rightDynamicSize := self createRightResizerElement: aBlElement.

	moveEventBottom := self moveSpaceEventBottom: aBlElement.
	bottomDynamicSize := self createBottomResizerElement: aBlElement.

	moveEventBottomAndRight := self moveSpaceEventBottomAndRight: aBlElement.
	bottomAndRightDynamicSize := self createBottomAndRightResizerElement: aBlElement.

	resizeContainer addChild: rightDynamicSize.
	resizeContainer addChild: bottomDynamicSize.
	resizeContainer addChild: bottomAndRightDynamicSize.

	eventElement addChild: resizeContainer
]

{ #category : #accessing }
PyramidDynamicResizer >> editor [

	^ editor
]

{ #category : #accessing }
PyramidDynamicResizer >> editor: aPyramidEditor [
	| spacePlugin listOfExtension extensionSorted |
	
	editor := aPyramidEditor.
	
	spacePlugin := aPyramidEditor findPlugin: PyramidSpacePlugin.
	
	listOfExtension := spacePlugin builder extensions.
	
	extensionSorted := listOfExtension select: [ :extensions |
		                           extensions isKindOf: PyramidPositionExtension ].
	extensionSorted size = 1 ifFalse: [ ^ self ].
	pyramidPositionExtension := extensionSorted asArray first
]

{ #category : #initialization }
PyramidDynamicResizer >> initialize [ 
	
	resizeElementSize := 8@8.
	resizeElementColor := Color black.
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> installOnDynamicResizer: aEventElement [

	| originBlElement |
	self projectModel selection size = 1 ifFalse: [ ^ self ].

	originBlElement := self projectModel selection first.
	
	(originBlElement size) < (30@30) ifTrue: [ ^ self ].
	self dynamicResizer: aEventElement originElement: originBlElement
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventBottom: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed
				  ifFalse: [
					  evt consumed: true.
					  self resizeCommand: aBlElement with: aBlElement size.
					  aBlElement userData removeKey: #pyramidPreviousDynamicResize.
					  pyramidSelectionWidgetExtension elementAtEvents
						  removeEventHandler: moveEventBottom ]
				  ifTrue: [
					  self currentTranslationBottom:
						  pyramidPositionExtension position - self positionOriginBottom.
					  aBlElement size:
						  aBlElement size x @ self currentTranslationBottom y ] ]
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventBottomAndRight: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed
				  ifFalse: [
					  evt consumed: true.
					  self resizeCommand: aBlElement with: aBlElement size.
					  aBlElement userData removeKey: #pyramidPreviousDynamicResize.
					  pyramidSelectionWidgetExtension elementAtEvents
						  removeEventHandler: moveEventBottomAndRight ]
				  ifTrue: [
					  self currentTranslationBottomAndRight:
						  pyramidPositionExtension position
						  - self positionOriginBottomAndRight.
					  aBlElement size: self currentTranslationBottomAndRight x 
											@ 
											self currentTranslationBottomAndRight y ] ]
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventRight: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed
				  ifFalse: [
					  evt consumed: true.
					  self resizeCommand: aBlElement with: aBlElement size.
					  aBlElement userData removeKey: #pyramidPreviousDynamicResize.
					  pyramidSelectionWidgetExtension elementAtEvents
						  removeEventHandler: moveEventRight ]
				  ifTrue: [
					  self currentTranslationRight:
						  pyramidPositionExtension position - self positionOriginRight.
					  aBlElement size:
						  self currentTranslationRight x @ aBlElement size y ] ]
]

{ #category : #accessing }
PyramidDynamicResizer >> positionOriginBottom [

	^ positionOriginBottom 
]

{ #category : #accessing }
PyramidDynamicResizer >> positionOriginBottom: aPosition [

	positionOriginBottom := aPosition 
]

{ #category : #accessing }
PyramidDynamicResizer >> positionOriginBottomAndRight [

	^ positionOriginBottomAndRight
]

{ #category : #accessing }
PyramidDynamicResizer >> positionOriginBottomAndRight: aPosition [

	positionOriginBottomAndRight := aPosition 
]

{ #category : #accessing }
PyramidDynamicResizer >> positionOriginRight [

	^ positionOriginRight
]

{ #category : #accessing }
PyramidDynamicResizer >> positionOriginRight: aPosition [

	positionOriginRight := aPosition
]

{ #category : #accessing }
PyramidDynamicResizer >> projectModel [

	^ projectModel
]

{ #category : #accessing }
PyramidDynamicResizer >> projectModel: aPyramidProjectModel [

	projectModel := aPyramidProjectModel
]

{ #category : #accessing }
PyramidDynamicResizer >> pyramidSelectionWidgetExtension: aPyramidSelectionWidgetExtension [

	pyramidSelectionWidgetExtension := aPyramidSelectionWidgetExtension 
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> resizeCommand: aBlElement with: aSize [

	self editor commandExecutor
		use: PyramidDynamicResizeCommand new
		on: {aBlElement}
		with: aSize

]
