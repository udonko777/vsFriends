//
//  ResultViewController.swift
//  vs Friend
//
//  Created by 池上　魁 on 2016/05/08.
//  Copyright © 2016年 asari. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let scoreDate: UserDefaults = UserDefaults.standard
    
    //プレイヤーの人数。
    var member:Int!
    var score:[Int?] = []
    var player:Int = 0
    var score_board:[Int] = [1]//ここで1を入れているが、動作には全く関係無い。ただoptional型にしたくないので入れた。
    var winner:[Int]?
    @IBOutlet var Player_score_1: UILabel!
    @IBOutlet var Player_score_2: UILabel!
    @IBOutlet var Player_score_3: UILabel!
    @IBOutlet var Player_score_4: UILabel!
    @IBOutlet var Player_3: UILabel!
    @IBOutlet var Player_4: UILabel!
    @IBOutlet var next: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        if member! < 4 {
            Player_4.text = " "
        }
        if member! < 3 {
            Player_3.text = " "
            print(member)
        }
        
        if (nil != scoreDate.object(forKey: "mykey")){
            score_board = scoreDate.object(forKey: "mykey") as! [Int]
            NSLog("score_boardが読み込まれました。")
            print(score_board)
            Player_score_1.text = String(score_board[0])
            let score_board_count = score_board.count - 1
            if (score_board_count == 1){
                Player_score_2.text = String(score_board[score_board_count])
                if (member == 2){end()}
            }else if(score_board_count == 2){
                Player_score_3.text = String(score_board[score_board_count])
                if (member == 3){end()}
            }else if(score_board_count == 3){
                Player_score_4.text = String(score_board[score_board_count])
                end()
            }
        }
    }
    
    func winner_sort(_ score_bored:[Int],member:Int)->[Int]{
        var provisional_winner_score:Int = -1
        var provisional_winner:[Int] = []
        var i:Int = 0
        while (i < member){
            if (provisional_winner_score < score_board[i]){
                provisional_winner_score = score_board[i]
                provisional_winner.removeAll()
                provisional_winner.append(i)
            }else if (provisional_winner_score == score_board[i]){
                provisional_winner.append(i)
            }
            i = i + 1
        }
        return provisional_winner
    }
    
    func end(){
        winner =  winner_sort(score_board,member: member)
        var winner_display:String = String(winner![0]+1)
        var i:Int = 1
        while (i < winner!.count){
            winner_display += "番と" + String(winner![i]+1)
            i = i + 1
        }
        let alert2 = UIAlertController(title:"終了！",
            message: "\(winner_display)番のプレイヤーの勝利です！",
            preferredStyle: UIAlertControllerStyle.alert)
        alert2.addAction(
            UIAlertAction(
                title:"OK",
                style: UIAlertActionStyle.default,
                handler: {action in
                    NSLog("OK")
                    self.next.isEnabled = false
                }
            )
        )
        present(alert2, animated: true, completion: nil)
    }
    
    @IBAction func end_game(){
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func next_game(){
        if (scoreDate.object(forKey: "pro") as! Bool? == nil){
            scoreDate.set(false, forKey:"pro")
        }
        if (scoreDate.object(forKey: "pro")! as! Bool == true){
                performSegue(withIdentifier: "prosegue", sender: self)
        }else{
                performSegue(withIdentifier: "gamesegue", sender: self)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
