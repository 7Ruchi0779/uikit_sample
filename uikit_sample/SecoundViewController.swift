//
//  SecoundViewController.swift
//  uikit_sample
//
//  Created by TshujiTakayuki on 2025/04/20.
//

import UIKit

struct TimeData{
    let hour:Int
    let minutes:Int
    let secound:Int
}

class SecoundViewController: UIViewController {
    var countLabel = UILabel()
    var time:Float = 0.0
    var timer = Timer()
    
    let stopbutton = UIButton(type: .system)
    let restartbutton = UIButton(type: .system)
    let finishbutton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(time)
        view.backgroundColor = .cyan
        title = "SecoundScreen"
        
        stopbutton.setTitle("停止", for: .normal)
        stopbutton.setTitleColor(.blue, for: .normal)
        stopbutton.backgroundColor = .yellow
        stopbutton.frame = CGRect(x:450,y:600,width:100,height:100)
        stopbutton.layer.cornerRadius = 30
        stopbutton.alpha = 5
        stopbutton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        
        restartbutton.setTitle("再開", for: .normal)
        restartbutton.setTitleColor(.black, for: .normal)
        restartbutton.backgroundColor = .blue
        restartbutton.frame = CGRect(x:450,y:600,width:100,height:100)
        restartbutton.layer.cornerRadius = 30
        restartbutton.alpha = 5
        restartbutton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        
        finishbutton.setTitle("終了", for: .normal)
        finishbutton.setTitleColor(.black, for: .normal)
        finishbutton.backgroundColor = .red
        finishbutton.frame = CGRect(x:290,y:600,width:100,height:100)
        finishbutton.layer.cornerRadius = 30
        finishbutton.alpha = 5
        finishbutton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
                
        countLabel.frame = CGRect(x:330,y:450,width:100,height:100)
        
        view.addSubview(countLabel)
        view.addSubview(stopbutton)
        view.addSubview(restartbutton)
        view.addSubview(finishbutton)
        restartbutton.isHidden=true

        startTimer()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(timer) in
            self.time += 0.01
            let hour = Int(self.time / 3600)
            let minutes = Int(self.time / 60)
            let secound = Int(self.time) % 60
            //let milliSecond = Int(self.time * 100) % 100
            self.countLabel.text = String(format: "%02d%02d:%02d", hour,minutes,secound)
        })
    }
    @objc func stopButtonTapped() {
        stopbutton.isHidden=true
        restartbutton.isHidden=false
        timer.invalidate()
    }
    @objc func restartButtonTapped() {
        stopbutton.isHidden=false
        restartbutton.isHidden=true
        startTimer()
    }
    @objc func finishButtonTapped() {
        timer.invalidate()
        let hour = Int(self.time / 3600)
        let minutes = Int(self.time / 60)
        let secound = Int(self.time) % 60
        
        let timedata = TimeData(hour: hour, minutes: minutes, secound: secound)
        
        let Result = ResultViewController()
        Result.passedTime = timedata
        
        navigationController?.pushViewController(Result, animated: true)
    }
}
