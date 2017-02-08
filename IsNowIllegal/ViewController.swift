//
//  ViewController.swift
//  IsNowIllegal
//
//  Created by Maya Lekova on 2/7/17.
//  Copyright © 2017 Maya Lekova. All rights reserved.
//

import UIKit
import MapleBacon
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var resultMeme: UIImageView!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let enteredText = self.textBox.text?.uppercased() else {
            return
        }
        // TODO: trim to 10 characters
        
        let parameters: Parameters = [
            "task": "gif",
            "word": enteredText
        ]
        let url = "https://is-now-illegal.firebaseio.com/queue/tasks.json"
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            if let error = response.error {
                print("ERROR: Generating gif with text\(enteredText): \(error)")
                return
            }
            
            // TODO: check if this is a strong retain cycle
            self.getGifUrl() { urlString in
                guard let url = URL(string: urlString) else {
                    print("ERROR: Invalid URL for generated gif: \(urlString)")
                    return
                }
                
                self.resultMeme.setImage(withUrl: url) { instance, error in
                    if let error = error {
                        print("ERROR while downloading image: \(error)")
                    }
                }
            }
        }
    }
    
    func getGifUrl(callback: @escaping (String) -> Void) {
        guard let enteredText = self.textBox.text?.uppercased() else {
            return
        }

        let url = "https://is-now-illegal.firebaseio.com/gifs/\(enteredText).json"
        
        Alamofire.request(url).responseString { response in
            if let JSON = response.result.value,
                let jsonObj = JSON.parseJSONString,
                let gifData = jsonObj as? NSDictionary,
                let gifObj = IllegalGif(dictionary: gifData) {
                return callback(gifObj.url ?? "")
            } else {
                return callback("")
            }
        }
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

// Inspired by http://stackoverflow.com/a/27269242
extension String {
    
    var parseJSONString: Any? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do {
                let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
                return parsedData
            } catch {
                return nil
            }
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}
