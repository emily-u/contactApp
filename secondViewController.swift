//
//  secondViewController.swift
//  listApp
//
//  Created by Emily on 2/1/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit
import CoreData

protocol ViewControllerDelegate: class {
    func savelist(by controller: secondViewController, firstName: String, lastName: String, phone: String, at indexPath: NSIndexPath?)
}


class secondViewController: UIViewController {
    
    @IBOutlet weak var firstnameinput: UITextField!
    @IBOutlet weak var lastnameinput: UITextField!
    @IBOutlet weak var numberinput: UITextField!
    
    var firstname : String?
    var lastname : String?
    var phone : String?
    var delegate : ViewControllerDelegate?
    var indexPath : NSIndexPath?
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.savelist(by: self, firstName: firstnameinput.text!,lastName: lastnameinput.text!, phone: numberinput.text!, at: indexPath)
    }
    

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameinput.text = firstname
        lastnameinput.text = lastname
        numberinput.text = phone
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}


