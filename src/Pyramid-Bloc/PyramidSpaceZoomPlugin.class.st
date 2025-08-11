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
		'currentScaleFactor',
		'pyramidWheelTransformExtension',
		'display',
		'pyramidSelectionWidgetExtension',
		'scaleLap',
		'spacePlugin',
		'pyramidPositionExtension',
		'slider',
		'scaledZoom',
		'maxScaleValue'
	],
	#category : #'Pyramid-Bloc-plugin-space-zoom-move'
}

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> EditScaleDisplayElement: aBlElement [
	
	pyramidSelectionWidgetExtension scaleFactor: self currentScaleFactor.
	pyramidPositionExtension scaleFactor: self currentScaleFactor.
	
	self refreshScaledZoom.

	aBlElement transformDo: [ :t | t scaleBy: self currentScaleFactor.
											t translateBy: self scaledZoom ].
										
	slider blocToMoveZoomPosition: self currentScaleFactor.
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> EditScaleDisplayElement: aBlElement scaleValue: aValue [
	
	self currentScaleFactor: aValue.
	pyramidSelectionWidgetExtension scaleFactor: self currentScaleFactor.
	pyramidPositionExtension scaleFactor: self currentScaleFactor.
	
	self refreshScaledZoom.

	aBlElement transformDo: [ :t | t scaleBy: self currentScaleFactor.
											t translateBy: self scaledZoom ].
										
	slider blocToMoveZoomPosition: self currentScaleFactor.
]

{ #category : #connecting }
PyramidSpaceZoomPlugin >> connectOn: aPyramidEditor [

	self pluginFromPyramid: aPyramidEditor.
	
	pyramidSelectionWidgetExtension ifNil: [ ^ self ].
	
	pyramidSelectionWidgetExtension scaleFactor: self currentScaleFactor.
	
	self installOnZoomSpace
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> createZoomSlider [

	slider := PyramidZoomSlider new.
	slider whenValueChangedDo: [ :scaleValue | 
		self EditScaleDisplayElement: pyramidSelectionWidgetExtension elementAtMain scaleValue: scaleValue ].
	
	slider scaledZoomValue: self maxScaleValue.
	scaleLap := slider sliderLapScale.
	
	^ slider createSlider.
	
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> currentScaleFactor [

	^ currentScaleFactor
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> currentScaleFactor: aValue [

	currentScaleFactor := aValue.
]

{ #category : #accessing }
PyramidSpaceZoomPlugin >> defaultScale [

	self currentScaleFactor: 1.
	pyramidSelectionWidgetExtension ifNotNil: [
		self EditScaleDisplayElement: pyramidSelectionWidgetExtension elementAtMain scaleValue: 1 ]
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> defaultScaleButton [ 
	
	| button image |
	
	image := (BlElement new
         constraintsDo: [:constraints |  constraints horizontal exact: 16.0.
            constraints vertical exact: 16.0.
            constraints frame horizontal alignCenter.
            constraints frame vertical alignCenter ];
         background: (BlImageBackground new
               image: (PyramidExternalRessourceProxy new
                     pyramidExternalRessourceSource: (PyramidExternalRessourceSource new
                           target: Object;
                           selector: #iconNamed:;
                           arguments: {#smallFullscreen};
                           yourself);
                     yourself);
               opacity: 1.0;
               yourself)).

	button := BlElement new
   constraintsDo: [:constraints |  constraints horizontal exact: 20.0.
      constraints vertical exact: 20.0 ];
   background: (BlPaintBackground new
         paint: (BlColorPaint new
               color: (Color r: 1.0 g: 1.0 b: 1.0 alpha: 1.0);
               yourself);
         opacity: 1.0;
         yourself);
	border: Color black;
   layout: BlFrameLayout new;
   id: #defaultScaleButton;
	addEventHandler: (BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt | 
				self defaultScale.
				evt consumed: true ]).

	button addChild: image.
	
	^ button
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

	self scaleLap: 0.1.
	self currentScaleFactor: 1.
	self maxScaleValue: 10.0.
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

	| listOfSpaceExtension pyramidWheelTransformExtensionSet  pyramidSelectionWidgetExtensionSet pyramidPositionExtensionSet listOfPlugins pluginSorted |
	
	listOfPlugins := aPyramidEditor plugins.
	pluginSorted := listOfPlugins select: [ :extensions | extensions isKindOf: PyramidSpacePlugin ].
	pluginSorted size = 1
	ifFalse: [^ self].
	spacePlugin := pluginSorted asArray first.

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

	scaledZoom := pyramidWheelTransformExtension elementAtMain extent x
	              * (self currentScaleFactor - 1 / 2)
	              @
		              (pyramidWheelTransformExtension elementAtMain extent y
		               * (self currentScaleFactor - 1 / 2))
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

{ #category : #connecting }
PyramidSpaceZoomPlugin >> windowOpenBy: aPyramidEditor [

	| position aUIElement |
	aUIElement := BlElement new.
	aUIElement
		id: 'UI';
		height: 1;
		zIndex: 1001;
		clipChildren: false.
	aUIElement layout: BlLinearLayout new.
	aUIElement layout horizontalAlignment:
		BlElementAlignment horizontal start.
		
	pyramidWheelTransformExtension ifNil: [ ^ self ].

	position := pyramidWheelTransformExtension elementAtDisplaysAddons
		            childWithId: 'position'.

	pyramidWheelTransformExtension elementAtDisplaysAddons removeChild:
		position.
		
	pyramidWheelTransformExtension elementAtDisplaysAddons constraints
		horizontal matchParent.
	pyramidWheelTransformExtension elementAtDisplaysAddons
		height: 1;
		zIndex: 1001.

	aUIElement addChild: self createZoomSlider.
	aUIElement addChild: self defaultScaleButton.
	aUIElement addChild: position.

	pyramidWheelTransformExtension elementAtDisplaysAddons addChild:
		aUIElement
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> zoomIn [

	self currentScaleFactor >= (slider sliderMaxScale-0.05)  ifTrue: [ ^ self ].

	self currentScaleFactor: self currentScaleFactor + scaleLap.
	self EditScaleDisplayElement: pyramidSelectionWidgetExtension elementAtMain
]

{ #category : #'as yet unclassified' }
PyramidSpaceZoomPlugin >> zoomOut [

	self currentScaleFactor <= (scaleLap + slider sliderMinScale) ifTrue: [ ^ self ].

	self currentScaleFactor: self currentScaleFactor - scaleLap.
	self EditScaleDisplayElement: pyramidSelectionWidgetExtension elementAtMain
]
