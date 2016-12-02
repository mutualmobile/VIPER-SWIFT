//
//  AddViewController.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, AddViewInterface {
    var eventHandler : AddModuleInterface?

    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var datePicker : UIDatePicker!

    var minimumDate : Date = Date()
    var transitioningBackgroundView : UIView = UIView()
    
    @IBAction func save(_ sender: AnyObject) {
        if let eventHandler = eventHandler, let text = nameTextField.text {
            eventHandler.saveAddActionWithName(text, dueDate: datePicker.date)
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        nameTextField.resignFirstResponder()
        eventHandler?.cancelAddAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(AddViewController.dismissFunc))
        
        transitioningBackgroundView.isUserInteractionEnabled = true
        
        nameTextField.becomeFirstResponder()
        
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = minimumDate
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        nameTextField.resignFirstResponder()
    }
    
    func dismissFunc() {
        eventHandler?.cancelAddAction()
    }
    
    func setEntryName(_ name: String) {
        nameTextField.text = name
    }
    
    func setEntryDueDate(_ date: Date) {
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = date
        }
    }
    
    func setMinimumDueDate(_ date: Date) {
        minimumDate = date
        
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = date
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
