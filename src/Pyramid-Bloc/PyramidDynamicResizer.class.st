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
		'resizerContainer'
	],
	#category : #'Pyramid-Bloc-plugin-space-extensions'
}

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createBottomAndRightResizerElement [
	
	| bottomAndRightResizer |
	
	bottomAndRightResizer := BlElement new.
	bottomAndRightResizer background: resizeElementColor;
						id: 'bottomAndRightResizer';
						size: resizeElementSize;
						zIndex:1005.
	bottomAndRightResizer constraintsDo: [ :c |
	c frame horizontal alignRight.
	c frame vertical alignBottom].
	
	bottomAndRightResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt | 
					 self inform: 'salutbottomAndRightResizer'.
					 self positionOriginBottomAndRight: evt position
						 - pyramidSelectionWidgetExtension currentTransformTranslation.
					 "bottomAndRightResizer"pyramidSelectionWidgetExtension elementAtEvents addEventHandler:
						 moveEventBottomAndRight.
					 evt consumed: true ]).
				
	^ bottomAndRightResizer 
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createBottomAndRightResizerElement: aBlElement [
	
	| bottomAndRightResizer |
	
	bottomAndRightResizer := BlElement new.
	bottomAndRightResizer background: resizeElementColor;
						id: 'bottomAndRightResizer';
						size: resizeElementSize.
	bottomAndRightResizer constraintsDo: [ :c |
	c frame horizontal alignRight.
	c frame vertical alignBottom].
	
	bottomAndRightResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt | 
					 self inform: 'salutbottomAndRightResizer'.
					 self positionOriginBottomAndRight: evt position
						 "- pyramidSelectionWidgetExtension currentTransformTranslation".
					 aBlElement addEventHandler:
						 moveEventBottomAndRight.
					 evt consumed: true ]).
				
	^ bottomAndRightResizer 
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createBottomResizerElement [
	
	| bottomResizer |
	
	bottomResizer := BlElement new.
	bottomResizer background: resizeElementColor;
						id: 'bottomResizer';
						size: resizeElementSize.
	bottomResizer constraintsDo: [ :c |
	c frame horizontal alignCenter.
	c frame vertical alignBottom].
	
	bottomResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt | 
					 self inform: 'salutBottomResizer'.
					 self positionOriginBottom: evt position
						 - pyramidSelectionWidgetExtension currentTransformTranslation.
					 "bottomResizer"pyramidSelectionWidgetExtension elementAtEvents addEventHandler:
						 moveEventBottom.
					 evt consumed: true ]).
				
	^ bottomResizer 
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createBottomResizerElement: aBlElement [
	
	| bottomResizer |
	
	bottomResizer := BlElement new.
	bottomResizer background: resizeElementColor;
						id: 'bottomResizer';
						size: resizeElementSize;
						position: (resizerContainer size x /2)@(resizerContainer size y-10).
	bottomResizer constraintsDo: [ :c |
	c frame horizontal alignCenter.
	c frame vertical alignBottom].
	
	bottomResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt | 
					 self inform: 'salutBottomResizer'.
					 self positionOriginBottom: evt position
						 "- pyramidSelectionWidgetExtension currentTransformTranslation".
					 aBlElement addEventHandler:
						 moveEventBottom.
					 evt consumed: true ]).
				
	^ bottomResizer 
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createRightResizerElement [
	
	| rightResizer |
	
	rightResizer := BlElement new.
	rightResizer background: resizeElementColor;
						id: 'rightResizer';
						size: resizeElementSize;
						zIndex:1005.
	rightResizer constraintsDo: [ :c |
	c frame horizontal alignRight.
	c frame vertical alignCenter].
	
	rightResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt | 
					 self inform: 'salutRightResizer'.
					 self positionOriginRight: evt position
						 - pyramidSelectionWidgetExtension currentTransformTranslation.
					 "rightResizer"pyramidSelectionWidgetExtension elementAtEvents addEventHandler:
						 moveEventRight.
					 evt consumed: true ]).
			
	^ rightResizer 
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> createRightResizerElement: aBlElement [
	
	| rightResizer |
	
	rightResizer := BlElement new.
	rightResizer background: resizeElementColor;
						id: 'rightResizer';
						size: resizeElementSize.
	rightResizer constraintsDo: [ :c |
	c frame horizontal alignRight.
	c frame vertical alignCenter].
	
	rightResizer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt | 
					 self inform: 'salutRightResizer'.
					 self positionOriginRight: evt position
						 "- pyramidSelectionWidgetExtension currentTransformTranslation".
					 aBlElement addEventHandler:
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
PyramidDynamicResizer >> dynamicResizer: aBlOverlayElement originElement: aBlElement [
	
	resizerContainer := BlElement new.
	resizerContainer id:'dynamicResizer';
							zIndex: 1001.
	"resizerContainer layout: BlFrameLayout new."
	resizerContainer layout: BlBasicLayout new.
	resizerContainer constraints horizontal matchParent.
	resizerContainer constraints vertical matchParent.
	
	moveEventRight := self moveSpaceEventRight: aBlOverlayElement.
	rightDynamicSize := self createRightResizerElement: aBlElement space.
	
	moveEventBottom := self moveSpaceEventBottom: aBlOverlayElement.
	bottomDynamicSize := self createBottomResizerElement: aBlElement space.
	
	moveEventBottomAndRight := self moveSpaceEventBottomAndRight: aBlOverlayElement.
	bottomAndRightDynamicSize := self createBottomAndRightResizerElement: aBlElement space.
	
	resizerContainer addChild: rightDynamicSize.
	resizerContainer addChild: bottomDynamicSize.
	resizerContainer addChild: bottomAndRightDynamicSize.
	
	aBlOverlayElement addChild: resizerContainer.
	
]

{ #category : #initialization }
PyramidDynamicResizer >> initialize [ 
	
	resizeElementSize := 20@20.
	resizeElementColor := Color black.
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> installOnDynamicResizer: aBlOverlayElement [
	
	| originBlElement |
	
	(self projectModel selection size) = 1
	ifFalse: [ ^ self ].
	
	originBlElement := self projectModel selection first.
	
	self projectModel firstLevelElements do: [ :element | element = originBlElement
															ifTrue: [ self dynamicResizer: aBlOverlayElement originElement: originBlElement. ] ].
	"self dynamicResizer: aBlOverlayElement originElement: originBlElement."
	
	
	 
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventBottom: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed ifFalse: [
				  bottomDynamicSize space removeEventHandler: moveEventBottom
				"pyramidSelectionWidgetExtension elementAtEvents removeEventHandler: moveEventRight" ].

				  self currentTranslationBottom: evt position - self positionOriginBottom.
				  aBlElement size: 
						(aBlElement size x
						@ 
						((aBlElement size y) + (self currentTranslationBottom y))).
				  bottomDynamicSize transformDo: [
					  :t | t translateBy: 0@(self currentTranslationBottom y) ].
				  
				  self positionOriginBottom: evt position "- pyramidSelectionWidgetExtension currentTransformTranslation".
				self inform: self currentTranslationBottom y asString.
				  evt consumed: true ]
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventBottomAndRight: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed ifFalse: [
				  bottomAndRightDynamicSize space removeEventHandler: moveEventBottomAndRight
					"pyramidSelectionWidgetExtension elementAtEvents removeEventHandler: moveEventRight" ].
			
				  self currentTranslationBottomAndRight: evt position - self positionOriginBottomAndRight.
				  bottomAndRightDynamicSize transformDo: [
					  :t | t translateBy: self currentTranslationBottomAndRight ].
				  aBlElement size: 
						(((aBlElement size x) + (self currentTranslationBottomAndRight x))
						@ 
						((aBlElement size y) + (self currentTranslationBottomAndRight y))).
				  self positionOriginBottomAndRight: evt position "- pyramidSelectionWidgetExtension currentTransformTranslation".
				  evt consumed: true ]
]

{ #category : #'as yet unclassified' }
PyramidDynamicResizer >> moveSpaceEventRight: aBlElement [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed ifFalse: [
					rightDynamicSize space removeEventHandler: moveEventRight
					"pyramidSelectionWidgetExtension elementAtEvents removeEventHandler: moveEventRight" ].

				  self currentTranslationRight: evt position - self positionOriginRight.
				  rightDynamicSize transformDo: [
					  :t | t translateBy: (self currentTranslationRight x)@0 ].
				  aBlElement size: 
						(((aBlElement size x) + (self currentTranslationRight x))
						@ 
						(aBlElement size y)).
					self positionOriginRight: evt position "- pyramidSelectionWidgetExtension currentTransformTranslation".
				  evt consumed: true ]
]

{ #category : #accessing }
PyramidDynamicResizer >> overlayElement [

	^ overlayElement
]

{ #category : #accessing }
PyramidDynamicResizer >> overlayElement: aBlElement [

	overlayElement := aBlElement 
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
