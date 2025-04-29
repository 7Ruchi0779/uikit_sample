//
//  SecoundViewController.swift
//  uikit_sample
//
//  Created by TshujiTakayuki on 2025/04/20.
//

import UIKit

class SecoundViewController: UIViewController {
    var stattime:Date?
    var countLabel = UILabel()
    var time:Float = 0.0
    var timer = Timer()
    
    let stopbutton = UIButton(type: .system)
    let restartbutton = UIButton(type: .system)
    let finishbutton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "作業時間"
        stattime = Date()
        
        stopbutton.setTitle("停止", for: .normal)
        stopbutton.setTitleColor(.blue, for: .normal)
        stopbutton.backgroundColor = .yellow
        stopbutton.frame = CGRect(x:390,y:600,width:100,height:100)
        stopbutton.layer.cornerRadius = 30
        stopbutton.alpha = 5
        stopbutton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        
        restartbutton.setTitle("再開", for: .normal)
        restartbutton.setTitleColor(.black, for: .normal)
        restartbutton.backgroundColor = .blue
        restartbutton.frame = CGRect(x:390,y:600,width:100,height:100)
        restartbutton.layer.cornerRadius = 30
        restartbutton.alpha = 5
        restartbutton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        
        finishbutton.setTitle("終了", for: .normal)
        finishbutton.setTitleColor(.black, for: .normal)
        finishbutton.backgroundColor = .red
        finishbutton.frame = CGRect(x:260,y:600,width:100,height:100)
        finishbutton.layer.cornerRadius = 30
        finishbutton.alpha = 5
        finishbutton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
                
        countLabel.text = String(time)
        countLabel.font = .systemFont(ofSize: 20)
        countLabel.frame = CGRect(x:290,y:400,width:180,height:150)
        
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
            self.countLabel.text = String(format: "大体%02d時間%02d分%02d", hour,minutes,secound)
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
        guard let stat = stattime else { return }
        timer.invalidate()
        
        let alert = UIAlertController(title: "作業終了", message: "作業内容の入力", preferredStyle: .alert)
        alert.addTextField{ textField in
            textField.placeholder = "例：読書、開発など"
        }
        alert.addAction(UIAlertAction(title: "保存", style: .default, handler: { _ in
            let taskname = alert.textFields?.first?.text ?? "未設定"
            let end = Date()
            let timeDate = TimeData(taskName: taskname, starttime: stat, endtime: end)
            self.saveNewTimeDate(timeDate)
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        present(alert, animated: true)
    }
    func saveNewTimeDate(_ newDate:TimeData){
        var current = loadSaveTimeDate()
        current.insert(newDate, at: 0)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let encoded = try? encoder.encode(current){
            UserDefaults.standard.set(encoded, forKey: "timeDataList")
        }
    }
    
    func loadSaveTimeDate() -> [TimeData] {
        if let date = UserDefaults.standard.data(forKey: "timeDataList"){
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let saved = try? decoder.decode([TimeData].self, from: date){
                return saved
            }
        }
        return []
    }
}
