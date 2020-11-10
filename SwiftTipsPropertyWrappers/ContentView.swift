//
//  ContentView.swift
//  SwiftTipsPropertyWrappers
//
//  Created by Ramill Ibragimov on 10.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var stateValue: Bool = false
    
    var body: some View {
        Text(stateValue ? "Hello, world!" : "SwiftUI")
            .padding()
            .onAppear() {
                setState()
            }
            .onTapGesture(count: 1, perform: {
                setState()
            })
    }
    
    func setState() {
        stateValue.toggle()
        UserDefaultValue.someValue = stateValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UserDefaultValue {
    @UserDefault(key: "someValue", defaultValue: false)
    static var someValue: Bool
}

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    
    init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: Value {
        get {
            (UserDefaults.standard.object(forKey: self.key) as? Value) ?? self.defaultValue
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: self.key)
        }
    }
    
    var projectedValue: Self {
        get {
            return self
        }
    }
}
