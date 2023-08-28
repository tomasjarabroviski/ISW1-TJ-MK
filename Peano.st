!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 23:19:12'!
* aNaturalNumber
	^aNaturalNumber.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 21:31:14'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:12:40'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].! !

!I class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:27:01'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/26/2023 13:27:52'!
<= aNaturalNumber
	self = aNaturalNumber ifTrue: [^true].
	^self < aNaturalNumber.
! !

!I class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 21:27:01'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 23:29:45'!
substractFrom: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/27/2023 23:23:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 23:21:13'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 21:29:45'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 23:30:14'!
- aNaturalNumber
	^aNaturalNumber substractFrom: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:08'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:26:41'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:29:07'!
<= aNaturalNumber
	self = aNaturalNumber ifTrue: [^true].
	^self < aNaturalNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 21:29:45'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 21:29:45'!
previous
	^previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 21:29:45'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/24/2023 23:29:26'!
substractFrom: aNaturalNumber
	^((self previous) substractFrom: aNaturalNumber previous).! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/27/2023 23:23:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
- aNaturalNumber
	^aNaturalNumber substractFrom: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
<= aNaturalNumber
	self = aNaturalNumber ifTrue: [^true].
	^self < aNaturalNumber.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
previous
	^previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
substractFrom: aNaturalNumber
	^((self previous) substractFrom: aNaturalNumber previous).! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/27/2023 23:23:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
- aNaturalNumber
	^aNaturalNumber substractFrom: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
<= aNaturalNumber
	self = aNaturalNumber ifTrue: [^true].
	^self < aNaturalNumber.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
previous
	^previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Matias C 8/25/2023 12:34:26'!
substractFrom: aNaturalNumber
	^((self previous) substractFrom: aNaturalNumber previous).! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/27/2023 23:23:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!