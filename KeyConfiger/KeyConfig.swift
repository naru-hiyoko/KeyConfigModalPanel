//
//  KeyConfiger.swift
//  KeyConfiger
//
//  Created by 成沢淳史 on 2017/02/28.
//  Copyright © 2017 naru. All rights reserved.
//

import Foundation
import Cocoa

class KeyConfig
{
    static var keyMapping: Dictionary<String, (Void) -> Void> = [:]
    static var currentKey = ""
    static var message = ""
    private static let _window_delegate = WindowDelegate()
    
    class func call(key: String)
    {
        let f = keyMapping[key] ?? KeyConfig.nop
        f()
    }
    
    class func setFunc(key: String, f: @escaping (Void) -> Void)
    {
        keyMapping[key] = f
    }
    
    class func callShortCutFunc(_ event: NSEvent)
    {
        let key = KeyConfig.convertEvent(event) 
        KeyConfig.call(key: key!)
        
    }
    
    class func setFuncWithModal(message: String = "", f: @escaping (Void) -> Void) -> String?
    {
        var arr: NSArray = []
        let _ = Bundle.main.loadNibNamed("KeyConfigView", owner: self, topLevelObjects: &arr)
        
        var app: NSApplication?
        var win: NSWindow?
        
        for content in arr
        {
            
            if content is NSApplication
            {
                app = content as? NSApplication
            }
            
            if content is NSWindow
            {
                win = content as? NSWindow
            }
        }
        
        
        win!.title = "KeyConfig"
        win!.delegate = _window_delegate
        let setting_view = win!.contentView as! SettingView
        setting_view.message = message
        app!.runModal(for: win!)
        
        if currentKey != ""
        {
            keyMapping[currentKey] = f
            return currentKey
        } else {
            return nil
        }

        
    }
    
    class func convertEvent(_ event: NSEvent) -> String?
    {
        let types: Array<NSEventModifierFlags> = [.option, .shift, .control, .command]
        var displayStr = ""
        
        if event.keyCode == 36
        {
            return nil
        }
        
        if event.keyCode == 51
        {
            return ""
        }
        
        for type in types 
        {
            if event.modifierFlags.contains(type)
            {
                switch type {
                case NSEventModifierFlags.command:
                    displayStr.append("⌘")
                case NSEventModifierFlags.control:
                    displayStr.append("^")
                case NSEventModifierFlags.option:
                    displayStr.append("⎇")
                case NSEventModifierFlags.shift:
                    displayStr.append("⇧")
                default:
                    break
                }
            }
        }
        
        displayStr.append(event.charactersIgnoringModifiers!.uppercased())
        return displayStr
    }
    
    class func nop()
    {
        
    }
}

fileprivate class WindowDelegate:NSObject, NSWindowDelegate
{
    func windowWillClose(_ notification: Notification) {
        NSApplication.shared().abortModal()
        print("close")
    }
}
