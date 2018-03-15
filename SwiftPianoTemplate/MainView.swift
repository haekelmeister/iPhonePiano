//
//  MainView.swift
//  SwiftPiano
//
//  Created by Chris on 01.03.18.
//  Copyright © 2018 csh. All rights reserved.
//

import UIKit
import AVFoundation
import os.log


class MainView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init() {
        self.init(frame: .zero)

        self.backgroundColor = .black

        self.addSubview(PianoKey(type: .diatonic, number: 1, sound: "A4"))
        self.addSubview(PianoKey(type: .diatonic, number: 2, sound: "B4"))
        self.addSubview(PianoKey(type: .diatonic, number: 3, sound: "C4"))
        self.addSubview(PianoKey(type: .diatonic, number: 4, sound: "D4"))
        self.addSubview(PianoKey(type: .diatonic, number: 5, sound: "E4"))
        self.addSubview(PianoKey(type: .diatonic, number: 6, sound: "F4"))
        self.addSubview(PianoKey(type: .diatonic, number: 7, sound: "G4"))

        self.addSubview(PianoKey(type: .pentatonic, number: 1, sound: "Ab4"))
        self.addSubview(PianoKey(type: .pentatonic, number: 2, sound: "Bb4"))
        self.addSubview(PianoKey(type: .pentatonic, number: 3, sound: "Db4"))
        self.addSubview(PianoKey(type: .pentatonic, number: 4, sound: "Eb4"))
        self.addSubview(PianoKey(type: .pentatonic, number: 5, sound: "Gb4"))
    }
}

