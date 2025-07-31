"
This slider is used by PyramidSpaceZoomPlugin.
"
Class {
	#name : #PyramidZoomSlider,
	#superclass : #Object,
	#instVars : [
		'sliderContainer',
		'lineSlider',
		'blocToMove',
		'moveEvent',
		'currentBlocSliderTranslation',
		'scaleValue',
		'blockAction',
		'sliderLap',
		'sliderDefaultValue',
		'lineSliderWidth',
		'sliderWidth',
		'dragSlider',
		'sliderPaddingWidth'
	],
	#category : #'Pyramid-Bloc-plugin-space-zoom-move'
}

{ #category : #accessing }
PyramidZoomSlider >> blocToMoveZoomPosition: aScaleValue [

	| value | 
	value := ((aScaleValue -1) * 100.0). 

	blocToMove transformDo: [ :t | t translateBy: value@0 ].
]

{ #category : #helpers }
PyramidZoomSlider >> createSlider [ 
	
	^ self refreshSlider
]

{ #category : #accessing }
PyramidZoomSlider >> currentBlocSliderTranslation [

	^ currentBlocSliderTranslation
]

{ #category : #accessing }
PyramidZoomSlider >> currentBlocSliderTranslation: aPosition [

	currentBlocSliderTranslation := aPosition 
]

{ #category : #accessing }
PyramidZoomSlider >> dragSlider [
	
	^ dragSlider
]

{ #category : #accessing }
PyramidZoomSlider >> dragSlider: aBoolean [

	dragSlider := aBoolean
]

{ #category : #initialization }
PyramidZoomSlider >> initialize [
	
	self dragSlider: false.
	
	sliderWidth := 250.
	sliderDefaultValue := 50.
	sliderPaddingWidth := 40.
	sliderLap := 10.

	self refreshSlider
]

{ #category : #accessing }
PyramidZoomSlider >> maxBlocMoveSliderLength [

	^ ((lineSliderWidth + (sliderPaddingWidth/2) ) - blocToMove position x / sliderLap) rounded * sliderLap @ 0
]

{ #category : #accessing }
PyramidZoomSlider >> minBlocMoveSliderLength [

	^ ((sliderPaddingWidth/2) - blocToMove position x / sliderLap) rounded * sliderLap @ 0
]

{ #category : #'as yet unclassified' }
PyramidZoomSlider >> moveBlocSliderEvent [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  self dragSlider: true.
			  evt primaryButtonPressed ifFalse: [
				  sliderContainer removeEventHandler: moveEvent.
				  self dragSlider: false. ].

			  self currentBlocSliderTranslation:
				  (evt position x - sliderContainer position x
				   - blocToMove position x / sliderLap) rounded * sliderLap @ 0.
			  blocToMove transformDo: [ :t |
				  "Si inférieur à la taille max du slider (ligne)
					if inferior to the max size of the slider (line)"
				  self currentBlocSliderTranslation x < ((lineSliderWidth - sliderDefaultValue) + 1) 
				  ifTrue: [
					  "Si supérieur au début du slider (ligne)
						if superior to the begin of the slider (line)"
					  self currentBlocSliderTranslation x > ((sliderDefaultValue + 1) * -1)
					  ifTrue: [
						  t translateBy: self currentBlocSliderTranslation.
						  scaleValue := 1 + (self currentBlocSliderTranslation x / 100.0).
						  blockAction value: scaleValue ]
					  ifFalse: [ t translateBy: self minBlocMoveSliderLength ] ]
				  ifFalse: [ t translateBy: self maxBlocMoveSliderLength ] ].
			  evt consumed: true ]
]

{ #category : #'as yet unclassified' }
PyramidZoomSlider >> refreshSlider [

	| sliderContainerWidth nbLap cornerRadius |
	
	lineSliderWidth := sliderWidth - sliderDefaultValue.
	sliderContainerWidth := sliderWidth + sliderPaddingWidth - sliderDefaultValue.

	sliderContainer := BlElement new.
	sliderContainer
		background: Color white;
		size: sliderContainerWidth @ 35;
		zIndex: 1001.
	sliderContainer  constraintsDo: [ :c |
			c frame horizontal alignLeft.
			c frame vertical alignBottom].

	lineSlider := BlElement new.
	lineSlider
		size: lineSliderWidth @ 2;
		position: (sliderPaddingWidth/2) @ 9;
		background: Color black.

	nbLap := lineSliderWidth / sliderLap.
	0 to: nbLap do: [ :i |
		| e |
		e := BlElement new.
		e
			background: Color gray;
			size: 1 @ 10;
			position: ((i * sliderLap) + (sliderPaddingWidth/2)) @ 5.
			
		((i * sliderLap)/50) isInteger
		ifTrue: [ sliderContainer addChild: (ToLabel new
													text: (i = 0
														ifTrue: [ (sliderDefaultValue) asString,'%']
														ifFalse: [(i * sliderLap + sliderDefaultValue) asString,'%']);
													position: ((i * sliderLap) + (sliderPaddingWidth/6)) @ 15).
						e background: Color blue;
						size: 2 @ 10 ].
					
		sliderContainer addChild: e ].
	
	cornerRadius := (BlRoundedRectangleGeometry cornerRadii:
					           (BlCornerRadii new
						            topLeft: 4;
						            topRight: 4;
						            bottomRight: 4;
						            bottomLeft: 4)).

	blocToMove := BlElement new.
	blocToMove
		background: Color red;
		geometry: cornerRadius;
		size: 6 @ 15;
		position: ((sliderPaddingWidth/2) + sliderDefaultValue -3) @ 2.
			
	sliderContainer addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt | 
				self dragSlider
					ifFalse: [ moveEvent := self moveBlocSliderEvent.
				 		sliderContainer addEventHandler: moveEvent ] ]).

	sliderContainer addChild: lineSlider.
	sliderContainer addChild: blocToMove.
	
	^ sliderContainer
]

{ #category : #'as yet unclassified' }
PyramidZoomSlider >> scaledZoomValue: aScale [

	sliderWidth := (aScale*100)
]

{ #category : #accessing }
PyramidZoomSlider >> sliderLapScale [

	^ (sliderLap/100.0)
]

{ #category : #'as yet unclassified' }
PyramidZoomSlider >> sliderMaxScale [

	^ (sliderWidth/100)
]

{ #category : #'as yet unclassified' }
PyramidZoomSlider >> sliderMinScale [

	^ ((sliderDefaultValue)/100)
]

{ #category : #enumerating }
PyramidZoomSlider >> whenValueChangedDo: aBlock [

	blockAction := aBlock
]
