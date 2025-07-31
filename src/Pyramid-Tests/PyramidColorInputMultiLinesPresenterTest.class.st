Class {
	#name : #PyramidColorInputMultiLinesPresenterTest,
	#superclass : #TestCase,
	#traits : 'TPyramidInputPresenterTest',
	#classTraits : 'TPyramidInputPresenterTest classTrait',
	#category : #'Pyramid-Tests-cases-specs-custom'
}

{ #category : #accessing }
PyramidColorInputMultiLinesPresenterTest >> dummyValues [

	^ {
		  Color black.
		  Color red.
		  Color transparent.
		 Color red translucent }
]

{ #category : #accessing }
PyramidColorInputMultiLinesPresenterTest >> expectedEmptyValue [

	^ Color black alpha: 0
]

{ #category : #accessing }
PyramidColorInputMultiLinesPresenterTest >> expectedMixedValues [

	^ Color black alpha: 0
]

{ #category : #tests }
PyramidColorInputMultiLinesPresenterTest >> makeNewInput [

	^ PyramidColorInputMultiLinesPresenter new
]

{ #category : #'as yet unclassified' }
PyramidColorInputMultiLinesPresenterTest >> triggerValueChangedOf: anInput [
	"Pharo 12"
	anInput hexaInput hexInput textInput contextKeyBindings keymaps do: [ :bind |
		bind action value ].
	"Pharo 13 - nouvelle méthode du déclenchement de whenSubmitDo -> ne fonctionne pas sur pharo 12
	 car en pharo 12 c'est [ self showContextMenu ] dans l'action tandis que dans pharo 13 c'est [ aBlock value:
	 self text ] ce qui déclenche whenSubmitDo comme pour l'action précédente juste au dessus en pharo 12 "
	anInput hexaInput hexInput textInput ensureInternalActions
		decoratedGroup entries do: [ :bind | bind execute ]
]
