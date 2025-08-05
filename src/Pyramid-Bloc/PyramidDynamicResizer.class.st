Class {
	#name : #PyramidDynamicResizer,
	#superclass : #Object,
	#instVars : [
		'pyramidSelectionWidgetExtension',
		'projectModel',
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
PyramidDynamicResizer >> createBottomAndRightResizerElement [

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
				 self positionOriginBottomAndRight: evt position.
				 pyramidSelectionWidgetExtension elementAtEvents addEventHandler:
					 moveEventBottomAndRight.
				 evt consumed: true ]).

	^ bottomAndRightResizer
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createBottomResizerElement [

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
				 self positionOriginBottom: evt position.
				 pyramidSelectionWidgetExtension elementAtEvents addEventHandler:
					 moveEventBottom.
				 evt consumed: true ]).

	^ bottomResizer
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createRightResizerElement [

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
				 self positionOriginRight: evt position.
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
	rightDynamicSize := self createRightResizerElement.

	moveEventBottom := self moveSpaceEventBottom: aBlElement.
	bottomDynamicSize := self createBottomResizerElement.

	moveEventBottomAndRight := self moveSpaceEventBottomAndRight: aBlElement.
	bottomAndRightDynamicSize := self createBottomAndRightResizerElement.

	resizeContainer addChild: rightDynamicSize.
	resizeContainer addChild: bottomDynamicSize.
	resizeContainer addChild: bottomAndRightDynamicSize.

	eventElement addChild: resizeContainer
]

{ #category : #initialization }
PyramidDynamicResizer >> initialize [ 
	
	resizeElementSize := 7@7.
	resizeElementColor := Color black.
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> installOnDynamicResizer: aBlOverlayElement [

	| originBlElement |
	self projectModel selection size = 1 ifFalse: [ ^ self ].

	originBlElement := self projectModel selection first.

	self dynamicResizer: aBlOverlayElement originElement: originBlElement
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventBottom: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed ifFalse: [
				  pyramidSelectionWidgetExtension elementAtEvents removeEventHandler: moveEventBottom ]
			  ifTrue: [ 
				  self currentTranslationBottom: evt position - self positionOriginBottom.
				  bottomDynamicSize transformDo: [
					  :t | t translateBy: 0@(self currentTranslationBottom y) ].
				  aBlElement size: 
						(aBlElement size x
						@ 
						((aBlElement size y) + (self currentTranslationBottom y))).
				  self positionOriginBottom: evt position.
				  evt consumed: true ] ]
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventBottomAndRight: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed ifFalse: [
				  pyramidSelectionWidgetExtension elementAtEvents removeEventHandler: moveEventBottomAndRight ]
			  ifTrue: [
				  self currentTranslationBottomAndRight: evt position - self positionOriginBottomAndRight.
				  bottomAndRightDynamicSize transformDo: [
					  :t | t translateBy: self currentTranslationBottomAndRight ].
				  aBlElement size: 
						(((aBlElement size x) + (self currentTranslationBottomAndRight x))
						@ 
						((aBlElement size y) + (self currentTranslationBottomAndRight y))).
				  self positionOriginBottomAndRight: evt position.
				  evt consumed: true ] ]
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventRight: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed ifFalse: [
				  pyramidSelectionWidgetExtension elementAtEvents removeEventHandler: moveEventRight ]
			  ifTrue: [
				  self currentTranslationRight: evt position - self positionOriginRight.
				  rightDynamicSize transformDo: [
					  :t | t translateBy: (self currentTranslationRight x)@0 ].
				  aBlElement size: 
						(((aBlElement size x) + (self currentTranslationRight x))
						@ 
						(aBlElement size y)).
					self positionOriginRight: evt position.
				  evt consumed: true ] ]
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
