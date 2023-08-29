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

!I class methodsFor: 'operaciones' stamp: 'Matias C 8/24/2023 23:19:12'!
* aNaturalNumber
	^aNaturalNumber.! !

!I class methodsFor: 'operaciones' stamp: 'Matias C 8/24/2023 21:31:14'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'operaciones' stamp: 'Matias C 8/28/2023 21:43:41'!
- aNaturalNumber
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'operaciones' stamp: 'Matias C 8/28/2023 21:45:15'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'operaciones' stamp: 'Matias C 8/28/2023 20:35:59'!
substractTo: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: 'comparaciones' stamp: 'Matias C 8/25/2023 12:27:01'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^true.! !


!I class methodsFor: 'errores' stamp: 'Matias C 8/28/2023 21:45:03'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'Error en operación: no se puede dividir por un número mayor'.! !

!I class methodsFor: 'errores' stamp: 'Matias C 8/28/2023 21:42:04'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Operación no soportada: número negativo'.! !


!I class methodsFor: 'axiomas' stamp: 'Matias C 8/28/2023 20:35:22'!
next
	^II.! !


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

!II class methodsFor: 'errores' stamp: 'Matias C 8/28/2023 21:47:38'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'Error en operación: no se puede dividir por un número mayor'.! !


!II class methodsFor: 'comparaciones' stamp: 'Matias C 8/25/2023 12:26:41'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !


!II class methodsFor: 'operaciones' stamp: 'Matias C 8/24/2023 23:21:13'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber.! !

!II class methodsFor: 'operaciones' stamp: 'Matias C 8/24/2023 21:29:45'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'operaciones' stamp: 'Matias C 8/28/2023 20:36:27'!
- aNaturalNumber
	^aNaturalNumber substractTo: self.! !

!II class methodsFor: 'operaciones' stamp: 'Matias C 8/28/2023 21:48:26'!
/ aNaturalNumber
	self < aNaturalNumber ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber) < aNaturalNumber		ifTrue: [^I].
	^I + ((self - aNaturalNumber) / aNaturalNumber).! !

!II class methodsFor: 'operaciones' stamp: 'Matias C 8/28/2023 20:38:30'!
substractTo: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!II class methodsFor: 'axiomas' stamp: 'Matias C 8/28/2023 21:12:22'!
next
	next ifNotNil: [^next].
	next := II createChildNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'axiomas' stamp: 'Matias C 8/24/2023 21:29:45'!
previous
	^previous.! !

!II class methodsFor: 'axiomas' stamp: 'Matias C 8/24/2023 21:29:45'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/28/2023 21:54:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/28/2023 21:54:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Matias C 8/28/2023 21:54:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!