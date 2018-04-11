import AVKit
import AVFoundation




// Class which contains all functions to play media in this playground.
// When conforming to a delegate I made a extension of this class
open class VideoAndVoiceModelClass: NSObject{
    
    
    public var delegate: speakDelegate!
    private var notifications: NSObjectProtocol!
    private var videoPlayer = AVPlayer()
    private var audioPlayer = AVAudioPlayer()
    private var dialogue = AVSpeechUtterance(string: "")
    private let Synth = AVSpeechSynthesizer()
    private let VideoURL: NSURL = Bundle.main.url(forResource: "Siri Gif", withExtension: "mp4")! as NSURL
    
  
    @objc func playerItemDidReachEnd() {
        videoPlayer.seek(to: kCMTimeZero)
    }
    
    open func runVideo() -> AVPlayerLayer{
        // creates a endless loop of the siri Video.
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: videoPlayer.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.videoPlayer.seek(to: kCMTimeZero)
                self.videoPlayer.play()
            }
        })
        
        videoPlayer = AVPlayer(url: VideoURL as URL)
        videoPlayer.actionAtItemEnd = .none
        videoPlayer.isMuted = true
        videoPlayer.play()
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        playerLayer.frame = CGRect(x: 0, y: 100, width: 375, height: 100)
        
        playerLayer.zPosition = 1.0
        
        return playerLayer
    }
    
    
    
    
    open func play(MediaName: String, Mediatyp: String ){
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: MediaName, ofType: Mediatyp)!))
            
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.isMeteringEnabled = true
            audioPlayer.updateMeters()
        }catch{
            print(error)
        }
        
        audioPlayer.play()
        if audioPlayer.play() == false{
            audioPlayer.play()
        }
    }
    
    open func speak(text: String, language: String){
        dialogue = AVSpeechUtterance(string: text)
        dialogue.rate = AVSpeechUtteranceDefaultSpeechRate
        dialogue.voice = AVSpeechSynthesisVoice(language: language)
        
        Synth.delegate = self
        Synth.speak(dialogue)
        
    }
    
    open func startMacShutDown(){
        
    }
    
    
    
    
}

extension VideoAndVoiceModelClass: AVSpeechSynthesizerDelegate{
    
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("Hello I´m the mac")
    }
    
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        switch utterance.speechString {
        case Constants.DialogueParts.FinderIntro:
            print("Tap the Siri Btn!")
            
        case Constants.DialogueParts.siriDialogue:
            self.play(MediaName: "Siri Stop", Mediatyp: ".mp3")
       
        case Constants.DialogueParts.finderRespons:
            NotificationCenter.default.post(name: Constants.macShutdown, object: self)
            
        case Constants.DialogueParts.thankYou: 
             NotificationCenter.default.post(name: Constants.theEnd, object: self)
            
            
        default:
            print("I hope you like my idea and this playground ;)")
            
        }
        
        
        
    }
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        
    }
    
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        
        // Needs also a function to continue the speech!
        notifications = NotificationCenter.default.addObserver(forName: Constants.speechPauseNotification, object: self, queue: OperationQueue.main) { notification in
            self.Synth.pauseSpeaking(at: .word)
        }
        
        notifications = NotificationCenter.default.addObserver(forName: Constants.speechContinue, object: self, queue: OperationQueue.main) { notification in
            self.Synth.continueSpeaking()
        }
        
        
        
    }
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
    }
}


extension VideoAndVoiceModelClass: AVAudioPlayerDelegate{
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        func searchItem(_ name: String) -> Int? {
            let mediaSource = Constants.mediaItems
            let itemDuration = mediaSource[name]?.duration
            return itemDuration
        }
        
        
        
        let playerDuration = Int(player.duration)
        
        
        switch playerDuration{
            
        case (searchItem("crash"))! :
            delegate.createLoading()
            
        case (searchItem("BootUp"))! :
            delegate.startShow()

        case (searchItem("SiriStart"))!:
            delegate.dialogueTransition()
         
            
        case (searchItem("siriStop"))! :
            delegate.finderIdea()
          
        
        default: print("Maybe this could be a feature in future macOS releases?")
            
        }
        
    }
    
}









