import UIKit

class ViewController: UIViewController {
    var defaults = UserDefaults.standard

    @IBOutlet var targetGuessLabel: UILabel!
    @IBOutlet var targetGuessField: UITextField!
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var segmentedControl: UISegmentedControl!

    enum GameStyle: Int { case moveSlider, guessPosition }

    let game = BullsEyeGame()
    let gameStyleRange = 0..<2
    var gameStyle = GameStyle.guessPosition

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaultGameStyle = defaults.integer(forKey: "gameStyle")
        print(defaultGameStyle)
        if gameStyleRange.contains(defaultGameStyle) {
            gameStyle = GameStyle(rawValue: defaultGameStyle)!
            segmentedControl.selectedSegmentIndex = defaultGameStyle
        } else {
            gameStyle = .moveSlider
            defaults.set(0, forKey: "gameStyle")
        }
        updateView()
    }

    @IBAction func chooseGameStyle(_ sender: UISegmentedControl) {
        if gameStyleRange.contains(sender.selectedSegmentIndex) {
            gameStyle = GameStyle(rawValue: sender.selectedSegmentIndex)!
            updateView()
        }
        defaults.set(sender.selectedSegmentIndex, forKey: "gameStyle")
    }

    func updateView() {
        switch gameStyle {
        case .moveSlider:
            targetGuessLabel.text = "Get as close as you can to: "
            targetGuessField.text = "\(game.targetValue)"
            targetGuessField.isEnabled = false
            slider.value = Float(game.startValue)
            slider.isEnabled = true
        case .guessPosition:
            targetGuessLabel.text = "Guess where the slider is: "
            targetGuessField.text = ""
            targetGuessField.placeholder = "1-100"
            targetGuessField.isEnabled = true
            slider.value = Float(game.targetValue)
            slider.isEnabled = false
        }

        roundLabel.text = "Round: \(game.round)"
        scoreLabel.text = "Score: \(game.scoreTotal)"
    }

    @IBAction func checkGuess(_ sender: Any) {
        var guess: Int?
        switch gameStyle {
        case .moveSlider:
            guess = Int(lroundf(slider.value))
        case .guessPosition:
            targetGuessField.resignFirstResponder()
            guess = Int(targetGuessField.text!)
        }
        showScoreAlert(difference: game.check(guess: guess!))
    }

    func showScoreAlert(difference: Int) {
        let title = "you scored \(game.scoreRound) points"
        let message = "target value \(game.targetValue)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.game.startNewRound()
            self.updateView()
        })
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func startOver(_ sender: Any) {
        game.startNewGame()
        updateView()
    }
}
