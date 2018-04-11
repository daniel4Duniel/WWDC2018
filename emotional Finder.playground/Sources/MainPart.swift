import UIKit

// the fuctions are mostly in chronological order like they get called during the execution of the playground.

public class MainView: UIViewController{
    
    var gestureRecognizer = UIPanGestureRecognizer()
    
    
    // struct which keeps all the UIElements of the MainView. I did this to provide clearer code.
    private struct UIElements {
        static var helpInstruction = UILabel()
        static var helpView = UIView()
        static var finderIcon = UIImageView()
        static var siriIcon = UIButton()
        static let tapInstruction = UILabel()
        static let volumeDemand = UILabel()
        static let volumeHint = UIImageView()
        static var infoButton = UIButton()
        static var dialogActivity = UIImageView()
        static let loadingScreen = UIView()
        static let loadingApple = UIScrollView()
        static let progressView = Progressdisplay()
        static let messagesView = UIImageView()
        static let startButton = UIButton()
        static let myImageView = UIImageView()
        static let WWDCImageView = UIImageView()
        static let homeImageView = UIImageView()
        static let endLabel = UILabel()
        static let loveSwift = UILabel()
        static let swiftIcon = UIImageView()
        static let germanFlag = UILabel()
        static let stuffIlike = UIScrollView()
        static let planeLabel = UILabel()
    }
    
    
    public var videoAndVoice = VideoAndVoiceModelClass()
    private var speechNotification: NSObjectProtocol!
    private var animator = UIViewPropertyAnimator.init()
    
    
    public override func viewDidLoad() {
        createIntroView()
        videoAndVoice.delegate = self
    }
    
    public func createIntroView(){
        
        configurationView(GenericUI: UIElements.helpView, Type: 0, SuperView: self.view, Frame: CGRect(x: 35, y: 100, width: 300, height: 400)
            , Border: (20, 0, .clear), Background: .lightGray)
        
        UIElements.helpView.alpha = 0.0
        configurationView(GenericUI: UIElements.tapInstruction, Type: 2, SuperView: UIElements.helpView, Frame:  CGRect(x: 50, y: 60, width: 300, height: 70), Text: ("Tap the Speaker", .white, 30), Background: .clear)
        
        
        configurationView(GenericUI: UIElements.volumeDemand, Type: 2, SuperView: UIElements.helpView, Frame:  CGRect(x: 40, y: 220, width: 300, height: 140), Text: ("Please make sure that the\n   volume is turned on!", .white, 22), Background: .clear)
        UIElements.volumeDemand.numberOfLines = 2
        UIElements.volumeDemand.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        configurationView(GenericUI: UIElements.startButton, Type: 1, SuperView: UIElements.helpView, Frame: CGRect(x: 90, y: 120, width: 140, height: 140), Text: ("🔇", .white, 80),  Background: .clear)
        UIElements.startButton.addTarget(self, action: #selector(startFullMac), for: .touchUpInside)
        
        
        UIElements.helpView.alpha = 0.0
        
        
        UIView.animate(withDuration: 5.0, animations:{ UIElements.helpView.alpha = 1.0}, completion: nil)
    }
    
    
    // Located all the selector functions down here for a better code order.
    @objc func startFullMac(){
        UIElements.startButton.setTitle("🔊", for: .normal)
        NotificationCenter.default.post(name: Constants.macShutdown, object: self)
    }
    
    @objc func startSiri(){
        videoAndVoice.play(MediaName: "Siri start", Mediatyp: ".mp3")
    }
    
    // setting the values to go back the the previous state of the "dialogueActivity" after closing the "helpView"
    var beforeHelpOpening : (CGRect, UIImage?) = (CGRect.zero, nil)
    var setFinderBack = CGRect()
    
    
    @objc func closeHelpView(){
        NotificationCenter.default.post(name: Constants.speechContinue, object: videoAndVoice)
        UIElements.helpInstruction.removeFromSuperview()
        UIElements.infoButton.setTitle("?", for: .normal)
        UIElements.infoButton.backgroundColor  = .clear
        UIElements.infoButton.addTarget(self, action: #selector(showHelpView), for: .touchUpInside)
        
        
        UIView.animate(withDuration: 1.0, animations: {
            
            UIElements.infoButton.frame = CGRect(x: 2, y: 2, width: 50, height: 50)
            
            UIElements.dialogActivity.frame = self.beforeHelpOpening.0
            UIElements.dialogActivity.image = self.beforeHelpOpening.1
        })
    }
    
    
    
    @objc func showHelpView(){
        print("You need help!? Please follow the instructions of the finder!")
        NotificationCenter.default.post(name: Constants.speechPauseNotification, object: videoAndVoice)
        
        UIElements.infoButton.removeTarget(self, action: #selector(showHelpView), for: .touchUpInside)
        
        beforeHelpOpening = (UIElements.dialogActivity.frame, UIElements.dialogActivity.image)
        
        
        configurationView(GenericUI: UIElements.helpInstruction, Type: 2, SuperView: UIElements.dialogActivity, Frame: CGRect.init(x: 0, y: 30, width: 300, height: 100), Text: ("My playground is about the hard\n work of the finder. Please just follow the instructions.\n Thank You!", .lightGray, 20), Background: .clear)
        UIElements.helpInstruction.numberOfLines = 4
        UIElements.helpInstruction.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        animator.stopAnimation(true)
        
        UIView.animate(withDuration: 1.0, animations: {
            UIElements.dialogActivity.image = nil
            UIElements.dialogActivity.frame = CGRect(x: 35, y: 100, width: 300, height: 400)
            
            UIElements.infoButton.frame = CGRect(x: 35, y: 100, width: 50, height: 50)
            
            UIElements.infoButton.setTitle("+", for: .normal)
            UIElements.infoButton.backgroundColor  = .red
            
        })
        
        UIElements.infoButton.addTarget(self, action: #selector(closeHelpView), for: .touchUpInside)
    }
    
    
    // creates all the ending page with my personal information
   public func ending(){
        self.view.subviews[4].removeFromSuperview()
        
        UIElements.finderIcon.image = UIImage.init(named: "Finder happy.png")
        
        UIView.animate(withDuration: 1.0, animations: {
            UIElements.finderIcon.frame = CGRect(x: 145, y: 260, width: 100, height: 100)
            UIElements.dialogActivity.frame = UIElements.finderIcon.frame
            
        }) { (true) in
            
            UIView.animate(withDuration: 0.5, animations: {
                UIElements.finderIcon.frame = CGRect(x: 145, y: 280, width: 100, height: 100)
                UIElements.dialogActivity.frame = UIElements.finderIcon.frame
            }) { (true) in
                
                UIView.animate(withDuration: 1.0, animations: {
                    UIElements.finderIcon.frame = CGRect(x: 145, y: 260, width: 100, height: 100)
                    UIElements.dialogActivity.frame = UIElements.finderIcon.frame
                }) { (true) in
                    
                    UIView.animate(withDuration: 3.0, animations: {
                        UIElements.planeLabel.frame = CGRect(x: 50, y: 50, width: 120, height: 80)
                    }) { (true) in
                        
                        UIView.animate(withDuration: 3.0, animations: {
                            UIElements.planeLabel.frame = CGRect(x: 200, y: 550, width: 120, height: 80)
                        })
                    }
                }
            }
        }
        
        UIElements.infoButton.removeFromSuperview()
        
        configurationView(GenericUI: UIElements.WWDCImageView, Type: 4, SuperView: self.view, Frame: CGRect(x: 0, y: 120, width: 150, height: 50), image: UIImage.init(named: "wwdc.jpeg"), Background: .clear)
        
        configurationView(GenericUI: UIElements.homeImageView, Type: 4, SuperView: self.view, Frame: CGRect(x: 200, y: 550, width: 200, height: 100), image: UIImage.init(named: "großrinderfeld.jpg"), Background: .clear)
        
        
        configurationView(GenericUI: UIElements.planeLabel, Type: 2, SuperView: self.view, Frame: CGRect(x: 200, y: 550, width: 120, height: 80), Text: ("✈️", .black, 55), Background: .clear)
        
        configurationView(GenericUI: UIElements.myImageView, Type: 4, SuperView: self.view, Frame: CGRect(x: 140, y: 50, width: 70, height: 100),  image: UIImage.init(named: "me.jpg"), Background: .clear)
        
        configurationView(GenericUI: UIElements.loveSwift, Type: 2, SuperView: self.view, Frame: CGRect(x: 200, y: 400, width: 120, height: 80), Text: ("I ❤️", .black, 45), Background: .clear)
        
        configurationView(GenericUI: UIElements.germanFlag, Type: 2, SuperView: self.view, Frame: CGRect(x: 300, y: 100, width: 120, height: 80), Text: ("🇩🇪", .black, 60), Background: .clear)
        
        configurationView(GenericUI: UIElements.swiftIcon, Type: 4, SuperView: self.view, Frame: CGRect(x: 300, y: 400, width: 70, height: 70), image: UIImage.init(named: "SwiftIcon.jpeg"), Background: .clear)
        
        videoAndVoice.speak(text: Constants.DialogueParts.thankYou, language: Constants.Languages.BritEnglish.rawValue)
        
    }
    
    
    // shows the end label
   public func lastFunction(){
        UIElements.planeLabel.removeFromSuperview()
        
        UIElements.homeImageView.removeFromSuperview()
        UIElements.germanFlag.removeFromSuperview()
        
        print("This was my playground! Please have a look at my personal information!")
        configurationView(GenericUI: UIElements.endLabel, Type: 2, SuperView: self.view, Frame: CGRect.init(x: 0, y: 500, width: 400, height: 200), Text: ("The End", .black, 80), Background: .clear)
        UIElements.endLabel.alpha = 0.0
        UIView.animate(withDuration: 1.0, animations: {
            UIElements.endLabel.alpha = 1.0
        })
        
    }
}


// conform to the delegate in an extension
extension MainView: speakDelegate {
    
    
    public func createLoading(){
        print("restart because of the full hard disk!")
        UIView.animate(withDuration: 1.0, animations: {
            self.view.subviews[1].alpha = 0.0
        }, completion: {(true) in
            self.videoAndVoice.play(MediaName: "mac StartUp", Mediatyp: "mp3")
            self.view.subviews[1].removeFromSuperview()
            
        })
        
        
        configurationView(GenericUI: UIElements.loadingScreen, Type: 0, SuperView: self.view, Frame: Constants.viewScreenFrame, Border: (cornerRadius:1, width: 1, colour:.clear), Text: nil, image: nil, Background: .black, Action: nil)
        
        
        configurationView(GenericUI: UIElements.loadingApple, Type: 3, SuperView: UIElements.loadingScreen, Frame: CGRect.init(x: 140, y: 100, width: 100, height: 100), Border: (cornerRadius:50, width: 1, colour:.clear), image: UIImage.init(named: "Apple steve.jpg"), Background: .clear, Action: nil)
        
        configurationView(GenericUI: UIElements.progressView, Type: 0, SuperView: UIElements.loadingScreen, Frame:CGRect(x: 8, y: 300, width: 360, height: 12), Border: (cornerRadius:7, width: 1, colour:.white), Background: .clear)
        
        UIElements.progressView.showProgress(animator: animator, time: 3.0, Colour: .lightGray)
        
    }
    
    public func startShow(){
        print("let the show beginn")
        configurationView(GenericUI: UIElements.finderIcon, Type: 4, SuperView: self.view, Frame: CGRect(x: 145, y: 280, width: 100, height: 100), Text:  ("?", .gray, 40), image: UIImage.init(named: "Finder happy.png"), Background: .white, Action: nil)
        
        configurationView(GenericUI: UIElements.infoButton, Type: 1, Frame: CGRect(x: 2, y: 2, width: 50, height: 50), Border: (cornerRadius:25, width: 1, colour:.black), Text: ("?", .gray, 40), image: nil, Background: .white, Action: nil)
        
        self.view.addSubview(UIElements.infoButton)
        UIElements.helpView.removeFromSuperview()
        
        UIElements.loadingScreen.removeFromSuperview()
        
        configurationView(GenericUI: UIElements.siriIcon, Type: 1, SuperView: self.view, Frame: CGRect(x: 320, y: 10, width: 40, height: 40), Border: (cornerRadius:9, width: 1, colour:.clear), Text: ("?", .gray, 40), image: UIImage.init(named: "Siri.png"), Background: .clear)
        
        UIElements.siriIcon.addTarget(self, action: #selector(startSiri), for: .touchUpInside)
        
        configurationView(GenericUI: UIElements.dialogActivity, Type: 4, SuperView: self.view, Frame: CGRect(x: 1, y: 1, width: 375, height: 668), Border: (cornerRadius:25, width: 1, colour:.black), Background: .clear)
        
        UIElements.infoButton.addTarget(self, action: #selector(showHelpView), for: .touchUpInside)
        
        
        self.view.frame = Constants.viewScreenFrame
        self.view.backgroundColor = .white
        self.view.addSubview(UIElements.volumeHint)
        
        videoAndVoice.speak(text: Constants.DialogueParts.FinderIntro, language: Constants.Languages.BritEnglish.rawValue)
        
        UIElements.volumeHint.removeFromSuperview()
        
        
        animator.addAnimations {UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: { UIElements.finderIcon.frame = CGRect(x: 150, y: 550, width: 100, height: 100)}, completion:{ if $0 == .end{
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {UIElements.dialogActivity.frame = CGRect(x: 150, y: 550, width: 100, height: 100)},  completion:{ if $0 == .end{
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3.0, delay: 0.0, options: .curveEaseIn, animations: { UIElements.dialogActivity.frame = CGRect(x: 0, y: 150, width: 375, height: 320)
                    UIElements.dialogActivity.image = UIImage.init(named: "Mac.png")
                    
                }, completion:
                    nil)
                }
            }
            )}
        })
        }
        animator.startAnimation()
    }
    
    
    public func dialogueTransition(){
        
        videoAndVoice.speak(text: Constants.DialogueParts.siriDialogue, language: Constants.Languages.USEnglish.rawValue)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.5, delay: 0.0, options: .curveEaseIn, animations: {
            UIElements.finderIcon.frame = CGRect(x: 50, y: 550, width: 100, height: 100)
            UIElements.siriIcon.frame = CGRect(x: 250, y: 550, width: 100, height: 100)},  completion:{ if $0 == .end{
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.5, delay: 0.0, options: .curveEaseIn, animations: {  UIElements.dialogActivity.layer.cornerRadius = 50
                    UIElements.dialogActivity.frame = CGRect(x: 250, y: 550, width: 100, height: 100)
                    UIElements.dialogActivity.image = nil
                    // Get the playerLayer from the model and add it the dialogueActivity
                    UIElements.dialogActivity.layer.addSublayer(self.videoAndVoice.runVideo())
                }, completion: { if $0 == .end{
                    
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.5, delay: 0.0, options: .curveEaseIn, animations: {  UIElements.dialogActivity.layer.cornerRadius = 50
                        UIElements.dialogActivity.frame = CGRect(x: 0, y: 150, width: 375, height: 320)}, completion: nil)
                    
                    
                    }
                }
                )}
        })
        
    }
    
    public func finderIdea(){
        videoAndVoice.speak(text: Constants.DialogueParts.finderRespons, language: Constants.Languages.BritEnglish.rawValue)
        configurationView(GenericUI: UIElements.messagesView, Type: 4, SuperView: self.view, Frame: CGRect(x: 380, y:130, width: 250, height: 50), Border: (cornerRadius:1, width: 1, colour:.clear), image: UIImage.init(named: "Hard Disk.png"), Background: .white)
        
        UIView.animate(withDuration: 1, animations: {
            // Remove the playerLayer once again. The "Siri" part is over.
            UIElements.dialogActivity.image = nil
            UIElements.dialogActivity.layer.sublayers![0].removeFromSuperlayer()
            UIElements.dialogActivity.layer.cornerRadius = 6
            UIElements.dialogActivity.frame = CGRect(x: 150, y: 550, width: 100, height: 100)
            
        }){ (true) in
            
            UIView.animate(withDuration: 1, animations: {
                UIElements.siriIcon.frame = CGRect(x: 320, y: 10, width: 40, height: 40)}){ (true) in
                    
                    UIView.animate(withDuration: 1, animations: { UIElements.messagesView.frame.offsetBy(dx: 130.0, dy: 250.0)
                        
                        UIElements.finderIcon.image = UIImage.init(named: "Finder Sad.png")
                        
                        UIView.animate(withDuration: 1, animations: { UIElements.finderIcon.frame = CGRect(x: 150, y: 550, width: 100, height: 100)})
                        UIElements.siriIcon.alpha = 0.0
                        UIElements.siriIcon.removeFromSuperview()
                    })
            }
        }
    }
    
}
