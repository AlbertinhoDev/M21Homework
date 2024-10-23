//import UIKit
//
//class ViewController: UIViewController {
//    
//    lazy var backgroundImage: UIImageView = {
//        let back = UIImageView(image: UIImage(named: "Background"))
//        back.contentMode = .scaleAspectFill
//        back.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//        return back
//    }()
//    
//    let fishSize = 150.0
//    var stopGame = true
//    
//    lazy var fish: UIImageView = {
//        let fish = UIImageView(image: UIImage(named: "Fish"))
//        fish.contentMode = .scaleAspectFit
//        let xRandom = Int.random(in: 0...Int(view.bounds.width) - Int(fishSize))
//        let yRandom = Int.random(in: 0...Int(view.bounds.height) - Int(fishSize))
//        fish.frame = CGRect(x: CGFloat(xRandom), y: CGFloat(yRandom), width: fishSize, height: fishSize)
//        fish.translatesAutoresizingMaskIntoConstraints = true
//        fish.isHidden = true
//        return fish
//    }()
//    
//    lazy var playButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Play", for: .normal)
//        button.backgroundColor = .orange
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        playButton.addTarget(self, action: #selector(animateBegin), for: .touchUpInside)
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
//        fish.addGestureRecognizer(tapGesture)
//        fish.isUserInteractionEnabled = true
//    }
//    
//    private func setupView() {
//        view.addSubview(backgroundImage)
//        view.addSubview(fish)
//        view.addSubview(playButton)
//        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
//        playButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
//        playButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
//        playButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
//    
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
//    
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
//    
//    @objc func imageTapped() {
//        self.fish.isHidden = true
//        self.playButton.isHidden = false
//        self.stopGame = false
//        self.fish.layer.removeAllAnimations()
//    }
//
//}
//
