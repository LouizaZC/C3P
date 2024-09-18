"
a class that holds countries
import the country list and act as a mini database for the future functionalities we want to implement (such as a
fag browser).
"
Class {
	#name : 'EarthMap',
	#superclass : 'Object',
	#instVars : [
		'countries'
	],
	#category : 'EarthTutorial',
	#package : 'EarthTutorial'
}

{ #category : 'accessing' }
EarthMap >> countries [ 
	^ countries 
]

{ #category : 'accessing' }
EarthMap >> countries: aString [
	countries := aString 
]

{ #category : 'as yet unclassified' }
EarthMap >> importCountriesFrom: aFilePath [
    | xmlTree |
    "Step 1: Parse the XML file and get the XML tree"
    xmlTree := self xmlTreeFromFile: aFilePath.
    
    "Step 2: Traverse the XML tree and import each country"
    xmlTree elements do: [ :eachElement |
        (eachElement name = 'country') ifTrue: [
            self importCountryFromXMLNode: eachElement
        ]].
]

{ #category : 'as yet unclassified' }
EarthMap >> importCountryFromXMLNode: aXMLElement [
	countries add: (EarthMapCountry new fromXML: aXMLElement)
]

{ #category : 'initialization' }
EarthMap >> initialize [
	super initialize.
	countries := OrderedCollection new
]

{ #category : 'as yet unclassified' }
EarthMap >> openPopulatedCanvas [
	self populatedCanvas open
]

{ #category : 'as yet unclassified' }
EarthMap >> populatedCanvas [
	^ RSCanvas new
		addAll: (countries collect: [ :country | country asRSShape ]);
		@ RSCanvasController;
		yourself
]

{ #category : 'as yet unclassified' }
EarthMap >> xmlTreeFromFile: aFileName [
	^ aFileName asFileReference readStreamDo: [ :stream |(XMLDOMParser parse: stream) document ]

]
