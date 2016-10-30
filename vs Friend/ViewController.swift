//
//  ViewController.swift
//  vs Friend
//
//  Created by 池上　魁 on 2016/05/08.
//  Copyright © 2016年 asari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let scoredate:UserDefaults = UserDefaults.standard
    @IBOutlet var hiscore:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (scoredate.object(forKey: "scorekey") as! Int? == nil){
        scoredate.set(1,forKey:"scorekey")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scoredate.removeObject(forKey: "mykey")
        NSLog("scoreDate.objectForKey(mykey)の中身が削除されました")
        // Do any additional setup after loading the view, typically from a nib.
        if (scoredate.object(forKey: "scorekey") as! Int? != nil){
            hiscore.text = String((scoredate.object(forKey: "scorekey") as! Int?)!)
        }
    }
    
    override func viewDidAppear(_ animeted: Bool){
        if (scoredate.object(forKey: "hawto") as! Bool? == nil){
            let alert3 = UIAlertController(title:"初めに",
            message: "初めに「おぷしょん」から「練習モード」を遊んでみましょう。",
            preferredStyle: UIAlertControllerStyle.alert)
            alert3.addAction(
                UIAlertAction(
                    title:"OK",
                    style: UIAlertActionStyle.default,
                    handler: {action in
                        NSLog("OK")
                        self.scoredate.set(true, forKey: "hawto")
                        self.scoredate.set(true, forKey: "hawtomode")
                    }
                )
            )
            present(alert3, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

}

