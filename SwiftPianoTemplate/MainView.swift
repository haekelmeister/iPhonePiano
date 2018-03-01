//
//  MainView.swift
//  SwiftPiano
//
//  Created by Chris on 01.03.18.
//  Copyright © 2018 csh. All rights reserved.
//

import UIKit

class MainView: UIView {
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = .gray

        let subView = UIView(frame: .zero)
        subView.frame = CGRect(x: 0, y: 100, width: 300, height: 100)
        subView.backgroundColor = .white

        self.addSubview(subView)
    }
}

