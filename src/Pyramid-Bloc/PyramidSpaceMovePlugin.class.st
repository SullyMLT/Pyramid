"
This class is used for moving the view with CTRL + PrimaryMouseDown and movement on the workspace.
"
Class {
	#name : #PyramidSpaceMovePlugin,
	#superclass : #Object,
	#traits : 'TPyramidPlugin',
	#classTraits : 'TPyramidPlugin classTrait',
	#instVars : [
		'currentScale',
		'positionOrigin',
		'currentTranslation',
		'moveEvent',
		'pyramidWheelTransformExtension',
		'spacePlugin',
		'space',
		'OriginMovement',
		'defaultPositionButton',
		'editor'
	],
	#category : #'Pyramid-Bloc-plugin-space-zoom-move'
}

{ #category : #connecting }
PyramidSpaceMovePlugin >> connectOn: aPyramidEditor [

	self pluginFromPyramid: aPyramidEditor.
	
	self editor: aPyramidEditor.

	self installOnMoveSpace.
	
	"pyramidWheelTransformExtension elementAtDisplaysAddons zIndex: 1001."
]

{ #category : #accessing }
PyramidSpaceMovePlugin >> currentTranslation [

	^ currentTranslation
]

{ #category : #accessing }
PyramidSpaceMovePlugin >> currentTranslation: aPosition [

	currentTranslation := aPosition.
]

{ #category : #'as yet unclassified' }
PyramidSpaceMovePlugin >> defaultViewPosition [

	pyramidWheelTransformExtension elementAtTransforms transformDo: [ :t | 
				t translateBy: (50@50 - pyramidWheelTransformExtension elementAtTransforms position) ]
]

{ #category : #accessing }
PyramidSpaceMovePlugin >> editor [

	^ editor
]

{ #category : #accessing }
PyramidSpaceMovePlugin >> editor: aPyramidEditor [

	editor := aPyramidEditor 
]

{ #category : #initialization }
PyramidSpaceMovePlugin >> initialize [

	moveEvent := self moveSpaceEventRight.
	defaultPositionButton := ToButton new
			                 icon: (ToImage new innerImage: (self iconNamed: #smallFullscreen));
			                 clickAction: [ self defaultViewPosition ];
			                 yourself.
	defaultPositionButton zIndex: 1.
]

{ #category : #displaying }
PyramidSpaceMovePlugin >> installOnMoveSpace [

	pyramidWheelTransformExtension elementAtMain addEventHandler:
		(BlEventHandler
			 on: BlPrimaryMouseDownEvent "BlMiddleMouseDownEvent"
			 do: [ :evt |
				 | moveTo |
				 moveTo := nil.
				 pyramidWheelTransformExtension isOnlyCtrlKeyPressed ifTrue: [
					 moveTo := evt position ].
				 moveTo ifNotNil: [
					"self inform: 'salut'.
					(self editor window services at: 'space') presenter morph removeHalo."
					 self positionOrigin: evt position
						 - pyramidWheelTransformExtension currentTransformTranslation.
					 pyramidWheelTransformExtension elementAtMain addEventHandler:
						 moveEvent.
					 evt consumed: true ] ]) 
	
]

{ #category : #'as yet unclassified' }
PyramidSpaceMovePlugin >> moveSpaceEventRight [

	^ BlEventHandler
		  on: BlMouseMoveEvent
		  do: [ :evt |
			  evt primaryButtonPressed ifFalse: [
				  pyramidWheelTransformExtension elementAtMain
					  removeEventHandler: moveEvent ].
				
			  pyramidWheelTransformExtension isOnlyCtrlKeyPressed ifTrue: [
				  self currentTranslation: evt position - self positionOrigin.
				  pyramidWheelTransformExtension elementAtTransforms transformDo: [
					  :t | t translateBy: self currentTranslation ].
				  evt consumed: true ] ]
]

{ #category : #'accessing - classes' }
PyramidSpaceMovePlugin >> pluginFromPyramid: aPyramidEditor [

	| listOfSpaceExtension pyramidWheelTransformExtensionSet |
	spacePlugin := aPyramidEditor findPlugin: PyramidSpacePlugin.

	self space: spacePlugin builder space.

	listOfSpaceExtension := spacePlugin builder extensions.

	pyramidWheelTransformExtensionSet := listOfSpaceExtension select: [
		                                     :extensions |
		                                     extensions isKindOf:
			                                     PyramidWheelTransformExtension ].
	pyramidWheelTransformExtensionSet size = 1 ifFalse: [ ^ self ].

	pyramidWheelTransformExtension := pyramidWheelTransformExtensionSet
		                                  asArray first
]

{ #category : #accessing }
PyramidSpaceMovePlugin >> positionOrigin [

	^ positionOrigin
]

{ #category : #accessing }
PyramidSpaceMovePlugin >> positionOrigin: aPosition [

	positionOrigin := aPosition.
]

{ #category : #accessing }
PyramidSpaceMovePlugin >> space [ 

	^ space
]

{ #category : #accessing }
PyramidSpaceMovePlugin >> space: aSpace [

	space := aSpace
]
