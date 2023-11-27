!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportCustomerTest category: 'CustomerImporter'!
TestCase subclass: #ImportCustomerTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportCustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!ImportCustomerTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportCustomerTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 15:37:07'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportCustomerTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 15:37:18'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportCustomerTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 15:18:22'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportCustomerTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportCustomerTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 15:18:22'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportCustomerTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportCustomerTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:15:52'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!ImportCustomerTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 21:36:16'!
setUp

	system := Environment current createCustomerSystem.
	system start.
	system beginTransaction.
! !

!ImportCustomerTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 20:12:16'!
tearDown

	system commit.
	system stop
	! !


!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportCustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #ImportSupplierTest category: 'CustomerImporter'!
TestCase subclass: #ImportSupplierTest
	instanceVariableNames: 'supplierSystem customerSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportSupplierTest methodsFor: 'support' stamp: 'MatiasCra 11/27/2023 14:05:53'!
importMultipleSuppliers
	
	CustomerImporter valueFrom: self validCustomerImportData into: customerSystem.
	SupplierImporter valueFrom: self multipleValidSuppliersImportData customersInto: customerSystem suppliersInto: supplierSystem.! !

!ImportSupplierTest methodsFor: 'support' stamp: 'MatiasCra 11/27/2023 14:23:17'!
importOneSupplier
	
	CustomerImporter valueFrom: self validCustomerImportData into: customerSystem.
	SupplierImporter valueFrom: self validSupplierImportData 
		customersInto: customerSystem 
		suppliersInto: supplierSystem.! !


!ImportSupplierTest methodsFor: 'tests' stamp: 'MatiasCra 11/27/2023 12:26:53'!
test01CanImportValidSuplierData
	
	self importOneSupplier.

	self assertOneSupplierImported.
	self assertSupplier1WasImportedCorrecty.
! !

!ImportSupplierTest methodsFor: 'tests' stamp: 'MatiasCra 11/27/2023 14:04:59'!
test02CanImportMultipleValidSupliers
	
	self importMultipleSuppliers.

	self assertThreeSuppliersImported.
	self assertSupplier1WasImportedCorrecty.
	self assertSupplier2WasImportedCorrecty.
	self assertSupplier3WasImportedCorrecty.
! !

!ImportSupplierTest methodsFor: 'tests' stamp: 'MatiasCra 11/27/2023 14:25:29'!
test03CannotImportSupplierRecordWithLessThanFourFields

	self
		shouldFailImporting: self supplierRecordWithLessThanFourFields
		messageText: SupplierParser invalidSupplierRecordErrorDescription
		asserting: [ self assertNoSupplierWasImported ]

	! !

!ImportSupplierTest methodsFor: 'tests' stamp: 'MatiasCra 11/27/2023 14:33:50'!
test04CannotImportSupplierRecordWithMoreThanFourFields

	self
		shouldFailImporting: self supplierRecordWithMoreThanFourFields
		messageText: SupplierParser invalidSupplierRecordErrorDescription
		asserting: [ self assertNoSupplierWasImported ]

	! !

!ImportSupplierTest methodsFor: 'tests' stamp: 'MatiasCra 11/27/2023 14:36:17'!
test05CannotImportAddressRecordBeforeSupplier

	self
		shouldFailImporting: self addressRecordBeforeSupplier
		messageText: SupplierImporter canNotImportAddressWithoutSupplierErrorDescription 
		asserting: [ self assertNoSupplierWasImported ]

	! !

!ImportSupplierTest methodsFor: 'tests' stamp: 'MatiasCra 11/27/2023 14:42:54'!
test06CannotImportNewCustomerRecordBeforeSupplier

	self
		shouldFailImporting: self customerRecordBeforeSupplier
		messageText: SupplierImporter canNotImportCustomerWithoutSupplierErrorDescription 
		asserting: [ self assertNoSupplierWasImported ]

	! !

!ImportSupplierTest methodsFor: 'tests' stamp: 'MatiasCra 11/27/2023 14:45:20'!
test07CannotImportExistingCustomerRecordBeforeSupplier
	CustomerImporter valueFrom: self validCustomerImportData into: customerSystem.
	self
		shouldFailImporting: self existingCustomerRecordBeforeSupplier
		messageText: SupplierImporter canNotImportCustomerWithoutSupplierErrorDescription 
		asserting: [ self assertNoSupplierWasImported ]

	! !

!ImportSupplierTest methodsFor: 'tests' stamp: 'MatiasCra 11/27/2023 15:05:33'!
test08CannotImportExistingCustomerIfNotInCustomerSystem

	self
		shouldFailImporting: self validSupplierImportData
		messageText: ExistingCustomerParser canNotFindExistantCustomerErrorDescription 
		asserting: [ self assertOneSupplierImported ]

	! !


!ImportSupplierTest methodsFor: 'setUp/tearDown' stamp: 'MatiasCra 11/27/2023 13:26:33'!
setUp

	supplierSystem := Environment current createSupplierSystem.
	supplierSystem start; beginTransaction.

	customerSystem := Environment current createCustomerSystem.
	customerSystem 	start; beginTransaction.! !

!ImportSupplierTest methodsFor: 'setUp/tearDown' stamp: 'Matias Cra 11/23/2023 19:36:15'!
tearDown

	supplierSystem commit; stop.
	customerSystem commit; stop.	! !


!ImportSupplierTest methodsFor: 'test data' stamp: 'MatiasCra 11/27/2023 14:35:19'!
addressRecordBeforeSupplier

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
EC,D,5456774
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportSupplierTest methodsFor: 'test data' stamp: 'MatiasCra 11/27/2023 14:38:22'!
customerRecordBeforeSupplier

	^ ReadStream on:
'NC,Pepe,Sanchez,D,22333444
S,Supplier1,D,123
EC,D,5456774
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportSupplierTest methodsFor: 'test data' stamp: 'MatiasCra 11/27/2023 14:43:29'!
existingCustomerRecordBeforeSupplier

	^ ReadStream on:
'EC,D,5456774
S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportSupplierTest methodsFor: 'test data' stamp: 'MatiasCra 11/27/2023 14:16:06'!
multipleValidSuppliersImportData

	^ ReadStream on:
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
EC,D,5456774
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
S,Supplier2,D,456
NC,Pepito,Hernandez,D,12345678
A,Santa Fe,5011,Palermo,1450,CABA
S,Supplier3,D,789
NC,James,Smith,D,11111111
A,San Martin,3323,Olivos,1636,BsAs
'! !

!ImportSupplierTest methodsFor: 'test data' stamp: 'MatiasCra 11/27/2023 14:25:52'!
supplierRecordWithLessThanFourFields

	^ ReadStream on:
'S,Supplier1,D'! !

!ImportSupplierTest methodsFor: 'test data' stamp: 'MatiasCra 11/27/2023 14:26:03'!
supplierRecordWithMoreThanFourFields

	^ ReadStream on:
'S,Supplier1,D,123,asddas'! !

!ImportSupplierTest methodsFor: 'test data' stamp: 'Matias Cra 11/23/2023 19:03:16'!
validCustomerImportData

	^ ReadStream on:
'C,Dario,Perez,D,5456774'! !

!ImportSupplierTest methodsFor: 'test data' stamp: 'Matias Cra 11/23/2023 19:01:34'!
validSupplierImportData

	^ ReadStream on:
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
EC,D,5456774
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !


!ImportSupplierTest methodsFor: 'assertions' stamp: 'Matias Cra 11/23/2023 18:53:48'!
assertAddressOf: importedSupplier at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedSupplier addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.! !

!ImportSupplierTest methodsFor: 'assertions' stamp: 'Matias Cra 11/23/2023 19:49:46'!
assertCustomerOf: importedSupplier isNamed: aName lastName: aLastName idType: anIdType idNumber: anIdNumber
	| importedCustomer |

	importedCustomer := importedSupplier customerWithIdentificationType: anIdType number: anIdNumber ifNone: [ self fail ].
	self assert: importedCustomer firstName = aName.
	self assert: importedCustomer lastName = aLastName.! !

!ImportSupplierTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 14:26:25'!
assertNoSupplierWasImported

	self assert: supplierSystem numberOfSuppliers equals: 0. ! !

!ImportSupplierTest methodsFor: 'assertions' stamp: 'Matias Cra 11/23/2023 19:00:29'!
assertOneSupplierImported

	self assert: supplierSystem numberOfSuppliers equals: 1. ! !

!ImportSupplierTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 15:27:39'!
assertSupplier1WasImportedCorrecty
	| importedSupplier |

	importedSupplier := supplierSystem supplierWithIdentificationType: 'D' number: '123'.

	self assert: (importedSupplier isNamed: 'Supplier1').
	self assert: (importedSupplier hasIdentificationType: 'D' number: '123').
	
	self assertAddressOf: importedSupplier at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedSupplier at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.
	
	self assertCustomerOf: importedSupplier isNamed: 'Dario' lastName: 'Perez' idType: 'D' idNumber: '5456774'.
	self assertCustomerOf: importedSupplier isNamed: 'Pepe' lastName: 'Sanchez' idType: 'D' idNumber: '22333444'.
	
	^ importedSupplier ! !

!ImportSupplierTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 15:27:24'!
assertSupplier2WasImportedCorrecty
	| importedSupplier |

	importedSupplier := supplierSystem supplierWithIdentificationType: 'D' number: '456'.

	self assert: (importedSupplier isNamed: 'Supplier2').
	self assert: (importedSupplier hasIdentificationType: 'D' number: '456').
	
	self assertAddressOf: importedSupplier at: 'Santa Fe' hasNumber: 5011 town: 'Palermo' zipCode: 1450 province: 'CABA'.

	self assertCustomerOf: importedSupplier isNamed: 'Pepito' lastName: 'Hernandez' idType: 'D' idNumber: '12345678'.
	
	^ importedSupplier ! !

!ImportSupplierTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 15:27:29'!
assertSupplier3WasImportedCorrecty
	| importedSupplier |

	importedSupplier := supplierSystem supplierWithIdentificationType: 'D' number: '789'.

	self assert: (importedSupplier isNamed: 'Supplier3').
	self assert: (importedSupplier hasIdentificationType: 'D' number: '789').
	
	self assertAddressOf: importedSupplier at: 'San Martin' hasNumber: 3323 town: 'Olivos' zipCode: 1636 province: 'BsAs'.

	self assertCustomerOf: importedSupplier isNamed: 'James' lastName: 'Smith' idType: 'D' idNumber: '11111111'.
	
	^ importedSupplier ! !

!ImportSupplierTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 14:05:23'!
assertThreeSuppliersImported

	self assert: supplierSystem numberOfSuppliers equals: 3. ! !

!ImportSupplierTest methodsFor: 'assertions' stamp: 'MatiasCra 11/27/2023 14:30:13'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ SupplierImporter valueFrom: aReadStream customersInto: customerSystem suppliersInto: supplierSystem. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!classDefinition: #CSVImporter category: 'CustomerImporter'!
Object subclass: #CSVImporter
	instanceVariableNames: 'line record readStream parsers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CSVImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/23/2023 20:11:32'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CSVImporter methodsFor: 'evaluating - private' stamp: 'MatiasCra 11/27/2023 15:42:58'!
assertRecordIsNotEmpty

	record size > 0 ifFalse: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'Matias Cra 11/23/2023 20:13:32'!
createRecord

	^ record := line findTokens: $,! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'Matias Cra 11/23/2023 20:14:02'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'MatiasCra 11/27/2023 15:42:35'!
importRecord
	self assertRecordIsNotEmpty.

	(parsers detect: [ :parser | parser canParse: record ]
		ifNone: [ self error: self class invalidRecordTypeErrorDescription ]) parse: record! !


!CSVImporter methodsFor: 'initialization' stamp: 'MatiasCra 11/27/2023 15:31:08'!
initializeFrom: aReadStream with: aParserCollection

	readStream := aReadStream.
	parsers := aParserCollection ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: 'CustomerImporter'!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'instance creation' stamp: 'MatiasCra 11/27/2023 15:31:59'!
from: aReadStream with: aParsersCollection

	^ self new initializeFrom: aReadStream with: aParsersCollection ! !


!CSVImporter class methodsFor: 'error messages' stamp: 'MatiasCra 11/27/2023 15:38:52'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
CSVImporter subclass: #CustomerImporter
	instanceVariableNames: 'newCustomer customerSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'MatiasCra 11/27/2023 15:35:13'!
initializeFrom: aReadStream into: aCustomerSystem

	customerSystem := aCustomerSystem.
	super initializeFrom: aReadStream with: {
		self customerParser.
		self addressParser.
	}.
! !


!CustomerImporter methodsFor: 'customer' stamp: 'MatiasCra 11/27/2023 15:35:54'!
customerParser

	^ CustomerParser onSuccess: [ :customer |
		newCustomer := customer.
		customerSystem add: newCustomer	
	]! !


!CustomerImporter methodsFor: 'address' stamp: 'MatiasCra 11/27/2023 15:36:35'!
addressParser

	^ AddressParser onSuccess: [ :address | 
		self assertCustomerWasImported.
		newCustomer addAddress: address
	]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:58:41'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 21:15:35'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 21:15:52'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:13:48'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:41:39'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !


!classDefinition: #SupplierImporter category: 'CustomerImporter'!
CSVImporter subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier customerSystem supplierSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'supplier' stamp: 'MatiasCra 11/27/2023 13:53:54'!
suplierParser

	^ SupplierParser onSuccess: [ :supplier | 
		newSupplier := supplier. 
		supplierSystem add: newSupplier
	].! !


!SupplierImporter methodsFor: 'customer' stamp: 'MatiasCra 11/27/2023 14:38:02'!
assertSupplierWasImportedBeforeCustomer

	^ newSupplier ifNil: [ self error: self class canNotImportCustomerWithoutSupplierErrorDescription ]! !

!SupplierImporter methodsFor: 'customer' stamp: 'MatiasCra 11/27/2023 15:34:37'!
existingCustomerParser

	^ ExistingCustomerParser with: customerSystem onSuccess: [ :customer |
		self assertSupplierWasImportedBeforeCustomer.
		newSupplier addCustomer: customer
	]! !

!SupplierImporter methodsFor: 'customer' stamp: 'MatiasCra 11/27/2023 14:42:33'!
newCustomerParser

	^ CustomerParser onSuccess: [ :customer |
		self assertSupplierWasImportedBeforeCustomer.
		newSupplier addCustomer: customer	
	]! !


!SupplierImporter methodsFor: 'address' stamp: 'MatiasCra 11/27/2023 14:37:22'!
addressParser

	^ AddressParser onSuccess: [ :address | 
		self assertSupplierWasImportedBeforeAddress.
		newSupplier addAddress: address
	]! !

!SupplierImporter methodsFor: 'address' stamp: 'MatiasCra 11/27/2023 14:37:22'!
assertSupplierWasImportedBeforeAddress

	^ newSupplier ifNil: [ self error: self class canNotImportAddressWithoutSupplierErrorDescription ]! !


!SupplierImporter methodsFor: 'initialization' stamp: 'MatiasCra 11/27/2023 15:33:15'!
initializeFrom: aReadStream customersInto: aCustomerSystem suppliersInto: aSupplierSystem

	customerSystem := aCustomerSystem.
	supplierSystem := aSupplierSystem.	

	super initializeFrom: aReadStream with: (Array 
		with: self suplierParser
		with: self addressParser
		with: self existingCustomerParser
		with: self newCustomerParser
	).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: 'CustomerImporter'!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'instance creation' stamp: 'MatiasCra 11/27/2023 14:00:33'!
from: aReadStream customersInto: aCustomerSystem suppliersInto: aSupplierSystem

	^ self new initializeFrom: aReadStream customersInto: aCustomerSystem suppliersInto: aSupplierSystem! !

!SupplierImporter class methodsFor: 'instance creation' stamp: 'MatiasCra 11/27/2023 13:59:37'!
valueFrom: aReadStream customersInto: aCustomerSystem suppliersInto: aSupplierSystem

	^ (self from: aReadStream customersInto: aCustomerSystem suppliersInto: aSupplierSystem) value.! !


!SupplierImporter class methodsFor: 'error messages' stamp: 'MatiasCra 11/27/2023 14:35:59'!
canNotImportAddressWithoutSupplierErrorDescription

	^ 'Can''t import address without supplier'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'Matias Cra 11/23/2023 20:34:49'!
canNotImportCustomerWithoutSupplierErrorDescription

	^ 'Can''t import customer without supplier'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:41:06'!
createCustomerSystem

	self subclassResponsibility ! !

!Environment methodsFor: 'customer system' stamp: 'Matias Cra 11/23/2023 18:59:23'!
createSupplierSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentVariable

	^ Smalltalk at: self environmentKey! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:09'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:46:01'!
makeCurrent

	"
	Tener en cuenta que en Smalltalk se podría poner directamente la clase de environment,
	esto es DevelopmentEnvironment o IntegrationEnvironmet o hasta una instancia de ellas,
	pero se está simulando el hecho de que esto esté definido por fuera del sistema, como una
	variable del sistema operativo - Hernan"
	
	Smalltalk at: self environmentKey put: self identifier! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'MatiasCra 11/27/2023 15:11:20'!
createCustomerSystem

	^TransientPartySystem new! !

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'MatiasCra 11/27/2023 15:13:05'!
createSupplierSystem

	^TransientPartySystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:42:50'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:52'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'MatiasCra 11/27/2023 15:15:04'!
createCustomerSystem

	^PersistentPartySystem new! !

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'MatiasCra 11/27/2023 15:20:40'!
createSupplierSystem

	^PersistentPartySystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:07'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:04'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #Party category: 'CustomerImporter'!
Object subclass: #Party
	instanceVariableNames: 'firstName identificationType identificationNumber addresses id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Party methodsFor: 'addresses' stamp: 'MatiasCra 11/27/2023 12:40:00'!
addAddress: anAddress

	^ addresses add: anAddress ! !

!Party methodsFor: 'addresses' stamp: 'Matias Cra 11/23/2023 19:15:39'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Party methodsFor: 'addresses' stamp: 'Matias Cra 11/23/2023 19:15:46'!
isAddressesEmpty

	^addresses isEmpty ! !


!Party methodsFor: 'initialization' stamp: 'Matias Cra 11/23/2023 19:16:13'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Party methodsFor: 'testing' stamp: 'MatiasCra 11/27/2023 15:14:20'!
hasIdentificationType: anIdType number: anIdNumber

	^ identificationType = anIdType and: [ identificationNumber = anIdNumber ]! !


!classDefinition: #Customer category: 'CustomerImporter'!
Party subclass: #Customer
	instanceVariableNames: 'lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

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


!classDefinition: #Supplier category: 'CustomerImporter'!
Party subclass: #Supplier
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'testing' stamp: 'Matias Cra 11/23/2023 19:44:46'!
isNamed: aName

	^ firstName = aName! !


!Supplier methodsFor: 'customers' stamp: 'MatiasCra 11/27/2023 12:39:49'!
addCustomer: aCustomer

	^ customers add: aCustomer! !

!Supplier methodsFor: 'customers' stamp: 'Matias Cra 11/23/2023 19:37:20'!
customerWithIdentificationType: anIdType number: anIdNumber ifNone: aBlock

	^ customers detect: [ :customer | customer identificationType = anIdType and: [customer identificationNumber = anIdNumber ]] ifNone: aBlock! !


!Supplier methodsFor: 'initialization' stamp: 'Matias Cra 11/23/2023 19:29:31'!
initializeNamed: aName idType: anIdType idNumber: anIdNumber

	super initialize.
	customers := OrderedCollection new.
	firstName := aName.
	identificationType := anIdType.
	identificationNumber := anIdNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Supplier class' category: 'CustomerImporter'!
Supplier class
	instanceVariableNames: ''!

!Supplier class methodsFor: 'as yet unclassified' stamp: 'Matias Cra 11/23/2023 19:28:49'!
named: aName identificationType: anIdType identificationNumber: anIdNumber
	
	^ self new initializeNamed: aName idType: anIdType idNumber: anIdNumber! !


!classDefinition: #PartySystem category: 'CustomerImporter'!
Object subclass: #PartySystem
	instanceVariableNames: 'partyClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartySystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:17:57'!
add: aCustomer

	self subclassResponsibility ! !

!PartySystem methodsFor: 'customers' stamp: 'MatiasCra 11/27/2023 15:18:22'!
numberOfCustomers

	self subclassResponsibility ! !

!PartySystem methodsFor: 'customers' stamp: 'MatiasCra 11/27/2023 15:18:31'!
numberOfSuppliers

	self subclassResponsibility ! !


!PartySystem methodsFor: 'transactions' stamp: 'MatiasCra 11/27/2023 15:13:33'!
beginTransaction

	self subclassResponsibility ! !

!PartySystem methodsFor: 'transactions' stamp: 'MatiasCra 11/27/2023 15:13:38'!
commit

	self subclassResponsibility ! !


!PartySystem methodsFor: 'system lifecycle' stamp: 'MatiasCra 11/27/2023 15:13:42'!
start

	self subclassResponsibility ! !

!PartySystem methodsFor: 'system lifecycle' stamp: 'MatiasCra 11/27/2023 15:13:45'!
stop

	self subclassResponsibility ! !


!classDefinition: #PersistentPartySystem category: 'CustomerImporter'!
PartySystem subclass: #PersistentPartySystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:15:24'!
add: aParty

	^session persist: aParty ! !

!PersistentPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:26:40'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:18:22'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !

!PersistentPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:18:58'!
numberOfSuppliers

	^(session selectAllOfType: Supplier) size! !

!PersistentPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:29:37'!
supplierWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer hasIdentificationType: anIdType number: anIdNumber ]
		ofType: Supplier) anyOne! !


!PersistentPartySystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:12:39'!
beginTransaction

	session beginTransaction.
! !

!PersistentPartySystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:13:00'!
commit

	session commit ! !


!PersistentPartySystem methodsFor: 'system lifecycle' stamp: 'MatiasCra 11/27/2023 15:24:24'!
start

	session := DataBaseSession for: (Array with: Address with: Customer with: Supplier).
	! !

!PersistentPartySystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:13:10'!
stop

	session close! !


!classDefinition: #TransientPartySystem category: 'CustomerImporter'!
PartySystem subclass: #TransientPartySystem
	instanceVariableNames: 'parties'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientPartySystem methodsFor: 'system lifecycle' stamp: 'MatiasCra 11/27/2023 15:12:46'!
start

	parties := OrderedCollection new! !

!TransientPartySystem methodsFor: 'system lifecycle' stamp: 'MatiasCra 11/27/2023 15:12:46'!
stop

	parties := nil! !


!TransientPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:12:46'!
add: aParty

	parties add: aParty ! !

!TransientPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:27:53'!
customerWithIdentificationType: anIdType number: anIdNumber

	^parties detect: [ :aParty | aParty hasIdentificationType: anIdType number: anIdNumber ]! !

!TransientPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:19:57'!
numberOfCustomers

	^ (parties select: [ :aParty | aParty isKindOf: Customer ]) size! !

!TransientPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:20:08'!
numberOfSuppliers

	^ (parties select: [ :aParty | aParty isKindOf: Supplier ]) size! !

!TransientPartySystem methodsFor: 'parties' stamp: 'MatiasCra 11/27/2023 15:28:02'!
supplierWithIdentificationType: anIdType number: anIdNumber

	^parties detect: [ :aParty | aParty hasIdentificationType: anIdType number: anIdNumber ]! !


!TransientPartySystem methodsFor: 'transactions' stamp: 'MatiasCra 11/27/2023 13:22:55'!
beginTransaction! !

!TransientPartySystem methodsFor: 'transactions' stamp: 'MatiasCra 11/27/2023 13:22:58'!
commit! !


!classDefinition: #RecordParser category: 'CustomerImporter'!
Object subclass: #RecordParser
	instanceVariableNames: 'onSuccessClosure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!RecordParser methodsFor: 'parsing' stamp: 'Matias Cra 11/23/2023 21:21:30'!
canParse: aRecord

	self subclassResponsibility! !

!RecordParser methodsFor: 'parsing' stamp: 'Matias Cra 11/23/2023 21:08:39'!
parse: aRecord

	self subclassResponsibility! !


!RecordParser methodsFor: 'assertion' stamp: 'Matias Cra 11/23/2023 21:10:37'!
assertValidRecord: record

	self subclassResponsibility! !


!RecordParser methodsFor: 'initialization' stamp: 'MatiasCra 11/27/2023 12:55:15'!
initializeWith: aClosure.

	onSuccessClosure := aClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RecordParser class' category: 'CustomerImporter'!
RecordParser class
	instanceVariableNames: ''!

!RecordParser class methodsFor: 'instance creation' stamp: 'MatiasCra 11/27/2023 12:55:58'!
onSuccess: onSuccessClosure

	^ self new initializeWith: onSuccessClosure ! !


!classDefinition: #AddressParser category: 'CustomerImporter'!
RecordParser subclass: #AddressParser
	instanceVariableNames: 'party'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!AddressParser methodsFor: 'assertion' stamp: 'Matias Cra 11/23/2023 21:34:26'!
assertValidRecord: record

	record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ].! !


!AddressParser methodsFor: 'parsing' stamp: 'MatiasCra 11/27/2023 13:10:24'!
canParse: record
	
	^ record first = 'A'! !

!AddressParser methodsFor: 'parsing' stamp: 'MatiasCra 11/27/2023 13:02:01'!
parse: record
	| newAddress |
	self assertValidRecord: record.

	newAddress := Address new.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth.

	onSuccessClosure value: newAddress.
	^ newAddress ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddressParser class' category: 'CustomerImporter'!
AddressParser class
	instanceVariableNames: ''!

!AddressParser class methodsFor: 'instance creation' stamp: 'Matias Cra 11/23/2023 21:36:34'!
assertValidParty: aParty

	^ aParty ifNil: [ self error: self canNotImportAddressWithoutPartyErrorDescription ]! !

!AddressParser class methodsFor: 'instance creation' stamp: 'Matias Cra 11/23/2023 21:36:39'!
canNotImportAddressWithoutPartyErrorDescription

	^ 'Can''t import address without party'! !


!AddressParser class methodsFor: 'error description' stamp: 'Matias Cra 11/23/2023 20:42:15'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !


!classDefinition: #CustomerParser category: 'CustomerImporter'!
RecordParser subclass: #CustomerParser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerParser methodsFor: 'assertion' stamp: 'Matias Cra 11/23/2023 21:10:37'!
assertValidRecord: record

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !


!CustomerParser methodsFor: 'parsing' stamp: 'MatiasCra 11/27/2023 13:10:28'!
canParse: record
	
	^ record first = 'C' or: [ record first = 'NC' ].! !

!CustomerParser methodsFor: 'parsing' stamp: 'MatiasCra 11/27/2023 12:53:54'!
parse: record
	| parsedCustomer |
	
	self assertValidRecord: record.
	
	parsedCustomer := Customer new.
	parsedCustomer firstName: record second.
	parsedCustomer lastName: record third.
	parsedCustomer identificationType: record fourth.
	parsedCustomer identificationNumber: record fifth.
	onSuccessClosure value: parsedCustomer.
	^ parsedCustomer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerParser class' category: 'CustomerImporter'!
CustomerParser class
	instanceVariableNames: ''!

!CustomerParser class methodsFor: 'error description' stamp: 'Matias Cra 11/23/2023 21:10:57'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !


!classDefinition: #ExistingCustomerParser category: 'CustomerImporter'!
RecordParser subclass: #ExistingCustomerParser
	instanceVariableNames: 'system supplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ExistingCustomerParser methodsFor: 'initialization' stamp: 'MatiasCra 11/27/2023 12:59:53'!
initializeWith: aCustomerSystem onSuccess: aClosure   

	system := aCustomerSystem.
	onSuccessClosure := aClosure.! !


!ExistingCustomerParser methodsFor: 'parsing' stamp: 'MatiasCra 11/27/2023 13:10:33'!
canParse: record
	
	^ record first = 'EC'! !

!ExistingCustomerParser methodsFor: 'parsing' stamp: 'MatiasCra 11/27/2023 15:29:09'!
parse: record
	| customer |
	self assertValidRecord: record.
	
	[ customer := system customerWithIdentificationType: record second number: record third ]
		on: Error
		do: [ self error: self class canNotFindExistantCustomerErrorDescription ].
	
	onSuccessClosure value: customer.
	
	^ customer! !


!ExistingCustomerParser methodsFor: 'assertion' stamp: 'MatiasCra 11/27/2023 13:11:30'!
assertValidRecord: record

	^ record size ~= 3 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExistingCustomerParser class' category: 'CustomerImporter'!
ExistingCustomerParser class
	instanceVariableNames: ''!

!ExistingCustomerParser class methodsFor: 'error description' stamp: 'MatiasCra 11/27/2023 14:52:23'!
canNotFindExistantCustomerErrorDescription

	^ 'Can''t find customer in customer system'! !


!ExistingCustomerParser class methodsFor: 'instance creation' stamp: 'MatiasCra 11/27/2023 12:59:17'!
with: aCustomerSystem onSuccess: onSuccessClosure

	^ self new initializeWith: aCustomerSystem onSuccess: onSuccessClosure.! !


!classDefinition: #SupplierParser category: 'CustomerImporter'!
RecordParser subclass: #SupplierParser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierParser methodsFor: 'parsing' stamp: 'MatiasCra 11/27/2023 13:10:36'!
canParse: record
	
	^ record first = 'S'! !

!SupplierParser methodsFor: 'parsing' stamp: 'MatiasCra 11/27/2023 13:00:29'!
parse: record
	| supplier |
	self assertValidRecord: record.

	supplier := Supplier named: record second
		identificationType: record third
		identificationNumber: record fourth.
		
	onSuccessClosure value: supplier.
	^ supplier! !


!SupplierParser methodsFor: 'assertion' stamp: 'MatiasCra 11/27/2023 14:33:58'!
assertValidRecord: record

	^ record size ~= 4 ifTrue: [ self error: self class invalidSupplierRecordErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierParser class' category: 'CustomerImporter'!
SupplierParser class
	instanceVariableNames: ''!

!SupplierParser class methodsFor: 'error messages' stamp: 'MatiasCra 11/27/2023 14:26:50'!
invalidSupplierRecordErrorDescription

	^ 'Invalid Supplier record'! !
