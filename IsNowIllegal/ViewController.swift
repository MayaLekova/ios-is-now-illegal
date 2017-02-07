//
//  ViewController.swift
//  IsNowIllegal
//
//  Created by Maya Lekova on 2/7/17.
//  Copyright © 2017 Maya Lekova. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var resultMeme: UIImageView!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let enteredText = self.textBox.text else {
            return
        }
        // TODO:
        // 1. Make a PUT to https://is-now-illegal.firebaseio.com/queue/tasks.json with the format { task: 'gif', word: enteredText }
        // 2. Get the result from https://is-now-illegal.firebaseio.com/gifs/TEST.json -> "url"
        // 3. Move the following to the response
        let url = URL(string: "https://storage.googleapis.com/is-now-illegal.appspot.com/gifs/TEST.gif")
//        let url = URL(string: "https://media.giphy.com/media/9g0cXfCFIj8Aw/giphy.gif")
        self.resultMeme.kf.setImage(with: url) {
            image, error, cacheType, imageURL in
            if let errorOccured = error {
                print("ERROR while getting gif with URL: \(imageURL)")
                print(errorOccured)
            }
        }
    }
    
    override func loadView() {
        let imageView = AnimatedImageView()
        self.resultMeme = imageView
        
        super.loadView()
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

