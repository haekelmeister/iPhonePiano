//
//  MainViewController.swift
//  SwiftPianoTemplate
//
//  Created by Chris on 01.03.18.
//  Copyright © 2018 csh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    override public func loadView() {
        super.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}

