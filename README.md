# How to use

at ViewController <br>

function hello.
```swift
    func hello()
    {
        print("hello")
    }
 ```
 
register keyboard shortcut for func hello.
    
    
```swift
   let key = KeyConfig.setFuncWithModal(message: "hello method: ", f: hello)
```

call function from keyboard through keyDown:event

```swift
    override func keyDown(with event: NSEvent) {
        KeyConfig.callShortCutFunc(event)
    }
 ```
