!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'MatiasCra 11/7/2023 11:51:18'!
test09CanSeeTheCartsItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart items occurrencesOf: testObjectsFactory itemSellByTheStore) = 2.
	self assert: cart items size = 2.! !

!CartTest methodsFor: 'tests' stamp: 'MatiasCra 11/7/2023 11:54:29'!
test10CannoBypassCartsProtocol

	| cart items |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	items := cart items.
	items add: testObjectsFactory itemSellByTheStore.
	self deny: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) =
				(items occurrencesOf: testObjectsFactory itemSellByTheStore)! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 12:20:49'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier := Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InternalClientInterfaceTest category: 'TusLibros'!
TestCase subclass: #InternalClientInterfaceTest
	instanceVariableNames: 'testObjectsFactory isValidUserBehavour currentDateAndTime'
	classVariableNames: 'ClientInterface'
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalClientInterfaceTest methodsFor: 'support' stamp: 'MatiasCra 11/9/2023 14:03:26'!
advanceThirtyMinutes

	currentDateAndTime := currentDateAndTime + 30 minutes.
! !

!InternalClientInterfaceTest methodsFor: 'support' stamp: 'MatiasCra 11/9/2023 14:13:56'!
advanceTwentyNineMinutes

	currentDateAndTime := currentDateAndTime + 29 minutes.
! !

!InternalClientInterfaceTest methodsFor: 'support' stamp: 'MatiasCra 11/6/2023 20:41:55'!
createCartClient: aClientId password: aPassword
	| anInterface |
	
	anInterface := self createInterface.
	^ self interface: anInterface createCartClient: aClientId password: aPassword.
! !

!InternalClientInterfaceTest methodsFor: 'support' stamp: 'MatiasCra 11/9/2023 14:04:50'!
createInterface

	^ InternalClientInterface
		authenticator: self
		catalogue: testObjectsFactory defaultCatalog
		merchantProcessor: self
		timeProvider: self.! !

!InternalClientInterfaceTest methodsFor: 'support' stamp: 'MatiasCra 11/9/2023 14:47:01'!
decreaseOneMinute

	currentDateAndTime := currentDateAndTime - 1 minutes.
! !

!InternalClientInterfaceTest methodsFor: 'support' stamp: 'MatiasCra 11/6/2023 20:52:11'!
interface: anInterface createCartClient: aClientId password: aPassword

	^ anInterface createCartClient: aClientId password: aPassword
! !


!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/7/2023 11:58:15'!
test01CanCreateCart
	| cartId interface |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	self assert: cartId isNumber.
	self assert: (interface listCart: cartId) isEmpty.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/7/2023 11:59:47'!
test02CannotCreateCartWithInvalidUser
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | false ].

	self should: [ 	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 	interface invalidUserErrorMessage.
			self shouldFail: [ interface listCart: cartId ]
		]! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/7/2023 12:00:33'!
test03CanCreateMultipleCarts
	| interface cartId secondCartId |

	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].

	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	secondCartId := self interface: interface createCartClient: 2 password: 'hijklim123'.

	self assert: cartId isNumber.
	self assert: secondCartId isNumber.
	self deny: (cartId = secondCartId).
	self assert: (interface listCart: cartId) isEmpty.
	self assert: (interface listCart: secondCartId) isEmpty.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/6/2023 21:47:52'!
test04CanAddToCart
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore.

	self assert: (interface listCart: cartId) includes: testObjectsFactory itemSellByTheStore! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/7/2023 11:37:41'!
test05CanAddMultipleToCart
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.

	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 3.
	self assert: ((interface listCart: cartId) occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 3.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 11:17:46'!
test06CanListEmptyCart
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 2 password: 'abcdefg123'.

	self assert: (interface listCart: cartId) isEmpty.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 11:17:52'!
test07CanListNonEmptyCart
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 2 password: 'abcdefg123'.

	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 3.
	self assert: (interface listCart: cartId) size equals: 3.
	self assert: ((interface listCart: cartId) occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 3.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 13:46:40'!
test08CannotCheckoutEmptyCart
	| cartId interface |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	self should: [ interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier cartCanNotBeEmptyErrorMessage.
			self assert: (interface listPurchasesClient: 1 password: 'abcdefg123') isEmpty.
		]! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 13:47:20'!
test09CanCheckoutNonEmptyCart
	| cartId interface transactionId |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore.
	
	transactionId := interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard.
	self assert: transactionId isInteger.
	self deny: (interface listPurchasesClient: 1 password: 'abcdefg123') isEmpty.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 13:47:49'!
test10CanCheckoutMultipleCarts
	| firstCartId secondCartId interface firstTransactionId secondTransactionId |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	firstCartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	secondCartId := self interface: interface createCartClient: 2 password: 'hijklmn123'.

	interface addToCart: firstCartId book: testObjectsFactory itemSellByTheStore quantity: 2.
	interface addToCart: secondCartId book: testObjectsFactory itemSellByTheStore quantity: 5.

	firstTransactionId := interface checkOut: firstCartId charging: testObjectsFactory notExpiredCreditCard.
	secondTransactionId := interface checkOut: secondCartId charging: testObjectsFactory notExpiredCreditCard.
	self deny: firstTransactionId = secondTransactionId.
	self deny: (interface listPurchasesClient: 1 password: 'abcdefg123') isEmpty.
	self deny: (interface listPurchasesClient: 2 password: 'hijklmn123') isEmpty.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 11:27:54'!
test11CanListEmptyPurchases
	| interface purchase |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.

	purchase := interface listPurchasesClient: 1 password: 'abcdefg123'.
	self assert: purchase isEmpty.
! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 11:26:56'!
test12CanListSingleItemPurchase
	| cartId interface purchase |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore.
	
	interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard.

	purchase := interface listPurchasesClient: 1 password: 'abcdefg123'.
	self assert: purchase includes: testObjectsFactory itemSellByTheStore.
! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 11:36:48'!
test13CanListMultipleItemsPurchase
	| cartId interface purchase |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 12.
	
	interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard.

	purchase := interface listPurchasesClient: 1 password: 'abcdefg123'.
	self assert: (purchase occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 12.
! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 11:40:24'!
test14PurchasesOnlyHavePurchasedItems
	| cartId interface purchase |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 10.
	
	interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard.

	purchase := interface listPurchasesClient: 1 password: 'abcdefg123'.
	self assert: (purchase occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 10.
	self assert: purchase size equals: 10.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 13:01:32'!
test15CanListItemsFromMultiplePurchases
	| firstCartId secondCartId interface purchases |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	
	firstCartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: firstCartId book: testObjectsFactory itemSellByTheStore quantity: 12.
	interface checkOut: firstCartId charging: testObjectsFactory notExpiredCreditCard.

	secondCartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: secondCartId book: testObjectsFactory itemSellByTheStore quantity: 8.
	interface checkOut: secondCartId charging: testObjectsFactory notExpiredCreditCard.

	purchases := interface listPurchasesClient: 1 password: 'abcdefg123'.
	self assert: (purchases occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 20.
	self assert: purchases size equals: 20.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 13:34:08'!
test16CanGetPurchasesTotal
	| cartId interface purchases |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 20.
	interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard.
	
	purchases := interface listPurchasesClient: 1 password: 'abcdefg123'.
	self assert: purchases total equals: testObjectsFactory itemSellByTheStorePrice * 20.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 13:35:27'!
test17CanGetEmptyPurchasesTotal
	| interface purchases |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.

	purchases := interface listPurchasesClient: 1 password: 'abcdefg123'.
	self assert: purchases total equals: 0.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:28:06'!
test18CannotAddToCartAfterThirtyMinutes
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	self shouldntFail: [ interface addToCart: cartId book: testObjectsFactory itemSellByTheStore ].
	
	self advanceThirtyMinutes.
	
	self should: [ interface addToCart: cartId book: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood 
		withMessageText: interface expiredCartMessageText! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:22:39'!
test19CanAddToCartBeforeThirtyMinutes
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	self advanceTwentyNineMinutes.

	self shouldntFail: [ interface addToCart: cartId book: testObjectsFactory itemSellByTheStore ].! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:25:12'!
test20CartModifiedTimeUpdatesOnAdd
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	self advanceTwentyNineMinutes.

	self shouldntFail: [ interface addToCart: cartId book: testObjectsFactory itemSellByTheStore ].
	
	self advanceTwentyNineMinutes.
	
	self shouldntFail: [ interface addToCart: cartId book: testObjectsFactory itemSellByTheStore ].! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:28:50'!
test21CannotListExpiredCart
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	self shouldntFail: [ interface listCart: cartId ].
	
	self advanceThirtyMinutes.
	
	self should: [ interface listCart: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: interface expiredCartMessageText! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:25:56'!
test22CartModifiedTimeUpdatesOnList
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	self advanceTwentyNineMinutes.

	self shouldntFail: [ interface listCart: cartId ].
	
	self advanceTwentyNineMinutes.
	
	self shouldntFail: [ interface listCart: cartId ].! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:31:39'!
test23CannotCheckoutExpiredCart
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore.
	
	self advanceThirtyMinutes.
	
	self should: [ interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 	interface expiredCartMessageText.
			self assert: (interface listPurchasesClient: 1 password: 'abcdefg123') isEmpty	
		]! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:39:17'!
test24CartModifiedTimeUpdatesOnCheckout
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore.

	self advanceTwentyNineMinutes.

	self shouldntFail: [ interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard ].
	
	self advanceTwentyNineMinutes.
	
	self shouldntFail: [ interface listCart: cartId ].
! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:40:57'!
test25CannotAccessNonExistantCart
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	self should: [ interface listCart: cartId + 1 ]
		raise: Error - MessageNotUnderstood
		description: interface nonExistantCartErrorMessage.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 14:48:31'!
test26CannotAccessCartBeforeCreation
	| interface cartId |
	
	interface := self createInterface.
	isValidUserBehavour := [ :userId :password | true ].
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	
	self decreaseOneMinute.
	self should: [ interface listCart: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: interface unknownErrorMessage.! !

!InternalClientInterfaceTest methodsFor: 'tests' stamp: 'MatiasCra 11/9/2023 15:43:49'!
test27CannotModifyPurchaseWithoutCheckout
	| cartId interface purchase |

	isValidUserBehavour := [ :userId :password | true ].
	interface := self createInterface.
	cartId := self interface: interface createCartClient: 1 password: 'abcdefg123'.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 12.
	
	interface checkOut: cartId charging: testObjectsFactory notExpiredCreditCard.

	purchase := interface listPurchasesClient: 1 password: 'abcdefg123'.
	 
	self shouldFail: [ purchase add: (Sale of: #('Pepe') total: 100) ].
	self deny: ((interface listPurchasesClient: 1 password: 'abcdefg123') includes: 'Pepe').
	! !


!InternalClientInterfaceTest methodsFor: 'setup' stamp: 'MatiasCra 11/9/2023 14:02:47'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	isValidUserBehavour := [ :userId :password | ].
	currentDateAndTime := DateAndTime today.! !


!InternalClientInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'MatiasCra 11/9/2023 11:58:06'!
debit: anAmmount from: aCreditCard

! !


!InternalClientInterfaceTest methodsFor: 'clock protocol' stamp: 'MatiasCra 11/9/2023 14:00:53'!
now

	^ currentDateAndTime! !


!InternalClientInterfaceTest methodsFor: 'user authenticator protocol' stamp: 'MatiasCra 11/6/2023 20:35:19'!
isValid: aUserId password: aPassword

	^ isValidUserBehavour value: aUserId value: aPassword ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'MatiasCra 11/9/2023 12:27:22'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'MatiasCra 11/7/2023 11:54:42'!
items

	^ items copy! !

!Cart methodsFor: 'queries' stamp: 'MatiasCra 11/9/2023 12:27:35'!
occurrencesOf: anItem

	^ items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'MatiasCra 11/9/2023 12:27:39'!
includes: anItem

	^ items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'MatiasCra 11/9/2023 12:27:41'!
isEmpty
	
	^ items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MatiasCra 11/9/2023 12:23:01'!
createSale

	^ Sale of: (cart items) total: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InternalClientInterface category: 'TusLibros'!
Object subclass: #InternalClientInterface
	instanceVariableNames: 'authenticator lastCartId catalogue carts lastTransactionId purchases merchantProcessor timeProvider'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalClientInterface methodsFor: 'initialization' stamp: 'MatiasCra 11/9/2023 14:06:04'!
initializeWithAuthenticator: aUserAuthenticator catalogue: aCatalogue merchantProcessor: aMerchantProcessor timeProvider: aTimeProvider   

	carts := Dictionary new.
	purchases := Dictionary new.
	lastCartId := 0.
	lastTransactionId := 0.
	catalogue := aCatalogue.
	authenticator := aUserAuthenticator.
	merchantProcessor := aMerchantProcessor.
	timeProvider := aTimeProvider.! !


!InternalClientInterface methodsFor: 'cart time limit - private' stamp: 'MatiasCra 11/9/2023 14:17:30'!
cartTimeLimit

	^ 30 minutes! !

!InternalClientInterface methodsFor: 'cart time limit - private' stamp: 'MatiasCra 11/9/2023 14:17:55'!
timeSinceModified: aCartId

	^ timeProvider now - (self timeStampFor: aCartId)! !


!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/9/2023 14:50:05'!
assertValidCart: aCartId
	
	(carts includesKey: aCartId)
		ifFalse: [ self signalNonExistantCart ].
	
	((self timeSinceModified: aCartId) < 0 minutes)
		ifTrue: [ self signalUnknownError ].
	
	((self timeSinceModified: aCartId) >= self cartTimeLimit)
		ifTrue: [ self signalExpiredCart ]! !

!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/9/2023 14:12:16'!
expiredCartMessageText

	^ 'This cart has expired due to inactivity, please create a new cart'! !

!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/6/2023 20:56:04'!
invalidUserErrorMessage

	^ 'User isn''t valid'! !

!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/9/2023 14:42:24'!
nonExistantCartErrorMessage

	^ 'The requested cart doesn''t exist, please provide a valid cart id'! !

!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/9/2023 14:11:47'!
signalExpiredCart

	^ self error: self expiredCartMessageText! !

!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/6/2023 20:54:39'!
signalInvalidUser

	^ self error: self invalidUserErrorMessage! !

!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/9/2023 14:42:03'!
signalNonExistantCart
	
	self error: self nonExistantCartErrorMessage! !

!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/9/2023 14:48:47'!
signalUnknownError

	self error: self unknownErrorMessage! !

!InternalClientInterface methodsFor: 'error assertion' stamp: 'MatiasCra 11/9/2023 14:49:13'!
unknownErrorMessage

	^ 'Cannot perform the request, an unknown error has occured'! !


!InternalClientInterface methodsFor: 'cart interface' stamp: 'MatiasCra 11/6/2023 21:49:35'!
addToCart: aCartId book: aBook

	self addToCart: aCartId book: aBook quantity: 1! !

!InternalClientInterface methodsFor: 'cart interface' stamp: 'MatiasCra 11/9/2023 14:23:59'!
addToCart: aCartId book: aBook quantity: aQuantity

	self assertValidCart: aCartId.
	(self cartFor: aCartId) add: aQuantity of: aBook.
	self updateCartTimeStamp: aCartId.! !

!InternalClientInterface methodsFor: 'cart interface' stamp: 'MatiasCra 11/9/2023 14:38:05'!
checkOut: cartId charging: aCreditCard
	| cashier |
	
	self assertValidCart: cartId.
	(purchases includesKey: (self clientFor: cartId)) ifFalse: [ 
		purchases at: (self clientFor: cartId) put: SalesBook new.
	].

	cashier := Cashier toCheckout: (carts at: cartId) second
					   charging: aCreditCard 
					   throught: merchantProcessor 
					   on: DateAndTime today
					   registeringOn: (purchases at: (self clientFor: cartId)).
	cashier checkOut.
	
	self updateCartTimeStamp: cartId.
	^ self nextTransactionId! !

!InternalClientInterface methodsFor: 'cart interface' stamp: 'MatiasCra 11/9/2023 11:41:35'!
createCartClient: aClientId password: aPassword
	
	self authenticateClientId: aClientId password: aPassword.
	self saveNewCart: self nextCartId for: aClientId.
	^ lastCartId! !

!InternalClientInterface methodsFor: 'cart interface' stamp: 'MatiasCra 11/9/2023 14:29:31'!
listCart: aCartId

	self assertValidCart: aCartId.	
	self updateCartTimeStamp: aCartId.
	^ (self cartFor: aCartId) items! !

!InternalClientInterface methodsFor: 'cart interface' stamp: 'MatiasCra 11/9/2023 13:07:24'!
listPurchasesClient: aClientId password: aPassword

	self authenticateClientId: aClientId password: aPassword.
	^ self purchasesFor: aClientId.
! !


!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/6/2023 20:53:53'!
authenticateClientId: aClientId password: aPassword

	(authenticator isValid: aClientId password: aPassword)
		ifFalse: [ self signalInvalidUser ]
! !

!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/9/2023 14:08:17'!
cartFor: aCartId

	^ (carts at: aCartId) second! !

!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/9/2023 12:11:18'!
clientFor: cartId

	^ (carts at: cartId) first! !

!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/9/2023 11:14:03'!
nextCartId

	^ lastCartId := lastCartId + 1! !

!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/9/2023 11:14:48'!
nextTransactionId

	^ lastTransactionId := lastTransactionId + 1! !

!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/9/2023 15:40:38'!
purchasesFor: aClientId

	^ PurchasesList for: (purchases at: aClientId ifAbsent: [ ^ SalesBook new ])! !

!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/9/2023 14:07:45'!
saveNewCart: aCartId for: aClientId

	carts at: aCartId put: {aClientId. Cart acceptingItemsOf: catalogue. timeProvider now}.! !

!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/9/2023 14:11:15'!
timeStampFor: aCartId

	^ (carts at: aCartId) third! !

!InternalClientInterface methodsFor: 'cart interface - private' stamp: 'MatiasCra 11/9/2023 14:24:52'!
updateCartTimeStamp: aCartId

	(carts at: aCartId) at: 3 put: timeProvider now! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalClientInterface class' category: 'TusLibros'!
InternalClientInterface class
	instanceVariableNames: ''!

!InternalClientInterface class methodsFor: 'instance creation' stamp: 'MatiasCra 11/9/2023 14:05:53'!
authenticator: aUserAuthenticator catalogue: aCatalogue merchantProcessor: aMerchantProcessor timeProvider: aTimeProvider  

	^ self new
		initializeWithAuthenticator: aUserAuthenticator
		catalogue: aCatalogue
		merchantProcessor: aMerchantProcessor timeProvider: aTimeProvider.! !


!classDefinition: #PurchasesList category: 'TusLibros'!
Object subclass: #PurchasesList
	instanceVariableNames: 'items salesBook total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchasesList methodsFor: 'testing' stamp: 'MatiasCra 11/9/2023 15:38:54'!
includes: anItem

	 ^ items includes: anItem! !

!PurchasesList methodsFor: 'testing' stamp: 'MatiasCra 11/9/2023 15:39:03'!
isEmpty

	 ^ items isEmpty! !


!PurchasesList methodsFor: 'accessing' stamp: 'MatiasCra 11/9/2023 15:40:02'!
occurrencesOf: anItem

	^ items occurrencesOf: anItem! !

!PurchasesList methodsFor: 'accessing' stamp: 'MatiasCra 11/9/2023 15:37:56'!
size

	^ items size! !

!PurchasesList methodsFor: 'accessing' stamp: 'MatiasCra 11/9/2023 15:39:13'!
total

	^ total! !


!PurchasesList methodsFor: 'initialization' stamp: 'MatiasCra 11/9/2023 15:38:27'!
computeItems

	salesBook do: [ :item | items add: item ]! !

!PurchasesList methodsFor: 'initialization' stamp: 'MatiasCra 11/9/2023 15:39:33'!
initializeFor: aSalesBook

	salesBook := aSalesBook.

	total := salesBook total.
	items := Bag new.
	self computeItems.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchasesList class' category: 'TusLibros'!
PurchasesList class
	instanceVariableNames: ''!

!PurchasesList class methodsFor: 'instance creation' stamp: 'MatiasCra 11/9/2023 15:34:11'!
for: aSalesBook

	^ self new initializeFor: aSalesBook! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'testing' stamp: 'MatiasCra 11/9/2023 12:25:53'!
includes: anItem

	^ items includes: anItem! !


!Sale methodsFor: 'queries' stamp: 'MatiasCra 11/9/2023 13:10:19'!
items

	^ items copy! !

!Sale methodsFor: 'queries' stamp: 'MatiasCra 11/9/2023 12:26:33'!
occurrencesOf: anItem

	^ items occurrencesOf: anItem! !

!Sale methodsFor: 'queries' stamp: 'MatiasCra 11/9/2023 12:30:57'!
size

	^ items size! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'MatiasCra 11/9/2023 12:22:30'!
initializeItems: anItemsCollection total: aTotal

	items := anItemsCollection.
	total := aTotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'MatiasCra 11/9/2023 12:22:00'!
of: items total: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeItems: items total: aTotal ! !


!classDefinition: #SalesBook category: 'TusLibros'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'adding' stamp: 'MatiasCra 11/9/2023 13:31:22'!
add: aSale
	
	sales add: aSale.
! !


!SalesBook methodsFor: 'initialization' stamp: 'MatiasCra 11/9/2023 14:44:32'!
initialize

	sales := OrderedCollection new.
! !


!SalesBook methodsFor: 'queries' stamp: 'MatiasCra 11/9/2023 15:36:04'!
do: perItemClosure

	sales do: [ :sale | sale items do: perItemClosure ]! !

!SalesBook methodsFor: 'queries' stamp: 'MatiasCra 11/9/2023 13:36:40'!
occurrencesOf: anItem

	^ sales sum: [ :sale | sale occurrencesOf: anItem ] ifEmpty: [ 0 ]! !

!SalesBook methodsFor: 'queries' stamp: 'MatiasCra 11/9/2023 13:36:52'!
size

	^ sales sum: [ :sale | sale size ] ifEmpty: [ 0 ]! !

!SalesBook methodsFor: 'queries' stamp: 'MatiasCra 11/9/2023 13:36:55'!
total

	^ sales sum: [ :sale | sale total ] ifEmpty: [ 0 ]! !


!SalesBook methodsFor: 'testing' stamp: 'MatiasCra 11/9/2023 13:26:16'!
includes: anItem

	^ sales anySatisfy: [ :sale | sale includes: anItem ]! !

!SalesBook methodsFor: 'testing' stamp: 'MatiasCra 11/9/2023 13:25:51'!
isEmpty

	^ sales isEmpty ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
