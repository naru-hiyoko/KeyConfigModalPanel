//
//  ViewController.swift
//  KeyConfiger
//
//  Created by 成沢淳史 on 2017/02/28.
//  Copyright © 2017 naru. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onTest2(_ sender: Any) {
        let key = KeyConfig.setFuncWithModal(message: "hello method: ", f: hello)
        
    }
    
    func hello()
    {
        print("hello")
    }
    
    override func mouseDown(with event: NSEvent) {

    }
    
    
}

class CustomView: NSView
{
    override var acceptsFirstResponder: Bool
    {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        KeyConfig.callShortCutFunc(event)
    }
    
}

