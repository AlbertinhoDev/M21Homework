import UIKit

class Fish: UIViewController {

    let fishSize = 150.0

    lazy var fishImageView: UIImageView = {
        let fish = UIImageView(image: UIImage(named: "Fish"))
        fish.contentMode = .scaleAspectFit
        let xRandom = Int.random(in: 0...Int(view.bounds.width) - Int(fishSize))
        let yRandom = Int.random(in: 0...Int(view.bounds.height) - Int(fishSize))
        fish.frame = CGRect(x: CGFloat(xRandom), y: CGFloat(yRandom), width: fishSize, height: fishSize)
        fish.translatesAutoresizingMaskIntoConstraints = true
        fish.isHidden = true
        return fish
    }()

    @objc func animateBegin(fish: UIImageView) {
        fish.isHidden = false
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

    var stopGame = true

    let fish = Fish().fishImageView
    let fishTwo = Fish().fishImageView
    let fishThree = Fish().fishImageView
    let fishFour = Fish().fishImageView
    let fishFive = Fish().fishImageView

    @objc func animation() {
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


        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_ :)))
        fish.addGestureRecognizer(tapGesture)
        fish.isUserInteractionEnabled = true

        fishTwo.addGestureRecognizer(tapGesture)
        fishTwo.isUserInteractionEnabled = true

        fishThree.addGestureRecognizer(tapGesture)
        fishThree.isUserInteractionEnabled = true

        fishFour.addGestureRecognizer(tapGesture)
        fishFour.isUserInteractionEnabled = true

        fishFive.addGestureRecognizer(tapGesture)
        fishFive.isUserInteractionEnabled = true

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

//    @objc func animateBegin() {
//        if stopGame {
//            playButton.isHidden = true
//            if self.fish.isHidden {
//                self.fish.isHidden = false
//            }
//            let xPosition = setMove().xRandom
//            let yPosition = setMove().yRandom
//            let timeShift = setMove().timeShift
//            UIView.animate(withDuration: timeShift, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: {
//                self.fish.center = CGPoint(x: CGFloat(xPosition), y: CGFloat(yPosition))
//            }, completion: { finished in
//                self.animateContinue()
//            })
//        }else{
//            stopGame = true
//            return
//        }
//
//    }
//    private func animateContinue() {
//        if stopGame {
//            let xPosition = setMove().xRandom
//            let yPosition = setMove().yRandom
//            let timeShift = setMove().timeShift
//            UIView.animate(withDuration: timeShift, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: {
//                self.fish.center = CGPoint(x: CGFloat(xPosition), y: CGFloat(yPosition))
//            }, completion: { finished in
//                self.animateBegin()
//            })
//        }else{
//            stopGame = true
//            return
//        }
//    }

//    private func setMove() -> (xRandom: Int, yRandom: Int, timeShift: Double) {
//        let xCurrentPosition = Int(self.fish.frame.origin.x)
//        let yCurrentPosition = Int(self.fish.frame.origin.y)
//        let xMaxView = view.bounds.width - 150
//        let yMaxView = view.bounds.height - 150
//
//        let xRandom = Int.random(in: 0...Int(xMaxView))
//        let yRandom = Int.random(in: 0...Int(yMaxView))
//
//
//        let sqrtX = xCurrentPosition - xRandom
//        let sqrtY = yCurrentPosition - yRandom
//        let currentPositionToFinalPosition = sqrt(Double(sqrtX * sqrtX + sqrtY * sqrtY))
//        let speed = 100.0
//        let timeShift = currentPositionToFinalPosition / speed
//        return (xRandom, yRandom, timeShift)
//    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        switch sender.view {
        case fish:
            fish.isHidden = true
            fish.layer.removeAllAnimations()
            print("Рыбка 1")
        case fishTwo:
            fishTwo.isHidden = true
            fishTwo.layer.removeAllAnimations()
            print("Рыбка 2")
        case fishThree:
            fishThree.isHidden = true
            fishThree.layer.removeAllAnimations()
            print("Рыбка 3")
        case fishFour:
            fishFour.isHidden = true
            fishFour.layer.removeAllAnimations()
            print("Рыбка 4")
        case fishFive:
            fishFive.isHidden = true
            fishFive.layer.removeAllAnimations()
            print("Рыбка 5")
        default:
            print("")
        }


//        self.playButton.isHidden = false
//        self.stopGame = false
    }

}

