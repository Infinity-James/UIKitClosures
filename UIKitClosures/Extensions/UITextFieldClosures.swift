//
//  UITextFieldClosures.swift
//  Pokemem
//
//  Created by James Valaitis on 14/03/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import UIKit
import ObjectiveC

//	MARK: Box Class

/**
    `Box`

    Boxes a value to be able to use it with Objective-C.
*/
private class Box<T> {
    /// The value boxed within this class.
    let value: T
    
    /**
        Initializes a boxed value with the value to box.
     
        - Parameter value:  The value to box.
     
        - Returns:  An initialized box with the given value.
     */
    init(value: T) {
        self.value = value
    }
}

//	MARK: UITextField Closures Extension

/**
    `UITextField`

    This extension to UITextField adds the ability to assign closures to what would usually need to be delegate methods.
*/
public extension UITextField {
    
    //	MARK: Associated Keys Struct
    
    /**
        `AssociatedKeys`
    
        A private struct which holds the keys for retrieving associated values.
    */
    private struct AssociatedKeys {
        /// The handle for retrieving or storing the text field delegate as an associated value.
        static let textFieldDelegateHandle = "textFieldDelegateHandle"
        
        /// The handle for retrieving or storing the `shouldBeginEditingClosure` as an associated value.
        static let textFieldShouldBeginEditingHandle = "textFieldShouldBeginEditingHandle"
        /// The handle for retrieving or storing the `shouldEndEditingClosure` as an associated value.
        static let textFieldShouldEndEditingHandle = "textFieldShouldEndEditingHandle"
        
        /// The handle for retrieving or storing the `didBeginEditingClosure` as an associated value.
        static let textFieldDidBeginEditingHandle = "textFieldDidBeginEditingHandle"
        /// The handle for retrieving or storing the `didEndEditingClosure` as an associated value.
        static let textFieldDidEndEditingHandle = "textFieldDidEndEditingHandle"
        
        /// The handle for retrieving or storing the `shouldChangeCharactersClosure` as an associated value.
        static let textFieldShouldChangeCharactersHandle = "textFieldShouldChangeCharactersHandle"
        
        /// The handle for retrieving or storing the `shouldClearClosure` as an associated value.
        static let textFieldShouldClearHandle = "textFieldShouldClearHandle"
        /// The handle for retrieving or storing the `shouldReturnClosure` as an associated value.
        static let textFieldShouldReturnHandle = "textFieldShouldReturnHandle"
    }
    
    //	MARK: Type Aliases
    
    /// A closure to be called when an action has been performed in the text field.
    typealias TextFieldAction = (textField: UITextField) -> ()
    /// A closure to be the text field requires a response.
    typealias TextFieldResponse = (textField: UITextField) -> (Bool)
    /// A closure to be called when an characters have changes within the text field.
    typealias TextFieldChangeCharacters = (textField: UITextField, range: NSRange, replacementText: String) -> (Bool)
    
    //	MARK: Delegate Management
    
    /**
        Manages the fact that we need to be the delegate for this UITextField, but there may be an object that also wants to be the delegate.
    */
    private func manageDelegate() {
        //  if we are not our own delegate we need to set ourselves as such but keep the old delegate for messaging where appropriate
        if let textFieldDelegate = delegate where !(textFieldDelegate is UITextField) {
            self.textFieldDelegate = textFieldDelegate
        }
        
        delegate = self
    }
    
    /// The actual delegate for the text field (besides us).
    private var textFieldDelegate: UITextFieldDelegate? {
        get {
            return objc_getAssociatedObject(self, AssociatedKeys.textFieldDelegateHandle) as? UITextFieldDelegate
        }
        
        set {
            objc_setAssociatedObject(self, AssociatedKeys.textFieldDelegateHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //	MARK: UITextField Closure Access
    
    /// The closure to be called to determine whether the text field should begin editing.
    var shouldBeginEditingClosure: TextFieldResponse? {
        get {
            guard let boxedValue = objc_getAssociatedObject(self, AssociatedKeys.textFieldShouldBeginEditingHandle) as? Box<TextFieldResponse> else { return nil }
            return boxedValue.value
        }
        set {
            let boxedValue: Box<TextFieldResponse>? = newValue != nil ? Box(value: newValue!) : nil
            objc_setAssociatedObject(self, AssociatedKeys.textFieldShouldBeginEditingHandle, boxedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            manageDelegate()
        }
    }
    
    /// The closure to be called to determine whether the text field should end editing.
    var shouldEndEditingClosure: TextFieldResponse? {
        get {
            guard let boxedValue = objc_getAssociatedObject(self, AssociatedKeys.textFieldShouldEndEditingHandle) as? Box<TextFieldResponse> else { return nil }
            return boxedValue.value
        }
        set {
            let boxedValue: Box<TextFieldResponse>? = newValue != nil ? Box(value: newValue!) : nil
            objc_setAssociatedObject(self, AssociatedKeys.textFieldShouldEndEditingHandle, boxedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            manageDelegate()
        }
    }
    
    /// The closure to be called when the text field did begin editing.
    var didBeginEditingClosure: TextFieldAction? {
        get {
            guard let boxedValue = objc_getAssociatedObject(self, AssociatedKeys.textFieldDidBeginEditingHandle) as? Box<TextFieldAction> else { return nil }
            return boxedValue.value
        }
        set {
            let boxedValue: Box<TextFieldAction>? = newValue != nil ? Box(value: newValue!) : nil
            objc_setAssociatedObject(self, AssociatedKeys.textFieldDidBeginEditingHandle, boxedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            manageDelegate()
        }
    }
    
    /// The closure to be called when the text field end begin editing.
    var didEndEditingClosure: TextFieldAction? {
        get {
            guard let boxedValue = objc_getAssociatedObject(self, AssociatedKeys.textFieldDidEndEditingHandle) as? Box<TextFieldAction> else { return nil }
            return boxedValue.value
        }
        set {
            let boxedValue: Box<TextFieldAction>? = newValue != nil ? Box(value: newValue!) : nil
            objc_setAssociatedObject(self, AssociatedKeys.textFieldDidEndEditingHandle, boxedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            manageDelegate()
        }
    }
    
    /// The closure to be called to determine whether the chracters in the text field should change.
    var shouldChangeCharactersClosure: TextFieldChangeCharacters? {
        get {
            guard let boxedValue = objc_getAssociatedObject(self, AssociatedKeys.textFieldShouldChangeCharactersHandle) as? Box<TextFieldChangeCharacters> else { return nil }
            return boxedValue.value
        }
        set {
            let boxedValue: Box<TextFieldChangeCharacters>? = newValue != nil ? Box(value: newValue!) : nil
            objc_setAssociatedObject(self, AssociatedKeys.textFieldShouldChangeCharactersHandle, boxedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            manageDelegate()
        }
    }
    
    /// The closure to be called to determine whether the text field should clear.
    var shouldClearClosure: TextFieldResponse? {
        get {
            guard let boxedValue = objc_getAssociatedObject(self, AssociatedKeys.textFieldShouldClearHandle) as? Box<TextFieldResponse> else { return nil }
            return boxedValue.value
        }
        set {
            let boxedValue: Box<TextFieldResponse>? = newValue != nil ? Box(value: newValue!) : nil
            objc_setAssociatedObject(self, AssociatedKeys.textFieldShouldClearHandle, boxedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            manageDelegate()
        }
    }
    /// The closure to be called to determine whether the text field should return.
    var shouldReturnClosure: TextFieldResponse? {
        get {
            guard let boxedValue = objc_getAssociatedObject(self, AssociatedKeys.textFieldShouldReturnHandle) as? Box<TextFieldResponse> else { return nil }
            return boxedValue.value
        }
        set {
            let boxedValue: Box<TextFieldResponse>? = newValue != nil ? Box(value: newValue!) : nil
            objc_setAssociatedObject(self, AssociatedKeys.textFieldShouldReturnHandle, boxedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            manageDelegate()
        }
    }
}

//	MARK: UITextFieldDelegate

extension UITextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(textField: UITextField) {
        if let didBeginEditingClosure = didBeginEditingClosure {
            didBeginEditingClosure(textField: textField)
        } else if let delegate = textFieldDelegate {
            delegate.textFieldDidBeginEditing?(textField)
        }
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        if let didEndEditingClosure = didEndEditingClosure {
            didEndEditingClosure(textField: textField)
        } else if let delegate = textFieldDelegate {
            delegate.textFieldDidEndEditing?(textField)
        }
    }
    
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if let shouldBeginEditingClosure = shouldBeginEditingClosure {
            return shouldBeginEditingClosure(textField: textField)
        } else if let delegate = textFieldDelegate,
            response = delegate.textFieldShouldBeginEditing?(textField) {
                return response
        }
        
        return true
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let shouldChangeCharactersClosure = shouldChangeCharactersClosure {
            return shouldChangeCharactersClosure(textField: textField, range: range, replacementText: string)
        } else if let delegate = textFieldDelegate,
            response = delegate.textField?(textField, shouldChangeCharactersInRange: range, replacementString: string) {
                return response
        }
        
        return true
    }
    
    public func textFieldShouldClear(textField: UITextField) -> Bool {
        if let shouldClearClosure = shouldClearClosure {
            return shouldClearClosure(textField: textField)
        } else if let delegate = textFieldDelegate,
            response = delegate.textFieldShouldClear?(textField) {
                return response
        }
        
        return true
    }
    
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if let shouldEndEditingClosure = shouldEndEditingClosure {
            return shouldEndEditingClosure(textField: textField)
        } else if let delegate = textFieldDelegate,
            response = delegate.textFieldShouldEndEditing?(textField) {
                return response
        }
        
        return true
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let shouldReturnClosure = shouldReturnClosure {
            return shouldReturnClosure(textField: textField)
        } else if let delegate = textFieldDelegate,
            response = delegate.textFieldShouldReturn?(textField) {
                return response
        }
        
        return true
    }
}