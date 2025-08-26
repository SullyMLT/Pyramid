Class {
	#name : #PyramidEditNavigationTreePlugin,
	#superclass : #Object,
	#traits : 'TPyramidPlugin',
	#classTraits : 'TPyramidPlugin classTrait',
	#instVars : [
		'navigationPlugin',
		'libraryPre'
	],
	#category : #'Pyramid-Bloc-plugin-edit-navigation'
}

{ #category : #connecting }
PyramidEditNavigationTreePlugin >> connectOn: aPyramidEditor [

	self pluginFromPyramid: aPyramidEditor.
	
	self installOnAddChildList.
	
	libraryPre libraryController initializeCategories.
	
	
	
	
]

{ #category : #'as yet unclassified' }
PyramidEditNavigationTreePlugin >> installOnAddChildList [
		
	| elementPre categoryPre |
	
	elementPre := SpFilteringListPresenter new
		                    display: [ :class | class name ];
		                    displayIcon: [ :each | each icon ].
	elementPre whenSelectionChangedDo: [ :e |
		| index element |
		index := e selectedIndex.
		index <= 0 ifFalse: [
			element := elementPre items at: index.
			libraryPre addButtonPresenter enabled: element isNotNil.
			libraryPre addButtonPresenter action: [
				libraryPre libraryController addNewElement: element ].
			element
				ifNil: [ libraryPre imagePresenter image: (Form extent: 1 asPoint) ]
				ifNotNil: [ libraryPre imagePresenter image: element asForm ] ] ].
	
	categoryPre := SpFilteringListPresenter new
		                    display: [ :class | class name ];
		                    displayIcon: [ :each | each icon ].
	categoryPre whenSelectionChangedDo: [ :category | | index elements |
		index := category selectedIndex.
		
		index <= 0 ifFalse: [
			elements := (categoryPre items at: index).
			elementPre items: elements elements ] ].

	libraryPre categoryPresenter: categoryPre.
	libraryPre elementPresenter: elementPre.
]

{ #category : #'accessing - classes' }
PyramidEditNavigationTreePlugin >> pluginFromPyramid: aPyramidEditor [

	| listOfPlugins pluginSorted |
	listOfPlugins := aPyramidEditor plugins.
	pluginSorted := listOfPlugins select: [ :extensions | extensions isKindOf: PyramidNavigationPlugin ].
	pluginSorted size = 1
	ifFalse: [^ self].
	navigationPlugin := pluginSorted asArray first.
	
	libraryPre := navigationPlugin navigation library
]
