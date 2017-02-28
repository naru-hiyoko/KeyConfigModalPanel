//
//  KeyConfigViewController.swift
//  KeyConfiger
//
//  Created by 成沢淳史 on 2017/02/28.
//  Copyright © 2017 naru. All rights reserved.
//

import Foundation
import Cocoa


class SettingView: NSView
{
    @IBOutlet weak var infoLabel: NSTextField?
    
    var message : String = ""
    private var _pressedKeys: String = ""
    var pressedKeys: String
    {
        get {
            return _pressedKeys
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.becomeFirstResponder()
        _pressedKeys = ""
        KeyConfig.currentKey = ""
    }
    
    override func viewWillDraw() {
        Swift.print(self.message)
        self.infoLabel?.stringValue = self.message
    }
    

    
    override var acceptsFirstResponder: Bool
    {
        return true
    }
    
    func buttonOnDown()
    {
        NSApplication.shared().abortModal()
    }
    
    
    
    override func keyDown(with event: NSEvent) {
        
        guard let key = KeyConfig.convertEvent(event) else {
            NSApplication.shared().abortModal()            
            return 
        }
        
        self._pressedKeys = key
        KeyConfig.currentKey = self._pressedKeys
        let s = "CurrentSet: "
        self.message = s.appending(self._pressedKeys)
        self.infoLabel!.stringValue = self.message

    }
        
    
}
