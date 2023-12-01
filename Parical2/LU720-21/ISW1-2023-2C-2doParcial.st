!classDefinition: #MineFieldTest category: 'ISW1-2023-2C-2doParcial'!
TestCase subclass: #MineFieldTest
	instanceVariableNames: 'randomGenerator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 21:17:30'!
createBoardOf: cols by: rows lightArmors: lightArmorsLocations heavyArmors: heavyArmorsLocations

	^ self createBoardOf: cols by: rows withLowPotencyMinesAt: #() highPotencyMinesAt: #() lightArmors: lightArmorsLocations heavyArmors: heavyArmorsLocations tunels: #()! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 19:52:54'!
createBoardOf: cols by: rows withHighPotencyMinesAt: highPotencyMinesLocations

	^ self createBoardOf: cols by: rows withLowPotencyMinesAt: #() highPotencyMinesAt: highPotencyMinesLocations lightArmors: #() heavyArmors: #() tunels: #()! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 21:44:20'!
createBoardOf: cols by: rows withHighPotencyMinesAt: highPotencyMinesLocations heavyArmors: heavyArmorsLocations

	^ self createBoardOf: cols by: rows withLowPotencyMinesAt: #() highPotencyMinesAt: highPotencyMinesLocations lightArmors: #() heavyArmors: heavyArmorsLocations tunels: #()! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 21:11:08'!
createBoardOf: cols by: rows withHighPotencyMinesAt: highPotencyMinesLocations lightArmors: lightArmorsLocations

	^ self createBoardOf: cols by: rows withLowPotencyMinesAt: #() highPotencyMinesAt: highPotencyMinesLocations lightArmors: lightArmorsLocations heavyArmors: #() tunels: #()! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 19:52:57'!
createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations

	^ self createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations highPotencyMinesAt: #() lightArmors: #() heavyArmors: #() tunels: #()! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 21:45:19'!
createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations heavyArmors: heavyArmorsLocations

	^ self createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations highPotencyMinesAt: #() lightArmors: #() heavyArmors: heavyArmorsLocations tunels: #()! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 21:00:07'!
createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations highPotencyMinesAt: highPotencyMinesLocations lightArmors: lightArmorsLocations

	^ self createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations highPotencyMinesAt: highPotencyMinesLocations lightArmors: lightArmorsLocations heavyArmors: #() tunels: #()! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 21:19:11'!
createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations highPotencyMinesAt: highPotencyMinesLocations lightArmors: lightArmorsLocations heavyArmors: heavyArmorsLocations tunels: tunelsLocations
	| board |
	board := self emptyBoardWithOf: cols by: rows.
	lowPotencyMinesLocations do: [ :location | self inLocation: location ofBoard: board put: LowPotencyMine new ].
	highPotencyMinesLocations do: [ :location | self inLocation: location ofBoard: board put: HighPotencyMine new ].
	lightArmorsLocations do: [ :location | self inLocation: location ofBoard: board put: LightArmorPickup new ].
	heavyArmorsLocations do: [ :location | self inLocation: location ofBoard: board put: HeavyArmorPickup new ].
	
	tunelsLocations do: [ :tunelLocations |
		| firstLocation secondLocation tunel |
		firstLocation := tunelLocations first.
		secondLocation := tunelLocations second.
		tunel := Tunel between: firstLocation and: secondLocation.
		self inLocation: firstLocation ofBoard: board put: tunel.
		self inLocation: secondLocation ofBoard: board put: tunel.
	].
	^ board! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 21:15:15'!
createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations lightArmors: lightArmorsLocations

	^ self createBoardOf: cols by: rows withLowPotencyMinesAt: lowPotencyMinesLocations highPotencyMinesAt: #() lightArmors: lightArmorsLocations heavyArmors: #() tunels: #()! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 20:32:38'!
createBoardOf: cols by: rows withTunels: tunelsLocations

		^ self createBoardOf: cols by: rows withLowPotencyMinesAt: #() highPotencyMinesAt: #() lightArmors: #() heavyArmors: #() tunels: tunelsLocations ! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 20:21:46'!
createGameWithBoard: aMineFieldBoard startingAt: aStartingColumn lives: startingLives 
	
	^ MineFieldGame board: aMineFieldBoard startingAt: aStartingColumn lives: startingLives randomPointProvider: self.! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 19:30:30'!
emptyBoardWithOf: cols by: rows

	^ ((1 to: rows) collect: [ :number | self emptyRow: cols ]) asArray! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 20:25:21'!
emptyRow: rowSize

	^ ((1 to: rowSize) collect: [ :number | NoElement new ]) asArray! !

!MineFieldTest methodsFor: 'support' stamp: 'Matias Cra 11/30/2023 19:47:31'!
inLocation: location ofBoard: board put: element

	^ (board at: location y) at: (location x) put: element! !


!MineFieldTest methodsFor: 'assertions' stamp: 'Matias Cra 11/30/2023 18:53:54'!
shouldFailStartingAt: aStartingColumn inBoard: aBoard
	| game |

	self should: [ game := self createGameWithBoard: aBoard startingAt: aStartingColumn lives: 3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: game isNil.
			self assert: anError messageText equals: MineFieldGame invalidStartingPositionErrorDescription .
		]! !

!MineFieldTest methodsFor: 'assertions' stamp: 'Matias Cra 11/30/2023 19:29:37'!
shouldFailStartingWith: anAmountOfLives
	| game |

	self should: [ game := self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: anAmountOfLives ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: game isNil.
			self assert: anError messageText equals: MineFieldGame invalidLivesAmountErrorDescrition.
		]! !


!MineFieldTest methodsFor: 'setUp' stamp: 'Matias Cra 11/30/2023 20:28:19'!
setUp

	randomGenerator := [ :bottomLeft :topRight | 0@0 ].! !


!MineFieldTest methodsFor: 'random' stamp: 'Matias Cra 11/30/2023 20:23:36'!
randomPointInAreaBetween: bottomLeftPoint and: topRightPoint

	^ randomGenerator value: bottomLeftPoint value: topRightPoint ! !

!MineFieldTest methodsFor: 'random' stamp: 'Matias Cra 11/30/2023 20:23:03'!
setRandomToLeft

	randomGenerator := [ :bottomLeft :topRight | -1@0 ].! !

!MineFieldTest methodsFor: 'random' stamp: 'Matias Cra 11/30/2023 21:11:20'!
setRandomToThreeToTheRight

	randomGenerator := [ :bottomLeft :topRight | 3@0 ].! !

!MineFieldTest methodsFor: 'random' stamp: 'Matias Cra 11/30/2023 20:23:17'!
setRandomToUp

	randomGenerator := [ :bottomLeft :topRight | 0@1 ].! !


!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test01PlayerCanStartAt1x1
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: 3.
	self assert: (game playerIsAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test02PlayerCanStartAnywhereInFirstRow
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 2 lives: 3.
	self assert: (game playerIsAt: 2@1).
	
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 5 lives: 3.
	self assert: (game playerIsAt: 5@1).
	
	self deny: (game playerIsAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test03PlayerCannotStartOutsideTheField
	
	self shouldFailStartingAt: 0 inBoard: ( self emptyBoardWithOf: 5 by: 5).
	self shouldFailStartingAt: 6 inBoard: ( self emptyBoardWithOf: 5 by: 5).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test04PlayerMustStartAtAValidColumnNumber
	
	self shouldFailStartingAt: -1 inBoard: ( self emptyBoardWithOf: 5 by: 5).
	self shouldFailStartingAt: 1.2 inBoard: ( self emptyBoardWithOf: 5 by: 5).
	self shouldFailStartingAt: 'a' inBoard: ( self emptyBoardWithOf: 5 by: 5).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test05PlayerAlwaysStartsInFirstRow
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 2 lives: 3.
	self assert: (game playerIsAt: 2@1).
	self deny: (game playerIsAt: 2@3).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test06CreatedGameHasFiveByFiveBoard
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 2 lives: 3.
	self assert: game boardDimensions equals: 5@5.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:30:47'!
test07CreatedGameHasConfiguredBoardSize
	| game |
	game :=  self createGameWithBoard: (self emptyBoardWithOf: 6 by: 4) startingAt: 2 lives: 3.
	self assert: game boardDimensions equals: 6@4.
	self deny: (game boardDimensions = (5@5)).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test08PlayerCanMoveUp
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: 3.
	game moveUp.
	self assert: (game playerIsAt: 1@2).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test09PlayerCanMoveRight
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: 3.
	game moveRight.
	self assert: (game playerIsAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test10PlayerCanMoveDown
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: 3.
	game moveDown.
	self assert: (game playerIsAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test11PlayerCanMoveLeft
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 2 lives: 3.
	game moveLeft.
	self assert: (game playerIsAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test12PlayerCanMoveMultipleTimes
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: 3.
	game moveUp; moveRight.
	self assert: (game playerIsAt: (2@2)).
	game moveRight; moveRight; moveDown; moveLeft.
	self assert: (game playerIsAt: (3@1)).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test13PlayerCannotMoveOutsideOfBoard
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 5 lives: 3.
	10 timesRepeat: [ game moveLeft ].
	self assert: (game playerIsAt: (1@1)).
	10 timesRepeat: [ game moveRight ].
	self assert: (game playerIsAt: (5@1)).
	10 timesRepeat: [ game moveDown ].
	self assert: (game playerIsAt: (5@1)).
	10 timesRepeat: [ game moveUp ].
	self assert: (game playerIsAt: (5@5)).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test14PlayerCanStartWith3Lives
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: 3.
	self assert: (game remainingLivesAre: 3).
	self deny: (game remainingLivesAre: 2).
	self deny: (game remainingLivesAre: 4).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:29:37'!
test15PlayerCanStartWithConfiguredLives
	| game |
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: 1.
	self assert: (game remainingLivesAre: 1).
	self deny: (game remainingLivesAre: 3).
	
	game :=  self createGameWithBoard: ( self emptyBoardWithOf: 5 by: 5) startingAt: 1 lives: 10.
	self assert: (game remainingLivesAre: 10).
	self deny: (game remainingLivesAre: 1).
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 18:50:45'!
test16StartingLivesMustBePositive
	
	self shouldFailStartingWith: 0.
	self shouldFailStartingWith: -10.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 18:53:03'!
test17StartingLivesMustIntegers
	
	self shouldFailStartingWith: 'a'.
	self shouldFailStartingWith: 1.2.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:55:00'!
test18LowPotencyMineTakesALife
	| game |
	game :=  self createGameWithBoard: (self createBoardOf: 4 by: 4 withLowPotencyMinesAt: {(1@2).}) 
				startingAt: 1
				lives: 3.
		
	game moveUp.
	self assert: (game remainingLivesAre: 2).
	self assert: (game playerIsAt: 1@2).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:54:51'!
test19LowPotencyMineTakesALifeMovingFromAnywhere
	| game |
	game :=  self createGameWithBoard: (self createBoardOf: 4 by: 4 withLowPotencyMinesAt: {(1@2).}) 
				startingAt: 1
				lives: 3.
		
	game moveRight; moveUp; moveLeft.
	self assert: (game remainingLivesAre: 2).
	self assert: (game playerIsAt: 1@2).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:54:33'!
test20LowPotencyMineIsGoneAfterTriggering
	| game |
	game :=  self createGameWithBoard: ( self createBoardOf: 4 by: 4 withLowPotencyMinesAt: {(1@2).}) 
				startingAt: 1
				lives: 3.
		
	game moveRight; moveUp; moveLeft.
	self assert: (game remainingLivesAre: 2).
	self assert: (game playerIsAt: 1@2).
	game moveUp; moveDown.
	self assert: (game remainingLivesAre: 2).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:53:43'!
test21HighPotencyMineTakesTwoLives
	| game |
	game :=  self createGameWithBoard: (self createBoardOf: 4 by: 4 withHighPotencyMinesAt: {(4@4).}) 
				startingAt: 4
				lives: 3.
		
	4 timesRepeat: [ game moveUp. ].
	self assert: (game remainingLivesAre: 1).
! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 19:59:01'!
test22HighPotencyMineIsGoneAfterTriggering
	| game |
	game :=  self createGameWithBoard: (self createBoardOf: 4 by: 4 withHighPotencyMinesAt: {(4@4).}) 
				startingAt: 4
				lives: 3.
		
	3 timesRepeat: [ game moveUp. ].
	self assert: (game remainingLivesAre: 1).
	3 timesRepeat: [ game moveUp; moveRight ].
	self assert: (game remainingLivesAre: 1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 20:30:06'!
test23HighPotencyMineSendsPlayerFlying
	| game |
	game :=  self createGameWithBoard: (self createBoardOf: 10 by: 10 withHighPotencyMinesAt: {(5@5). (5@7).}) 
				startingAt: 5
				lives: 3.
		
	self setRandomToUp.
	4 timesRepeat: [ game moveUp. ].

	self assert: (game playerIsAt: (5@6)).

	self setRandomToLeft.
	game moveUp.
	self assert: (game playerIsAt: (4@7)).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:49:08'!
test24TunelWorksOneWay
	| game |
	game :=  self createGameWithBoard: (
					self createBoardOf: 10 by: 10 withTunels: {{(1@2). (9@9).}}
				)
				startingAt: 1
				lives: 3.

	game moveUp.
	self assert: (game playerIsAt: (9@9)).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:49:20'!
test25TunelsWorkBothWays
	| game |
	game :=  self createGameWithBoard: (
					self createBoardOf: 10 by: 10 withTunels: {{(1@2). (9@9).}}
				)
				startingAt: 1
				lives: 3.

	game moveUp.
	self assert: (game playerIsAt: (9@9)).
	game moveLeft; moveRight.
	self assert: (game playerIsAt: (1@2)).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:01:58'!
test26LightArmorPreventsDamageFromMines
	| game |
	game :=  self createGameWithBoard: (
					self createBoardOf: 10 by: 10
						 withLowPotencyMinesAt: {(1@3).} 
						 highPotencyMinesAt: {(1@5).} 
						 lightArmors: {(1@2). (1@4)}
				) 
				startingAt: 1
				lives: 3.

	4 timesRepeat: [ game moveUp ].
	self assert: (game remainingLivesAre: 3).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:10:51'!
test27LightArmorHalvesFlightFromHighPotencyMines
	| game |
	game :=  self createGameWithBoard: (
					self createBoardOf: 10 by: 10
						 withHighPotencyMinesAt: {(1@3).} 
						 lightArmors: {(1@2).}
				) 
				startingAt: 1
				lives: 3.

	self setRandomToThreeToTheRight.
	2 timesRepeat: [ game moveUp ].
	self assert: (game remainingLivesAre: 3).
	self assert: (game playerIsAt: (2@3)).! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:12:43'!
test28LightArmorBreaksWithMine
	| game |
	game :=  self createGameWithBoard: (
					self createBoardOf: 10 by: 10
						 withHighPotencyMinesAt: {(1@3).} 
						 lightArmors: {(1@2).}
				) 
				startingAt: 1
				lives: 3.

	self setRandomToThreeToTheRight.
	game moveUp.
	game assert: game playerHasLightArmor.
	game moveUp.
	self deny: game playerHasLightArmor.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:14:51'!
test29LightArmorDisappearsFromBoardAfterPickup
	| game |
	game :=  self createGameWithBoard: (
					self createBoardOf: 10 by: 10
						 withLowPotencyMinesAt: {(1@3).} 
						 lightArmors: {(1@2).}
				) 
				startingAt: 1
				lives: 3.

	self setRandomToThreeToTheRight.
	game moveUp; moveUp; moveDown.
	self deny: game playerHasLightArmor.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:16:55'!
test30LightGetsReplacedWithHeavyArmor
	| game |
	game :=  self createGameWithBoard: (
					self createBoardOf: 10 by: 10
						 lightArmors: {(1@2).}
						 heavyArmors: {(1@3).}
				) 
				startingAt: 1
				lives: 3.

	self setRandomToThreeToTheRight.
	game moveUp.
	self assert: game playerHasLightArmor.
	game moveUp.
	self deny: game playerHasLightArmor.
	self assert: game playerHasHeavyArmor.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:45:43'!
test31HeavyArmorWithstandsTwoLowPotencyMines
	| game |
	game :=  self createGameWithBoard: (
					self createBoardOf: 10 by: 10
						 withLowPotencyMinesAt: {(1@3). (1@4).}
						 heavyArmors: {(1@2).}
				) 
				startingAt: 1
				lives: 3.

	self setRandomToThreeToTheRight.
	game moveUp; moveUp.
	self assert: game playerHasHeavyArmor.
	game moveUp.
	self deny: game playerHasHeavyArmor.! !

!MineFieldTest methodsFor: 'tests' stamp: 'Matias Cra 11/30/2023 21:02:09'!
test99TODO
	
	"Ganar/Perder"
	"Volar recursivo"
	"El campo debe ser rectangular, minimo de 2x2 y tener elementos validos"
	"Emprolijar tests"! !


!classDefinition: #MineFieldElement category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #MineFieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineFieldElement methodsFor: 'triggering' stamp: 'Matias Cra 11/30/2023 20:16:22'!
triggerOn: aMineFieldGame

	self subclassResponsibility ! !


!classDefinition: #HeavyArmorPickup category: 'ISW1-2023-2C-2doParcial'!
MineFieldElement subclass: #HeavyArmorPickup
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!HeavyArmorPickup methodsFor: 'triggering' stamp: 'Matias Cra 11/30/2023 21:18:26'!
triggerOn: aMineFieldGame

	aMineFieldGame triggerHeavyArmor.! !


!classDefinition: #HighPotencyMine category: 'ISW1-2023-2C-2doParcial'!
MineFieldElement subclass: #HighPotencyMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!HighPotencyMine methodsFor: 'triggering' stamp: 'Matias Cra 11/30/2023 20:16:27'!
triggerOn: aMineFieldGame

	aMineFieldGame triggerHighPotencyMine.! !


!classDefinition: #LightArmorPickup category: 'ISW1-2023-2C-2doParcial'!
MineFieldElement subclass: #LightArmorPickup
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LightArmorPickup methodsFor: 'triggering' stamp: 'Matias Cra 11/30/2023 21:04:22'!
triggerOn: aMineFieldGame

	aMineFieldGame triggerLightArmor.! !


!classDefinition: #LowPotencyMine category: 'ISW1-2023-2C-2doParcial'!
MineFieldElement subclass: #LowPotencyMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LowPotencyMine methodsFor: 'triggering' stamp: 'Matias Cra 11/30/2023 20:10:26'!
triggerOn: aMineFieldGame

	aMineFieldGame triggerLowPotencyMine.! !


!classDefinition: #NoElement category: 'ISW1-2023-2C-2doParcial'!
MineFieldElement subclass: #NoElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!NoElement methodsFor: 'triggering' stamp: 'Matias Cra 11/30/2023 20:24:45'!
triggerOn: aMineFieldGame! !


!classDefinition: #Tunel category: 'ISW1-2023-2C-2doParcial'!
MineFieldElement subclass: #Tunel
	instanceVariableNames: 'firstLocation secondLocation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!
!Tunel commentStamp: '<historical>' prior: 0!
TODO: seguramente es mejor usar "patas" para no tener informacion rebundante!


!Tunel methodsFor: 'initialization' stamp: 'Matias Cra 11/30/2023 20:39:13'!
initializeBetween: aLocation and: anotherLocation

	firstLocation := aLocation.
	secondLocation := anotherLocation.! !


!Tunel methodsFor: 'triggering' stamp: 'Matias Cra 11/30/2023 20:49:01'!
triggerOn: aMineFieldGame

	(aMineFieldGame playerIsAt: firstLocation)
		ifTrue: [ ^ aMineFieldGame triggerTunelTo: secondLocation ].
		
	(aMineFieldGame playerIsAt: secondLocation)
		ifTrue: [ ^ aMineFieldGame triggerTunelTo: firstLocation ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tunel class' category: 'ISW1-2023-2C-2doParcial'!
Tunel class
	instanceVariableNames: ''!

!Tunel class methodsFor: 'instance creation' stamp: 'Matias Cra 11/30/2023 20:38:32'!
between: aLocation and: anotherLocation

	^ self new initializeBetween: aLocation and: anotherLocation! !


!classDefinition: #MineFieldGame category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #MineFieldGame
	instanceVariableNames: 'position board lives randomPointProvider armor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineFieldGame methodsFor: 'initialization' stamp: 'Matias Cra 11/30/2023 21:33:58'!
initializeWith: aBoard at: aColumnNumber lives: anAmountOfLives randomPointProvider: aRandomPointProvider  
	
	board := aBoard.
	position := aColumnNumber@1.
	lives := anAmountOfLives.
	randomPointProvider := aRandomPointProvider.
	self loseArmor.! !


!MineFieldGame methodsFor: 'board - private' stamp: 'Matias Cra 11/30/2023 19:07:44'!
elementAtCurrentPosition

	^ (board at: position y) at: position x! !


!MineFieldGame methodsFor: 'moving - private' stamp: 'Matias Cra 11/30/2023 19:10:48'!
moveTo: newPosition

	position := newPosition.
	self triggerCurrentPositionEffect.! !


!MineFieldGame methodsFor: 'moving' stamp: 'Matias Cra 11/30/2023 19:11:35'!
moveDown
	
	position y > 1 ifTrue: [
		self moveTo: position - (0@1)
	]! !

!MineFieldGame methodsFor: 'moving' stamp: 'Matias Cra 11/30/2023 19:11:28'!
moveLeft
	
	position x > 1 ifTrue: [
		self moveTo: position - (1@0)
	]! !

!MineFieldGame methodsFor: 'moving' stamp: 'Matias Cra 11/30/2023 19:11:15'!
moveRight
	
	position x < self numberOfColumns ifTrue: [
		self moveTo: position + (1@0).
	]! !

!MineFieldGame methodsFor: 'moving' stamp: 'Matias Cra 11/30/2023 19:10:58'!
moveUp
	
	position y < self numberOfRows ifTrue: [
		self moveTo: position + (0@1).
	]! !


!MineFieldGame methodsFor: 'accessing' stamp: 'Matias Cra 11/30/2023 19:31:20'!
boardDimensions

	^ self numberOfColumns @ self numberOfRows ! !

!MineFieldGame methodsFor: 'accessing' stamp: 'Matias Cra 11/30/2023 18:03:32'!
numberOfColumns

	^ board first size! !

!MineFieldGame methodsFor: 'accessing' stamp: 'Matias Cra 11/30/2023 18:03:24'!
numberOfRows

	^ board size! !


!MineFieldGame methodsFor: 'testing' stamp: 'Matias Cra 11/30/2023 21:38:14'!
playerHasHeavyArmor

	^ armor isKindOf: HeavyArmor ! !

!MineFieldGame methodsFor: 'testing' stamp: 'Matias Cra 11/30/2023 21:38:03'!
playerHasLightArmor

	^ armor isKindOf: LightArmor ! !

!MineFieldGame methodsFor: 'testing' stamp: 'Matias Cra 11/30/2023 18:26:44'!
playerIsAt: aPosition

	^ position = aPosition! !

!MineFieldGame methodsFor: 'testing' stamp: 'Matias Cra 11/30/2023 18:46:00'!
remainingLivesAre: anAmountOfLives

	^ anAmountOfLives = lives.! !


!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 20:27:42'!
emptyCurrentPosition

	^ (board at: position y) at: position x put: NoElement new! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 21:31:56'!
getRandomFlightDisplacement

	^ randomPointProvider randomPointInAreaBetween: (-3@3) and: (3@3)! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 21:33:58'!
loseArmor

	^ armor := NoArmor new! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 21:28:20'!
takeDamage: anAmountOfLives

	^ lives := lives - (armor damageTaken: anAmountOfLives)! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 20:18:46'!
triggerCurrentPositionEffect

	self elementAtCurrentPosition triggerOn: self.

! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 21:36:30'!
triggerHeavyArmor

	armor := HeavyArmor new.
	self emptyCurrentPosition.! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 21:47:51'!
triggerHighPotencyMine
	| amountToFly |
	self takeDamage: 2.
	self emptyCurrentPosition.
	amountToFly := armor makeFlyBy: (self getRandomFlightDisplacement).
	armor highPotencyMineTakenIn: self.
	"TODO: testear cambiar por moveTo: para hacerlo recursivo"
	position := position + amountToFly.
! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 21:36:21'!
triggerLightArmor

	armor := LightArmor new.
	self emptyCurrentPosition.! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 21:42:51'!
triggerLowPotencyMine
	
	self takeDamage: 1.
	armor lowPotencyMineTakenIn: self.
	self emptyCurrentPosition.! !

!MineFieldGame methodsFor: 'triggering - private' stamp: 'Matias Cra 11/30/2023 20:44:13'!
triggerTunelTo: aNewPosition

	position := aNewPosition 	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineFieldGame class' category: 'ISW1-2023-2C-2doParcial'!
MineFieldGame class
	instanceVariableNames: ''!

!MineFieldGame class methodsFor: 'instance creation' stamp: 'Matias Cra 11/30/2023 20:19:59'!
board: aBoard startingAt: aColumnNumber lives: anAmountOfLives randomPointProvider: aRandomPointProvider  

	self assertColumn: aColumnNumber inBoard: aBoard.	
	self assertPositiveLives: anAmountOfLives.
	^ self new initializeWith: aBoard at: aColumnNumber lives: anAmountOfLives randomPointProvider: aRandomPointProvider! !


!MineFieldGame class methodsFor: 'error assertion' stamp: 'Matias Cra 11/30/2023 17:53:31'!
assertColumn: aColumnNumber inBoard: aBoard

	 ((aColumnNumber isKindOf: Integer) and: [ 0 < aColumnNumber ] and: [ aColumnNumber <= (self numberOfColumns: aBoard) ])
		ifFalse: [ self error: self invalidStartingPositionErrorDescription ]! !

!MineFieldGame class methodsFor: 'error assertion' stamp: 'Matias Cra 11/30/2023 18:53:26'!
assertPositiveLives: anAmountOfLives

	 ((anAmountOfLives isKindOf: Integer) and: [ anAmountOfLives > 0 ])
		ifFalse: [ self error: self invalidLivesAmountErrorDescrition ]! !

!MineFieldGame class methodsFor: 'error assertion' stamp: 'Matias Cra 11/30/2023 18:48:17'!
invalidLivesAmountErrorDescrition

	^ 'Amount of starting lives must be a positive integer'! !

!MineFieldGame class methodsFor: 'error assertion' stamp: 'Matias Cra 11/30/2023 17:39:52'!
invalidStartingPositionErrorDescription

	^ 'Can''t start in desired position, must start at a valid position in the first row of the board'! !

!MineFieldGame class methodsFor: 'error assertion' stamp: 'Matias Cra 11/30/2023 17:52:09'!
numberOfColumns: aBoard

	^ aBoard first size! !


!classDefinition: #PlayerArmor category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #PlayerArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!
!PlayerArmor commentStamp: '<historical>' prior: 0!
TODO: conviene usar un state completo?!


!PlayerArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:23:29'!
damageTaken: anAmountOfLives
	
	self subclassResponsibility ! !

!PlayerArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:40:21'!
highPotencyMineTakenIn: aMineFieldGame

	self subclassResponsibility.! !

!PlayerArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:39:17'!
lowPotencyMineTaken

	self subclassResponsibility ! !

!PlayerArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:40:27'!
lowPotencyMineTakenIn: aMineFieldGame

	self subclassResponsibility.! !

!PlayerArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:26:21'!
makeFlyBy: aPointToFlyBy

	self subclassResponsibility ! !


!classDefinition: #HeavyArmor category: 'ISW1-2023-2C-2doParcial'!
PlayerArmor subclass: #HeavyArmor
	instanceVariableNames: 'lowPotencyMinesTaken'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!HeavyArmor methodsFor: 'initialization' stamp: 'Matias Cra 11/30/2023 21:46:43'!
initialize

	lowPotencyMinesTaken := 2! !


!HeavyArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:35:52'!
damageTaken: anAmountOfLives

	^ 0! !

!HeavyArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:41:06'!
highPotencyMineTakenIn: aMineFieldGame

	aMineFieldGame loseArmor.! !

!HeavyArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:41:56'!
lowPotencyMineTakenIn: aMineFieldGame
	
	lowPotencyMinesTaken := lowPotencyMinesTaken - 1.
	lowPotencyMinesTaken = 0 ifTrue: [ aMineFieldGame loseArmor. ]! !

!HeavyArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:36:04'!
makeFlyBy: aPointToFlyBy

	^ 0@0! !


!classDefinition: #LightArmor category: 'ISW1-2023-2C-2doParcial'!
PlayerArmor subclass: #LightArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LightArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:35:34'!
damageTaken: anAmountOfLives

	^ 0! !

!LightArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:41:01'!
highPotencyMineTakenIn: aMineFieldGame

	aMineFieldGame loseArmor.! !

!LightArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:40:01'!
lowPotencyMineTakenIn: aMineFieldGame

	aMineFieldGame loseArmor.! !

!LightArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:35:38'!
makeFlyBy: aPointToFlyBy

	^ aPointToFlyBy // 2! !


!classDefinition: #NoArmor category: 'ISW1-2023-2C-2doParcial'!
PlayerArmor subclass: #NoArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!NoArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:25:20'!
damageTaken: anAmountOfLives

	^ anAmountOfLives ! !

!NoArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:40:50'!
highPotencyMineTakenIn: aMineFieldGame

! !

!NoArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:40:32'!
lowPotencyMineTakenIn: aMineFieldGame

! !

!NoArmor methodsFor: 'armor' stamp: 'Matias Cra 11/30/2023 21:26:02'!
makeFlyBy: aPointToFlyBy

	^ aPointToFlyBy ! !
