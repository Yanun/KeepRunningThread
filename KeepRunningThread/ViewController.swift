//
//  ViewController.swift
//  KeepRunningThread
//
//  Created by 丁燕军 on 2023/12/8.
//

import UIKit

class ViewController: UIViewController {
    
    var longLiveThread: KeepRunningThread?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func start(_ sender: Any) {
        print(" 开启线程")
        longLiveThread = KeepRunningThread()
        longLiveThread?.start()
    }
    
    @IBAction func execute(_ sender: Any) {
        longLiveThread?.execute {
            print("执行任务", Int.random(in: 0..<10))
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        print(" 终止线程")
        longLiveThread?.stop()
        longLiveThread = nil
    }
    
}

