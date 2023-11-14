!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'setup' stamp: 'Matias Cra 11/13/2023 21:51:12'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
	inputStream := UniFileStream new open: 'input.txt' forWrite: false.! !

!ImportTest methodsFor: 'setup' stamp: 'Matias Cra 11/13/2023 21:51:49'!
tearDown

	session close.
	inputStream close.! !


!ImportTest methodsFor: 'support' stamp: 'Matias Cra 11/13/2023 21:55:33'!
assertCustomer: customer

	self assert: customer firstName equals: 'Pepe'.
	self assert: customer lastName equals: 'Sanchez'.
	self assert: customer identificationType equals: 'D'.
	self assert: customer identificationNumber equals: '22333444'! !

!ImportTest methodsFor: 'support' stamp: 'MatiasCra 11/13/2023 23:16:58'!
assertCustomer: customer isNamed: aName withSurname: aSurname identificationType: anIdentificationType identificationNumber: anIdentificationNumber

	self assert: customer firstName equals: aName.
	self assert: customer lastName equals: aSurname.
	self assert: customer identificationType equals: anIdentificationType.
	self assert: customer identificationNumber equals: anIdentificationNumber.! !

!ImportTest methodsFor: 'support' stamp: 'MatiasCra 11/13/2023 23:21:25'!
assertNumberOfCustomers: anAmmount
	| numberOfCustomers |

	numberOfCustomers := (session selectAllOfType: Customer) size.
	self assert: numberOfCustomers equals: anAmmount.
! !

!ImportTest methodsFor: 'support' stamp: 'Matias Cra 11/13/2023 21:51:04'!
importCustomers
	
	(CustomerStreamReader session: session inputStream: inputStream	) read! !


!ImportTest methodsFor: 'tests' stamp: 'MatiasCra 11/13/2023 23:22:23'!
test01Import
	| customers customer allAddresses |

	self importCustomers.
	
	allAddresses := session selectAllOfType: Address.	

	self assert: allAddresses size equals: 3.
	self assertNumberOfCustomers: 2.
	
	customers := session
		select: [ :aCustomer | aCustomer identificationType = 'D' and: [ aCustomer identificationNumber = '22333444' ]]
		ofType: Customer.
	
	self assert: customers size equals: 1.
	customer := customers anyOne.
	
	self assertCustomer: customer
		isNamed: 'Pepe'
		withSurname: 'Sanchez' 
		identificationType: 'D'
		identificationNumber: '22333444'.
	
	self assert: (allAddresses includesAllOf: customer addresses).
	
	customers := session
		select: [ :aCustomer | aCustomer identificationType = 'C' and: [ aCustomer identificationNumber = '23-25666777-9' ]]
		ofType: Customer.
	
	self assert: customers size equals: 1.
	customer := customers anyOne.
	
	self assertCustomer: customer 
		isNamed: 'Juan'
		withSurname: 'Perez'
		identificationType: 'C'
		identificationNumber: '23-25666777-9'.

	self assert: (allAddresses includesAllOf: customer addresses).
! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerStreamReader category: 'CustomerImporter'!
Object subclass: #CustomerStreamReader
	instanceVariableNames: 'databaseSession inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerStreamReader methodsFor: 'initialization' stamp: 'Matias Cra 11/13/2023 21:53:02'!
initializeSession: aSession inputStream: anInputStream 
	databaseSession := aSession.
	inputStream := anInputStream.! !


!CustomerStreamReader methodsFor: 'evaluating' stamp: 'Matias Cra 11/13/2023 21:53:02'!
read

	"
	self importCustomers
	"
	| newCustomer line |

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			databaseSession persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].

	databaseSession commit.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerStreamReader class' category: 'CustomerImporter'!
CustomerStreamReader class
	instanceVariableNames: ''!

!CustomerStreamReader class methodsFor: 'instance creation' stamp: 'Matias Cra 11/13/2023 21:48:49'!
session: aSession inputStream: anInputStream 
	^self new initializeSession: aSession inputStream: anInputStream! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
