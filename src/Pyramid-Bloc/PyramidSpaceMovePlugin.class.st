"
This class is used for moving the view with CTRL + PrimaryMouseDown and movement on the workspace.
"
Class {
	#name : #PyramidSpaceMovePlugin,
	#superclass : #Object,
	#traits : 'TPyramidPlugin',
	#classTraits : 'TPyramidPlugin classTrait',
	#instVars : [
		'positionOrigin',
		'currentTranslation',
		'moveEvent',
		'pyramidWheelTransformExtension'
	],
	#category : #'Pyramid-Bloc-plugin-space-zoom-move'
}

{ #category : #connecting }
PyramidSpaceMovePlugin >> connectOn: aPyramidEditor [

	self pluginFromPyramid: aPyramidEditor.

	self installOnMoveSpace
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

{ #category : #'as yet unclassified' }
PyramidSpaceMovePlugin >> defaultViewPositionButton [

	| button elementButton |
	button := ToButton new
		  icon: (ToImage new innerImage: (self iconNamed: #haloDrag));
		  clickAction: [ self defaultViewPosition ];
		  yourself.
		
	elementButton := (BlElement new id:'defaultViewPositionButton') 
							clipChildren: false;
							position: 0@35;
							size: 10@10.		
	elementButton addChild: button.
	
	^ elementButton
]

{ #category : #initialization }
PyramidSpaceMovePlugin >> initialize [

	moveEvent := self moveSpaceEvent
]

{ #category : #displaying }
PyramidSpaceMovePlugin >> installOnMoveSpace [

	pyramidWheelTransformExtension elementAtMain addEventHandler:
		(BlEventHandler
			 on: BlPrimaryMouseDownEvent
			 do: [ :evt |
				 | moveTo |
				 moveTo := nil.
				 pyramidWheelTransformExtension isOnlyCtrlKeyPressed ifTrue: [
					 moveTo := evt position ].
				 moveTo ifNotNil: [
					 self positionOrigin: evt position
						 - pyramidWheelTransformExtension currentTransformTranslation.
					 pyramidWheelTransformExtension elementAtMain addEventHandler:
						 moveEvent.
					 evt consumed: true ] ]) 
	
]

{ #category : #'as yet unclassified' }
PyramidSpaceMovePlugin >> moveSpaceEvent [

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

	| spacePlugin listOfSpaceExtension pyramidWheelTransformExtensionSet |
	spacePlugin := aPyramidEditor findPlugin: PyramidSpacePlugin.

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

{ #category : #connecting }
PyramidSpaceMovePlugin >> windowOpenBy: aPyramidEditor [
	
	pyramidWheelTransformExtension elementAtDisplaysAddons zIndex: 1001.
	
	pyramidWheelTransformExtension elementAtDisplaysAddons addChild: self defaultViewPositionButton
]
