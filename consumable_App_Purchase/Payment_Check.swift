//
//  Payment_Check.swift
//  consumable_App_Purchase
//
//  Created by AVINASH on 19/10/22.
//

import UIKit

class Payment_Check: UIViewController {
    @IBOutlet weak var button: UISwitch!
//    var loggedIn = false
//    var loggedOff = true
    let UserDefault = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    @IBAction func toggle(_ sender: Any) {
//         var valuetrue = true
//        UserDefaults.standard.set(valuetrue, forKey: "num")
//        
            self.dismiss(animated: true, completion: nil)
       
        
        }
        
    }
    
    

