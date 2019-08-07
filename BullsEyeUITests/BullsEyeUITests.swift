import XCTest

class BullsEyeUITests: XCTestCase {
  var app: XCUIApplication!
  
  override func setUp() {
    continueAfterFailure = false
    
    app = XCUIApplication()
    app.launch()
  }
  
  func testPlayerAddressChange() {
    let oldAddress = "123 Tutorial Street"
    let newAddress = "Michalska 12"
    app.buttons["Players"].tap()
    
    let player1Address = app.staticTexts["player1Address"]
    let player2Address = app.staticTexts["player2Address"]
    
    XCTAssertEqual(player1Address.label, oldAddress)
    XCTAssertEqual(player2Address.label, oldAddress)
    
    app.buttons["player1ChangeAddress"].tap()
    
    let textField = app.alerts["Change address"].textFields["addressInput"]
    textField.tap()
    textField.typeText(newAddress)

    app.alerts["Change address"].buttons["OK"].tap()
    
    XCTAssertEqual(player1Address.label, newAddress)
    XCTAssertEqual(player2Address.label, oldAddress)
  }
}
