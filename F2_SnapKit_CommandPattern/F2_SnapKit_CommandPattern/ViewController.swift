//
//  ViewController.swift
//  F2_SnapKit_CommandPattern
//
//  Created by Smart on 2025/8/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let red = UIView()
        red.backgroundColor = .red
        view.addSubview(red)
        
        red.sl_makeConstraints { maker in
            maker.left.equalTo(self.view).offset(20)
            maker.top.equalTo(self.view).offset(200)
            maker.width.equalTo(120)
            maker.height.equalTo(200)
        }
    }
}

