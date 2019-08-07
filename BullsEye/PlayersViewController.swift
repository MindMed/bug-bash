import UIKit

class PlayersViewController: UIViewController {
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player1Address: UILabel!
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player2Address: UILabel!
    
    
  var players: [Player]?

    override func viewDidLoad() {
        super.viewDidLoad()
        players = []
      
        self.populateInitialData()
        self.updateUI()
    }
  
  private func populateInitialData() {
    let address = Address(fullAddress: "123 Tutorial Street")
    players?.append(Player(name: "Peter", address: address))
    players?.append(Player(name: "Martin", address: address))
  }
  
  private func updateUI() {
    player1Name.text = players?[0].name
    player1Address.text = players?[0].address.fullAddress
    player2Name.text = players?[1].name
    player2Address.text = players?[1].address.fullAddress
  }
  
  private func showAlert(player: Player){
    let alert = UIAlertController(title: "Change address", message: "Enter new address for player: \(player.name)", preferredStyle: .alert)
    
    alert.addTextField { (textField) in
      textField.text = "Enter new address"
    }
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
      let textField = alert?.textFields![0]
      player.address.fullAddress = textField!.text ?? ""
      self.updateUI()
    }))
    
    self.present(alert, animated: true, completion: nil)
  }

    @IBAction func changePlayer1Address(_ sender: Any) {
      showAlert(player: players![0])
    }
    

    @IBAction func changePlayer2Address(_ sender: Any) {
      showAlert(player: players![1])
    }
  
}
