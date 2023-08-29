!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'axioms' stamp: 'Matias C 8/24/2023 23:19:12'!
* aNaturalNumber
	^aNaturalNumber.! !

!I class methodsFor: 'axioms' stamp: 'Matias C 8/24/2023 21:31:14'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'axioms' stamp: 'Matias C 8/25/2023 12:12:40'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].! !

!I class methodsFor: 'axioms' stamp: 'Matias C 8/25/2023 12:27:01'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^true.! !

!I class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:35:22'!
next
	^II.! !

!I class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:35:59'!
substractTo: aNaturalNumber
	^aNaturalNumber previous.! !


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

!II class methodsFor: 'axioms' stamp: 'Matias C 8/24/2023 23:21:13'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!II class methodsFor: 'axioms' stamp: 'Matias C 8/24/2023 21:29:45'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:36:27'!
- aNaturalNumber
	^aNaturalNumber substractTo: self.! !

!II class methodsFor: 'axioms' stamp: 'Matias C 8/25/2023 12:34:08'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!II class methodsFor: 'axioms' stamp: 'Matias C 8/25/2023 12:26:41'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !

!II class methodsFor: 'axioms' stamp: 'Matias C 8/24/2023 21:29:45'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'axioms' stamp: 'Matias C 8/24/2023 21:29:45'!
previous
	^previous.! !

!II class methodsFor: 'axioms' stamp: 'Matias C 8/24/2023 21:29:45'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!II class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:38:30'!
substractTo: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/28/2023 21:09:03'!
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

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
- aNaturalNumber
	^aNaturalNumber substractTo: self.! !

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
previous
	^previous.! !

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!III class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:19'!
substractTo: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/28/2023 21:09:03'!
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

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
- aNaturalNumber
	^aNaturalNumber substractTo: self.! !

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
previous
	^previous.! !

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!IIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
substractTo: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/28/2023 21:09:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Peano'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Peano'!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
- aNaturalNumber
	^aNaturalNumber substractTo: self.! !

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
previous
	^previous.! !

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!IIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
substractTo: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/28/2023 21:09:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Peano'!
DenotativeObject subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Peano'!
IIIIII class
	instanceVariableNames: 'next previous'!

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
- aNaturalNumber
	^aNaturalNumber substractTo: self.! !

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.! !

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
previous
	^previous.! !

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!IIIIII class methodsFor: 'axioms' stamp: 'Matias C 8/28/2023 20:39:40'!
substractTo: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/28/2023 21:09:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!