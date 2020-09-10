//
//  BaseViewController.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
	lazy var navView: UIView = {
		let v  = UIView()
		v.frame = CGRect(x: 0, y: 0, width: screen_width, height: navBarHeight)
		v.backgroundColor = .hexInt(0x3c74f1)
		view.addSubview(v)
		v.isHidden = true
		return v
	}()
    override func viewDidLoad() {
        super.viewDidLoad()
		automaticallyAdjustsScrollViewInsets = false
		view.backgroundColor = .white
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		navView.frame = CGRect(x: 0, y: 0, width: screen_width, height: self.navigationController?.navigationBar.frame.maxY ?? navBarHeight)
		view.bringSubviewToFront(navView)
	}
	func _backItem()  {
		let barItem = UIBarButtonItem(image: UIImage(named: "all_fahuia_btn"), style: .plain, target: self, action: #selector(backBarClicked))
		navigationItem.leftBarButtonItems = [barItem]
		barItem.tintColor = .white
	}

	@objc func backBarClicked(){
		if (navigationController?.viewControllers.count ?? 0) > 1 {
			navigationController?.popViewController(animated: true)
		}else{
			dismiss(animated: true, completion: nil)
		}
	}
}
