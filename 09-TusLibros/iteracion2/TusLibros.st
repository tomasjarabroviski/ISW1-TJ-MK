!classDefinition: #CartTest category: 'TusLibros-Cart'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Cart'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 18:55:59'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 18:56:08'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 18:56:08'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSoldByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 18:55:59'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSoldByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 18:56:08'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self assert: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 18:56:07'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 18:56:08'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 18:56:08'!
test09CanAccessCartsItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore withOcurrences: 2.
	self assert: cart items asBag equals: (Bag with: self itemSoldByTheStore with: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:40:44'!
test10CanGetTotalPrice

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore withOcurrences: 2.
	self assert: cart total equals: 2000.! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'Matias Cra 11/2/2023 21:35:47'!
defaultCatalog
	
	^ Dictionary with: self itemSoldByTheStore->1000! !

!CartTest methodsFor: 'support' stamp: 'Matias Cra 11/2/2023 18:55:59'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'Matias Cra 11/2/2023 18:56:07'!
itemSoldByTheStore
	
	^ 'validBook'! !


!classDefinition: #Cart category: 'TusLibros-Cart'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Cart'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'Matias Cra 11/2/2023 21:38:07'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'Matias Cra 11/2/2023 18:55:44'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'Matias Cra 11/2/2023 21:36:29'!
items

	^items copy! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'Matias Cra 11/2/2023 21:41:14'!
total

	^ items sum: [ :item | catalog at: item ]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !


!Cart methodsFor: 'checkout' stamp: 'Matias Cra 11/2/2023 20:47:00'!
takeItems
	| itemsTaken |

	itemsTaken := items.
	items := Bag new.
	^ itemsTaken ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Cart'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !
!classDefinition: #CashierTest category: 'TusLibros-Cashier'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Cashier'!

!CashierTest methodsFor: 'tests' stamp: 'Matias Cra 11/4/2023 19:00:19'!
test01CannotCheckoutAnEmptyCart
	| cart cashier |
	cart := self createCart.

	self should: [ cashier := self cashierFor: cart from: self createCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: Cashier emptyCartErrorMessage.	
			self assert: cashier isNil.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 20:50:00'!
test02CanCheckoutACartWithSingleItem
	| cart cashier |
	cart := self createCart.
	cart add: 'Product 1'.
	cashier := self cashierFor: cart from: self createCard.

	self assert: cashier checkout equals: 1000.
	self assert: cart isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 20:49:54'!
test03CanCheckoutACartWithMultipleItems
	| cart cashier |
	cart := self createCart.
	cart add: 'Product 1'.
	cart add: 'Product 2'.
	cashier := self cashierFor: cart from: self createCard.
	
	self assert: cashier checkout equals: 1900.
	self assert: cart isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:51:02'!
test04CannotCheckoutWithInvalidCard
	| cart |
	cart := self createCart.
	cart add: 'Product 1'.
	cart add: 'Product 2'.
	
	self should: [ self cashierFor: cart from: self createInvalidCard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier invalidCardErrorMessage.
			self deny: cart isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'Matias Cra 11/4/2023 18:56:19'!
test05CashierRemembersPurchase
	| cart cashier |
	cart := self createCart.
	cart add: 'Product 1'.
	cart add: 'Product 2'.
	cashier := self cashierFor: cart from: self createCard.
	cashier checkout.

	self assert: cashier itemsSold asBag equals: (Bag with: 'Product 1' with: 'Product 2').
	self assert: cashier totalSold equals: 1900.! !

!CashierTest methodsFor: 'tests' stamp: 'Matias Cra 11/4/2023 19:02:07'!
test06CashierStartsWithoutItemsSold
	| cart cashier |
	cart := self createCart.
	cart add: 'Product 1'.
	cart add: 'Product 2'.
	cashier := self cashierFor: cart from: self createCard.

	self assert: cashier itemsSold isEmpty.
	self assert: cashier totalSold equals: 0.! !


!CashierTest methodsFor: 'support' stamp: 'Matias Cra 11/6/2023 11:35:56'!
cashierFor: aCart from: aCreditCard

	^ Cashier for: aCart from: aCreditCard merchantProcessor: MerchantProcessor successTester.! !

!CashierTest methodsFor: 'support' stamp: 'Matias Cra 11/2/2023 21:48:43'!
createCard
	
	^ CreditCard number: '1234123412341234' expiryDate: (November of: 2030)! !

!CashierTest methodsFor: 'support' stamp: 'Matias Cra 11/2/2023 18:38:18'!
createCart
	
	^ Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'Matias Cra 11/2/2023 21:48:58'!
createInvalidCard

	^ CreditCard number: '1234123412341234' expiryDate: (January of: 2022)! !

!CashierTest methodsFor: 'support' stamp: 'Matias Cra 11/2/2023 21:42:47'!
defaultCatalog

	^ Dictionary with: 'Product 1'->1000 with: 'Product 2'->900 with: 'Product 3'->1200.! !


!classDefinition: #Cashier category: 'TusLibros-Cashier'!
Object subclass: #Cashier
	instanceVariableNames: 'cart card itemsSold totalSold merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Cashier'!

!Cashier methodsFor: 'checkout' stamp: 'Matias Cra 11/6/2023 11:41:51'!
checkout
	| total |

	total := cart total.
	merchantProcessor debit: totalSold from: card.
	itemsSold := cart takeItems.
	^ totalSold := total ! !


!Cashier methodsFor: 'initialization' stamp: 'Matias Cra 11/6/2023 11:40:52'!
initializeFor: aCart from: aCreditCard merchantProcessor: aMerchantProcessor

	merchantProcessor := aMerchantProcessor.
	cart := aCart.
	card := aCreditCard.
	itemsSold := Bag new.
	totalSold := 0.! !


!Cashier methodsFor: 'accessing' stamp: 'Matias Cra 11/4/2023 18:55:17'!
itemsSold

	^ itemsSold ! !

!Cashier methodsFor: 'accessing' stamp: 'Matias Cra 11/4/2023 18:55:24'!
totalSold

	^ totalSold ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Cashier'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:40:25'!
for: aCart from: aCreditCard current: aMonthOfYear merchantProcessor: aMerchantProcessor

	self assertValidCart: aCart.
	self assertValidCard: aCreditCard to: aMonthOfYear.

	^ self new initializeFor: aCart from: aCreditCard merchantProcessor: aMerchantProcessor.! !

!Cashier class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:39:29'!
for: aCart from: aCreditCard merchantProcessor: aMerchantProcessor

	^ self for: aCart from: aCreditCard current: GregorianMonthOfYear current merchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'error assertion' stamp: 'Matias Cra 11/2/2023 21:47:50'!
assertValidCard: aCreditCard to: aMonthOfYear

	(aCreditCard isExpiredTo: aMonthOfYear) 
		ifTrue: [ self error: self invalidCardErrorMessage ]! !

!Cashier class methodsFor: 'error assertion' stamp: 'Matias Cra 11/2/2023 20:42:48'!
assertValidCart: aCart

	(aCart isEmpty) 
		ifTrue: [ self error: self emptyCartErrorMessage ]! !

!Cashier class methodsFor: 'error assertion' stamp: 'Matias Cra 11/2/2023 20:42:35'!
emptyCartErrorMessage

	^ 'Cannot cashout an empty cart'! !

!Cashier class methodsFor: 'error assertion' stamp: 'Matias Cra 11/2/2023 20:45:49'!
invalidCardErrorMessage

	^ 'Cannot cashout, invalid credit card'! !
!classDefinition: #CreditCardTest category: 'TusLibros-CreditCard'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'number november2030 pepe'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-CreditCard'!

!CreditCardTest methodsFor: 'setup' stamp: 'Matias Cra 11/2/2023 21:25:18'!
setUp

	number := '1234123412341234'.
	november2030 := November of: 2030.
! !


!CreditCardTest methodsFor: 'support' stamp: 'Matias Cra 11/2/2023 21:25:12'!
createCard

	^ CreditCard number: number expiryDate: november2030.! !


!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:27:06'!
assertInvalidExpiryDate: aValue
	| card |
	self should: [ card := CreditCard number: number expiryDate: aValue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CreditCard invalidExpiryDateErrorDescription.
			self assert: card isNil.	
		]! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:25:24'!
assertInvalidNumber: aValue
	| card |
	self should: [ card := CreditCard number: aValue expiryDate: november2030 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CreditCard invalidNumberErrorDescription.
			self assert: card isNil.	
		]! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:25:28'!
test01CanCreateCard
	| card |
	
	card := self createCard.
	self assert: card number equals: number.
	self assert: card expiryDate equals: november2030.
! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:26:29'!
test02CanCreateMultipleCards
	| card |
	
	card := self createCard.
	self assert: card number equals: number.
	self assert: card expiryDate equals: november2030.

	
	card := CreditCard number: '0123012301230123' expiryDate: (October of: 2025).
	self assert: card number equals: '0123012301230123'.
	self assert: card expiryDate equals: (October of: 2025).
! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:10:21'!
test03CannotCreateCardWithInvalidNumber
	
	self assertInvalidNumber: '-12321'.
	self assertInvalidNumber: '123412341234123'.
	self assertInvalidNumber: 'pepe'.
	self assertInvalidNumber: 12.2.! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:28:34'!
test04CannotCreateCardWithInvalidExpiryDate
	
	self assertInvalidExpiryDate: December / 25 / 2023.
	self assertInvalidExpiryDate: '06/2024'.
	self assertInvalidExpiryDate: October / 1.! !

!CreditCardTest methodsFor: 'tests' stamp: 'Matias Cra 11/2/2023 21:26:18'!
test05CanCheckIfCardIsExpired
	| card |
	
	card := self createCard.
	self deny: (card isExpiredTo: (November of: 2023)).
	self assert: (card isExpiredTo: (December of: 2030)).! !


!classDefinition: #CreditCard category: 'TusLibros-CreditCard'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiryDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-CreditCard'!

!CreditCard methodsFor: 'initialization' stamp: 'Matias Cra 11/2/2023 21:26:05'!
initializeNumber: aCardNumber expiryDate: aMonthOfYear
	
	number := aCardNumber.
	expiryDate := aMonthOfYear.
! !


!CreditCard methodsFor: 'accessing' stamp: 'Matias Cra 11/2/2023 21:02:06'!
expiryDate

	^ expiryDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'Matias Cra 11/2/2023 21:02:11'!
number

	^ number ! !

!CreditCard methodsFor: 'accessing' stamp: 'Matias Cra 11/2/2023 21:02:15'!
owner

	^ owner! !


!CreditCard methodsFor: 'testing' stamp: 'Matias Cra 11/2/2023 21:15:17'!
isExpiredTo: aMonthOfYear

	^ expiryDate <= aMonthOfYear ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-CreditCard'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error assertion' stamp: 'Matias Cra 11/4/2023 18:40:37'!
assertValidCardNumber: aCardNumber

	((aCardNumber isKindOf: String)
	and: [ aCardNumber size = 16 ]
	and: [ aCardNumber allSatisfy: [ :char | char isDigit ] ])
		ifFalse: [ self error: self invalidNumberErrorDescription ]! !

!CreditCard class methodsFor: 'error assertion' stamp: 'Matias Cra 11/2/2023 21:31:28'!
assertValidExpiryDate: anExpiryDate

	(anExpiryDate isKindOf: GregorianMonthOfYear)
		ifFalse: [ self error: self invalidExpiryDateErrorDescription ]! !

!CreditCard class methodsFor: 'error assertion' stamp: 'Matias Cra 11/2/2023 21:29:04'!
invalidExpiryDateErrorDescription

	^ 'Invalid expiry date, it must be a month of year'! !

!CreditCard class methodsFor: 'error assertion' stamp: 'Matias Cra 11/2/2023 21:05:30'!
invalidNumberErrorDescription

	^ 'Invalid card number, it must be a numeric string with 16 characters'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'Matias Cra 11/2/2023 21:34:19'!
number: aCardNumber expiryDate: aMonthOfYear
	
	self assertValidCardNumber: aCardNumber.
	self assertValidExpiryDate: aMonthOfYear.
	
	^ self new initializeNumber: aCardNumber expiryDate: aMonthOfYear! !
!classDefinition: #MerchantProcessorTest category: 'TusLibros-MerchantProcessor'!
TestCase subclass: #MerchantProcessorTest
	instanceVariableNames: 'card'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!MerchantProcessorTest methodsFor: 'setup' stamp: 'Matias Cra 11/4/2023 22:15:18'!
setUp

	card := CreditCard number: '1234123412341234' expiryDate: (October of: 2030).! !


!MerchantProcessorTest methodsFor: 'tests' stamp: 'Matias Cra 11/5/2023 15:46:46'!
test01CanSimulateSuccessfulDebit
	| merchantProcessor |

	merchantProcessor := MerchantProcessor successTester.
	self assert: (merchantProcessor debit: 1000 from: card) isInteger.
! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'Matias Cra 11/5/2023 15:46:46'!
test02CanSimulateMultipleSuccessfulDebits
	| merchantProcessor transactionId1 transactionId2 |

	merchantProcessor := MerchantProcessor successTester.
	transactionId1 := merchantProcessor debit: 1000 from: card.
	transactionId2 := merchantProcessor debit: 2000 from: card.
	
	self assert: transactionId1 isInteger.
	self assert: transactionId2 isInteger.
	self deny: transactionId1 = transactionId2.! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'Matias Cra 11/5/2023 15:48:37'!
test03CanSimulateNonExistantCard
	| merchantProcessor |

	merchantProcessor := MerchantProcessor nonExistantCard.
	self should: [ merchantProcessor debit: 1000 from: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: merchantProcessor nonExistantCardErrorDescription.	
			self assert: merchantProcessor lastTransactionId equals: 0.
		]
! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'Matias Cra 11/5/2023 15:52:32'!
test04CanSimulateExpiredCard
	| merchantProcessor |

	merchantProcessor := MerchantProcessor expiredCard.
	self should: [ merchantProcessor debit: 1000 from: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: merchantProcessor expiredCardErrorDescription.	
			self assert: merchantProcessor lastTransactionId equals: 0.
		]
! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'Matias Cra 11/5/2023 15:55:03'!
test05CanSimulateStolenCard
	| merchantProcessor |

	merchantProcessor := MerchantProcessor stolenCard.
	self should: [ merchantProcessor debit: 1000 from: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: merchantProcessor stolenCardErrorDescription.	
			self assert: merchantProcessor lastTransactionId equals: 0.
		]
! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'Matias Cra 11/5/2023 16:00:17'!
test06CanSimulateWrongCardOwner
	| merchantProcessor |

	merchantProcessor := MerchantProcessor wrongCardOwner.
	self should: [ merchantProcessor debit: 1000 from: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: merchantProcessor wrongCardOwnerErrorDescription.	
			self assert: merchantProcessor lastTransactionId equals: 0.
		]
! !

!MerchantProcessorTest methodsFor: 'tests' stamp: 'Matias Cra 11/5/2023 16:05:07'!
test07CanSimulateInsufficentFunds
	| merchantProcessor |

	merchantProcessor := MerchantProcessor insufficientFunds.
	self should: [ merchantProcessor debit: 1000 from: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: merchantProcessor insufficentFundsErrorDescription.	
			self assert: merchantProcessor lastTransactionId equals: 0.
		]
! !


!classDefinition: #MerchantProcessor category: 'TusLibros-MerchantProcessor'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'lastId state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!MerchantProcessor methodsFor: 'debiting' stamp: 'Matias Cra 11/6/2023 12:00:49'!
debit: anAmmount from: aCreditCard

	^ state debit: anAmmount from: aCreditCard ! !

!MerchantProcessor methodsFor: 'debiting' stamp: 'Matias Cra 11/6/2023 11:50:22'!
nextId

	^ lastId := lastId + 1
! !


!MerchantProcessor methodsFor: 'initialization' stamp: 'Matias Cra 11/6/2023 12:00:35'!
initializeFor: aMerchantProcessorState

	state := aMerchantProcessorState.
	lastId := 0.! !


!MerchantProcessor methodsFor: 'accessing' stamp: 'Matias Cra 11/5/2023 15:46:04'!
lastTransactionId

	^ lastId! !


!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 15:53:21'!
expiredCardErrorDescription
	
	^ 'The provided card is expired. Contact your card provider to ask for a new card'! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 16:03:47'!
insufficentFundsErrorDescription
	
	^ 'Couldn''t perform the operation. Insufficient funds in account or ammount surpasses allowed limit'! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 15:48:21'!
nonExistantCardErrorDescription
	
	^ 'The provided card doesn''t exist. Check the provided information is correct'! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 15:53:33'!
signalExpiredCard

	self error: self expiredCardErrorDescription ! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 16:04:17'!
signalInsufficientFunds
	
	self error: self insufficentFundsErrorDescription ! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 15:48:30'!
signalNonExistantCard

	self error: self nonExistantCardErrorDescription ! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 15:57:11'!
signalStolenCard

	self error: self stolenCardErrorDescription ! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 15:59:39'!
signalWrongCardOwner
	
	self error: self wrongCardOwnerErrorDescription ! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 15:56:43'!
stolenCardErrorDescription
	
	^ 'The provided card has been reported as stolen. If you think this is a mistake contact your card provider'! !

!MerchantProcessor methodsFor: 'error assertion' stamp: 'Matias Cra 11/5/2023 15:59:16'!
wrongCardOwnerErrorDescription
	
	^ 'The provided owner name doesn''t match with the registered owner. Please check the provided information'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros-MerchantProcessor'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:58:20'!
expiredCard

	^ self for: ExpiredCard ! !

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:59:48'!
for: aMerchantProcessorState
	| merchantProcessor |

	merchantProcessor := self new.
	^ merchantProcessor initializeFor: (aMerchantProcessorState for: merchantProcessor)! !

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:58:27'!
insufficientFunds

	^ self for: InsufficientFunds ! !

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:58:32'!
nonExistantCard

	^ self for: NonExistantCard ! !

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:58:36'!
stolenCard

	^ self for: StolenCard ! !

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 12:02:03'!
successTester

	^ self for: Success ! !

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:58:49'!
wrongCardOwner

	^ self for: WrongCardOwner ! !


!classDefinition: #MerchantProcessorState category: 'TusLibros-MerchantProcessor'!
Object subclass: #MerchantProcessorState
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!MerchantProcessorState methodsFor: 'initialization' stamp: 'Matias Cra 11/6/2023 11:52:19'!
initializeFor: aMerchantProcessor

	merchantProcessor := aMerchantProcessor! !


!MerchantProcessorState methodsFor: 'deibiting' stamp: 'Matias Cra 11/6/2023 11:47:13'!
debit: anAmmount from: aCard

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorState class' category: 'TusLibros-MerchantProcessor'!
MerchantProcessorState class
	instanceVariableNames: ''!

!MerchantProcessorState class methodsFor: 'instance creation' stamp: 'Matias Cra 11/6/2023 11:51:17'!
for: aMerchantProcessor

	^ self new initializeFor: aMerchantProcessor ! !


!classDefinition: #ExpiredCard category: 'TusLibros-MerchantProcessor'!
MerchantProcessorState subclass: #ExpiredCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!ExpiredCard methodsFor: 'debiting' stamp: 'Matias Cra 11/6/2023 11:55:45'!
debit: anAmmount from: aCard

	merchantProcessor signalExpiredCard ! !


!classDefinition: #InsufficientFunds category: 'TusLibros-MerchantProcessor'!
MerchantProcessorState subclass: #InsufficientFunds
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!InsufficientFunds methodsFor: 'debiting' stamp: 'Matias Cra 11/6/2023 11:57:15'!
debit: anAmmount from: aCard

	merchantProcessor signalInsufficientFunds ! !


!classDefinition: #NonExistantCard category: 'TusLibros-MerchantProcessor'!
MerchantProcessorState subclass: #NonExistantCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!NonExistantCard methodsFor: 'debiting' stamp: 'Matias Cra 11/6/2023 11:55:18'!
debit: anAmmount from: aCard

	merchantProcessor signalNonExistantCard! !


!classDefinition: #StolenCard category: 'TusLibros-MerchantProcessor'!
MerchantProcessorState subclass: #StolenCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!StolenCard methodsFor: 'debiting' stamp: 'Matias Cra 11/6/2023 11:56:07'!
debit: anAmmount from: aCard

	merchantProcessor signalStolenCard ! !


!classDefinition: #Success category: 'TusLibros-MerchantProcessor'!
MerchantProcessorState subclass: #Success
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!Success methodsFor: 'debiting' stamp: 'Matias Cra 11/6/2023 11:52:47'!
debit: anAmmount from: aCard

	^ merchantProcessor nextId! !


!classDefinition: #WrongCardOwner category: 'TusLibros-MerchantProcessor'!
MerchantProcessorState subclass: #WrongCardOwner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-MerchantProcessor'!

!WrongCardOwner methodsFor: 'debiting' stamp: 'Matias Cra 11/6/2023 11:56:52'!
debit: anAmmount from: aCard

	merchantProcessor signalWrongCardOwner ! !
