//
//  DetailViewController.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/9.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .red
		_backItem() //设置返回按钮
		navView.isHidden = false //设置导航
		navigationItem.title = "详细情况"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
