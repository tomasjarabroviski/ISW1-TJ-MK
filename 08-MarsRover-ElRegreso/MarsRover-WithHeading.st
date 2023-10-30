!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/28/2023 20:31:51'!
test01RoverStartsWithEmptyLog
	| rover logger |
	rover := MarsRover at: 0@0 heading: self north.
	logger := RoverGenericLogger new.
	rover addLogger: logger.
	self assert: logger log isEmpty.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/28/2023 20:31:51'!
test02RoverCanLogOneForward
	| rover logger |
	rover := MarsRover at: 1@1 heading: self north.
	logger := RoverGenericLogger new.
	rover addLogger: logger.
	rover process: 'f'. 
	self assert: logger log equals: (OrderedCollection with: '1@2').! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/28/2023 20:31:51'!
test03RoverCanLogAnyOneCommand
	| rover logger |
	rover := MarsRover at: 1@1 heading: self north.
	logger := RoverGenericLogger new.
	rover addLogger: logger.
	rover process: 'b'. 
	self assert: logger log equals: (OrderedCollection with: '1@0').

	rover := MarsRover at: 1@1 heading: self north.
	logger := RoverGenericLogger new.
	rover addLogger: logger.
	rover process: 'r'. 
	self assert: logger log equals: (OrderedCollection with: 'East').

	rover := MarsRover at: 1@1 heading: self north.
	logger := RoverGenericLogger new.
	rover addLogger: logger..
	rover process: 'l'. 
	self assert: logger log equals: (OrderedCollection with: 'West').
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/28/2023 20:31:51'!
test04RoverCanLogMultipleCommands
	| rover logger |
	rover := MarsRover at: 1@1 heading: self north.
	logger := RoverGenericLogger new.
	rover addLogger: logger.
	rover process: 'frfffblll'. 
	self assert: logger log asArray equals: #('1@2' 'East' '2@2' '3@2' '4@2' '3@2' 'North' 'West' 'South').
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 21:34:56'!
test05CanLogOnlyPosition
	| rover positionLogger |
	rover := MarsRover at: 1@1 heading: self north.
	positionLogger := RoverPositionLogger new.
	rover addLogger: positionLogger to: 'position' using: [ :logger :position | logger updatePosition: position ].
	rover process: 'frfffblll'.
	self assert: positionLogger log asArray equals: #('1@2' '2@2' '3@2' '4@2' '3@2').
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 21:35:16'!
test06CanLogOnlyHead
	| rover headLogger |
	rover := MarsRover at: 1@1 heading: self north.
	headLogger := RoverHeadLogger new.
	rover addLogger: headLogger to: 'head' using: [ :logger :head | logger updateHead: head ].
	rover process: 'frfffblll'. 
	self assert: headLogger log asArray equals: #('East' 'North' 'West' 'South').
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/28/2023 20:31:51'!
test07CanHaveMultipleLogs
	| rover firstLogger secondLogger |
	rover := MarsRover at: 1@1 heading: self north.
	firstLogger := RoverGenericLogger new.
	secondLogger := RoverGenericLogger new.
	rover addLogger: firstLogger.
	rover process: 'frff'.
	self assert: firstLogger log asArray equals: #('1@2' 'East' '2@2' '3@2').
	
	rover addLogger: secondLogger.
	rover process: 'fblll'. 
	self assert: firstLogger log asArray equals: #('1@2' 'East' '2@2' '3@2' '4@2' '3@2' 'North' 'West' 'South').
	self assert: secondLogger log asArray equals: #('4@2' '3@2' 'North' 'West' 'South').! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 21:35:37'!
test08CanHaveMultipleDifferentLogs
	| rover positionLogger headLogger |
	rover := MarsRover at: 1@1 heading: self north.
	positionLogger := RoverPositionLogger new.
	headLogger := RoverHeadLogger new.
	rover addLogger: positionLogger to: 'position' using: [ :logger :position | logger updatePosition: position ].
	rover process: 'frff'.
	self assert: positionLogger log asArray equals: #('1@2' '2@2' '3@2').
	
	rover addLogger: headLogger to: 'head' using: [ :logger :head | logger updateHead: head ].
	rover process: 'fblll'. 
	self assert: positionLogger log asArray equals: #('1@2' '2@2' '3@2' '4@2' '3@2').
	self assert: headLogger log asArray equals: #('North' 'West' 'South').! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 22:59:49'!
test09WindowLoggerStartsEmpty
	| rover windowLogger |
	rover := MarsRover at: 1@1 heading: self north.
	windowLogger := RoverPositionWindowLogger new.
	rover addLogger: windowLogger to: 'position' using: [ :logger :position | logger displayPosition: position ].

	self assert: windowLogger displaying equals: ''.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 22:59:21'!
test10WindowLoggerCanLogPosition
	| rover windowLogger |
	rover := MarsRover at: 1@1 heading: self north.
	windowLogger := RoverPositionWindowLogger new.
	rover addLogger: windowLogger to: 'position' using: [ :logger :position | logger displayPosition: position ].

	rover process: 'frbb'.
	self assert: windowLogger displaying equals: '-1@2'.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 23:00:37'!
test11WindowLoggerCanLogHead
	| rover windowLogger |
	rover := MarsRover at: 1@1 heading: self north.
	windowLogger := RoverHeadWindowLogger new.
	rover addLogger: windowLogger to: 'head' using: [ :logger :head | logger displayHead: head ].
	rover process: 'frbbfbbr'.
	self assert: windowLogger displaying equals: 'Apuntando al Sur'.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 23:02:36'!
test12WindowLoggerCanLogPositionAndHead
	| rover windowLogger |
	rover := MarsRover at: 1@1 heading: self north.
	windowLogger := RoverPositionAndHeadWindowLogger new.
	rover addLogger: windowLogger to: 'position' using: [ :logger :position | logger displayPosition: position ].

	rover process: 'frb'.
	self assert: windowLogger position equals: '0@2'.
	self assert: windowLogger head equals: ''.
	
	rover addLogger: windowLogger to: 'head' using: [ :logger :head | logger displayHead: head ].
	rover process: 'bfbbr'.
	self assert: windowLogger position equals: '-2@2'.
	self assert: windowLogger head equals: 'Apuntando al Sur'.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 14:53:35'!
test13CantAddLoggerToNonExistantAspect
	| rover logger |
	rover := MarsRover at: 1@1 heading: self north.
	logger := RoverGenericLogger new.
	self should: [ rover addLogger: logger to: 'darío' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MarsRover cannotLogNonExistantAspectErrorDescription	.
			self deny: (logger isLogging: rover)
		]! !


!MarsRoverLogTest methodsFor: 'headings' stamp: 'Matias Cra 10/26/2023 20:33:52'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'Matias Cra 10/26/2023 20:34:03'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'Matias Cra 10/26/2023 20:34:08'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'Matias Cra 10/26/2023 20:33:58'!
west

	^ MarsRoverHeadingWest ! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #ObservableProxyTest category: 'MarsRover-WithHeading'!
TestCase subclass: #ObservableProxyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObservableProxyTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 18:47:49'!
test01CanAccessData
	| proxy |
	proxy := ObservableProxy for: 0.
	self assert: proxy value equals: 0.! !

!ObservableProxyTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 21:48:52'!
test02CanAttachAnObserver
	| proxy logger |
	proxy := ObservableProxy for: 0.
	logger := GenericLogger new.
	proxy attach: logger using: [ :objectToLog | logger updateLog: objectToLog ].
	self assert: proxy value equals: 0.
	self assert: logger log isEmpty.! !

!ObservableProxyTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 21:48:38'!
test03CanObserveAChange
	| proxy logger |
	proxy := ObservableProxy for: 0.
	logger := GenericLogger new.
	proxy attach: logger using: [ :observer :objectToLog | observer updateLog: objectToLog ].
	proxy set: proxy value + 2.
	self assert: proxy value equals: 2.
	self assert: logger log asArray equals: #('2').! !

!ObservableProxyTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 21:48:38'!
test04CanObserveMultipleChanges
	| proxy logger |
	proxy := ObservableProxy for: 0.
	logger := GenericLogger new.
	proxy attach: logger using: [ :observer :objectToLog | observer updateLog: objectToLog ].
	proxy set: proxy value + 2.
	proxy set: proxy value - 1.
	proxy set: 'Pepe'.
	self assert: proxy value equals: 'Pepe'.
	self assert: logger log asArray equals: #('2' '1' 'Pepe').! !

!ObservableProxyTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 21:48:59'!
test05CanAttachMultipleObservers
	| proxy logger secondLogger |
	proxy := ObservableProxy for: 1.
	logger := GenericLogger new.
	secondLogger := GenericLogger new.
	proxy attach: logger using: [ :observer :objectToLog | observer updateLog: objectToLog ].
	proxy set: 2; set: 3.
	proxy attach: secondLogger using: [ :observer :objectToLog | observer updateLog: objectToLog ].
	proxy set: 4; set: 5.
	self assert: logger log asArray equals: #('2' '3' '4' '5').
	self assert: secondLogger log asArray equals: #('4' '5').! !

!ObservableProxyTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 14:47:24'!
test06CanSendMessagesToValue
	| proxy logger |
	proxy := ObservableProxy for: OrderedCollection new.
	logger := GenericLogger new.
	proxy attach: logger using: [ :observer :objectToLog | observer updateLog: objectToLog ].
	proxy add: 1.
	proxy add: 'Pepe'.
	self assert: proxy equals: (OrderedCollection with: 1 with: 'Pepe').
	self assert: logger log isEmpty.! !

!ObservableProxyTest methodsFor: 'tests' stamp: 'Matias Cra 10/30/2023 14:47:01'!
test07CanSendMessagesToValueAndRecieveAnswer
	| proxy logger |
	proxy := ObservableProxy for: Monday.
	logger := GenericLogger new.
	proxy attach: logger using: [ :observer :objectToLog | observer updateLog: objectToLog ].
	
	self deny: proxy isSaturday.
	self assert: (proxy equals: Monday).
	self assert: logger log isEmpty.! !

!ObservableProxyTest methodsFor: 'tests' stamp: 'Matias Cra 10/29/2023 21:48:38'!
test08CanTestObserver
	| proxy firstLogger secondLogger |
	proxy := ObservableProxy for: Monday.
	firstLogger := GenericLogger new.
	secondLogger := GenericLogger new.
	proxy attach: firstLogger using: [ :logger :data | logger updateLog: data ].

	self assert: (proxy hasObserver: firstLogger).
	self deny: (proxy hasObserver: secondLogger).! !


!classDefinition: #ChangesLogger category: 'MarsRover-WithHeading'!
Object subclass: #ChangesLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ChangesLogger methodsFor: 'accessing' stamp: 'Matias Cra 10/26/2023 21:12:56'!
log

	^ log! !


!ChangesLogger methodsFor: 'initialization' stamp: 'Matias Cra 10/26/2023 21:12:45'!
initialize

	log := OrderedCollection new! !


!classDefinition: #GenericLogger category: 'MarsRover-WithHeading'!
ChangesLogger subclass: #GenericLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!GenericLogger methodsFor: 'logging' stamp: 'Matias Cra 10/29/2023 21:46:24'!
updateLog: objectToLog

	log add: objectToLog asString! !


!classDefinition: #RoverLogger category: 'MarsRover-WithHeading'!
ChangesLogger subclass: #RoverLogger
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverLogger methodsFor: 'setting' stamp: 'Matias Cra 10/29/2023 19:48:20'!
setRover: aRover

	rover := aRover! !


!RoverLogger methodsFor: 'testing' stamp: 'Matias Cra 10/30/2023 14:52:28'!
isLogging: aMarsRover

	^ aMarsRover = rover! !


!classDefinition: #RoverGenericLogger category: 'MarsRover-WithHeading'!
RoverLogger subclass: #RoverGenericLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverGenericLogger methodsFor: 'logging' stamp: 'Matias Cra 10/29/2023 19:59:49'!
updateLog: objectToLog
	| logString |
	logString := objectToLog asString.
	(objectToLog isKindOf: MarsRoverHeading) ifTrue: [
		(objectToLog isHeading: MarsRoverHeadingEast) ifTrue: [ logString := 'East' ].
		(objectToLog isHeading: MarsRoverHeadingWest) ifTrue: [ logString := 'West' ].
		(objectToLog isHeading: MarsRoverHeadingNorth) ifTrue: [ logString := 'North' ].	
		(objectToLog isHeading: MarsRoverHeadingSouth) ifTrue: [ logString := 'South' ].	
	].
	^ log add: logString ! !


!classDefinition: #RoverHeadLogger category: 'MarsRover-WithHeading'!
RoverLogger subclass: #RoverHeadLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverHeadLogger methodsFor: 'logging' stamp: 'Matias Cra 10/29/2023 19:49:47'!
updateHead: aMarsRoverHeading

	(aMarsRoverHeading isHeading: MarsRoverHeadingEast) ifTrue: [ ^ log add: 'East' ].
	(aMarsRoverHeading isHeading: MarsRoverHeadingWest) ifTrue: [ ^ log add: 'West' ].
	(aMarsRoverHeading isHeading: MarsRoverHeadingNorth) ifTrue: [ ^ log add: 'North' ].	
	(aMarsRoverHeading isHeading: MarsRoverHeadingSouth) ifTrue: [ ^ log add: 'South' ].	! !


!classDefinition: #RoverPositionAndHeadLogger category: 'MarsRover-WithHeading'!
RoverLogger subclass: #RoverPositionAndHeadLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverPositionAndHeadLogger methodsFor: 'logging' stamp: 'Matias Cra 10/29/2023 22:28:31'!
updateHead: aMarsRoverHeading

	(aMarsRoverHeading isHeading: MarsRoverHeadingEast) ifTrue: [ ^ log add: 'East' ].
	(aMarsRoverHeading isHeading: MarsRoverHeadingWest) ifTrue: [ ^ log add: 'West' ].
	(aMarsRoverHeading isHeading: MarsRoverHeadingNorth) ifTrue: [ ^ log add: 'North' ].	
	(aMarsRoverHeading isHeading: MarsRoverHeadingSouth) ifTrue: [ ^ log add: 'South' ].	! !

!RoverPositionAndHeadLogger methodsFor: 'logging' stamp: 'Matias Cra 10/29/2023 22:28:21'!
updatePosition: aPositionPoint

	log add: aPositionPoint asString! !


!classDefinition: #RoverPositionLogger category: 'MarsRover-WithHeading'!
RoverLogger subclass: #RoverPositionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverPositionLogger methodsFor: 'logging' stamp: 'Matias Cra 10/28/2023 20:09:19'!
updatePosition: aPositionPoint

	log add: aPositionPoint asString! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'Matias Cra 10/29/2023 19:25:39'!
initializeAt: aPosition heading: aHeadingType

	position := ObservableProxy for: aPosition.
	head := ObservableProxy for: (aHeadingType for: self)! !


!MarsRover methodsFor: 'heading' stamp: 'Matias Cra 10/29/2023 19:26:01'!
headEast
	
	head set: (MarsRoverHeadingEast for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'Matias Cra 10/29/2023 19:26:08'!
headNorth
	
	head set: (MarsRoverHeadingNorth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'Matias Cra 10/29/2023 19:26:15'!
headSouth
	
	head set: (MarsRoverHeadingSouth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'Matias Cra 10/29/2023 19:26:21'!
headWest
	
	head set: (MarsRoverHeadingWest for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'Matias Cra 10/29/2023 19:50:42'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'Matias Cra 10/29/2023 19:50:45'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'Matias Cra 10/30/2023 14:48:24'!
isAt: aPosition heading: aHeadingType

	^ (position equals: aPosition) and: [ head isHeading: aHeadingType ]	! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'Matias Cra 10/29/2023 19:50:36'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'Matias Cra 10/30/2023 15:05:06'!
moveEast
	
	position set: position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'Matias Cra 10/29/2023 19:50:32'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'Matias Cra 10/30/2023 15:05:00'!
moveNorth
	
	position set: position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'Matias Cra 10/30/2023 15:04:45'!
moveSouth
	
	position set: position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'Matias Cra 10/30/2023 15:04:28'!
moveWest
	
	position set: position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'logging' stamp: 'Matias Cra 10/29/2023 21:37:24'!
addLogger: aLogger

	self addLogger: aLogger to: ''! !

!MarsRover methodsFor: 'logging' stamp: 'Matias Cra 10/29/2023 21:37:18'!
addLogger: aLogger to: aCollaboratorName

	self addLogger: aLogger to: aCollaboratorName using: [ :logger :objectToLog | logger updateLog: objectToLog ]! !

!MarsRover methodsFor: 'logging' stamp: 'Matias Cra 10/30/2023 14:55:37'!
addLogger: aLogger to: aCollaboratorName using: aLoggingClosure
	
	aCollaboratorName ifEmpty: [
		^ self attatchToAll: aLogger using: aLoggingClosure
	].

	self assertValidAspect: aCollaboratorName.
	(self instVarNamed: aCollaboratorName) attach: aLogger using: aLoggingClosure.
	aLogger setRover: self.! !

!MarsRover methodsFor: 'logging' stamp: 'Matias Cra 10/30/2023 14:56:18'!
assertValidAspect: aCollaboratorName

	(self isCollaborator: aCollaboratorName) ifFalse: [ self error: self class cannotLogNonExistantAspectErrorDescription ] 
! !

!MarsRover methodsFor: 'logging' stamp: 'Matias Cra 10/30/2023 14:55:21'!
attatchToAll: aLogger using: aLoggingClosure
	
	self class allInstVarNames do: [ :aCollaboratorName |
		(self instVarNamed: aCollaboratorName) attach: aLogger using: aLoggingClosure.
	]! !

!MarsRover methodsFor: 'logging' stamp: 'Matias Cra 10/30/2023 14:59:35'!
isCollaborator: aCollaboratorName

	^ self class allInstVarNames includes: 	aCollaboratorName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'errors' stamp: 'Matias Cra 10/30/2023 14:54:40'!
cannotLogNonExistantAspectErrorDescription

	^ 'Can''t add logger: specified aspect isn''t part of a Mars Rover'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #ObservableProxy category: 'MarsRover-WithHeading'!
Object subclass: #ObservableProxy
	instanceVariableNames: 'data observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObservableProxy methodsFor: 'accessing' stamp: 'Matias Cra 10/29/2023 18:47:42'!
value

	^ data! !


!ObservableProxy methodsFor: 'initialization' stamp: 'Matias Cra 10/29/2023 21:28:20'!
initializeFor: aValue

	data := aValue.
	observers := OrderedCollection new.! !


!ObservableProxy methodsFor: 'observing' stamp: 'Matias Cra 10/29/2023 21:48:38'!
attach: observer using: onUpdateClosure

	observers add: (Array with: observer with: onUpdateClosure)
	! !


!ObservableProxy methodsFor: 'updating' stamp: 'Matias Cra 10/29/2023 22:01:50'!
notify
	
	observers do: [ :observerAndClosure |
		| observer observingClosure |
		observer := observerAndClosure first.
		observingClosure := observerAndClosure second.
		observingClosure value: observer value: data	
	]! !

!ObservableProxy methodsFor: 'updating' stamp: 'Matias Cra 10/29/2023 19:00:22'!
set: aNewValue

	data := aNewValue.
	self notify.! !


!ObservableProxy methodsFor: 'messaging' stamp: 'Matias Cra 10/29/2023 21:56:54'!
doesNotUnderstand: aMessage
	
	^ aMessage sendTo: data! !


!ObservableProxy methodsFor: 'testing' stamp: 'Matias Cra 10/30/2023 14:46:36'!
equals: aValue

	^ data = aValue! !

!ObservableProxy methodsFor: 'testing' stamp: 'Matias Cra 10/29/2023 22:01:40'!
hasObserver: anObserver

	^ observers anySatisfy: [ :observerAndClosure | observerAndClosure first = anObserver ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ObservableProxy class' category: 'MarsRover-WithHeading'!
ObservableProxy class
	instanceVariableNames: ''!

!ObservableProxy class methodsFor: 'instance creation' stamp: 'Matias Cra 10/29/2023 18:46:50'!
for: aValue

	^ self new initializeFor: aValue! !


!classDefinition: #RoverWindowLogger category: 'MarsRover-WithHeading'!
Object subclass: #RoverWindowLogger
	instanceVariableNames: 'displaying rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!
!RoverWindowLogger commentStamp: '<historical>' prior: 0!
Uso variable de instancia 'displaying' para simular lo que mostraría en la ventana como contestó Hernán!


!RoverWindowLogger methodsFor: 'initializing' stamp: 'Matias Cra 10/29/2023 22:24:02'!
initialize

	displaying := ''! !



!RoverWindowLogger methodsFor: 'setting' stamp: 'Matias Cra 10/29/2023 22:55:29'!
setRover: aMarsRover

	rover := aMarsRover ! !


!RoverWindowLogger methodsFor: 'accessing' stamp: 'Matias Cra 10/29/2023 22:24:50'!
displaying

	^ displaying ! !


!classDefinition: #RoverHeadWindowLogger category: 'MarsRover-WithHeading'!
RoverWindowLogger subclass: #RoverHeadWindowLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!
!RoverHeadWindowLogger commentStamp: '<historical>' prior: 0!
Uso variable de instancia 'displaying' para simular lo que mostraría en la ventana como contestó Hernán!


!RoverHeadWindowLogger methodsFor: 'displaying' stamp: 'Matias Cra 10/29/2023 22:53:35'!
displayHead: aMarsRoverHeading

	(aMarsRoverHeading isHeading: MarsRoverHeadingEast) ifTrue: [ displaying := 'Apuntando al Este' ].
	(aMarsRoverHeading isHeading: MarsRoverHeadingWest) ifTrue: [ displaying := 'Apuntando al Oeste' ].
	(aMarsRoverHeading isHeading: MarsRoverHeadingNorth) ifTrue: [ displaying := 'Apuntando al Norte' ].	
	(aMarsRoverHeading isHeading: MarsRoverHeadingSouth) ifTrue: [ displaying := 'Apuntando al Sur' ].	! !


!classDefinition: #RoverPositionAndHeadWindowLogger category: 'MarsRover-WithHeading'!
RoverWindowLogger subclass: #RoverPositionAndHeadWindowLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!
!RoverPositionAndHeadWindowLogger commentStamp: '<historical>' prior: 0!
Uso variable de instancia 'displaying' para simular lo que mostraría en la ventana como contestó Hernán!


!RoverPositionAndHeadWindowLogger methodsFor: 'initializing' stamp: 'Matias Cra 10/29/2023 22:55:50'!
initialize

	displaying := OrderedCollection with: '' with: ''! !


!RoverPositionAndHeadWindowLogger methodsFor: 'displaying' stamp: 'Matias Cra 10/29/2023 22:57:52'!
displayHead: aMarsRoverHeading

	(aMarsRoverHeading isHeading: MarsRoverHeadingEast) ifTrue: [ self setHead: 'Apuntando al Este' ].
	(aMarsRoverHeading isHeading: MarsRoverHeadingWest) ifTrue: [ self setHead: 'Apuntando al Oeste' ].
	(aMarsRoverHeading isHeading: MarsRoverHeadingNorth) ifTrue: [ self setHead: 'Apuntando al Norte' ].	
	(aMarsRoverHeading isHeading: MarsRoverHeadingSouth) ifTrue: [ self setHead: 'Apuntando al Sur' ].	! !

!RoverPositionAndHeadWindowLogger methodsFor: 'displaying' stamp: 'Matias Cra 10/29/2023 22:58:05'!
displayPosition: aPosition
	
	self setPosition: aPosition asString! !

!RoverPositionAndHeadWindowLogger methodsFor: 'displaying' stamp: 'Matias Cra 10/29/2023 22:58:42'!
setHead: aHeadingString

	displaying at: 2 put: aHeadingString ! !

!RoverPositionAndHeadWindowLogger methodsFor: 'displaying' stamp: 'Matias Cra 10/29/2023 22:58:28'!
setPosition: aPositionString

	displaying at: 1 put: aPositionString ! !


!RoverPositionAndHeadWindowLogger methodsFor: 'accessing' stamp: 'Matias Cra 10/29/2023 22:56:19'!
head

	^ displaying second! !

!RoverPositionAndHeadWindowLogger methodsFor: 'accessing' stamp: 'Matias Cra 10/29/2023 22:56:14'!
position

	^ displaying first! !


!classDefinition: #RoverPositionWindowLogger category: 'MarsRover-WithHeading'!
RoverWindowLogger subclass: #RoverPositionWindowLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!
!RoverPositionWindowLogger commentStamp: '<historical>' prior: 0!
Uso variable de instancia 'displaying' para simular lo que mostraría en la ventana como contestó Hernán!


!RoverPositionWindowLogger methodsFor: 'displaying' stamp: 'Matias Cra 10/29/2023 22:50:35'!
displayPosition: aPosition
	
	displaying := aPosition asString! !
