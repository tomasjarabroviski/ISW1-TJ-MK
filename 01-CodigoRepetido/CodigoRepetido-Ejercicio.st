!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'time limit assertion' stamp: 'Matias C 9/4/2023 21:23:48'!
closure: aClosure shouldNotTakeMoreThan: aDuration
	self assert: (Time millisecondsToRun: aClosure) * millisecond < aDuration.! !


!CustomerBookTest methodsFor: 'error assertion' stamp: 'Matias C 9/5/2023 22:20:55'!
closure: aClosure shouldFailWithError: anError thenDo: perErrorClosure

  [ aClosure value.
  self fail ]
    on: anError
    do: perErrorClosure 
! !


!CustomerBookTest methodsFor: 'customer book assertion' stamp: 'Matias C 9/5/2023 22:35:42'!
assertCustomerBook: aCustomerBook hasAnActiveAmmountOf: anAmmountOfActive andASuspendedAmmountOf: anAmmountOfSuspended

	self assert: anAmmountOfActive equals: aCustomerBook numberOfActiveCustomers.
	self assert: anAmmountOfSuspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: (anAmmountOfActive + anAmmountOfSuspended) equals: aCustomerBook numberOfCustomers.
	
! !

!CustomerBookTest methodsFor: 'customer book assertion' stamp: 'Matias C 9/5/2023 22:33:06'!
assertCustomerBook: aCustomerBook onlyHas: aName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aName)
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'Matias C 9/4/2023 21:14:38'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	self closure: [customerBook addCustomerNamed: 'John Lennon'] shouldNotTakeMoreThan: 50 * millisecond.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias C 9/4/2023 21:16:56'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self closure: [customerBook removeCustomerNamed: paulMcCartney] shouldNotTakeMoreThan: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias C 9/5/2023 22:21:06'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self closure: [ customerBook addCustomerNamed: ''. ] 
		 shouldFailWithError: Error
		 thenDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty.
		 ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias C 9/5/2023 22:33:06'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self closure: [ customerBook removeCustomerNamed: 'Paul McCartney'.] 
		 shouldFailWithError: NotFound
		 thenDo: [ :anError | 
			self assertCustomerBook: customerBook onlyHas: johnLennon.
		 ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias C 9/5/2023 22:35:10'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook
		 hasAnActiveAmmountOf: 0
		 andASuspendedAmmountOf: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias C 9/5/2023 22:35:10'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook
		 hasAnActiveAmmountOf: 0
		 andASuspendedAmmountOf: 0.
		
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias C 9/5/2023 22:34:17'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self closure: [ customerBook suspendCustomerNamed: 'George Harrison'. ]
		 shouldFailWithError: CantSuspend
		 thenDo: [ :anError | 
			self assertCustomerBook: customerBook onlyHas: johnLennon.
		 ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias C 9/5/2023 22:34:31'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self closure: [ customerBook suspendCustomerNamed: johnLennon. ]
		shouldFailWithError: CantSuspend 
		thenDo: [ :anError | 
			self assertCustomerBook: customerBook onlyHas: johnLennon.
		]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'Matias C 9/4/2023 20:50:12'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Matias C 9/4/2023 20:47:27'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Matias C 9/5/2023 11:13:13'!
removeCustomerNamed: aName

	self orderedCollection: active remove: aName ifAbsent: [
		self orderedCollection: suspended remove: aName ifAbsent: [^NotFound signal]	
	]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'collection management' stamp: 'Matias C 9/5/2023 11:12:45'!
orderedCollection: anOrderedCollection remove: anItem ifAbsent: aClosure
	
	1 to: anOrderedCollection size do: 
	[ :index |
		anItem = (anOrderedCollection at: index)
			ifTrue: [
				anOrderedCollection removeAt: index.
				^ anItem 
			] 
	].
	
	aClosure value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
