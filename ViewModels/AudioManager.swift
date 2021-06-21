//
//  AudioManager.swift
//  TicTacToe
//
//  Created by President Raindas on 18/06/2021.
//

import Foundation
import AVKit

final class AudioManager: ObservableObject {
    // sound button
    @Published var soundOn = true //<--- false is sound button is tapped to mute
    
    // Audio files
    let backgroundSound = "Island-Strums"
    let gamePlaySound = "mixkit-game-level-music-689"
    let gameWinSound = "Ta Da-SoundBible.com-1884170640"
    let gameLoseSound = "mixkit-ominous-drums-227"
    let highScoreSound = "mixkit-game-level-completed-2059"
    let gameTapSound = "mixkit-game-ball-tap-2073"
    
    private var audioPlayer: AVAudioPlayer!
    private var buttonTapPlayer: AVAudioPlayer!
    
    private func loadSound(filename: String, type: String) {
        let sound = Bundle.main.path(forResource: filename, ofType: type)
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
    }
    
    public func playBackgroundSound() {
        if soundOn {
            loadSound(filename: backgroundSound, type: "mp3")
            self.audioPlayer.numberOfLoops = 5
            self.audioPlayer.play()
        }
        return
    }
    
    public func playGamePlaySound() {
        if soundOn {
            loadSound(filename: gamePlaySound, type: "wav")
            self.audioPlayer.numberOfLoops = 5
            self.audioPlayer.play()
        }
        return
    }
    
    public func playGameTapSound() {
        if soundOn {
            let sound = Bundle.main.path(forResource: gameTapSound, ofType: "wav")
            self.buttonTapPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.buttonTapPlayer.play()
        }
        return
    }
    
    public func playGameWinSound() {
        if soundOn {
            loadSound(filename: gameWinSound, type: "wav")
            self.audioPlayer.play()
        }
        return
    }
    
    public func playGameLoseSound() {
        if soundOn {
            loadSound(filename: gameLoseSound, type: "wav")
            self.audioPlayer.play()
        }
        return
    }
    
    public func playHighScoreSound() {
        if soundOn {
            loadSound(filename: highScoreSound, type: "wav")
            self.audioPlayer.play()
        }
        return
    }
    
    public func stopSound() {
        if soundOn {
            self.audioPlayer.stop()
        } else {
            self.audioPlayer.play()
        }
    }
}
