import UIKit

class Fish: UIViewController {

    let fishSize = 150.0
    
    func createFish(name: String) -> UIImageView{
        lazy var fishImageView: UIImageView = {
            let fish = UIImageView(image: UIImage(named: name))
            fish.contentMode = .scaleAspectFit
            let xRandom = Int.random(in: 0...Int(view.bounds.width) - Int(fishSize))
            let yRandom = Int.random(in: 0...Int(view.bounds.height) - Int(fishSize))
            fish.frame = CGRect(x: CGFloat(xRandom), y: CGFloat(yRandom), width: fishSize, height: fishSize)
            fish.translatesAutoresizingMaskIntoConstraints = true
            fish.isHidden = true
            return fish
        }()
        return fishImageView
    }

    @objc func animateBegin(fish: UIImageView) {
        
        let xPosition = setMove(fish: fish).xRandom
        let yPosition = setMove(fish: fish).yRandom
        let timeShift = setMove(fish: fish).timeShift
        UIView.animate(withDuration: timeShift, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: {
            fish.center = CGPoint(x: CGFloat(xPosition), y: CGFloat(yPosition))
        }, completion: { finished in
            self.animateContinue(fish: fish)
        })
    }
    private func animateContinue(fish: UIImageView) {
        let xPosition = setMove(fish: fish).xRandom
        let yPosition = setMove(fish: fish).yRandom
        let timeShift = setMove(fish: fish).timeShift
        UIView.animate(withDuration: timeShift, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: {
            fish.center = CGPoint(x: CGFloat(xPosition), y: CGFloat(yPosition))
        }, completion: { finished in
            self.animateBegin(fish: fish)
        })

    }

    private func setMove(fish: UIImageView) -> (xRandom: Int, yRandom: Int, timeShift: Double) {
        let xCurrentPosition = Int(fish.frame.origin.x)
        let yCurrentPosition = Int(fish.frame.origin.y)
        let xMaxView = view.bounds.width - 150
        let yMaxView = view.bounds.height - 150
        let xRandom = Int.random(in: 0...Int(xMaxView))
        let yRandom = Int.random(in: 0...Int(yMaxView))
        let sqrtX = xCurrentPosition - xRandom
        let sqrtY = yCurrentPosition - yRandom
        let currentPositionToFinalPosition = sqrt(Double(sqrtX * sqrtX + sqrtY * sqrtY))
        let speed = 100.0
        let timeShift = currentPositionToFinalPosition / speed
        return (xRandom, yRandom, timeShift)
    }


}

class ViewController: UIViewController {

    lazy var backgroundImage: UIImageView = {
        let back = UIImageView(image: UIImage(named: "Background"))
        back.contentMode = .scaleAspectFill
        back.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        return back
    }()
    
    lazy var alert: UIAlertController = {
        let alert = UIAlertController(
            title: "WIN", message: "Congratulations!", preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Ok", style: .default) { _ in //Исправление ошибки при повторном появлении Alert
            self.alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(action)
        return alert
    }()

    var stopGame = true

    let fish = Fish().createFish(name: "FishOne")
    let fishTwo = Fish().createFish(name: "FishTwo")
    let fishThree = Fish().createFish(name: "FishThree")
    let fishFour = Fish().createFish(name: "FishFour")
    let fishFive = Fish().createFish(name: "FishFive")

    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {

        super.viewDidLoad()
        setupView()
        playButton.addTarget(self, action: #selector(animation), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        view.addSubview(fish)
        view.addSubview(fishTwo)
        view.addSubview(fishThree)
        view.addSubview(fishFour)
        view.addSubview(fishFive)
    }

    private func setupView() {
        view.addSubview(backgroundImage)
        view.addSubview(playButton)
        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        playButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        playButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func animation() {
        stopGame = false
        fish.isHidden = false
        fishTwo.isHidden = false
        fishThree.isHidden = false
        fishFour.isHidden = false
        fishFive.isHidden = false
        playButton.isHidden = true

        Fish().animateBegin(fish: fish)
        Fish().animateBegin(fish: fishTwo)
        Fish().animateBegin(fish: fishThree)
        Fish().animateBegin(fish: fishFour)
        Fish().animateBegin(fish: fishFive)
    }
    
    @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        let fishes = [fish, fishTwo, fishThree, fishFour, fishFive]
        
        let touchLocation = gesture.location(in: self.view)
        
        for i in fishes {
            if let presentationLayer = i.layer.presentation() {
                let hitFrame = presentationLayer.frame
                if hitFrame.contains(touchLocation) {
                    i.isHidden = true
                    i.layer.removeAllAnimations()
                    var value = 0
                    for i in fishes {
                        if i.isHidden == true {
                            value += 1
                            if value == 5 {
                                self.present(alert, animated: true)
                                playButton.isHidden = false
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

