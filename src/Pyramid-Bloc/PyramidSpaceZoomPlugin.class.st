"
This class is used to Zoom on the workspace CTRL + Wheel Mouse up (to zoom in) or down (to zoom out).

To edit the max zoom scale go in this class and change the value maxScaleValue in the initialize.
"
Class {
	#name : #PyramidSpaceZoomPlugin,
	#superclass : #Object,
	#traits : 'TPyramidPlugin',
	#classTraits : 'TPyramidPlugin classTrait',
	#instVars : [
		'currentScale',
		'pyramidWheelTransformExtension',
		'display',
		'pyramidSelectionWidgetExtension',
		'scaleLap',
		'spacePlugin',
		'pyramidPositionExtension',
		'slider',
		'scaledZoom',
		'maxScaleValue',
		'space'
	],
	#category : #'Pyramid-Bloc-plugin-space-zoom-move'
}

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> EditScaleDisplayElement: aBlElement [
	
	pyramidSelectionWidgetExtension scaleFactor: self currentScale.
	pyramidPositionExtension scaleFactor: self currentScale.
	
	self refreshScaledZoom.
	
	aBlElement transformDo: [ :t | t scaleBy: self currentScale.
											t translateBy: self scaledZoom ]
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> EditScaleDisplayElement: aBlElement scaleValue: aValue [
	
	self currentScale: aValue.
	pyramidSelectionWidgetExtension scaleFactor: self currentScale.
	pyramidPositionExtension scaleFactor: self currentScale.
	
	self refreshScaledZoom.

	aBlElement transformDo: [ :t | t scaleBy: self currentScale.
											t translateBy: self scaledZoom ]
]

{ #category : #connecting }
PyramidSpaceZoomPlugin >> connectOn: aPyramidEditor [

	self pluginFromPyramid: aPyramidEditor.

	pyramidSelectionWidgetExtension scaleFactor: self currentScale.

	self installOnZoomSpace.
	
	"pyramidSelectionWidgetExtension elementAtDisplaysAddons zIndex: 1001."
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> createZoomSlider [

	slider := PyramidZoomSlider new.
	slider whenValueChangedDo: [ :scaleValue | 
		self EditScaleDisplayElement: pyramidSelectionWidgetExtension elementAtMain scaleValue: scaleValue ].
	
	slider scaledZoomValue: self maxScaleValue.
	
	scaleLap := slider sliderLapScale.
	(pyramidWheelTransformExtension elementAtDisplaysAddons childWithId: 'zoom-plugin') addChild: slider createSlider.
	
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> currentScale [

	^ currentScale
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> currentScale: aValue [

	currentScale := aValue.
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> defaultScale [

	self currentScale: 1.
	pyramidSelectionWidgetExtension ifNotNil: [
		self EditScaleDisplayElement: pyramidSelectionWidgetExtension elementAtMain scaleValue: 1 ]
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> display [

	^ display
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> display: aDisplay [

	display := aDisplay
]

{ #category : #initialization }
PyramidSpaceZoomPlugin >> initialize [

	"| zoomText |"
	self scaleLap: 0.1.
	self currentScale: 1.
	self maxScaleValue: 3.5.

	display := BlElement new.
	display id:'zoom-plugin';
		layout:  BlFrameLayout new.
	display constraints horizontal matchParent.
	display constraints vertical matchParent.
	
	display
		padding: (BlInsets all: 2)";
		size: 0@100;
		position: 0 @ 740".
]

{ #category : #displaying }
PyramidSpaceZoomPlugin >> installOnZoomSpace [

	pyramidWheelTransformExtension elementAtEvents addEventHandler:
		(BlEventHandler
			 on: BlMouseWheelEvent
			 do: [ :evt |
				 | moveTo |
				 moveTo := nil.
				 pyramidWheelTransformExtension isOnlyCtrlKeyPressed ifTrue: [
					 moveTo := evt vector asPoint leftRotated ].
				 moveTo ifNotNil: [
					 moveTo = (5 @ 0) asPoint
						 ifTrue: [ self zoomIn ]
						 ifFalse: [ self zoomOut ] ] ]).
	pyramidWheelTransformExtension elementAtDisplaysAddons addChild:
		self display
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> maxScaleValue [

	^ maxScaleValue 
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> maxScaleValue: aScaleValue [

	maxScaleValue := aScaleValue 
]

{ #category : #'accessing - classes' }
PyramidSpaceZoomPlugin >> pluginFromPyramid: aPyramidEditor [

	| listOfSpaceExtension pyramidWheelTransformExtensionSet pyramidSelectionWidgetExtensionSet pyramidPositionExtensionSet |
	spacePlugin := aPyramidEditor findPlugin: PyramidSpacePlugin.

	listOfSpaceExtension := spacePlugin builder extensions.

	pyramidWheelTransformExtensionSet := listOfSpaceExtension select: [
		                                     :extensions |
		                                     extensions isKindOf:
			                                     PyramidWheelTransformExtension ].
	pyramidWheelTransformExtensionSet size = 1 ifFalse: [ ^ self ].

	pyramidWheelTransformExtension := pyramidWheelTransformExtensionSet
		                                  asArray first.
		
	listOfSpaceExtension := spacePlugin builder extensions.

	pyramidSelectionWidgetExtensionSet := listOfSpaceExtension select: [
		                                      :extensions |
		                                      extensions isKindOf:
			                                      PyramidSelectionWidgetExtension ].
	pyramidSelectionWidgetExtensionSet size = 1 ifFalse: [ ^ self ].

	pyramidSelectionWidgetExtension := pyramidSelectionWidgetExtensionSet
		                                   asArray first.

	pyramidPositionExtensionSet := listOfSpaceExtension select: [
		                               :extensions |
		                               extensions isKindOf:
			                               PyramidPositionExtension ].
	pyramidPositionExtensionSet size = 1 ifFalse: [ ^ self ].

	pyramidPositionExtension := pyramidPositionExtensionSet asArray first
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> refreshScaledZoom [

	scaledZoom := pyramidWheelTransformExtension elementAtMain size x
						                   * (self currentScale - 1 / 2)
						                   @
						                   (pyramidWheelTransformExtension elementAtMain size y
						                    * (self currentScale - 1 / 2)).
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> scaleLap [

	scaleLap
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> scaleLap: aValue [
	
	self defaultScale.
	scaleLap := aValue
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> scaledZoom [

	^ scaledZoom
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> space [

	^ space
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> space: aSpace [

	space := aSpace 
]

{ #category : #connecting }
PyramidSpaceZoomPlugin >> windowOpenBy: aPyramidEditor [

	pyramidWheelTransformExtension elementAtDisplaysAddons constraints horizontal matchParent.
	pyramidWheelTransformExtension elementAtDisplaysAddons constraints vertical matchParent.
	
	self space: pyramidWheelTransformExtension elementAtDisplaysAddons space.
	
	self createZoomSlider.
	
	(aPyramidEditor window services at: 'space') presenter morph update
	
	
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> zoomIn [

	self currentScale >= slider sliderMaxScale  ifTrue: [ ^ self ].

	self currentScale: self currentScale + scaleLap.
	self EditScaleDisplayElement: pyramidSelectionWidgetExtension elementAtMain.
	slider blocToMoveZoomPosition: self currentScale.
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> zoomOut [

	self currentScale <= (scaleLap + slider sliderMinScale) ifTrue: [ ^ self ].

	self currentScale: self currentScale - scaleLap.
	self EditScaleDisplayElement: pyramidSelectionWidgetExtension elementAtMain.
	slider blocToMoveZoomPosition: self currentScale.
]
