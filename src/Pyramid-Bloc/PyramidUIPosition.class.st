Class {
	#name : #PyramidUIPosition,
	#superclass : #Object,
	#traits : 'TPyramidPlugin',
	#classTraits : 'TPyramidPlugin classTrait',
	#instVars : [
		'spacePlugin',
		'pyramidWheelTransformExtension'
	],
	#category : #'Pyramid-Bloc-plugin-space-ui-position'
}

{ #category : #asserting }
PyramidUIPosition class >> shouldInstall [

	^ false
]

{ #category : #connecting }
PyramidUIPosition >> connectOn: aPyramidEditor [

	self pluginFromPyramid: aPyramidEditor.
]

{ #category : #initialization }
PyramidUIPosition >> initialize [ 

	"Do nothing"
]

{ #category : #'accessing - classes' }
PyramidUIPosition >> pluginFromPyramid: aPyramidEditor [

| listOfSpaceExtension pyramidWheelTransformExtensionSet |
	spacePlugin := aPyramidEditor findPlugin: PyramidSpacePlugin.

	listOfSpaceExtension := spacePlugin builder extensions.

	pyramidWheelTransformExtensionSet := listOfSpaceExtension select: [
		                                     :extensions |
		                                     extensions isKindOf:
			                                     PyramidWheelTransformExtension ].
	pyramidWheelTransformExtensionSet size = 1 ifFalse: [ ^ self ].

	pyramidWheelTransformExtension := pyramidWheelTransformExtensionSet
		                                  asArray first.
]

{ #category : #connecting }
PyramidUIPosition >> windowOpenBy: aPyramidEditor [

	| position zoomSlider defaultScaleButton aUIElement |
	aUIElement := BlElement new.
	aUIElement
		height: 1;
		zIndex: 1001;
		clipChildren: false.
	aUIElement layout: BlLinearLayout new.
	aUIElement layout horizontalAlignment:
		BlElementAlignment horizontal start.

	position := pyramidWheelTransformExtension elementAtDisplaysAddons
		            childWithId: 'position'.
	zoomSlider := pyramidWheelTransformExtension elementAtDisplaysAddons
		            childWithId: 'zoomSlider'.
	defaultScaleButton := pyramidWheelTransformExtension elementAtDisplaysAddons
		            childWithId: 'defaultScaleButton'.

	pyramidWheelTransformExtension elementAtDisplaysAddons removeChild:
		position.
	pyramidWheelTransformExtension elementAtDisplaysAddons removeChild:
		zoomSlider.
	pyramidWheelTransformExtension elementAtDisplaysAddons removeChild:
		defaultScaleButton.
		
	pyramidWheelTransformExtension elementAtDisplaysAddons constraints
		horizontal matchParent.
	pyramidWheelTransformExtension elementAtDisplaysAddons
		height: 1;
		zIndex: 1001.

	aUIElement addChild: zoomSlider.
	aUIElement addChild: defaultScaleButton.
	aUIElement addChild: position.

	pyramidWheelTransformExtension elementAtDisplaysAddons addChild:
		aUIElement.
		
	pyramidWheelTransformExtension elementAtDisplaysAddons inspect
]
