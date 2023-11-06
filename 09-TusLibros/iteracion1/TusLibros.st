!classDefinition: #BookTest category: 'TusLibros'!
TestCase subclass: #BookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:18:48'!
assertInvalidBookPrice: aPrice
	| book |
	
	self should: [ book := Book title: 'Titulo' price: aPrice isbn: 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: Book priceMustBeValidErrorDescription.
			self assert: book isNil.
		]! !

!BookTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:18:14'!
test01CanCreateBook
	| book |
	book := Book title: 'Titulo' price: 5000 isbn: 1.
	self assert: book title equals: 'Titulo'.
	self assert: book price equals: 5000.
	self assert: book isbn equals: 1.! !

!BookTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:18:39'!
test02CanCreateMultipleBooks
	| book |
	book := Book title: 'Titulo' price: 5000 isbn: 1.
	self assert: book title equals: 'Titulo'.
	self assert: book price equals: 5000.
	self assert: book isbn equals: 1.
	
	book := Book title: 'Titulo 2' price: 2000 isbn: 2.
	self assert: book title equals: 'Titulo 2'.
	self assert: book price equals: 2000.
	self assert: book isbn equals: 2.
	! !

!BookTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:28:28'!
test03PriceMustBeValid

	self assertInvalidBookPrice: -12.
	self assertInvalidBookPrice: 0.
	self assertInvalidBookPrice: '12321'.! !

!BookTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:19:15'!
test04
	"TODO: validar isbn y title"! !


!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:04:01'!
test01CanCreateEmptyCart
	| cart |
	cart := Cart for: user.
	self assert: cart books isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:19:29'!
test02CanAddBookToCart
	| cart book |
	cart := Cart for: user.
	book := Book title: 'Titulo' price: 1000 isbn: 1.
	cart addBook: book.
	self assert: cart books asArray equals: { book }.! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:19:40'!
test03CanAddMultipleBooksToCart
	| cart firstBook secondBook thirdBook |
	cart := Cart for: user.
	firstBook := Book title: 'Titulo' price: 1000 isbn: 1.
	secondBook := Book title: 'Titulo 2' price: 1500 isbn: 2.
	thirdBook := Book title: 'Titulo 3' price: 900 isbn: 3.
	cart addBook: firstBook; addBook: secondBook; addBook: thirdBook.
	self assert: cart books asBag equals: (Bag with: firstBook with: secondBook with: thirdBook).! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:19:45'!
test04CanAddMultipleOfOneBook
	| cart book |
	cart := Cart for: user.
	book := Book title: 'Titulo' price: 1000 isbn: 1.

	cart addBook: book quantity: 5.
	self assert: cart books asSet equals: (Set with: book).
	self assert: (cart books occurrencesOf: book) equals: 5.! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:08:18'!
test05CartIsForASingleUser
	| mariosCart mario pepe |
	mario := User username: 'Mario' password: 'mario123'.
	pepe := User username: 'Pepe' password: 'pepe123'.
	mariosCart := Cart for: mario.

	self deny: (mariosCart belongsTo: pepe). 
	self assert: (mariosCart belongsTo: mario). ! !


!CartTest methodsFor: 'setup' stamp: 'Matias Cra 11/2/2023 14:03:55'!
setUp

	user := User username: 'Pepe' password: 'pepe123'.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'number november2030 september2027 january2023 secondNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setup' stamp: 'Matias Cra 10/30/2023 19:52:09'!
setUp
	
	number := '0123456789101112'.
	secondNumber := '0123456789101113'.
	november2030 := November of: 2030.
	september2027 := September of: 2027.
	january2023 := January of: 2023.! !


!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 19:39:27'!
assertInvalidCardNumber: aCardNumber
	| card |

	self should: [ card := CreditCard withNumber: 123 expiryDate: november2030 owner: 'Pepe Pepito' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard invalidCardNumberErrorDescription.
			self assert: 	card isNil.
		]
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 19:21:34'!
test01CanCreateACard
	| card |
	card := CreditCard withNumber: number expiryDate: november2030 owner: 'Pepe Pepito'.
	self assert: card number equals: number.
	self assert: card expiryDate equals: november2030.
	self assert: card owner equals: 'Pepe Pepito'.! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 19:52:27'!
test02CanCreateMultipleCards
	| firstCard secondCard |
	firstCard := CreditCard withNumber: number expiryDate: november2030 owner: 'Pepe Pepito'.
	secondCard := CreditCard withNumber: secondNumber expiryDate: september2027 owner: 'Darío Perez'.
	
	self assert: firstCard number equals: number.
	self assert: firstCard expiryDate equals: november2030.
	self assert: firstCard owner equals: 'Pepe Pepito'.
	
	self assert: secondCard number equals: secondNumber.
	self assert: secondCard expiryDate equals: september2027.
	self assert: secondCard owner equals: 'Darío Perez'.! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 19:30:08'!
test03CanTestIfItsExpired
	| firstCard secondCard |
	firstCard := CreditCard withNumber: number expiryDate: november2030 owner: 'Pepe Pepito'.
	secondCard := CreditCard withNumber: number expiryDate: january2023 owner: 'Darío Perez'.
	
	self deny: firstCard isExpired.
	self assert: secondCard isExpired.! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 19:52:42'!
test04CardNumberMustBeValid
	
	self assertInvalidCardNumber: '123'.
	self assertInvalidCardNumber: '123412341234123'.
	self assertInvalidCardNumber: 12341234123412345.
	self assertInvalidCardNumber: #ABC.! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 19:42:30'!
test05ExpiryDateMustBeValid
	
	| card |

	self should: [ card := CreditCard withNumber: number expiryDate: #November2023 owner: 'Pepe Pepito' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard invalidExpiryDateErrorDescription.
			self assert: 	card isNil.
		]
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:03:54'!
test06NameMustBeValid
	| card |

	self should: [ card := CreditCard withNumber: number expiryDate: november2030 owner: '' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard invalidOwnerNameErrorDescription.
			self assert: 	card isNil.
		]
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:08:13'!
test07CanCreateCardWithMonthAndYearNumber
	| card |

	card := CreditCard withNumber: number expiryMonthNumber: 11 expiryYearNumber: 2030 owner: 'Pepe Pepito'.
	self assert: card number equals: number.
	self assert: card expiryDate equals: november2030.
	self assert: card owner equals: 'Pepe Pepito'
	! !


!classDefinition: #PurchaseTest category: 'TusLibros'!
TestCase subclass: #PurchaseTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:20:07'!
test01CanCreatePurchase
	| user books purchase |
	user := User username: 'Pepe' password: 'pepe123'.
	books := Bag with: (Book title: 'Titulo' price: 2000 isbn: 1).
	purchase := Purchase for: user books: books.

	self assert: purchase user equals: user.
	self assert: purchase books equals: books.
! !

!PurchaseTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 14:20:32'!
test02CanGetTotal
	| user books purchase |
	user := User username: 'Pepe' password: 'pepe123'.
	books := Bag with: (Book title: 'Titulo' price: 2000 isbn: 1) 
				 with: (Book title: 'Titulo 2' price: 3000 isbn: 2)
				 with: (Book title: 'Titulo 3' price: 4000 isbn: 3).
	purchase := Purchase for: user books: books.

	self assert: purchase user equals: user.
	self assert: purchase books equals: books.
	self assert: purchase total equals: 9000.! !

!PurchaseTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 13:32:32'!
test03
	"TODO"! !


!classDefinition: #UserTest category: 'TusLibros'!
TestCase subclass: #UserTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!UserTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:48:43'!
assertInvalidPassword: aPassword
	| user |
	
	self should: [ user := User username: 'Pepe' password: aPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: User passwordMustBeValidErrorDescription.
			self assert: user isNil.
		]! !

!UserTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:43:05'!
assertInvalidUsername: aUsername
	| user |
	
	self should: [ user := User username: aUsername password: 'asofOdSn14@2d' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: User usernameMustBeValidErrorDescription.
			self assert: user isNil.
		]! !

!UserTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:33:26'!
test01CanCreateUser
	| user |
	user := User username: 'Pepe' password: 'pepe123'.
	self assert: user username equals: 'Pepe'.! !

!UserTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:35:24'!
test02CanCreateManyUsers
	| user |
	user := User username: 'Pepe' password: 'pepe123'.
	self assert: user username equals: 'Pepe'.
	user := User username: 'Pepito' password: 'pepito123'.
	self assert: user username equals: 'Pepito'.! !

!UserTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:37:57'!
test03CanValidateByUsernameAndPassword
	| user |
	user := User username: 'Pepe' password: 'pepe123'.
	self deny: (user isValidUsername: 'Pepe' password: 'pepe1234').
	self deny: (user isValidUsername: 'Pepito' password: 'pepe123').
	self assert: (user isValidUsername: 'Pepe' password: 'pepe123').! !

!UserTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:39:23'!
test04PasswordIsEncrypted
	| user |
	user := User username: 'Pepe' password: 'pepe123'.
	self deny: (user password = 'pepe123').! !

!UserTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:47:44'!
test05UsernameMustBeValid
	
	self assertInvalidUsername: ''.
	self assertInvalidUsername: 123321.
! !

!UserTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 20:48:11'!
test06PasswordMustBeValid
	
	self assertInvalidPassword: ''.
	self assertInvalidPassword: 123321.
	self assertInvalidPassword: 'das'.! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: 'price title isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'accessing' stamp: 'Matias Cra 11/2/2023 14:17:17'!
isbn

	^ isbn! !

!Book methodsFor: 'accessing' stamp: 'Matias Cra 10/30/2023 21:16:04'!
price

	^ price! !

!Book methodsFor: 'accessing' stamp: 'Matias Cra 11/2/2023 13:52:55'!
title

	^ title! !


!Book methodsFor: 'initialization' stamp: 'Matias Cra 10/30/2023 20:30:04'!
assertValidPrice: aPrice

	((aPrice isKindOf: Number) and: [ aPrice > 0 ])
		ifFalse: [ self error: self class priceMustBeValidErrorDescription ]! !

!Book methodsFor: 'initialization' stamp: 'Matias Cra 11/2/2023 14:16:13'!
initializeWithTitle: aTitle price: aPrice isbn: aISBNnumber
	
	self assertValidPrice: aPrice.

	title := aTitle.
	price := aPrice.
	isbn := aISBNnumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'error description' stamp: 'Matias Cra 10/30/2023 20:28:41'!
priceMustBeValidErrorDescription
	
	^ 'Invalid price, it must be a positive number'! !


!Book class methodsFor: 'instance creation' stamp: 'Matias Cra 11/2/2023 14:15:00'!
title: aTitle price: aPrice isbn: aISBNnumber

	^ self new initializeWithTitle: aTitle price: aPrice isbn: aISBNnumber ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'Matias Cra 11/2/2023 14:09:39'!
initializeFor: aUser

	user := aUser.
	books := Bag new! !


!Cart methodsFor: 'adding' stamp: 'Matias Cra 11/2/2023 13:41:34'!
addBook: aBook
	
	books add: aBook! !

!Cart methodsFor: 'adding' stamp: 'Matias Cra 11/2/2023 13:50:44'!
addBook: aBook quantity: aQuantity
	
	books add: aBook withOccurrences: aQuantity! !


!Cart methodsFor: 'accessing' stamp: 'Matias Cra 11/2/2023 13:41:41'!
books
	
	^ books! !


!Cart methodsFor: 'testing' stamp: 'Matias Cra 11/2/2023 14:09:12'!
belongsTo: aUser

	^ user = aUser! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'Matias Cra 11/2/2023 14:09:24'!
for: aUser

	^ self new initializeFor: aUser! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiryDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'assertion' stamp: 'Matias Cra 10/30/2023 19:48:22'!
assertValidExpiryDate: aMonthOfYear

	(aMonthOfYear isKindOf: GregorianMonthOfYear) ifFalse: [ self error: self class invalidExpiryDateErrorDescription ]
! !

!CreditCard methodsFor: 'assertion' stamp: 'Matias Cra 10/30/2023 19:55:55'!
assertValidNumber: aCardNumber

	((aCardNumber isKindOf: String) and: [ aCardNumber size = 16 ] and: [ self isNumericString: aCardNumber ])
		ifFalse: [ self error: self class invalidCardNumberErrorDescription ]! !

!CreditCard methodsFor: 'assertion' stamp: 'Matias Cra 10/30/2023 20:50:17'!
assertValidOwner: anOwnerName

	((anOwnerName isKindOf: CharacterSequence) and: [ anOwnerName isEmpty not ])
		ifFalse: [ self error: self class invalidOwnerNameErrorDescription ]! !

!CreditCard methodsFor: 'assertion' stamp: 'Matias Cra 10/30/2023 19:56:33'!
isNumericString: aCardNumberString

	^ aCardNumberString allSatisfy: 	[ :character | character isDigit ]
! !


!CreditCard methodsFor: 'initialization' stamp: 'Matias Cra 10/30/2023 20:00:06'!
initializeWithNumber: aCardNumberString expiryDate: aMonthOfYear owner: aNameString

	self assertValidNumber: aCardNumberString.
	self assertValidExpiryDate: aMonthOfYear.
	self assertValidOwner: aNameString.

	number := aCardNumberString.
	expiryDate := aMonthOfYear.
	owner := aNameString.! !


!CreditCard methodsFor: 'accessing' stamp: 'Matias Cra 10/30/2023 19:26:10'!
expiryDate

	^ expiryDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'Matias Cra 10/30/2023 19:26:02'!
number

	^ number! !

!CreditCard methodsFor: 'accessing' stamp: 'Matias Cra 10/30/2023 19:26:07'!
owner

	^ owner! !


!CreditCard methodsFor: 'testing' stamp: 'Matias Cra 10/30/2023 19:29:23'!
isExpired

	^ expiryDate <= GregorianMonthOfYear current! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error description' stamp: 'Matias Cra 10/30/2023 19:35:51'!
invalidCardNumberErrorDescription

	^ 'Invalid card number, it must be a number with 16 digits'! !

!CreditCard class methodsFor: 'error description' stamp: 'Matias Cra 10/30/2023 19:43:00'!
invalidExpiryDateErrorDescription

	^ 'Invalid expiry date, it must be a month of year'! !

!CreditCard class methodsFor: 'error description' stamp: 'Matias Cra 10/30/2023 19:58:20'!
invalidOwnerNameErrorDescription

	^ 'Invalid owner name, it must be non empty string'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'Matias Cra 10/30/2023 19:53:15'!
withNumber: aCardNumberString expiryDate: aMonthOfYear owner: aNameString

	^ self new initializeWithNumber: aCardNumberString expiryDate: aMonthOfYear owner: aNameString! !

!CreditCard class methodsFor: 'instance creation' stamp: 'Matias Cra 10/30/2023 20:07:57'!
withNumber: aCardNumberString expiryMonthNumber: aMonthNumber expiryYearNumber: anYearNumber owner: aNameString

	^ self withNumber: aCardNumberString
		   expiryDate: (GregorianMonthOfYear yearNumber: anYearNumber monthNumber: aMonthNumber) 
		   owner: aNameString ! !


!classDefinition: #Purchase category: 'TusLibros'!
Object subclass: #Purchase
	instanceVariableNames: 'user books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Purchase methodsFor: 'accessing' stamp: 'Matias Cra 10/30/2023 21:07:18'!
books

	^ books! !

!Purchase methodsFor: 'accessing' stamp: 'Matias Cra 10/30/2023 21:07:11'!
user

	^ user! !


!Purchase methodsFor: 'initialization' stamp: 'Matias Cra 10/30/2023 21:06:56'!
initializeFor: aUser books: aBooksBag

	user := aUser.
	books := aBooksBag.! !


!Purchase methodsFor: 'total' stamp: 'Matias Cra 10/30/2023 21:12:37'!
total

	^ books inject: 0 into: [ :currentTotal :book | currentTotal + book price ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Purchase class' category: 'TusLibros'!
Purchase class
	instanceVariableNames: ''!

!Purchase class methodsFor: 'instance creation' stamp: 'Matias Cra 10/30/2023 21:06:35'!
for: aUser books: aBooksBag

	^ self new initializeFor: aUser books: aBooksBag.! !


!classDefinition: #User category: 'TusLibros'!
Object subclass: #User
	instanceVariableNames: 'username password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!User methodsFor: 'initialization' stamp: 'Matias Cra 10/30/2023 20:52:02'!
assertValidPassword: aPasswordString

	((aPasswordString isKindOf: CharacterSequence) and: [ aPasswordString size >= 6 ])
		ifFalse: [ self error: self class passwordMustBeValidErrorDescription ]! !

!User methodsFor: 'initialization' stamp: 'Matias Cra 10/30/2023 20:44:55'!
assertValidUsername: aUsernameString

	((aUsernameString isKindOf: String) and: [ aUsernameString size > 1 ])
		ifFalse: [ self error: self class usernameMustBeValidErrorDescription ]! !

!User methodsFor: 'initialization' stamp: 'Matias Cra 10/30/2023 20:51:20'!
initializeUsername: aUsernameString password: aPasswordString
	
	self assertValidUsername: aUsernameString.
	self assertValidPassword: aPasswordString.

	username := aUsernameString.
	password := aPasswordString hash.! !


!User methodsFor: 'accessing' stamp: 'Matias Cra 10/30/2023 20:55:07'!
password
	
	^ password! !

!User methodsFor: 'accessing' stamp: 'Matias Cra 10/30/2023 20:35:34'!
username
	
	^ username! !


!User methodsFor: 'validation' stamp: 'Matias Cra 10/30/2023 20:39:53'!
isValidUsername: aUsernameString password: aPasswordString

	^ username = aUsernameString and: [ password = (aPasswordString hash) ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'User class' category: 'TusLibros'!
User class
	instanceVariableNames: ''!

!User class methodsFor: 'error description' stamp: 'Matias Cra 10/30/2023 20:49:39'!
passwordMustBeValidErrorDescription

	^ 'Invalid password, it must be a string with at least 6 characters'! !

!User class methodsFor: 'error description' stamp: 'Matias Cra 10/30/2023 20:46:03'!
usernameMustBeValidErrorDescription

	^ 'Invalid username, it must be a string with only english characters and with at least two'! !


!User class methodsFor: 'instance creation' stamp: 'Matias Cra 10/30/2023 20:36:38'!
username: aUsernameString password: aPasswordString

	^ self new initializeUsername: aUsernameString password: aPasswordString ! !
