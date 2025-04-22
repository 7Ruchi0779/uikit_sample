//
//  ResultViewController.swift
//  uikit_sample
//
//  Created by TshujiTakayuki on 2025/04/22.
//

import UIKit

class ResultViewController: UIViewController {
    var passedTime: TimeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let time = passedTime {
            print("受け取った時間: \(time.hour), \(time.minutes), \(time.secound)")
        }
    }
}
