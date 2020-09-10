//
//  RootTabBarController.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
	weak var leftSweepObject:CyMenuControllerProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
		var temp = [RootNavigationController]()
		let titles = ["精选","有啥","吃啥"]
		let iconImgNames = ["shouye2_btn_icon","renw2_btn_icon","wode_kongx2_btn_icon"]
		let iconSeletedNames = ["home_btn_icon","home_btn_icon","home_btn_icon"]

		let rootClass = [HomeViewController.self,
						 HaveViewController.self,
						 EatViewController.self]

		for i in 0..<3 {
			let viewController = rootClass[i].init()
			if i == 0 {
				leftSweepObject = viewController //纪律第一个
			}
			let rootVC = RootNavigationController(rootViewController: viewController)
			let barItem = UITabBarItem()
			barItem.title = titles[i]
			barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.hexInt(0x888888)], for: .normal)
			barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.hexInt(0x333333)], for: .selected)
			barItem.image = UIImage(named: iconImgNames[i])?.withRenderingMode(.alwaysOriginal)
			barItem.selectedImage = UIImage(named: iconSeletedNames[i])?.withRenderingMode(.alwaysOriginal)
			rootVC.tabBarItem = barItem as UITabBarItem
			temp.append(rootVC)
		}

		self.viewControllers = temp
		self.selectedIndex = 0
		view.backgroundColor = .white
		self.tabBar.isTranslucent = false
		self.tabBar.backgroundColor = .white

		if #available(iOS 13.0, *) {
			//处理tabbar  ios13 以后 顶部黑线
			let tabBarAppearance = UITabBarAppearance()
			tabBarAppearance.backgroundImage = UIImage()
			tabBarAppearance.shadowImage = UIImage()
			tabBarAppearance.shadowColor = .clear
			tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.hexInt(0x888888)]
			tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.hexInt(0x333333)]
			tabBarAppearance.backgroundColor = .white
			self.tabBar.standardAppearance = tabBarAppearance
		}else{
			self.tabBar.backgroundImage = UIImage()
			self.tabBar.shadowImage = UIImage()
		}
    }



	// 协议方法 - 从大的布局中调用内部部件 --
	func openCloseCallBack(_ callBack: @escaping (Bool) -> Void) {
		leftSweepObject?.openCloseCallBack?(callBack)
	}

	func isCanBegainMove() -> Bool {
		var isCanMove = false
		if selectedIndex == 0 { //如果 不是选的第一个 如果导航 首页 push 到其他页面 都无法打开左侧
			let rootVc:RootNavigationController? = viewControllers?[selectedIndex] as? RootNavigationController
			if rootVc != nil {
				isCanMove = rootVc!.viewControllers.count > 1 ? false : true
			}
		}
		return isCanMove
	}

	//协议方法 - 左侧发送给右侧 的方法
	func sendActionMessage(message: Any?, tag: Int) {
		let home:SendActionProtocol? = self.leftSweepObject as? SendActionProtocol
		home?.sendActionMessage?(message: message, tag: tag) //将信息转发给第一个页面
	}

}
