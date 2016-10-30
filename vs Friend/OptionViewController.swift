//
//  OptionViewController.swift
//  vs Friend
//
//  Created by 池上　魁 on 2016/06/19.
//  Copyright © 2016年 asari. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {
    
    let scoredate:UserDefaults = UserDefaults.standard
    
    @IBOutlet var myswicth:UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(scoredate.object(forKey: "pro") == nil){
            scoredate.set(false,forKey:"pro")
            scoredate.synchronize()
        }
        // Do any additional setup after loading the view.
        if(scoredate.object(forKey: "pro") as! Bool == true){
            myswicth.isOn = true
        }else{
            myswicth.isOn = false
        }
        myswicth.addTarget(self, action: #selector(OptionViewController.pro_switch), for: UIControlEvents.valueChanged)
        
        if (nil != scoredate.object(forKey: "mykey")){
            let alert_Op = UIAlertController(title:"終了！",
                message: "\((scoredate.object(forKey: "mykey")! as! [Int])[0])点獲得しました。",
                preferredStyle: UIAlertControllerStyle.alert)
            alert_Op.addAction(
                UIAlertAction(
                    title:"OK",
                    style: UIAlertActionStyle.default,
                    handler: {action in
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                    }
                )
            )
            present(alert_Op, animated: true, completion: nil)
        }
    }

    @IBAction func back(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func pro_switch(){
        scoredate.set(myswicth.isOn,forKey:"pro")
        scoredate.synchronize()
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
