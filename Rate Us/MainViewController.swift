//
//  MainViewController.swift
//  Rate Us
//
//  Created by Khant Zaw Ko on 2/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainViewController: UIViewController {
    
    var ref: FIRDatabaseReference!

    @IBOutlet weak var excellentEmoji: UIButton!
    @IBOutlet weak var excellentButton: UIButton!
    @IBOutlet weak var goodEmoji: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var averageEmoji: UIButton!
    @IBOutlet weak var averageButton: UIButton!
    @IBOutlet weak var badEmoji: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var terribleEmoji: UIButton!
    @IBOutlet weak var terribleButton: UIButton!
    
    @IBOutlet weak var thankyouLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


                
        excellentEmoji.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        excellentButton.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        goodEmoji.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        goodButton.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        averageEmoji.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        averageButton.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        badEmoji.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        badButton.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        terribleEmoji.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        terribleButton.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        thankyouLabel.alpha = 0
    }
    
    func pressButton(button: UIButton) {
        
        if button.titleLabel?.text == "Excellent" || button.titleLabel?.text == "😍" {
            updateRating(text: "Excellent")
        } else if button.titleLabel?.text == "Good" || button.titleLabel?.text == "😊"{
            updateRating(text: "Good")
        } else if button.titleLabel?.text == "Average" || button.titleLabel?.text == "🙂"{
            updateRating(text: "Average")
        } else if button.titleLabel?.text == "Bad" || button.titleLabel?.text == "😕"{
            updateRating(text: "Bad")
        } else if button.titleLabel?.text == "Terrible" || button.titleLabel?.text == "😡"{
            updateRating(text: "Terrible")
        } else {
            print("error")
        }
    }
    
    func updateRating(text: String) {
        ref = FIRDatabase.database().reference()
        
        let date = "03/03/2017"
        let key = ref.childByAutoId().key
        
        let post = ["date": date]
        let childUpdates = ["/the-testing-one/\(text)/\(key)": post]
        ref.updateChildValues(childUpdates)
        
        thankyouLabel.alpha = 1
        self.view.isUserInteractionEnabled = false

        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.myPerformeCode), userInfo: nil, repeats: false)
    }
    
    func myPerformeCode() {
        thankyouLabel.alpha = 0
        self.view.isUserInteractionEnabled = true
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
