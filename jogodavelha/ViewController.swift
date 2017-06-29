import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var ganhoDiagonalDireita: UIImageView!
    @IBOutlet weak var ganhoDiagonalEsquerda: UIImageView!
    @IBOutlet weak var ganhoHorizontal0: UIImageView!
    @IBOutlet weak var ganhoHorizontal1: UIImageView!
    @IBOutlet weak var ganhoHorizontal2: UIImageView!
    @IBOutlet weak var ganhoVertical0: UIImageView!
    @IBOutlet weak var ganhoVertical1: UIImageView!
    @IBOutlet weak var ganhoVertical2: UIImageView!

    
    var player: AVAudioPlayer = AVAudioPlayer()
    var activePlayer:Int = 1
    var hasWinner:Bool = false
    var scoreboard:Array = [0, 0, 0, 0, 0, 0, 0, 0 ,0]
    var combination:Array = [[0, 3, 6], [1, 4, 7],
                             [2, 5, 8], [0, 1, 2],
                             [3, 4, 5], [6, 7, 8],
                             [0, 4, 8], [2, 4, 6]]

    @IBAction func newGame(_ sender: AnyObject) {
        
        stopSound()
        activePlayer = 1
        hasWinner = false
        scoreboard = [0, 0, 0, 0, 0, 0, 0, 0 ,0]
        
        winnerLabel.text = ""
        winnerLabel.isHidden = true
        
        ganhoDiagonalDireita.isHidden = true
        ganhoDiagonalEsquerda.isHidden = true
        ganhoHorizontal0.isHidden = true
        ganhoHorizontal1.isHidden = true
        ganhoHorizontal2.isHidden = true
        ganhoVertical0.isHidden = true
        ganhoVertical1.isHidden = true
        ganhoVertical2.isHidden = true
        

        var button: UIButton
        
        for i in 0 ..< 9 {
            
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
            
        }
        
    }
    
    @IBAction func btnPlayed(_ sender: AnyObject) {
        
        if (!hasWinner && (scoreboard[sender.tag] == 0)) {
            
            var image:UIImage!
            
            scoreboard[sender.tag] = activePlayer
            
            if(activePlayer == 2){
                image = UIImage(named: "circle.png")
                activePlayer = 1
                //winnerLabel.text = "\"O\" ganhou!"
            } else {
                image = UIImage(named: "cross.png")
                activePlayer = 2
                //winnerLabel.text = "\"X\" ganhou!"
            }
            
            sender.setImage(image, for: .normal)
            
            for pos in combination{
                
                if  (   scoreboard[pos[0]] != 0 &&
                        scoreboard[pos[1]] != 0 &&
                        scoreboard[pos[2]] != 0 &&
                        (scoreboard[pos[0]] == scoreboard[pos[1]]) &&
                        (scoreboard[pos[1]] == scoreboard[pos[2]])){
                    
                    playSound()
                    hasWinner = true
                    
                    if pos[0] == 0 && pos[1] == 4 {
                        ganhoDiagonalEsquerda.isHidden = false
                    } else if pos[0] == 2 && pos[1] == 4 {
                        ganhoDiagonalDireita.isHidden = false
                    } else if pos[0] == 0 && pos[1] == 3 {
                        ganhoVertical0.isHidden = false
                    } else if pos[0] == 1 && pos[1] == 4 {
                        ganhoVertical1.isHidden = false
                    } else if pos[0] == 2 && pos[1] == 5 {
                        ganhoVertical2.isHidden = false
                    } else if pos[0] == 0 && pos[1] == 1 {
                        ganhoHorizontal0.isHidden = false
                    } else if pos[0] == 3 && pos[1] == 4 {
                        ganhoHorizontal1.isHidden = false
                    } else if pos[0] == 6 && pos[1] == 7 {
                        ganhoHorizontal2.isHidden = false
                    }
                    
                    //winnerLabel.isHidden = false
                    playSound()
                    
//                    UIView.animate(withDuration: 0.5, animations: {
//                        self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
//                    })
                    
                }
                
            }
            
            if (!hasWinner && !scoreboard.contains(0)){
                winnerLabel.text = "Deu Veia!"
                winnerLabel.isHidden = false
            }
            
        }
        
    }
    
    
    func loadSound() {
        
        let url = Bundle.main.url(forResource: "audio", withExtension: "mp3")!
        
        do {
            try player = AVAudioPlayer(contentsOf: url)
            
            player.prepareToPlay()
            
        } catch {
            // nao há o que fazer
        }
    }
    
    
    func playSound(){
        if !player.isPlaying{
            player.currentTime = 0
            player.play()
        }
    }
    
    func stopSound() {
        if player.isPlaying {
            player.stop()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        winnerLabel.isHidden = true
        
        ganhoDiagonalDireita.isHidden = true
        ganhoDiagonalEsquerda.isHidden = true
        ganhoHorizontal0.isHidden = true
        ganhoHorizontal1.isHidden = true
        ganhoHorizontal2.isHidden = true
        ganhoVertical0.isHidden = true
        ganhoVertical1.isHidden = true
        ganhoVertical2.isHidden = true
        
        loadSound()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

