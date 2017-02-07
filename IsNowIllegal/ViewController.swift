//
//  ViewController.swift
//  IsNowIllegal
//
//  Created by Maya Lekova on 2/7/17.
//  Copyright © 2017 Maya Lekova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textBox: UITextField!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let enteredText = self.textBox.text else {
            return
        }
        // TODO:
        // Make a PUT to https://is-now-illegal.firebaseio.com/queue/tasks.json with the format { task: 'gif', word: enteredText }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

