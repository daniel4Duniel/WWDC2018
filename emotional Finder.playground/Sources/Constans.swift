import UIKit
import AVFoundation
import SpriteKit


public struct Mediaitem{
    public var fileName = String()
    public var fileType = String()
    public var duration = Int()
}




// structur which stores some constants and funtions which are used quiet often in the playground.
public struct Constants {

   public static let playerBitmask: UInt32 = 0b0001
   public static let mediaBitmask: UInt32 = 0b0001
   public static let wallBitmask: UInt32 = 0b0010
    
    
    
   public static let mediaItems: [String : Mediaitem] = ["BootUp": Mediaitem(fileName: "mac StartUp", fileType: "mp3", duration: 3), "SiriStart":  Mediaitem(fileName: "Siri start", fileType: "mp3", duration: 1), "siriStop": Mediaitem(fileName: "Siri stop", fileType: "mp3", duration: 0), "crash": Mediaitem(fileName: "Mac Crash Chime", fileType: "mp3", duration: 4)]
    
    
    
    // All the parts which are said in this playground.
    public struct DialogueParts {
    
       public static let FinderIntro = "Hello. I´m the Finder and I help you now since over 30 years day and night! But today I`ve got an issue. You have got to much stuff on your hard disk! Thanks to Apple File System it got better. But it is still a mess. It is a lot work for me so I´m sad. But first let´s ask my friend Siri if she can help me... Click on the Siri button to wake her up."
        
       public static let siriDialogue = "Hi Finder, it´s me Siri! I´m sorry my friend my job is it to solve the users` problems. So I can't help you with the hard disk and so you have to annoy the user with a notification"
        
       public static let finderRespons = "Thank you Siri for your attention! I can understand your argue. So now it is up to me the fully packed hard disk! Oh I got it! You can help me if you want"
        
       public static let finderEjection = "Oh no the user has ejected a external hard disk on the worng way! Let´s inform the user with a message where I look very sad. On that way we can tell the user that the external was not ejected properly."
        
       public static let gameExplanation = "Let's clean up the hard disk by just dragging the remaining documents to the left and to the right out of the view!"
    
      public static let thankYou = "Now I´m happy once again. Thank you very much for your help and your attention. Me and the creator of this playground would be happy if you take a look at his personal information hehind me and if you could give him the chance to visit the WWDC. It was a lot of fun and also a little challenge to create this playground! Have a nice day and goodbye and hopefully see you soon. Sincerely your Finder and Daniel."
    }
    
    
    
    
    public enum Languages: String{
        case BritEnglish = "en-gb"
        case USEnglish = "en-US"
        
    }
    
    
    
   public static let showEnd = Notification.Name("showEnd")

   public static let theEnd = Notification.Name("theEnd")
    
   public static let speechContinue = Notification.Name("speechContinue")
    
   public static let speechPauseNotification = Notification.Name("speechPause")
    
   public static let gameEnded = Notification.Name.init("gameEnded")
    
   public static let macShutdown = Notification.Name.init("macShutdown")
    
   public static let font: String =  "HelveticaNeue-Thin"
   public static let size: CGSize = CGSize.init(width: 1080, height: 720)
    
  public static let viewScreenFrame = CGRect(x: 0, y: 0, width: 375, height: 668)
    
   public static let viewScreenSize = CGSize.init(width: 375, height: 668)
    
    public let headlineLabel = CGRect(x: 50, y: 20, width: 300, height: 70)
    
    // func which returns some random numbers.
    public static func diceRoll() -> (x: Int, y: Int) {
        let Number = Int(arc4random_uniform(UInt32(360)))
        let Number2 = Int(arc4random_uniform(UInt32(200))) + Number * 2
        return (Number, Number2)
    }
    
    
}

//In this playground I use a lot of UI elements. This functions prevents code duplication like give the element a frame, give it a title, backgroundColour and so on.
public func configurationView<View>(GenericUI: View, Type: Int, SuperView: UIView? = nil, Frame: CGRect, Border: (cornerRadius: Int?, width: Int?, colour: UIColor)? = nil, Text: (String, UIColor, Int)? = nil, image: UIImage? = nil, Background: UIColor = .white, Action: String? = nil) where View: UIView  {
  
    
    switch Type {
    case 0:
        fallthrough
    case 1:
        if Type == 1 {
            let BTN = GenericUI as! UIButton
            BTN.setTitle(Text?.0, for: .normal)
            
            if let UnwrapedImage = image{
                BTN.setImage(UnwrapedImage, for: .normal)
            }
            
            BTN.tintColor = .black
            BTN.setTitleColor(Text?.1, for: .normal)
            BTN.titleLabel?.font = UIFont.init(name: Constants.font, size: CGFloat((Text?.2)!))
        }
        fallthrough
    case 2:
        if Type == 2 {
            let label = GenericUI as! UILabel
            if let TextAppereance = Text {
                label.text = TextAppereance.0
                label.font = UIFont.init(name: Constants.font, size: CGFloat(TextAppereance.2))
                label.tintColor = .black
            }
        }
        fallthrough
    case 3:
        if Type == 3 {
            let scrollView = GenericUI as! UIScrollView
            if let UnwrapedImage = image{
                let subImageView = UIImageView(frame: Frame)
                subImageView.image = UnwrapedImage
                subImageView.addSubview(scrollView)
                SuperView?.addSubview(subImageView)
            }
        }
        fallthrough
        
        
    case 4:
        if Type == 4{
            let ImageView = GenericUI as! UIImageView
            if let UnwrapedImage = image{
                ImageView.image = UnwrapedImage
            }
        }
        fallthrough
        
        
    default:
        GenericUI.frame = Frame
        GenericUI.backgroundColor = Background
        
        if Type != 3 {
            SuperView?.addSubview(GenericUI)
        }
        GenericUI.layer.borderWidth = CGFloat(Border?.1 ?? 0)
        GenericUI.layer.borderColor = Border?.2.cgColor ?? UIColor.clear.cgColor
        GenericUI.layer.cornerRadius = CGFloat(Border?.0 ?? 0)
        

    }
}

