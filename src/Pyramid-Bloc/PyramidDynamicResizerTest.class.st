Class {
	#name : #PyramidDynamicResizerTest,
	#superclass : #Object,
	#category : #'Pyramid-Bloc-plugin-space-extensions'
}

{ #category : #'as yet unclassified' }
PyramidDynamicResizerTest >> createBlocDynamicResizer [

	| test resizer space |
	
	space := BlSpace new.
	space extent: 600@600.
	test := BlElement new.
	test position: 20@20;
	size: 100@100;
	background: Color blue.
	
	space root addChild: test.
	
	resizer := PyramidDynamicResizer new.
	
	resizer dynamicResizer: test originElement: test.
	
	
	
	space show 


]
