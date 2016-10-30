//
//  NextViewController.swift
//  vs Friend
//
//  Created by 池上　魁 on 2016/05/08.
//  Copyright © 2016年 asari. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    var member:Int = 0

  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPushed(_ sender: UIButton){
        member = sender.tag
        performSegue(withIdentifier: "next", sender: self)
    }

    
    //画面推移のときに渡すものを決めてます
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let resultViewController = segue.destination as! ResultViewController
        
        resultViewController.member = self.member
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
