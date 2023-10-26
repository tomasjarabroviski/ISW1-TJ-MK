!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'Matias Cra 10/24/2023 16:17:28'!
test01AccountSummaryWithoutTransactions
	| account reporter |
	account := ReceptiveAccount new.
	reporter := AccountSummaryReporter for: account.
	self assert: reporter report size equals: 1.
	self assert: reporter report first equals: 'Balance = 0'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'Matias Cra 10/24/2023 16:18:03'!
test02AccountSummaryWithSingleDeposit
	| account reporter |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	reporter := AccountSummaryReporter for: account.
	self assert: reporter report size equals: 2.
	self assert: reporter report first equals: 'Depósito por 100'.
	self assert: reporter report second equals: 'Balance = 100'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'Matias Cra 10/24/2023 16:20:02'!
test03AccountSummaryWithAnySingleTransaction
	| accountWithWithdraw accountWithTransferOut accountWithTransferIn reporter |
	accountWithWithdraw := ReceptiveAccount new.
	accountWithTransferOut := ReceptiveAccount new.
	accountWithTransferIn := ReceptiveAccount new.
		
	Withdraw register: 50 on: accountWithWithdraw.
	reporter := AccountSummaryReporter for: accountWithWithdraw.
	self assert: reporter report size equals: 2.
	self assert: reporter report first equals: 'Extracción por 50'.
	self assert: reporter report second equals: 'Balance = -50'.
		
	Transfer for: 30 from: accountWithTransferOut to: accountWithTransferIn.
	reporter := AccountSummaryReporter for: accountWithTransferOut.
	self assert: reporter report size equals: 2.
	self assert: reporter report first equals: 'Salida por transferencia de 30'.
	self assert: reporter report second equals: 'Balance = -30'.

	reporter := AccountSummaryReporter for: accountWithTransferIn.
	self assert: reporter report size equals: 2.
	self assert: reporter report first equals: 'Entrada por transferencia de 30'.	
	self assert: reporter report second equals: 'Balance = 30'.	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'Matias Cra 10/24/2023 16:20:28'!
test04AccountSummaryWithManyTransactions
	| account auxAccountForTransfers summary reporter |
	account := ReceptiveAccount new.
	auxAccountForTransfers := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer for: 20 from: account to: auxAccountForTransfers.
	Transfer for: 30 from: auxAccountForTransfers to: account.
	
	reporter := AccountSummaryReporter for: account.
	summary := reporter report.
	self assert: summary size equals: 5.
	self assert: summary first equals: 'Depósito por 100'.
	self assert: summary second equals: 'Extracción por 50'.
	self assert: summary third equals: 'Salida por transferencia de 20'.
	self assert: summary fourth equals: 'Entrada por transferencia de 30'.
	self assert: summary fifth equals: 'Balance = 60'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'Matias Cra 10/24/2023 16:21:01'!
test05PortfolioSummaryWithoutTransactions
	| portfolio reporter |
	portfolio := Portfolio new.
	reporter := AccountSummaryReporter for: portfolio.
	self assert: reporter report size equals: 1.
	self assert: reporter report first equals: 'Balance = 0'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'Matias Cra 10/24/2023 16:27:39'!
test06PortfolioSummaryWithManyAccounts
	| portfolio account auxAccountForTransfers portfolioReporter accountReporter |
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	auxAccountForTransfers := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer for: 20 from: account to: auxAccountForTransfers.
	Transfer for: 30 from: auxAccountForTransfers to: account.
	portfolio add: account.

	portfolioReporter := AccountSummaryReporter for: portfolio.
	accountReporter := AccountSummaryReporter for: account.
	self assert: portfolioReporter report equals: accountReporter report! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'Matias Cra 10/24/2023 16:28:58'!
test07PortfolioSummaryWithSingleAccount
	| portfolio account auxAccountForTransfers portfolioReporter accountReporter |
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	auxAccountForTransfers := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer for: 20 from: account to: auxAccountForTransfers.
	Transfer for: 30 from: auxAccountForTransfers to: account.
	portfolio add: account.
	
	portfolioReporter := AccountSummaryReporter for: portfolio.
	accountReporter := AccountSummaryReporter for: account.
	self assert: portfolioReporter report equals: accountReporter report! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'Matias Cra 10/24/2023 16:30:57'!
test08PortfolioSummaryWithManyAccounts
	| portfolio firstAccount secondAccount thirdAccount summary accountReporter |
	firstAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	Deposit register: 100 on: firstAccount.
	Withdraw register: 50 on: firstAccount.
	Transfer for: 20 from: secondAccount to: thirdAccount.
	Transfer for: 30 from: thirdAccount to: secondAccount.
	portfolio add: firstAccount; add: secondAccount; add: thirdAccount.
	
	summary := (AccountSummaryReporter for: portfolio) report.
	accountReporter := AccountSummaryReporter for: firstAccount.
	self assert: (summary copyFrom: 1 to: 2) equals: accountReporter report allButLast.
	
	accountReporter := AccountSummaryReporter for: secondAccount.
	self assert: (summary copyFrom: 3 to: 4) equals: accountReporter report allButLast.
	
	accountReporter := AccountSummaryReporter for: thirdAccount.
	self assert: (summary copyFrom: 5 to: 6) equals: accountReporter report allButLast.

	self assert: summary seventh equals: 'Balance = 50'.! !


!classDefinition: #NetTransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #NetTransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!NetTransferTest methodsFor: 'test' stamp: 'Matias Cra 10/24/2023 16:38:30'!
test01NoTransactionsHave0NetTransfer
	| account reporter |
	account := ReceptiveAccount new.
	reporter := NetTransferReporter for: account.
	self assert: reporter report equals: 0.! !

!NetTransferTest methodsFor: 'test' stamp: 'Matias Cra 10/24/2023 16:39:04'!
test02SingleTransferAffectsNet
	| accountToTransferFrom accountToTransferTo reporter |
	accountToTransferFrom := ReceptiveAccount new.
	accountToTransferTo := ReceptiveAccount new.
	Transfer for: 20 from: accountToTransferFrom to: accountToTransferTo.
	reporter := NetTransferReporter for: accountToTransferFrom.
	self assert: reporter report equals: -20.
	reporter := NetTransferReporter for: accountToTransferTo.
	self assert: reporter report equals: 20.! !

!NetTransferTest methodsFor: 'test' stamp: 'Matias Cra 10/24/2023 16:43:38'!
test03MultipleTransfersAffectNet
	| accountToTransferFrom accountToTransferTo |
	accountToTransferFrom := ReceptiveAccount new.
	accountToTransferTo := ReceptiveAccount new.
	Transfer for: 20 from: accountToTransferFrom to: accountToTransferTo.
	Transfer for: 30 from: accountToTransferTo to: accountToTransferFrom.
	self assert: (NetTransferReporter for: accountToTransferFrom) report equals: 10.
	self assert: (NetTransferReporter for: accountToTransferTo) report equals: -10.! !

!NetTransferTest methodsFor: 'test' stamp: 'Matias Cra 10/24/2023 16:44:38'!
test04OnlyTransfersAffectNet
	| accountToTransferFrom accountToTransferTo |
	accountToTransferFrom := ReceptiveAccount new.
	accountToTransferTo := ReceptiveAccount new.
	
	Deposit register: 100 on: accountToTransferFrom.
	Withdraw register: 50 on: accountToTransferFrom.
	Transfer for: 20 from: accountToTransferFrom to: accountToTransferTo.
	Transfer for: 30 from: accountToTransferTo to: accountToTransferFrom.
	self assert: (NetTransferReporter for: accountToTransferFrom) report equals: 10.
	self assert: (NetTransferReporter for: accountToTransferTo) report equals: -10.! !

!NetTransferTest methodsFor: 'test' stamp: 'Matias Cra 10/24/2023 16:46:48'!
test05EmptyPortfolioHas0NetTransfer
	| portfolio reporter |
	portfolio := Portfolio new.
	reporter := NetTransferReporter for: portfolio.
	self assert: reporter report equals: 0.! !

!NetTransferTest methodsFor: 'test' stamp: 'Matias Cra 10/24/2023 16:52:04'!
test06PortfolioWithAccountHasItsNet
	| portfolio account auxAccountForTransfers |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	auxAccountForTransfers := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer for: 20 from: account to: auxAccountForTransfers.
	Transfer for: 30 from: auxAccountForTransfers to: account.
	portfolio add: account.
	
	self assert: (NetTransferReporter for: portfolio) report equals: (NetTransferReporter for: account) report.! !

!NetTransferTest methodsFor: 'test' stamp: 'Matias Cra 10/24/2023 16:57:25'!
test07PortfolioWithMultipleAccountsAddsTheirNet
	| portfolio firstAccount secondAccount auxAccountForTransfers |
	portfolio := Portfolio new.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	auxAccountForTransfers := ReceptiveAccount new.

	Deposit register: 100 on: firstAccount.
	Withdraw register: 50 on: firstAccount.
	Transfer for: 20 from: firstAccount to: auxAccountForTransfers.
	Transfer for: 30 from: auxAccountForTransfers to: firstAccount.

	Deposit register: 1000 on: secondAccount.
	Transfer for: 700 from: secondAccount to: auxAccountForTransfers.
	Transfer for: 200 from: secondAccount to: firstAccount.
	
	portfolio add: firstAccount; add: secondAccount.
	self assert: (NetTransferReporter for: portfolio) report equals: 
		(NetTransferReporter for: firstAccount) report + (NetTransferReporter for: secondAccount) report.! !

!NetTransferTest methodsFor: 'test' stamp: 'Matias Cra 10/24/2023 17:00:25'!
test08PortfolioWithMultipleLeavesAddsTheirNet
	| portfolio childPortfolio firstAccount secondAccount thirdAccount auxAccountForTransfers |
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	auxAccountForTransfers := ReceptiveAccount new.

	Deposit register: 100 on: firstAccount.
	Withdraw register: 50 on: firstAccount.
	Transfer for: 20 from: firstAccount to: auxAccountForTransfers.
	Transfer for: 30 from: auxAccountForTransfers to: firstAccount.

	Deposit register: 1000 on: secondAccount.
	Transfer for: 700 from: secondAccount to: auxAccountForTransfers.
	Transfer for: 200 from: secondAccount to: firstAccount.
	
	Withdraw register: 123 on: thirdAccount.
	Transfer for: 400 from: auxAccountForTransfers to: thirdAccount.
	Transfer for: 321 from: thirdAccount to: secondAccount.
	
	childPortfolio add: thirdAccount.
	portfolio add: firstAccount; add: secondAccount; add: childPortfolio.
	self assert: (NetTransferReporter for: portfolio) report equals: 
		(NetTransferReporter for: firstAccount) report +
		(NetTransferReporter for: secondAccount) report +
		(NetTransferReporter for: thirdAccount) report.! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreeTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTreeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 12:09:09'!
test01EmptyPortfolio
	| portfolio reporter |
	portfolio := Portfolio named: 'Portfolio de Darío'.
	reporter := PortfolioTreeReporter for: portfolio.
	
	self assert: reporter report size equals: 1.
	self assert: reporter report first equals: 'Portfolio de Darío'! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 12:09:17'!
test02PortfolioWithAccount
	| portfolio account reporter |
	account := ReceptiveAccount named: 'Cuenta de Juan'.
	portfolio := Portfolio named: 'Portfolio de Darío' with: account.
	reporter := PortfolioTreeReporter for: portfolio.
	
	self assert: reporter report size equals: 2.
	self assert: reporter report first equals: 'Portfolio de Darío'.
	self assert: reporter report second equals: '   Cuenta de Juan'.! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 12:16:28'!
test03PortfolioWithMultipleAccounts
	| portfolio firstAccount secondAccount reporter |
	firstAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	secondAccount := ReceptiveAccount named: 'Cuenta de Pepe'.
	portfolio := Portfolio named: 'Portfolio de Darío' with: firstAccount with: secondAccount.
	reporter := PortfolioTreeReporter for: portfolio.
	
	self assert: reporter report size equals: 3.
	self assert: reporter report first equals: 'Portfolio de Darío'.
	self assert: reporter report second equals: '   Cuenta de Juan'.
	self assert: reporter report third equals:  '   Cuenta de Pepe'.! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 13:51:24'!
test04PortfolioWithEmptyPortfolio
	| portfolio childPortfolio reporter |
	childPortfolio := Portfolio named: 'Portfolio de Pepito'.
	portfolio := Portfolio named: 'Portfolio de Darío' with: childPortfolio.
	reporter := PortfolioTreeReporter for: portfolio.

	self assert: reporter report size equals: 2.
	self assert: reporter report first equals: 'Portfolio de Darío'.
	self assert: reporter report second equals: '   Portfolio de Pepito'.! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 13:51:34'!
test05PortfolioWithAPortfolio
	| portfolio childPortfolio firstAccount secondAccount reporter |
	firstAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	secondAccount := ReceptiveAccount named: 'Cuenta de Pepe'.
	childPortfolio := Portfolio named: 'Portfolio de Pepito' with: firstAccount with: secondAccount.
	portfolio := Portfolio named: 'Portfolio de Darío' with: childPortfolio.
	reporter := PortfolioTreeReporter for: portfolio.

	self assert: reporter report size equals: 4.
	self assert: reporter report first equals: 'Portfolio de Darío'.
	self assert: reporter report second equals: '   Portfolio de Pepito'.
	self assert: reporter report third equals:  '      Cuenta de Juan'.
	self assert: reporter report fourth equals: '      Cuenta de Pepe'.! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 13:51:40'!
test06PortfolioWithManyPortfolios
	| portfolio firstChildPortfolio secondChildPortfolio firstAccount secondAccount reporter |
	firstAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	secondAccount := ReceptiveAccount named: 'Cuenta de Pepe'.
	firstChildPortfolio := Portfolio named: 'Portfolio de Pepito' with: firstAccount.
	secondChildPortfolio := Portfolio named: 'Portfolio de Manolo' with: secondAccount.
	portfolio := Portfolio named: 'Portfolio de Darío' with: firstChildPortfolio with: secondChildPortfolio.
	reporter := PortfolioTreeReporter for: portfolio.

	self assert: reporter report size equals: 5.
	self assert: reporter report first equals:  'Portfolio de Darío'.
	self assert: reporter report second equals: '   Portfolio de Pepito'.
	self assert: reporter report third equals:  '      Cuenta de Juan'.
	self assert: reporter report fourth equals: '   Portfolio de Manolo'.
	self assert: reporter report fifth equals:  '      Cuenta de Pepe'.! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 17:16:23'!
test07UnnamedPortfolio
	| portfolio reporter |
	portfolio := Portfolio new.
	reporter := PortfolioTreeReporter for: portfolio.
	
	self assert: reporter report size equals: 1.
	self assert: reporter report first equals: 'Unnamed portfolio'! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 17:22:31'!
test08UnnamedAccount
	| portfolio account reporter |
	account := ReceptiveAccount new.
	portfolio := Portfolio named: 'Portfolio de Pepe' with: account.
	reporter := PortfolioTreeReporter for: portfolio.
	
	self assert: reporter report size equals: 2.
	self assert: reporter report first equals:  'Portfolio de Pepe'.
	self assert: reporter report second equals: '   Unnamed receptive account'.! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/25/2023 17:31:15'!
test09ReportIsExclusiveToPortfolios
	| account |
	account := ReceptiveAccount named: 'Cuenta de Pepito'.

	self should: [ PortfolioTreeReporter for: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: PortfolioTreeReporter reportExclusiveToPortfoliosErrorDescription
		]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransactionTreeTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransactionTreeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/26/2023 15:04:59'!
test01EmptyPortfolio
	| portfolio reporter |
	portfolio := Portfolio named: 'Portfolio de Darío'.
	reporter := TransactionTreeRporter for: portfolio.
	
	self assert: reporter report size equals: 2.
	self assert: reporter report first equals:  'Portfolio de Darío'.
	self assert: reporter report second equals: '   Balance = 0'! !

!TransactionTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/26/2023 15:22:46'!
test02PortfolioWithAccountWithoutTransactions
	| portfolio account reporter |
	account := ReceptiveAccount named: 'Cuenta de Pepe'.
	portfolio := Portfolio named: 'Portfolio de Darío' with: account.
	reporter := TransactionTreeRporter for: portfolio.
	
	self assert: reporter report size equals: 4.
	self assert: reporter report first equals:  'Portfolio de Darío'.
	self assert: reporter report second equals: '   Cuenta de Pepe'.
	self assert: reporter report third equals:  '      Balance = 0'.
	self assert: reporter report fourth equals: '   Balance = 0'.! !

!TransactionTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/26/2023 15:29:08'!
test03PortfolioWithAccountWithTransactions
	| portfolio account auxAccountForTransfer reporter |
	account := ReceptiveAccount named: 'Cuenta de Pepe'.
	auxAccountForTransfer := ReceptiveAccount new.
	Deposit register: 1000 on: account.
	Withdraw register: 10 on: account.
	Transfer for: 50 from: account to: auxAccountForTransfer.
	Transfer for: 10 from: auxAccountForTransfer to: account.
	
	portfolio := Portfolio named: 'Portfolio de Darío' with: account.
	reporter := TransactionTreeRporter for: portfolio.
	
	self assert: reporter report size equals: 8.
	self assert: reporter report first equals:   'Portfolio de Darío'.
	self assert: reporter report second equals:  '   Cuenta de Pepe'.
	self assert: reporter report third equals:   '      Depósito por 1000'.
	self assert: reporter report fourth equals:  '      Extracción por 10'.
	self assert: reporter report fifth equals:   '      Salida por transferencia de 50'.
	self assert: reporter report sixth equals:   '      Entrada por transferencia de 10'.	
	self assert: reporter report seventh equals: '      Balance = 950'.
	self assert: reporter report eighth equals:  '   Balance = 950'.! !

!TransactionTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/26/2023 15:36:47'!
test04PortfolioWithMultipleAccounts
	| portfolio account auxAccountForTransfer reporter |
	account := ReceptiveAccount named: 'Cuenta de Pepe'.
	auxAccountForTransfer := ReceptiveAccount named: 'Cuenta aux'.
	Deposit register: 1000 on: account.
	Withdraw register: 10 on: account.
	Transfer for: 50 from: account to: auxAccountForTransfer.
	Transfer for: 10 from: auxAccountForTransfer to: account.
	
	portfolio := Portfolio named: 'Portfolio de Darío' with: account with: auxAccountForTransfer.
	reporter := TransactionTreeRporter for: portfolio.
	
	self assert: reporter report size equals: 12.
	self assert: reporter report first equals:    'Portfolio de Darío'.
	self assert: reporter report second equals:   '   Cuenta de Pepe'.
	self assert: reporter report third equals:    '      Depósito por 1000'.
	self assert: reporter report fourth equals:   '      Extracción por 10'.
	self assert: reporter report fifth equals:    '      Salida por transferencia de 50'.
	self assert: reporter report sixth equals:    '      Entrada por transferencia de 10'.	
	self assert: reporter report seventh equals:  '      Balance = 950'.
	self assert: reporter report eighth equals:   '   Cuenta aux'.
	self assert: reporter report ninth equals:    '      Entrada por transferencia de 50'.
	self assert: (reporter report at: 10) equals: '      Salida por transferencia de 10'.
	self assert: (reporter report at: 11) equals: '      Balance = 40'.
	self assert: (reporter report at: 12) equals: '   Balance = 990'.
	! !

!TransactionTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/26/2023 15:42:05'!
test05PortfolioTreeWithoutTransactions
	| portfolio childPortfolio account reporter |
	account := ReceptiveAccount named: 'Cuenta de Pepe'.
	childPortfolio := Portfolio named: 'Portfolio hijo' with: account.
	
	portfolio := Portfolio named: 'Portfolio de Darío' with: childPortfolio.
	reporter := TransactionTreeRporter for: portfolio.
	
	self assert: reporter report size equals: 6.
	self assert: reporter report first equals:  'Portfolio de Darío'.
	self assert: reporter report second equals: '   Portfolio hijo'.
	self assert: reporter report third equals:  '      Cuenta de Pepe'.
	self assert: reporter report fourth equals: '         Balance = 0'.
	self assert: reporter report fifth equals:  '      Balance = 0'.
	self assert: reporter report sixth equals:  '   Balance = 0'.! !

!TransactionTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/26/2023 15:47:34'!
test06PortfolioTreeWithTransactions
	| portfolio childPortfolio account reporter |
	account := ReceptiveAccount named: 'Cuenta de Pepe'.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	childPortfolio := Portfolio named: 'Portfolio hijo' with: account.
	
	portfolio := Portfolio named: 'Portfolio de Darío' with: childPortfolio.
	reporter := TransactionTreeRporter for: portfolio.
	
	self assert: reporter report size equals: 8.
	self assert: reporter report first equals:   'Portfolio de Darío'.
	self assert: reporter report second equals:  '   Portfolio hijo'.
	self assert: reporter report third equals:   '      Cuenta de Pepe'.
	self assert: reporter report fourth equals:  '         Depósito por 100'.
	self assert: reporter report fifth equals:   '         Extracción por 50'.
	self assert: reporter report sixth equals:   '         Balance = 50'.
	self assert: reporter report seventh equals: '      Balance = 50'.
	self assert: reporter report eighth equals:  '   Balance = 50'.! !

!TransactionTreeTest methodsFor: 'tests' stamp: 'Matias Cra 10/26/2023 15:51:02'!
test07ReportIsExclusiveToPortfolios
	| account |
	account := ReceptiveAccount named: 'Cuenta de Pepito'.

	self should: [ PortfolioTreeReporter for: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: PortfolioTreeReporter reportExclusiveToPortfoliosErrorDescription
		]! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'Matias Cra 10/23/2023 19:46:33'!
test01TransferAffectsBalance
	| accountToTransferFrom accountToTransferTo |
	accountToTransferFrom := ReceptiveAccount new.
	accountToTransferTo := ReceptiveAccount new.
	Transfer for: 100 from: accountToTransferFrom to: accountToTransferTo.

	self assert: accountToTransferFrom balance equals: -100.
	self assert: accountToTransferTo balance equals: 100.! !

!TransferTest methodsFor: 'tests' stamp: 'Matias Cra 10/23/2023 19:46:23'!
test02TransferLegsAreRegistered
	| accountToTransferFrom accountToTransferTo transfer |
	accountToTransferFrom := ReceptiveAccount new.
	accountToTransferTo := ReceptiveAccount new.
	transfer := Transfer for: 100 from: accountToTransferFrom to: accountToTransferTo.

	self assert: (accountToTransferFrom hasRegistered: transfer withdrawLeg).
	self assert: (accountToTransferTo hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'Matias Cra 10/22/2023 22:00:24'!
test03TransferLegsKnowEachOther
	| accountToTransferFrom accountToTransferTo transfer |
	accountToTransferFrom := ReceptiveAccount new.
	accountToTransferTo := ReceptiveAccount new.
	transfer := Transfer for: 100 from: accountToTransferFrom to: accountToTransferTo.
	
	self assert: (transfer withdrawLeg) depositLeg equals: (transfer depositLeg).
	self assert: (transfer depositLeg) withdrawLeg equals: (transfer withdrawLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'Matias Cra 10/22/2023 22:00:29'!
test04TransferLegsKnowTheTransfer
	| accountToTransferFrom accountToTransferTo transfer |
	accountToTransferFrom := ReceptiveAccount new.
	accountToTransferTo := ReceptiveAccount new.
	transfer := Transfer for: 100 from: accountToTransferFrom to: accountToTransferTo.

	self assert: (transfer withdrawLeg) transfer equals: transfer.
	self assert: (transfer depositLeg) transfer equals: transfer.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 11:47:28'!
reportFor: aReporter
	
	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'Matias Cra 10/25/2023 17:19:15'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := 'Unnamed portfolio'! !

!Portfolio methodsFor: 'initialization' stamp: 'Matias Cra 10/25/2023 17:17:29'!
initializeNamed: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'naming' stamp: 'Matias Cra 10/25/2023 12:01:14'!
name
	
	^ name! !

!Portfolio methodsFor: 'naming' stamp: 'Matias Cra 10/25/2023 12:01:09'!
name: aName
	
	name := aName! !


!Portfolio methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 12:14:40'!
reportFor: aReporter

	accounts do: [ :account | aReporter reportAccountFor: account ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'Matias Cra 10/25/2023 17:17:55'!
named: aName

	^self new 
		initializeNamed: aName;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'Matias Cra 10/25/2023 17:18:06'!
named: aName with: anAccount

	^self new
		initializeNamed: aName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'Matias Cra 10/25/2023 17:18:09'!
named: aName with: anAccount with: anotherAccount

	^self new
		initializeNamed: aName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Matias Cra 10/25/2023 17:21:41'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := 'Unnamed receptive account'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Matias Cra 10/25/2023 17:21:50'!
initializeNamed: aName

	super initialize.
	transactions := OrderedCollection new.
	name := aName! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 11:46:22'!
reportFor: aReporter
	
	transactions do: [
		:transaction | transaction reportFor: aReporter 	
	]! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'naming' stamp: 'Matias Cra 10/25/2023 12:07:51'!
name

	^ name! !

!ReceptiveAccount methodsFor: 'naming' stamp: 'Matias Cra 10/25/2023 12:08:05'!
name: aName

	name := aName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'Matias Cra 10/25/2023 17:21:58'!
named: aName

	^ self new initializeNamed: aName! !


!classDefinition: #AccountReporter category: 'Portfolio-Solucion'!
Object subclass: #AccountReporter
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 13:52:54'!
makeReport
	
	^ self subclassResponsibility ! !

!AccountReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 13:52:54'!
report
	
	^ report! !

!AccountReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 13:57:19'!
reportAccountFor: anAccount
	
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:56:20'!
reportDepositFor: aDeposit

	self subclassResponsibility ! !

!AccountReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:56:39'!
reportTransferDepositFor: aTransferDepositLeg
	
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:56:46'!
reportTransferWithdrawFor: aTransferWithdrawLeg
	
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:56:58'!
reportWithdrawFor: aWithdraw

	self subclassResponsibility ! !


!AccountReporter methodsFor: 'initialization' stamp: 'Matias Cra 10/25/2023 13:52:54'!
initializeFor: anAccount
	
	account := anAccount. 
	self makeReport! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: 'Portfolio-Solucion'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'Matias Cra 10/25/2023 13:52:54'!
for: anAccount
	
	^ self new initializeFor: anAccount ! !


!classDefinition: #AccountSummaryReporter category: 'Portfolio-Solucion'!
AccountReporter subclass: #AccountSummaryReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 11:45:47'!
makeReport
	
	report := OrderedCollection new.
	account reportFor: self.
	report add: 'Balance = ', account balance asString.! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:54:37'!
reportAccountFor: anAccount
	
	anAccount reportFor: self! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:14:42'!
reportDepositFor: aDeposit
	
	report add: 'Depósito por ', aDeposit value asString! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:15:44'!
reportTransferDepositFor: aTransferDepositLeg
	
	report add: 'Entrada por transferencia de ', aTransferDepositLeg value asString! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:15:25'!
reportTransferWithdrawFor: aTransferWithdrawLeg
	
	report add: 'Salida por transferencia de ', aTransferWithdrawLeg value asString! !

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:15:06'!
reportWithdrawFor: aWithdraw
	
	report add: 'Extracción por ', aWithdraw value asString! !


!classDefinition: #NetTransferReporter category: 'Portfolio-Solucion'!
AccountReporter subclass: #NetTransferReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!NetTransferReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 11:48:07'!
makeReport
	
	report := 0.
	account reportFor: self.! !

!NetTransferReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:54:41'!
reportAccountFor: anAccount
	
	anAccount reportFor: self! !

!NetTransferReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:33:11'!
reportDepositFor: aDeposit! !

!NetTransferReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:33:26'!
reportTransferDepositFor: aTransferDepositLeg
	
	report := aTransferDepositLeg affectBalance: report! !

!NetTransferReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:33:36'!
reportTransferWithdrawFor: aTransferWithdrawLeg
	
	report := aTransferWithdrawLeg affectBalance: report! !

!NetTransferReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:33:15'!
reportWithdrawFor: aWithdraw! !


!classDefinition: #PortfolioTreeReporter category: 'Portfolio-Solucion'!
AccountReporter subclass: #PortfolioTreeReporter
	instanceVariableNames: 'indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReporter methodsFor: 'initialization' stamp: 'Matias Cra 10/25/2023 17:00:17'!
initialize
	
	indentation := self oneIndentation ! !


!PortfolioTreeReporter methodsFor: 'indentation' stamp: 'Matias Cra 10/25/2023 17:10:12'!
decreaseIndentation

	indentation := indentation copyFrom: 1 to: (indentation size - self oneIndentation size)! !

!PortfolioTreeReporter methodsFor: 'indentation' stamp: 'Matias Cra 10/25/2023 17:09:57'!
doWithIncreasedIndentation: aClosure

	self increaseIndentation.
	aClosure value.
	self decreaseIndentation.! !

!PortfolioTreeReporter methodsFor: 'indentation' stamp: 'Matias Cra 10/25/2023 17:09:52'!
increaseIndentation

	indentation := indentation, self oneIndentation! !

!PortfolioTreeReporter methodsFor: 'indentation' stamp: 'Matias Cra 10/25/2023 17:09:48'!
indent: aLine

	^ indentation, aLine! !

!PortfolioTreeReporter methodsFor: 'indentation' stamp: 'Matias Cra 10/25/2023 17:00:10'!
oneIndentation

	^ '   '! !


!PortfolioTreeReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 13:56:14'!
makeReport

	report := OrderedCollection with: account name.
	account reportFor: self! !

!PortfolioTreeReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 12:10:39'!
report
	
	^ report! !

!PortfolioTreeReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 17:03:23'!
reportAccountFor: anAccount

	report add: (self indent: anAccount name).
	self doWithIncreasedIndentation: [
		anAccount reportFor: self
	]! !

!PortfolioTreeReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:57:56'!
reportDepositFor: aDeposit! !

!PortfolioTreeReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:58:18'!
reportTransferDepositFor: aTransferWithdrawLeg
! !

!PortfolioTreeReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:58:14'!
reportTransferWithdrawFor: aTransferWithdrawLeg
! !

!PortfolioTreeReporter methodsFor: 'reporting' stamp: 'Matias Cra 10/25/2023 16:58:01'!
reportWithdrawFor: aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeReporter class' category: 'Portfolio-Solucion'!
PortfolioTreeReporter class
	instanceVariableNames: ''!

!PortfolioTreeReporter class methodsFor: 'instance creation' stamp: 'Matias Cra 10/25/2023 17:30:23'!
assertIsPortfolio: anAccount
	
	(anAccount isKindOf: Portfolio) ifFalse: [
		self error: self reportExclusiveToPortfoliosErrorDescription	
	]! !

!PortfolioTreeReporter class methodsFor: 'instance creation' stamp: 'Matias Cra 10/25/2023 17:30:56'!
for: anAccount
	
	self assertIsPortfolio: anAccount.
	^ super for: anAccount! !


!PortfolioTreeReporter class methodsFor: 'error description' stamp: 'Matias Cra 10/25/2023 17:28:16'!
reportExclusiveToPortfoliosErrorDescription
	
	^ 'This report is exclusive to portfolios'! !


!classDefinition: #TransactionTreeRporter category: 'Portfolio-Solucion'!
PortfolioTreeReporter subclass: #TransactionTreeRporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionTreeRporter methodsFor: 'reporting' stamp: 'Matias Cra 10/26/2023 16:00:08'!
addAccountBalance: anAccount
	
	report add: (self indent: 'Balance = ', anAccount balance asString)! !

!TransactionTreeRporter methodsFor: 'reporting' stamp: 'Matias Cra 10/26/2023 16:00:21'!
makeReport
	
	report := OrderedCollection with: account name.
	account reportFor: self.
	self addAccountBalance: account! !

!TransactionTreeRporter methodsFor: 'reporting' stamp: 'Matias Cra 10/26/2023 16:00:48'!
reportAccountFor: anAccount
	
	super reportAccountFor: anAccount.
	self doWithIncreasedIndentation: [
		self addAccountBalance: anAccount
	]! !

!TransactionTreeRporter methodsFor: 'reporting' stamp: 'Matias Cra 10/26/2023 15:57:53'!
reportDepositFor: aDeposit
	
	report add: (self indent: 'Depósito por ', aDeposit value asString)! !

!TransactionTreeRporter methodsFor: 'reporting' stamp: 'Matias Cra 10/26/2023 15:58:33'!
reportTransferDepositFor: aTransferDepositLeg
	
	report add: (self indent: 'Entrada por transferencia de ', aTransferDepositLeg value asString)! !

!TransactionTreeRporter methodsFor: 'reporting' stamp: 'Matias Cra 10/26/2023 15:58:42'!
reportTransferWithdrawFor: aTransferWithdrawLeg
	
	report add: (self indent: 'Salida por transferencia de ', aTransferWithdrawLeg value asString)! !

!TransactionTreeRporter methodsFor: 'reporting' stamp: 'Matias Cra 10/26/2023 15:58:49'!
reportWithdrawFor: aWithdraw
	
	report add: (self indent: 'Extracción por ', aWithdraw value asString)! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:06:00'!
reportFor: aTransactionsReporter

	^ self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:40:46'!
reportFor: aTransactionReporter

	aTransactionReporter reportDepositFor: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'initialization' stamp: 'Matias Cra 10/22/2023 22:10:27'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferLeg methodsFor: 'value' stamp: 'Matias Cra 10/22/2023 22:10:42'!
value

	^ transfer value! !


!TransferLeg methodsFor: 'transfer parts' stamp: 'Matias Cra 10/22/2023 22:10:27'!
depositLeg
	
	^ transfer depositLeg ! !

!TransferLeg methodsFor: 'transfer parts' stamp: 'Matias Cra 10/22/2023 22:10:27'!
transfer
	
	^ transfer ! !

!TransferLeg methodsFor: 'transfer parts' stamp: 'Matias Cra 10/22/2023 22:12:20'!
withdrawLeg
	
	^ transfer withdrawLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'Matias Cra 10/22/2023 22:10:27'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #TransferDepositLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDepositLeg methodsFor: 'balance' stamp: 'Matias Cra 10/22/2023 22:16:37'!
affectBalance: aBalance
	
	^ aBalance + self value! !


!TransferDepositLeg methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:40:31'!
reportFor: aTransactionReporter

	aTransactionReporter reportTransferDepositFor: self ! !


!classDefinition: #TransferWithdrawLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdrawLeg methodsFor: 'balance' stamp: 'Matias Cra 10/22/2023 22:16:15'!
affectBalance: aBalance
	
	^ aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:40:35'!
reportFor: aTransactionReporter

	aTransactionReporter reportTransferWithdrawFor: self ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reporting' stamp: 'Matias Cra 10/24/2023 16:40:27'!
reportFor: aTransactionReporter

	aTransactionReporter reportWithdrawFor: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'accessing' stamp: 'Matias Cra 10/22/2023 21:22:25'!
depositLeg

	^ depositLeg ! !

!Transfer methodsFor: 'accessing' stamp: 'Matias Cra 10/22/2023 22:20:34'!
value

	^ value ! !

!Transfer methodsFor: 'accessing' stamp: 'Matias Cra 10/22/2023 21:22:20'!
withdrawLeg

	^ withdrawLeg ! !


!Transfer methodsFor: 'initialization' stamp: 'Matias Cra 10/22/2023 22:30:06'!
initializeFor: aValue
	
	value := aValue! !

!Transfer methodsFor: 'initialization' stamp: 'Matias Cra 10/22/2023 22:19:22'!
initializeWithdrawLeg: aWithdrawLeg depositLeg: aDepositLeg

	withdrawLeg := aWithdrawLeg.
	depositLeg := aDepositLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'Matias Cra 10/22/2023 22:30:06'!
for: anAmmount from: anAccountToTransferFrom to: anAccountToTransferTo
	| withdraw deposit transfer |
	
	transfer := self new initializeFor: anAmmount.

	withdraw := TransferWithdrawLeg register: transfer on: anAccountToTransferFrom.
	deposit := TransferDepositLeg register: transfer on: anAccountToTransferTo.	
	
	^ transfer initializeWithdrawLeg: withdraw depositLeg: deposit! !
