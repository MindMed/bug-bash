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
  
  func testScoreIsComputedWhenGuessGTTarget() {
    let guess = sut.targetValue + 5
    sut.check(guess: guess)
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
  
  func testScoreIsComputedWhenGuessLTTarget() {
    let guess = sut.targetValue - 5
    sut.check(guess: guess)
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
}
