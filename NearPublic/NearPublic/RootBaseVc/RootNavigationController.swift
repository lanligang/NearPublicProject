//
//  RootNavigationController.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController,UINavigationControllerDelegate,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		setValue(NavBar(), forKey: "navigationBar")
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 32.f_pt),NSAttributedString.Key.foregroundColor:UIColor.hexInt(0xffffff)]
		self.interactivePopGestureRecognizer?.delegate = self
		self.delegate = self
    }

	//TODO: 侧滑返回手势 -----
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		if viewControllers.count == 1 {
			return false
		}
		return true
	}
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
	}
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
	//TODO: 覆盖使用 --
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		if viewControllers.count == 1 {
			viewController.hidesBottomBarWhenPushed = true
		}
		super.pushViewController(viewController, animated: animated)
	}
}
