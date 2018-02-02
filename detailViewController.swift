//
//  detailViewController.swift
//  listApp
//
//  Created by Emily on 2/1/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var viewname: UILabel!
    @IBOutlet weak var viewnumber: UILabel!
    
    var showname: String?
    var showlastname:String?
    var showphone: String?
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewname.text = showname! + " " + showlastname!
        viewnumber.text = showphone
        self.title = showname

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
