Class {
	#name : #PyramidPositionExtension,
	#superclass : #Object,
	#traits : 'TPyramidSpaceExtension + TPyramidEditorExtension',
	#classTraits : 'TPyramidSpaceExtension classTrait + TPyramidEditorExtension classTrait',
	#instVars : [
		'display',
		'scaleFactor'
	],
	#category : #'Pyramid-Bloc-plugin-space-extensions'
}

{ #category : #accessing }
PyramidPositionExtension >> display [

	^ display.
]

{ #category : #initialization }
PyramidPositionExtension >> initialize [

	scaleFactor := 1.
	display := (0 @ 0) asRopedText asElement.
	display
		id: 'position';
		background: Color white;
		zIndex: 1;
		padding: (BlInsets all: 3)
]

{ #category : #displaying }
PyramidPositionExtension >> installOn: aBuilder [

	self builder: aBuilder.

	self elementAtEvents addEventHandler: (BlEventHandler
			 on: BlMouseMoveEvent
			 do: [ :evt |
				 self display text:
					 (evt position - self currentTransformTranslation / scaleFactor) rounded asRopedText ]).
	self elementAtDisplaysAddons addChild: self display
]

{ #category : #accessing }
PyramidPositionExtension >> scaleFactor [

	^ scaleFactor
]

{ #category : #accessing }
PyramidPositionExtension >> scaleFactor: aScale [
	
	scaleFactor := aScale
]
