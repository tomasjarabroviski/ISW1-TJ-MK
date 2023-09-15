!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinderByPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'Matias C 9/14/2023 20:14:58'!
setUp
	sentenceFinderByPrefix := SentenceFinderByPrefix new! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Matias C 9/14/2023 20:45:18'!
test01emptyStringIsNotPrefix
	| stack |
	stack := OOStack new.
	self
		should: [ sentenceFinderByPrefix findPrefix: '' inStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixStringErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Matias C 9/14/2023 20:45:46'!
test02stringWithWhitespaceIsNotPrefix
	| stack |
	stack := OOStack new.
	self
		should: [ sentenceFinderByPrefix findPrefix: 'A string with whitespace' inStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixStringHasWhitespaceErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Matias C 9/14/2023 21:52:28'!
test03stackIsNotModifiedBySearch
	| stack sentences |
	stack := OOStack new.
	sentences := #('Winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here').
	sentences do: [:sentence | stack push: sentence ].

	sentenceFinderByPrefix findPrefix: 'Wint' inStack: stack.	

	self assert: ((sentences reversed) allSatisfy: [:sentence | sentence = stack pop ]).
	self assert: stack isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Matias C 9/14/2023 21:25:30'!
test04findsSingleElementCaseSensitive
	| stack sentences findResult |
	stack := OOStack new.
	sentences := #('winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here' 'winter is here').
	sentences do: [:sentence | stack push: sentence ].

	findResult := sentenceFinderByPrefix findPrefix: 'Wint' inStack: stack.
	self assert: [ findResult at: 1 = 'Winter is here' ].
	self assert: [ findResult size = 1 ]. ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Matias C 9/14/2023 21:24:20'!
test05findsMultipleElements
	| stack sentences findResult |
	stack := OOStack new.
	sentences := #('Winter is coming' 'winning is everything' 'winter is here' 'Winter is here' 'Winter ').
	sentences do: [:sentence | stack push: sentence ].
	findResult := sentenceFinderByPrefix findPrefix: 'Wint' inStack: stack.
	self assert: (sentences at: 1) = (findResult at: 1).	
	self assert: (sentences at: 4) = (findResult at: 2).	
	self assert: (sentences at: 5) = (findResult at: 3).
	self assert: findResult size = 3! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size topNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'Matias C 9/14/2023 18:19:06'!
pop
	| popedElement |
	popedElement := topNode element.
	topNode := topNode previous.
	size := size - 1.
	^popedElement! !

!OOStack methodsFor: 'operations' stamp: 'Matias C 9/14/2023 18:26:17'!
push: anElement
	topNode := OOStackElementNode new initializeWithElement: anElement andPrevious: topNode.
	size := size + 1! !


!OOStack methodsFor: 'accessing' stamp: 'Matias C 9/14/2023 18:13:44'!
size
	^size! !

!OOStack methodsFor: 'accessing' stamp: 'Matias C 9/14/2023 18:13:36'!
top
	^topNode element! !


!OOStack methodsFor: 'initialization' stamp: 'Matias C 9/14/2023 18:16:44'!
initialize
	size := 0.
	topNode := OOStackNullNode new! !


!OOStack methodsFor: 'testing' stamp: 'Matias C 9/14/2023 18:20:06'!
isEmpty
	^size = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackNode category: 'Stack-Exercise'!
Object subclass: #OOStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'accessing' stamp: 'Matias C 9/14/2023 18:05:12'!
element
	self subclassResponsibility! !

!OOStackNode methodsFor: 'accessing' stamp: 'Matias C 9/14/2023 18:04:46'!
previous
	self subclassResponsibility! !


!classDefinition: #OOStackElementNode category: 'Stack-Exercise'!
OOStackNode subclass: #OOStackElementNode
	instanceVariableNames: 'previous element'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementNode methodsFor: 'initialization' stamp: 'Matias C 9/14/2023 18:15:22'!
initializeWithElement: anElement andPrevious: aStackNode
	element := anElement.
	previous := aStackNode! !


!OOStackElementNode methodsFor: 'accessing' stamp: 'Matias C 9/14/2023 18:06:34'!
element
	^element! !

!OOStackElementNode methodsFor: 'accessing' stamp: 'Matias C 9/14/2023 18:06:58'!
previous
	^previous! !


!classDefinition: #OOStackNullNode category: 'Stack-Exercise'!
OOStackNode subclass: #OOStackNullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNullNode methodsFor: 'accessing' stamp: 'Matias C 9/14/2023 18:09:03'!
element
	^self error: OOStack stackEmptyErrorDescription ! !

!OOStackNullNode methodsFor: 'accessing' stamp: 'Matias C 9/14/2023 20:09:07'!
previous
	^self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #Prefix category: 'Stack-Exercise'!
Object subclass: #Prefix
	instanceVariableNames: 'prefixString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Prefix methodsFor: 'comparing' stamp: 'Matias C 9/14/2023 21:49:23'!
isPrefixOf: aString
	^(1 to: prefixString size) allSatisfy: [
		:index | (aString at: index) = (prefixString at: index)
	]! !


!Prefix methodsFor: 'initialization' stamp: 'Matias C 9/14/2023 20:33:26'!
initializeWith: aString
	prefixString := aString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prefix class' category: 'Stack-Exercise'!
Prefix class
	instanceVariableNames: ''!

!Prefix class methodsFor: 'instance creation' stamp: 'Matias C 9/14/2023 20:54:55'!
with: aString
	aString isEmpty ifTrue: [ self error: SentenceFinderByPrefix emptyPrefixStringErrorDescription ].
	(aString findString: ' ') ifNotZero: [ self error: SentenceFinderByPrefix prefixStringHasWhitespaceErrorDescription ].

	^self new initializeWith: aString! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'Matias C 9/15/2023 12:27:01'!
findPrefix: aPrefixString inStack: aStackToSearch
	| prefix popedElements sentencesWithPrefix stackSize |
	prefix := Prefix with: aPrefixString.
	popedElements := OrderedCollection new.
	sentencesWithPrefix := OrderedCollection new.

	stackSize := aStackToSearch size.
	1 to: stackSize do: [
		| popedElement |
		popedElement :=		aStackToSearch pop.	
		popedElements addFirst: popedElement.
		(prefix isPrefixOf: popedElement) ifTrue: [ sentencesWithPrefix addLast: popedElement ].
	].

	popedElements do: [:element | aStackToSearch push: element]

	^sentencesWithPrefix ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'Matias C 9/14/2023 20:31:27'!
emptyPrefixStringErrorDescription
	^'A prefix can''t be an empty String'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'Matias C 9/14/2023 20:32:05'!
prefixStringHasWhitespaceErrorDescription
	^'A prefix can''t have whitespace'! !
