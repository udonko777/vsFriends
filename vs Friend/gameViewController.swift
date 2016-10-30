//
//  gameViewController.swift
//  vs Friend
//
//  Created by 池上　魁 on 2016/06/05.
//  Copyright © 2016年 asari. All rights reserved.
//

import UIKit
import AVFoundation

class gameViewController: UIViewController {
    
    let scoredate:UserDefaults = UserDefaults.standard
    
    var timer = Timer()
    var count:Int = 0
    var puch_count:Int = 0
    var score:Int = 0
    var score_board:[Int] = []
    var random_number:Int = 0
    var next_random_number:Int = Int(arc4random() % 4)
    var combo_count:Int = 0
    let image = UIImage(named: "ボタン用")
    let image2 = UIImage(named: "ボタン用2")
    let image3 = UIImage(named: "ボタン用3")
    var message_st:String = "バグってます。"
    @IBOutlet var label:UILabel!
    @IBOutlet var button_pressed_output:UILabel!
    @IBOutlet var button:[UIButton]!
    @IBOutlet var combo:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        combo.alpha = 0
        start()
        random_button()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func random_button(){
        random_number = next_random_number
        next_random_number = Int(arc4random() % 4)
        for btn in button {
            if btn.tag == random_number{
                btn.setBackgroundImage(image, for:UIControlState())
            } else if btn.tag == next_random_number{
                btn.setBackgroundImage(image3, for:UIControlState())
            } else {
                btn.setBackgroundImage(image2, for:UIControlState())
            }
        }
    }
    
    //連打されるたびに呼ばれます
    @IBAction func puch(_ sender: UIButton){
        if (random_number == sender.tag){
            puch_count = puch_count + 1
            combo_count = combo_count + 1
            //コンボ用画像を表示
            if (combo_count > 5){
                combo.alpha = 1
                puch_count = puch_count + 1
            }
            button_pressed_output.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
            random_button()
        }else if(random_number != sender.tag && puch_count > 0){
            puch_count = puch_count - 1
            combo_count = 0
            combo.alpha = 0
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }else{
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        button_pressed_output.text = String(puch_count)
        anime()
    }
    
    func anime(){
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.button_pressed_output.transform = CGAffineTransform.identity
        })
    }
    
    func up(){
        //0.1秒に一回呼ばれる
        count = count + 1
        label.text = String(1000 - count)
        if count >= 1000 && timer.isValid {
            stop()
        }
    }
    
    func stop(){
        timer.invalidate()
        score = puch_count
        if (nil != scoredate.object(forKey: "mykey")){
            score_board = scoredate.object(forKey: "mykey") as! [Int]
        }
        score_board.append(score)
        scoredate.set(score_board, forKey:"mykey")
        if ((scoredate.object(forKey: "scorekey") as! Int?)! < score){
            scoredate.set(score,forKey:"scorekey")
        }
        print(score_board)
        self.dismiss(animated: true, completion: nil)
    }
    
    func start() {
        print(score_board)
        if (scoredate.object(forKey: "mykey") != nil){
        message_st = String(((scoredate.object(forKey: "mykey"))as! [Int]).count + 1)+"番目のプレイヤーの出番です"
        }else{
            message_st = "1番目のプレイヤーの出番です。"
        }
        if (scoredate.object(forKey: "hawtomode") as! Bool == true){
            message_st = "このゲームは複数人でプレイするゲームです。緑のボタンを押すと点数が増えます。赤色は次に緑色になる場所です。"
        }
        print(message_st)
        let alert = UIAlertController(title: "準備はOK？",
                                      message: message_st,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(
            UIAlertAction(
                title:"OK",
                style: UIAlertActionStyle.default,
                handler: {action in
                    NSLog("OKが押された")
                    self.scoredate.set(false, forKey: "hawtomode")
                    self.timer = Timer.scheduledTimer(timeInterval: 0.01,
                        target: self,
                        selector:  #selector(gameViewController.up),
                        userInfo: nil,
                        repeats: true       )
                }
            )
        )
        
        present(alert, animated: true, completion: nil)
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
