//
//  ViewController.swift
//  uikit_sample
//
//  Created by TshujiTakayuki on 2025/04/13.
//

import UIKit

class ViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    
        let label = UILabel()
        label.text = "Hello UIKit in iOS 12"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let btn = UIButton(type:.system)
        btn.setTitle("作業を開始する", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .black
        btn.frame = CGRect(x:330,y:600,width:100,height:100)
        btn.layer.cornerRadius = 30 //場所と大きさ
        btn.alpha = 5
        btn.addTarget(self, action: #selector(Btnobjtap), for: .touchUpInside)
        
        view.addSubview(btn)
        view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    @objc func Btnobjtap() {
        let alt = UIAlertController(title: "ポップアップ", message: "作業を開始しますか？", preferredStyle: .alert)
        let innerButton = UIAlertAction(title: "開始", style: .default){ _ in
            let secoundC = SecoundViewController()
            self.navigationController?.pushViewController(secoundC, animated: true)
        }
        let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alt.addAction(innerButton)
        alt.addAction(cancelButton)
        
        present(alt, animated: true, completion: nil)
    }
}
