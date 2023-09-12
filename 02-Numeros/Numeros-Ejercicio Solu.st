!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:13:40'!
* aMultiplier 
	
	^aMultiplier multiplyByEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:16:04'!
+ anAdder 
	
	^anAdder addEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:19:13'!
- aSubtrahend 
	
	^aSubtrahend subtractFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:17:42'!
/ aDivisor 
	
	^aDivisor divideEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:15:47'!
addEntero: anEntero

	^self class with: (value + anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:16:37'!
addFraccion: aFraccion

	^(self * aFraccion denominator + aFraccion numerator) / aFraccion denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:17:55'!
divideEntero: anEntero

	^Fraccion with: anEntero over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:18:24'!
divideFraccion: aFraccion

	^aFraccion numerator / (aFraccion denominator * self)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:15:45'!
fibonacci

	self subclassResponsibility
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:13:58'!
multiplyByEntero: anEntero

	^self class with: (value * anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:14:50'!
multiplyByFraccion: aFraccion

	^(self * aFraccion numerator) / aFraccion denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:19:25'!
subtractFromEntero: anEntero 
	
	^self class with: (anEntero integerValue - value)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:19:56'!
subtractFromFraccion: aFraccion 

	^(aFraccion numerator - (self * aFraccion denominator)) / aFraccion denominator! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'Matias C 9/11/2023 20:37:04'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'Matias C 9/11/2023 20:39:59'!
isNegative
	
	^self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'Matias C 9/11/2023 20:40:57'!
isOne
	
	^self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'Matias C 9/11/2023 20:41:01'!
isZero
	
	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'Matias C 9/11/2023 20:39:28'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].

	aValue = 0 ifTrue: [ ^Cero new ].	
	aValue = 1 ifTrue: [ ^Uno new ].
	aValue < 0 ifTrue: [ ^EnteroNegativo new initializeWith: aValue ].
	^EnteroMayorAUno new initializeWith: aValue! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'initialization' stamp: 'Matias C 9/11/2023 21:14:31'!
initialize

	value := 0! !


!Cero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:14:04'!
/ aNumero

	^self class new! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:14:00'!
divideEntero

	self error: Numero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:14:07'!
divideFraccion

	self error: Numero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:14:10'!
fibonacci

	^Entero with: 1! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:14:13'!
makeFraccionWithNumerator: anEntero

	self error: Numero canNotDivideByZeroErrorDescription! !


!Cero methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:13:46'!
isNegative

	^false! !

!Cero methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:13:49'!
isOne

	^false! !

!Cero methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:13:52'!
isZero

	^true! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:13:32'!
isNegative

	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:13:37'!
isOne

	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:13:41'!
isZero

	^false! !


!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:14:43'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^(self - one) fibonacci + (self - two) fibonacci! !

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:14:46'!
makeFraccionWithNumerator: anEntero

	^Fraccion new initializeWith: anEntero over: self! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'testing' stamp: 'Matias C 9/11/2023 20:41:09'!
isNegative

	^true! !

!EnteroNegativo methodsFor: 'testing' stamp: 'Matias C 9/11/2023 20:41:13'!
isOne

	^false! !

!EnteroNegativo methodsFor: 'testing' stamp: 'Matias C 9/11/2023 20:41:16'!
isZero

	^false! !


!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:13:24'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription
! !

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:17:41'!
makeFraccionWithNumerator: anEntero

	^Fraccion with: anEntero negated over: self negated! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:15:08'!
divideEntero: anEntero

	^anEntero! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:15:12'!
divideFraccion: aFraccion

	^aFraccion! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:15:15'!
fibonacci

	^Entero with: 1! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 21:15:19'!
makeFraccionWithNumerator: anEntero

	^anEntero! !


!Uno methodsFor: 'initialization' stamp: 'Matias C 9/11/2023 21:15:04'!
initialize

	value := 1! !


!Uno methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:14:55'!
isNegative

	^false! !

!Uno methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:14:58'!
isOne

	^true! !

!Uno methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:15:01'!
isZero

	^false! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:15:02'!
* aMultiplier 
	
	^aMultiplier multiplyByFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:17:02'!
+ anAdder 
	
	^anAdder addFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:20:05'!
- aSubtrahend 
	
	^aSubtrahend subtractFromFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:18:35'!
/ aDivisor 
	
	^aDivisor divideFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:15:34'!
addEntero: anEntero

	^(numerator + (anEntero * denominator)) / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:17:12'!
addFraccion: aFraccion

	^((numerator * aFraccion denominator) + (aFraccion numerator * denominator)) / (denominator * aFraccion denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:18:06'!
divideEntero: anEntero

	^(anEntero * denominator) / numerator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:18:47'!
divideFraccion: aFraccion

	^(aFraccion numerator * denominator) / (aFraccion denominator * numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:14:19'!
multiplyByEntero: anEntero

	^(numerator * anEntero) / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:15:14'!
multiplyByFraccion: aFraccion

	^(numerator * aFraccion numerator) / (denominator * aFraccion denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:19:37'!
subtractFromEntero: anEntero

	^((anEntero * denominator) - numerator) / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Matias C 9/11/2023 19:20:15'!
subtractFromFraccion: aFraccion

	^((aFraccion numerator * denominator) - (numerator * aFraccion denominator)) / (denominator * aFraccion denominator)! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'Matias C 9/11/2023 21:16:54'!
isNegative
	
	^numerator isNegative! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'Matias C 9/11/2023 21:12:59'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |

	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	^denominator makeFraccionWithNumerator: numerator! !
