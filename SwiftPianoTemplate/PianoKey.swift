//
//  PianoKey.swift
//  SwiftPianoTemplate
//
//  Created by ???? ???????? on 2018. 03. 15..
//  Copyright © 2018. csh. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

struct Settings {
    static let diatonicKeys        = 7
    static let diatonicKeyWidth    = UIScreen.main.bounds.width
    static let diatonicKeyHeight   = UIScreen.main.bounds.height / CGFloat(diatonicKeys)
    static let pentatonicKeyWidth  = UIScreen.main.bounds.width  / 2
    static let pentatonicKeyHeight = UIScreen.main.bounds.height / (CGFloat(diatonicKeys) * 2)
}

enum PianoKeyType {
    case diatonic    // aka "white"
    case pentatonic  // aka "black"

    var size: (width: CGFloat, height: CGFloat) {
        switch self {
        case .diatonic: return (width: Settings.diatonicKeyWidth, height: Settings.diatonicKeyHeight)
        case .pentatonic: return (width: Settings.pentatonicKeyWidth, height: Settings.pentatonicKeyHeight)
        }
    }
}

enum KeyStates {
    case Released, Pressed
}

class PianoKey: UIView /*UIButton*/ {
    var audioPlayer = AVAudioPlayer()
    var releasedColour: UIColor!
    var pressedColour: UIColor!
    var keyState: KeyStates = .Released

    init(type keytype: PianoKeyType, number numberOnKeyboard: Int, sound soundFile: String) {

        assert(numberOnKeyboard > 0, "Key number on piano keyboard starts at 1")
        assert(!soundFile.isEmpty, "No sound file given")

        super.init(frame: CGRect(x: 0, y: 0, width: keytype.size.width, height: keytype.size.height))
        switch keytype {
        case .diatonic:
            self.frame.origin.y = UIScreen.main.bounds.height - (keytype.size.height * CGFloat(numberOnKeyboard))
            releasedColour = .white
            pressedColour  = .gray
        case .pentatonic:
            let offset: Int = numberOnKeyboard / 3
            self.frame.origin.y = UIScreen.main.bounds.height - (Settings.diatonicKeyHeight * CGFloat(numberOnKeyboard + offset)) - (keytype.size.height/2)
            releasedColour = .black
            pressedColour  = .gray
        }

        let url = Bundle.main.url(forResource: soundFile, withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        }
        catch let error as NSError {
            os_log("Error setup sound. '%@'", type: .error, error)
        }

        // in case we use UIView
        let tap = UILongPressGestureRecognizer(target: self, action:  #selector (self.pressed(sender:)))
        tap.minimumPressDuration = 0
        self.addGestureRecognizer(tap)

        // in case we use UIButton
        /*self.addTarget(self, action: #selector (self.pressed(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector (self.released(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector (self.released(sender:)), for: .touchUpOutside)*/
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(frame: .zero)
    }

    @objc func pressed(sender: UITapGestureRecognizer) {
        if sender.state == .began {
            keyState = .Pressed
            audioPlayer.currentTime = 0
            audioPlayer.play()
        }
        else if sender.state == .ended {
            keyState = .Released
        }
        setNeedsDisplay()
    }

    /*@objc func pressed(sender: UIButton?) {
        keyState = .Pressed
        audioPlayer.currentTime = 0
        audioPlayer.play()
        setNeedsDisplay()
    }

    @objc func released(sender: UIButton) {
        keyState = .Released
        setNeedsDisplay()
    }*/

    func getPathAtMargin() -> UIBezierPath {
        // set margin property if wanted
        let cornerRadius =  CGSize(width: self.bounds.width / 25.0, height:  self.bounds.width / 25.0)
        let marginRect = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height)
        let path = UIBezierPath(roundedRect: marginRect, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii:  cornerRadius)
        path.lineWidth = 2.0

        return path
    }

    override func draw(_ rect: CGRect) {
        let path = getPathAtMargin()
        switch keyState {
        case .Released:
            releasedColour.setFill()
        case .Pressed:
            pressedColour.setFill()
        }

        path.fill()
        path.stroke()

        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
