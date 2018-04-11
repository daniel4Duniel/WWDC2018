import SpriteKit
import UIKit





// function for adding Nodes. Also clearer code and less duplication
public func AddNSKode(Texture: String, Size: CGSize, Position: CGPoint, Dynamic: Bool, Gravity: Bool) -> SKSpriteNode{
    
    
    let texture = SKTexture(image: UIImage.init(named: Texture)!)
    let tempSKSprite = SKSpriteNode(texture: texture, color: .clear, size: Size)
    tempSKSprite.position = Position
    
    
    
    tempSKSprite.physicsBody = SKPhysicsBody.init(rectangleOf: Size)
    tempSKSprite.physicsBody?.isDynamic = Dynamic
    tempSKSprite.physicsBody?.affectedByGravity = Gravity
    tempSKSprite.physicsBody?.categoryBitMask = Constants.mediaBitmask
    tempSKSprite.physicsBody?.collisionBitMask = Constants.mediaBitmask
    tempSKSprite.physicsBody?.contactTestBitMask = Constants.wallBitmask
    tempSKSprite.alpha = 0.0
    
    return tempSKSprite
}


public class GameScene: SKScene {
    public var currentView = GameView()
    private var allSetUP = false
    
   
    // important! this property tracks if all SKNodes were added to the screen.
    
    // struct which contains all the scene elements.
    private struct SceneElements{
        
        static var xcodeFiles: SKSpriteNode{
            return AddNSKode(Texture: "Xcode Project.png", Size: CGSize(width: 70, height: 70), Position: CGPoint(x: 265, y: 55), Dynamic: true, Gravity: false)
        }
        
        static var sadEmoji = AddNSKode(Texture: "sad emoji.png", Size: CGSize(width: 150, height: 150), Position: CGPoint(x: 200, y: 300), Dynamic: true, Gravity: false)
        
        
        static var ballOfDeath = AddNSKode(Texture: "ballofDeath.png", Size: CGSize(width: 300, height: 300), Position: CGPoint(x: 20, y: 200), Dynamic: true, Gravity: false)
        
        
        static var Siri = AddNSKode(Texture: "Siri.png", Size: CGSize(width: 150, height: 150), Position: CGPoint(x: 200, y: 300), Dynamic: true, Gravity: false)
        
        
        static var notification: SKSpriteNode {
            return AddNSKode(Texture: "Disk Notification.png", Size: CGSize(width: 300, height: 80), Position: CGPoint(x: 265, y: 55), Dynamic: true, Gravity: false)
        }
        
        static var finder = AddNSKode(Texture: "Finder Sad.png", Size:CGSize(width: 150, height: 150), Position: CGPoint(x: 200, y: 300), Dynamic: true, Gravity: false)
        
    }
    
    
    let voiceAndAudio = VideoAndVoiceModelClass()
    var fade = SKAction.fadeIn(withDuration: 0.7)
    
    
    private func CreateMessNotification(){
        for _ in 0...5{
            let NewNotification = SceneElements.notification
            NewNotification.position = CGPoint(x: Constants.diceRoll().x, y: Constants.diceRoll().y)
            NewNotification.run(fade)
            NewNotification.zPosition = 1.0
            self.addChild(NewNotification)
        }
    }
    
    private func CreatMessDisk(){
        for _ in 0...20{
            let NewMotionDisk = SceneElements.xcodeFiles
            NewMotionDisk.position = CGPoint(x: Constants.diceRoll().x, y: Constants.diceRoll().y)
            NewMotionDisk.zPosition = 1.0
            self.addChild(NewMotionDisk)
            NewMotionDisk.run(fade)
            NewMotionDisk.physicsBody?.applyAngularImpulse(0.1)
            
        }
    }
    
    //Transition between the Finder and the sad Emoji to amplify the sadness of the finder
    
    let fadding = SKAction.fadeOut(withDuration: 3.0)
    let SadEmoji = SceneElements.sadEmoji
    
    
    public func Transition(){
        print("the Finder is really sad...")
        SceneElements.sadEmoji.run(fadding)
        SceneElements.finder.run(SKAction.fadeIn(withDuration: 3.0))
        
        SceneElements.sadEmoji.physicsBody?.isDynamic = false
        SceneElements.sadEmoji.alpha = 1.0
        SceneElements.finder.physicsBody?.isDynamic = false
        
        self.addChild(SceneElements.finder)
        self.addChild(SceneElements.sadEmoji)
        self.addChild(SceneElements.Siri)
        self.addChild(SceneElements.ballOfDeath)
        
        let oneRevolution:SKAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1)
        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
        
        SceneElements.ballOfDeath.run(repeatRotation)
        
        SceneElements.Siri.alpha = 1.0
        SceneElements.sadEmoji.zPosition = 1.0
        SceneElements.ballOfDeath.zPosition = 1.0
        SceneElements.ballOfDeath.alpha = 1.0
    }
    
    
    
    public func moveCharacter(location: CGPoint){
        SceneElements.sadEmoji.position = location
    }
    
    
    // true if the scene is for the game and false if it is just for demonstration purpose
    public func setUpScene(endGame: Bool){
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: CGRect(x: 0, y: 0, width: 375, height: 668))
        
        
        if endGame == false {
            self.Transition()
            
            
        }else{
            self.physicsWorld.contactDelegate = self
            self.physicsBody?.categoryBitMask = Constants.wallBitmask
            self.physicsBody?.collisionBitMask = Constants.mediaBitmask
            self.physicsBody?.contactTestBitMask = Constants.mediaBitmask
            
            
            let finderSprite = SKSpriteNode(imageNamed: "Finder Sad.png")
            finderSprite.size = CGSize(width: 150, height: 150)
            finderSprite.position = CGPoint(x: 200, y: 300)
            finderSprite.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 150, height: 150))
            finderSprite.physicsBody?.isDynamic = true
            finderSprite.physicsBody?.affectedByGravity = false
            finderSprite.name = "sad"
            finderSprite.zPosition = 1.0
            
            finderSprite.physicsBody?.categoryBitMask =
                Constants.playerBitmask
            finderSprite.physicsBody?.collisionBitMask = Constants.wallBitmask | Constants.mediaBitmask
            
            self.addChild(finderSprite)
            
        }
        DispatchQueue.global(qos: .unspecified).async {
            self.CreatMessDisk()
        }
        
        DispatchQueue.global(qos: .userInteractive).async{
            self.CreateMessNotification()
            self.allSetUP = true
        }
        
        self.backgroundColor = .white
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.size = CGSize(width: 375, height: 668)
        
    }
    
    
}

extension GameScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        
        
    }
    // prevents that the Finder view is removed from the gameScene.
    public func didEnd(_ contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == "sad"{
            
        }else {
            contact.bodyB.node?.removeFromParent()
            
            if self.children.count < 11 && allSetUP == true {
                print("Game ended, thank you for your help!")
                
                let castMainView = self.view?.superview
                
                NotificationCenter.default.post(name: Constants.showEnd, object: castMainView)
            }
        }
    }
}



public class GameView: SKView{
    // this function is important because on the beginning there was a huge delay between the point of the gestureRecognizer and the way the FinderNode was moved in the scene. After some tests I created this method which doesn't work perfectly, but it's after all a huge improvement.
    var hardDiskView = Progressdisplay()
    var chechNodesTimer: Timer?
    var secondTimer: Timer?
    var currentNodesCount = 0
    
    func moveCorrectly(point: CGPoint)-> CGPoint{
        return CGPoint(x: (self.frame.maxX - self.frame.minX) / 2 + (point.x - 120), y: (self.frame.maxY - self.frame.minY) / 2 + (120 - point.y))
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    // true if its the game or false if its just for the demo of the full hard disk.
    public func present(hardDiskGame: Bool){
        let scene = GameScene()
        scene.setUpScene(endGame: hardDiskGame)
        scene.currentView = self
        self.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 1.0))
    }
    
   public func startDemo(){
        configurationView(GenericUI: hardDiskView, Type: 0, SuperView: self, Frame: CGRect.init(x: 80, y: 20, width: 250, height: 40), Border: (cornerRadius: 20, width: 1, colour: .black), Background: .clear)
        hardDiskView.showProgress(animator: UIViewPropertyAnimator(), time: 4.0, Colour: .red)
    }
    
   public func startGame(){
        configurationView(GenericUI: hardDiskView, Type: 0, SuperView: self, Frame: CGRect.init(x: 80, y: 20, width: 250, height: 40), Border: (cornerRadius: 20, width: 1, colour: .black), Background: .clear)
        
        hardDiskView.removeProgressComplet()
        gestureRecognizer.addTarget(self, action: #selector(translation))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func closeGame() {
        
        
        
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gestureRecognizer = UIPanGestureRecognizer()
    
    
    // Filter the nodes to find the Finder Node for dragging it around in the GameScene
    @objc func translation(){
        let Position = gestureRecognizer.translation(in: self)
        let NewList = self.scene?.children.filter{$0.name == "sad"        }
        NewList![0].position = self.moveCorrectly(point: Position)
    }
    
}





