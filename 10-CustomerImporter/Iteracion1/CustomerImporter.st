!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'setup' stamp: 'MatiasCra 11/14/2023 14:12:43'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	"inputStream := UniFileStream new open: 'input.txt' forWrite: false."
	inputStream := ReadStream on: self inputString.! !

!ImportTest methodsFor: 'setup' stamp: 'Matias Cra 11/13/2023 21:51:49'!
tearDown

	session close.
	inputStream close.! !


!ImportTest methodsFor: 'test data' stamp: 'MatiasCra 11/14/2023 12:52:01'!
addressAlem1122

	^ self newAddressIn: 'Alem' streetNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MatiasCra 11/14/2023 12:52:28'!
addressMaipu888

	^ self newAddressIn: 'Maipu' streetNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'MatiasCra 11/14/2023 13:16:59'!
addressSanMartin3322

	^ self newAddressIn: 'San Martin' streetNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'MatiasCra 11/14/2023 12:55:55'!
customerJuan

	^ self newCustomerNamed: 'Juan' 
		lastName: 'Perez'
		identificationType: 'C'
		identificationNumber: '23-25666777-9'
		addresses: {self addressAlem1122}! !

!ImportTest methodsFor: 'test data' stamp: 'MatiasCra 11/14/2023 12:55:32'!
customerPepe

	^ self newCustomerNamed: 'Pepe'
		lastName: 'Sanchez' 
		identificationType: 'D' 
		identificationNumber: '22333444' 
		addresses: {self addressSanMartin3322. self addressMaipu888}.
	
! !

!ImportTest methodsFor: 'test data' stamp: 'MatiasCra 11/14/2023 14:10:20'!
inputString

	^ 'C,Pepe,Sanchez,D,22333444', String newLineString,
	'A,San Martin,3322,Olivos,1636,BsAs', String newLineString,
	'A,Maipu,888,Florida,1122,Buenos Aires', String newLineString,
	'C,Juan,Perez,C,23-25666777-9', String newLineString,
	'A,Alem,1122,CABA,1001,CABA'
	
! !

!ImportTest methodsFor: 'test data' stamp: 'MatiasCra 11/14/2023 14:15:13'!
newAddressIn: aStreet streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince
	| address |
	
	address := Address new.
	address streetName: aStreet.
	address streetNumber: aStreetNumber.
	address town: aTown.
	address zipCode: aZipCode.
	address province: aProvince.
	
	^ address
	
	
! !

!ImportTest methodsFor: 'test data' stamp: 'MatiasCra 11/14/2023 12:54:45'!
newCustomerNamed: aName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber addresses: anAddressCollection 
	| customer |

	customer := Customer new.
	customer firstName: aName.
	customer lastName: aLastName.
	customer identificationType: anIdentificationType.
	customer identificationNumber: anIdentificationNumber.
	anAddressCollection do: [ :address | customer addAddress: address ].
	
	^ customer! !


!ImportTest methodsFor: 'comparison' stamp: 'MatiasCra 11/14/2023 14:00:59'!
address: address hasStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince

	^ address streetName = aStreetName
		and: [ address streetNumber = aStreetNumber ]
		and: [ address town = aTown ] 
		and: [ address zipCode = aZipCode ] 
		and: [ address province = aProvince ]	! !

!ImportTest methodsFor: 'comparison' stamp: 'MatiasCra 11/14/2023 13:56:13'!
assertCustomer: aCustomer 	hasAddressInStreet: aStreetName number: aStreetNumber town: aTown zipCode: aZipCode province: aProvince
	| addresses |
	addresses := (aCustomer addresses select: [ :anAddress |
		self address: anAddress 
			hasStreetName: aStreetName
			streetNumber: aStreetNumber 
			town: aTown
			zipCode: aZipCode 
			province: aProvince
	]).

	self assert: addresses size equals: 1.! !

!ImportTest methodsFor: 'comparison' stamp: 'MatiasCra 11/14/2023 13:11:32'!
assertCustomer: aCustomer hasAddresses: addresses

	self assert: aCustomer addresses size equals: addresses size.
	addresses do: [ :address |
		self assertCustomer: aCustomer 
			hasAddressInStreet: address streetName
			number: address streetNumber 
			town: address town
			zipCode: address zipCode
			province: address province
	]! !

!ImportTest methodsFor: 'comparison' stamp: 'MatiasCra 11/14/2023 13:06:14'!
assertCustomer: customer isNamed: aName withSurname: aSurname identificationType: anIdentificationType identificationNumber: anIdentificationNumber 

	self assert: customer firstName equals: aName.
	self assert: customer lastName equals: aSurname.
	self assert: customer identificationType equals: anIdentificationType.
	self assert: customer identificationNumber equals: anIdentificationNumber.! !


!ImportTest methodsFor: 'in database assertion' stamp: 'MatiasCra 11/14/2023 13:51:59'!
assertAddressInDatabase: anAddress
	| addresses |
	
	addresses := session select: [ :address | 
		self address: address
			hasStreetName: anAddress streetName
			streetNumber: anAddress streetNumber
			town: anAddress town
			zipCode: anAddress zipCode
			province: anAddress province.
	] ofType: Address.

	self assert: addresses size equals: 1.! !

!ImportTest methodsFor: 'in database assertion' stamp: 'MatiasCra 11/14/2023 13:44:42'!
assertAddressesInDatabase: addresses

	addresses do: [ :address | 
		self assertAddressInDatabase: address
	]! !

!ImportTest methodsFor: 'in database assertion' stamp: 'MatiasCra 11/14/2023 13:32:59'!
assertCustomerInDatabase: aCustomer
	| customers foundCustomer |
	
	customers := session
		select: [ :customer | customer identificationType = aCustomer identificationType
					and: [ customer identificationNumber = aCustomer identificationNumber ] ] 
		ofType: Customer.

	self assert: customers size equals: 1.

	foundCustomer := customers anyOne.
	self assertCustomer: foundCustomer 
		isNamed: aCustomer firstName
		withSurname: aCustomer lastName
		identificationType: aCustomer identificationType 
		identificationNumber: aCustomer identificationNumber.
	
	self assertCustomer: foundCustomer hasAddresses: aCustomer addresses.! !

!ImportTest methodsFor: 'in database assertion' stamp: 'MatiasCra 11/14/2023 13:35:27'!
assertNumberOfAddresses: anAmmount
	| numberOfAddresses |
	
	numberOfAddresses := (session selectAllOfType: Address) size.	
	self assert: numberOfAddresses equals: anAmmount! !

!ImportTest methodsFor: 'in database assertion' stamp: 'MatiasCra 11/13/2023 23:21:25'!
assertNumberOfCustomers: anAmmount
	| numberOfCustomers |

	numberOfCustomers := (session selectAllOfType: Customer) size.
	self assert: numberOfCustomers equals: anAmmount.
! !


!ImportTest methodsFor: 'support' stamp: 'Matias Cra 11/13/2023 21:51:04'!
importCustomers
	
	(CustomerStreamReader session: session inputStream: inputStream	) read! !


!ImportTest methodsFor: 'tests' stamp: 'MatiasCra 11/14/2023 14:02:55'!
test01Import
	
	self importCustomers.

	self assertNumberOfAddresses: 3.
	self assertNumberOfCustomers: 2.
	
	self assertCustomerInDatabase: self customerPepe.
	self assertCustomerInDatabase: self customerJuan.
	
	self assertAddressesInDatabase: self customerPepe addresses.
	self assertAddressesInDatabase: self customerJuan addresses.! !


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
