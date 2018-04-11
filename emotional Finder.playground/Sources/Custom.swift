import UIKit

// Custom class for the progressViews in the game and in the loading screen
public class Progressdisplay : UIView{
    
    private var backgroundView = UIView()
    
    public func showProgress(animator: UIViewPropertyAnimator, time: Float, Colour: UIColor){
        backgroundView = UIView.init(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: 0, height: self.frame.height))
        
        
        backgroundView.layer.cornerRadius = self.layer.cornerRadius
        backgroundView.backgroundColor = Colour
        self.superview?.addSubview(backgroundView)
        self.superview?.sendSubview(toBack: backgroundView)
        
        let animationTimes = time / 2
        
        let divided = self.frame.divided(atDistance: self.frame.width / 2, from: .minXEdge)
        
        
        UIView.animate(withDuration: TimeInterval(animationTimes), animations: {self.backgroundView.frame = divided.slice
            
        }, completion: {(true) in
            UIView.animate(withDuration: TimeInterval(animationTimes), animations: {
                self.backgroundView.frame = divided.slice.union(divided.remainder)
                
            })
        })
    }
    
    
    public func removeProgressComplet(){
        self.backgroundView.layer.cornerRadius = self.layer.cornerRadius
        self.backgroundView.frame = self.frame
        self.backgroundView.backgroundColor = .green
        self.superview?.addSubview(self.backgroundView)
        self.superview?.sendSubview(toBack: self.backgroundView)
        
        UIView.animate(withDuration: 14.0, animations: {
            self.backgroundView.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: 0, height: self.frame.height)
        }
    )}
}


// protocol for accessing the functions from the "MainView" in the "VideoAndVoiceModelClass".
public protocol speakDelegate{
    func createLoading()
    func startShow()
    func dialogueTransition()
    func finderIdea()
}



