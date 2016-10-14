//
//  ViewController.swift
//  UpNotificationCenter-Swift
//
//  Created by Chauyan Wang on 10/14/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let updateNotification:NSString = "updateNotification"
    
    @IBOutlet weak var notificationTextLabel:UILabel?

    @IBAction func updateLabel(sender: UIButton) {
        UpNotificationCenter.defaultCenter().post(name: updateNotification, object: nil)
    }
    
    
    func updateNotificationText() {
        notificationTextLabel?.text = "receive a notfication from button !!"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UpNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateNotificationText), name: updateNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UpNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

