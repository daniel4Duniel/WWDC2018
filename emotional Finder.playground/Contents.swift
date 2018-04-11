
//:Please run it on macOS with Xcode and the iOS simulator.
//:I used Xcode 9.2 to develop this playground.

//: Thank You!

import UIKit
import PlaygroundSupport



var notifications: NSObjectProtocol!

let finderView = MainView()


notifications = NotificationCenter.default.addObserver(forName: Constants.macShutdown, object: finderView, queue: OperationQueue.main) { notification in
    let fullVolume = GameView.init(frame: Constants.viewScreenFrame)
    fullVolume.present(hardDiskGame: false)
    fullVolume.startDemo()
    finderView.videoAndVoice.play(MediaName: "Mac Crash Chime", Mediatyp: ".mp3")
    finderView.view.addSubview(fullVolume)
}

notifications = NotificationCenter.default.addObserver(forName: Constants.macShutdown, object: finderView.videoAndVoice, queue: OperationQueue.main) { notification in
    finderView.videoAndVoice.speak(text: Constants.DialogueParts.gameExplanation, language: Constants.Languages.BritEnglish.rawValue)
    let Game = GameView.init(frame: Constants.viewScreenFrame)
    Game.startGame()
    let gameScene = GameScene()
    gameScene.setUpScene(endGame: true)
    Game.presentScene(gameScene)
    finderView.view.addSubview(Game)
}


notifications = NotificationCenter.default.addObserver(forName: Constants.showEnd, object: finderView.view, queue: OperationQueue.main) {notification in
    finderView.videoAndVoice.play(MediaName: "Applause", Mediatyp: ".mp3")
    finderView.ending()
}

notifications = NotificationCenter.default.addObserver(forName: Constants.theEnd, object: finderView.videoAndVoice, queue: OperationQueue.main) {notification in
    finderView.lastFunction()
}



PlaygroundPage.current.liveView = finderView

