//
//  SecoundViewController.swift
//  uikit_sample
//
//  Created by TshujiTakayuki on 2025/04/20.
//

import UIKit

class SecoundViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "SecoundScreen"
        
        let backbutton = UIButton(type: .system)
        backbutton.setTitle("戻る", for: .normal)
        backbutton.setTitleColor(.blue, for: .normal)
        backbutton.backgroundColor = .black
        backbutton.frame = CGRect(x:330,y:600,width:100,height:100)
        backbutton.layer.cornerRadius = 30 //場所と大きさ
        backbutton.alpha = 5
        backbutton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backbutton)
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
