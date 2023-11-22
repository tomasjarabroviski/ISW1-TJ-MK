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


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:50:42'!
customerImporterFrom: aStream

	^ CustomerImporter from: aStream into: system! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:54:38'!
customerImporterValueFrom: aStream

	^ CustomerImporter valueFrom: aStream into: system! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:54:46'!
test01Import

	self customerImporterValueFrom: self validImportData.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly.! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:51:14'!
test02CustomerRecordsMustProvideAllFiveParameters
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'C,Pepe,Sanchez,D').
	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer invalidCustomerRecordErrorMessage.
			self assertNoCustomersImported.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:51:00'!
test03CustomerRecordsMustNotProvideMoreThanFiveParameters
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'C,Pepe,Sanchez,D,22333444,Dario').
	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer invalidCustomerRecordErrorMessage.
			self assertNoCustomersImported.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:53:18'!
test04AddressRecordsMustProvideAllSixParameters
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'C,Juan,Perez,C,23-25666777-9', String newLineString, 'A,Alem,1122,CABA').


	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer invalidAddressRecordErrorMessage.
			self assertNoAddressesImported.
			self assertNumberOfCustomers: 1.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:52:11'!
test05AddressRecordsMustNotProvideMoreThanSixParameters
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'C,Juan,Perez,C,23-25666777-9', String newLineString, 'A,Alem,1122,CABA,1001,CABA,Dario').

	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer invalidAddressRecordErrorMessage.
			self assertNoAddressesImported.
			self assertNumberOfCustomers: 1.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:52:25'!
test06CannotHaveEmptyRecord
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'C,Juan,Perez,C,23-25666777-9', String newLineString, '', String newLineString).

	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer emptyRecordErrorMessage.
			self assertNoAddressesImported.
			self assertNumberOfCustomers: 1.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:52:33'!
test07AllRecordsMustBeClientsOrAddresses
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'D,Dario,Perez,D,123456').

	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer unknownRecordTypeErrorMessage.
			self assertNoAddressesImported.
			self assertNoCustomersImported.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:52:42'!
test08CannotImportAddressWithoutCustomer
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'A,Alem,1122,CABA,1001,CABA').

	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer invalidAddressRecordErrorMessage.
			self assertNoAddressesImported.
			self assertNoCustomersImported.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:52:51'!
test09AddressStreetNumberMustBePositiveInteger
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'C,Juan,Perez,C,23-25666777-9', String newLineString, 'A,Alem,dario,CABA,1001,CABA').

	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer invalidAddressRecordErrorMessage.
			self assertNoAddressesImported.
			self assertNumberOfCustomers: 1.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'Matias Cra 11/21/2023 20:53:00'!
test10AddressZipCodeMustBePositiveInteger
	| importer |
	importer := self customerImporterFrom: (ReadStream on: 'C,Juan,Perez,C,23-25666777-9', String newLineString, 'A,Alem,1122,CABA,dario,CABA').

	self should: [ importer value ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: importer invalidAddressRecordErrorMessage.
			self assertNoAddressesImported.
			self assertNumberOfCustomers: 1.
		]! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'Matias Cra 11/16/2023 19:40:51'!
assertImportedRightNumberOfCustomers

	^ self assertNumberOfCustomers: 2! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'Matias Cra 11/16/2023 20:01:38'!
assertNoAddressesImported

	^ self assertNumberOfAddresses: 0! !

!ImportTest methodsFor: 'assertions' stamp: 'Matias Cra 11/16/2023 19:41:18'!
assertNoCustomersImported

	^ self assertNumberOfCustomers: 0! !

!ImportTest methodsFor: 'assertions' stamp: 'Matias Cra 11/21/2023 20:42:35'!
assertNumberOfAddresses: anAmmount

	^ self assert: anAmmount equals: system countAllAddresses! !

!ImportTest methodsFor: 'assertions' stamp: 'Matias Cra 11/21/2023 20:42:51'!
assertNumberOfCustomers: anAmmount

	^ self assert: anAmmount equals: system countAllCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'Matias Cra 11/21/2023 20:58:22'!
setUp

	system := CustomerImporterSystem for: (DataBaseSession for: (Array with: Address with: Customer)).
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'Matias Cra 11/21/2023 20:47:01'!
tearDown

	system commit.
	system close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'Matias Cra 11/21/2023 20:44:45'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ system customerWithIdentificationType: anIdType number: anIdNumber! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'system readStream line record newCustomer newAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'Matias Cra 11/21/2023 20:56:18'!
initializeFrom: aReadStream into: aSystem
	system := aSystem.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 19:27:28'!
importAddress

	^ (self lineHasAddressRecord) ifTrue: [
		self readAddress.
	]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/21/2023 20:59:50'!
importCustomer

	^ (self lineHasCustomerRecord) ifTrue: [ 
		self readCustomer.
		system persist: newCustomer.
	]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 21:40:47'!
lineHasAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 21:40:59'!
lineHasCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 19:27:19'!
nextLine

	^ line := readStream nextLine! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 20:05:57'!
readAddress
	
	self assertValidAddressRecord.
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber.
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber.
	newAddress province: record sixth.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 19:50:23'!
readCustomer

	self assertValidCustomerRecord.
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 20:16:14'!
readRecord

	record := line findTokens: $,.
	self assertValidRecordFormat.
	^ record! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 19:34:04'!
thereIsALineToRead

	^ line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Matias Cra 11/16/2023 19:34:04'!
value

	self nextLine.
	[ self thereIsALineToRead ] whileTrue: [
		self readRecord.
		self importCustomer.
		self importAddress.
		self nextLine. 
	].

	! !


!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:49:16'!
assertValidAddressRecord

	(self wrongAddressRecordSize 
		or: [ self noCustomerImported ] 
		or: [ self streetNumberIsNotPositiveInteger ] 
		or: [ self zipCodeIsNotPositiveInteger ])
			ifTrue: [ self signalInvalidAddressRecord ]! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:37:19'!
assertValidCustomerRecord

	self wrongCustomerRecordSize ifTrue:
		[ self signalInvalidCustomerRecord ]! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:23:45'!
assertValidRecordFormat

	(record isEmpty)
		ifTrue: [ self signalEmptyRecord ].

	(self lineHasCustomerRecord or: [ self lineHasAddressRecord ])
		ifFalse: [ self signalUnknownRecordType ]! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:14:05'!
emptyRecordErrorMessage

	^ 'Error during import process: empty record read. Importing process stopped.'! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:03:56'!
invalidAddressRecordErrorMessage

	^ 'Cannot import address: invalid address record, check the format of the input. Importing process stopped.'! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 19:42:32'!
invalidCustomerRecordErrorMessage

	^ 'Cannot import customer: invalid customer record, check the format of the input. Importing process stopped.'! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:48:03'!
isNotPositiveInteger: aValue

	^ [ aValue asNumber <= 0 ]
		on: Error
		do: [ ^ true ].! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:36:11'!
noCustomerImported

	^ newCustomer isNil! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:15:07'!
signalEmptyRecord

	self error: self emptyRecordErrorMessage! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:04:09'!
signalInvalidAddressRecord

	self error: self invalidAddressRecordErrorMessage! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 19:43:26'!
signalInvalidCustomerRecord

	self error: self invalidCustomerRecordErrorMessage! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:21:34'!
signalUnknownRecordType

	self error: self unknownRecordTypeErrorMessage! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:48:20'!
streetNumberIsNotPositiveInteger

	^ self isNotPositiveInteger: record third! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:21:18'!
unknownRecordTypeErrorMessage

	^ 'Error during import process: record of unknown type read. Importing process stopped.'! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:36:54'!
wrongAddressRecordSize

	^ ((record size) = 6) not! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:37:19'!
wrongCustomerRecordSize

	^ ((record size) = 5) not! !

!CustomerImporter methodsFor: 'errors' stamp: 'Matias Cra 11/16/2023 20:48:33'!
zipCodeIsNotPositiveInteger

	^ self isNotPositiveInteger: record fifth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'Matias Cra 11/21/2023 20:56:40'!
from: aReadStream into: aSystem

	^self new initializeFrom: aReadStream into: aSystem ! !


!CustomerImporter class methodsFor: 'importing' stamp: 'Matias Cra 11/21/2023 20:56:58'!
valueFrom: aReadStream into: aSystem

	^(self from: aReadStream into: aSystem) value! !


!classDefinition: #CustomerImporterSystem category: 'CustomerImporter'!
Object subclass: #CustomerImporterSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!
!CustomerImporterSystem commentStamp: '<historical>' prior: 0!
"TODO: quitar colaborador interno, hacerlo clase abstracta. Convertir DataBaseSession en un PersistantSystem que herede de esta clase. Agregar un TransientSystem y una jerarquía de Environment"!


!CustomerImporterSystem methodsFor: 'selecting' stamp: 'Matias Cra 11/21/2023 20:44:21'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session 	select: [ :aCustomer | 
			aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]
		] ofType: Customer
	) anyOne! !


!CustomerImporterSystem methodsFor: 'accessing' stamp: 'Matias Cra 11/21/2023 20:30:24'!
session

	^ session! !


!CustomerImporterSystem methodsFor: 'initialization' stamp: 'Matias Cra 11/21/2023 20:30:14'!
initializeFor: aSession

	session := aSession! !


!CustomerImporterSystem methodsFor: 'counting' stamp: 'Matias Cra 11/21/2023 20:42:16'!
countAllAddresses

	^ (session selectAllOfType: Address) size! !

!CustomerImporterSystem methodsFor: 'counting' stamp: 'Matias Cra 11/21/2023 20:42:05'!
countAllCustomers

	^ (session selectAllOfType: Customer) size! !


!CustomerImporterSystem methodsFor: 'closing' stamp: 'Matias Cra 11/21/2023 20:46:52'!
close

	^ session close! !


!CustomerImporterSystem methodsFor: 'persistance' stamp: 'Matias Cra 11/21/2023 20:59:42'!
persist: anObject

	^ session persist: anObject ! !


!CustomerImporterSystem methodsFor: 'transaction management' stamp: 'Matias Cra 11/21/2023 20:58:14'!
beginTransaction

	^ session beginTransaction ! !

!CustomerImporterSystem methodsFor: 'transaction management' stamp: 'Matias Cra 11/21/2023 20:46:35'!
commit

	^ session commit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporterSystem class' category: 'CustomerImporter'!
CustomerImporterSystem class
	instanceVariableNames: ''!

!CustomerImporterSystem class methodsFor: 'instance creation' stamp: 'Matias Cra 11/21/2023 20:29:47'!
for: aSession

	^ self new initializeFor: aSession! !


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
