import XCTest
@testable import BullsEye

class BullsEyeTests: XCTestCase {
    var sut: BullsEyeGame!
    
    override func setUp() {
        super.setUp()
        sut = BullsEyeGame()
        sut.startNewGame()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testScoreIsComputedCorrectly() {
        let guess = sut.targetValue - 5
        sut.check(guess: guess)
        XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
    }
    
    
    func testPlayerscontrollerDeinit() {
        class ClassUnderTest: PlayersViewController {
            var deinitCalled: (() -> Void)?
            deinit { deinitCalled?() }
        }
        
        let exp = expectation(description: "PlayersViewController deinitialized")
        
        var playersVC: ClassUnderTest? = ClassUnderTest()
        playersVC?.deinitCalled = {
            exp.fulfill()
        }
        
        let address = Address(fullAddress: "123 Tutorial Street")
        playersVC?.players = [Player(name: "Peter", address: address)]
        playersVC?.loadPlayerPhotos()
        
        DispatchQueue.global(qos: .background).async {
            playersVC = nil
        }
        
        waitForExpectations(timeout: 5)
    }
}
