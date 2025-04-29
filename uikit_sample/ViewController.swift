//
//  ViewController.swift
//  uikit_sample
//
//  Created by TshujiTakayuki on 2025/04/13.
//

import UIKit


class ViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    var stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let btn = UIButton(type:.system)
        btn.setTitle("作業を開始する", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .black
        btn.frame = CGRect(x:330,y:600,width:100,height:100)
        btn.layer.cornerRadius = 30 //場所と大きさ
        btn.alpha = 5
        btn.addTarget(self, action: #selector(Btnobjtap), for: .touchUpInside)
        
        view.addSubview(btn)
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 40),
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDisplay()
    }
    func updateDisplay() {
        for subview in stackView.arrangedSubviews{
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        let timeDateList = loadSavedTimeDate()
        let latestTime = Array(timeDateList.prefix(4))
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute]
        formatter.unitsStyle = .short
        
        for date in latestTime {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = .gray
            
            let duration = formatter.string(from: date.duration) ?? "?"
            label.text = "\(date.taskName):\(duration)"
            stackView.addArrangedSubview(label)
        }
    }
    @objc func Btnobjtap() {
        let alt = UIAlertController(title: "確認", message: "作業を開始しますか？", preferredStyle: .alert)
        let innerButton = UIAlertAction(title: "開始", style: .default){ _ in
            let secoundC = SecoundViewController()
            self.navigationController?.pushViewController(secoundC, animated: true)
        }
        let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alt.addAction(innerButton)
        alt.addAction(cancelButton)
        
        present(alt, animated: true, completion: nil)
    }
    func loadSavedTimeDate() -> [TimeData]{
        if let date = UserDefaults.standard.data(forKey: "timeDataList") {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let saved = try? decoder.decode([TimeData].self, from: date){
                return saved
            }
        }
        return []
    }
}
