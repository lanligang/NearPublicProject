//
//  MineViewController.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

	open weak var delegate:SendActionProtocol?

	//此处参数主要用于展开和闭合
	var leftOpenCloseCallBack:((_ isOpen:Bool)->Void)?
	var heightCache = [IndexPath:CGFloat]()
	let headerReuserIdentifier = "MineHeaderCell_tag"
	let mineActionIdentifier = "MineArrowCell_tag"
	let titles = ["美食诱惑","运动健身","山水达人","绘画","练字","海滩度假","飞机旅行","设置"]
	let icons = ["chihaochide","dadalanqiu","dengshanma","huahua","lianshufa","quhaidaowan","shangtian","fbrw_szxq_icon"]
	var dataSource = Array<MineModel>()

	lazy var tableView: UITableView = {
		let tbV = UITableView(frame: .zero, style: .grouped)
		tbV.register(MineHeaderCell.self, forCellReuseIdentifier: headerReuserIdentifier)
		tbV.register(MineArrowCell.self, forCellReuseIdentifier: mineActionIdentifier)
		tbV.separatorStyle = .none
		tbV.backgroundColor = .hexInt(0xffffff)
		return tbV
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		if #available(iOS 11.0, *) {
			tableView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		tableView.snp.makeConstraints { (make) in
			make.left.top.equalTo(0)
			make.width.equalTo(view).multipliedBy(0.8)
			make.bottom.equalTo(0)
			//make.bottom.equalTo(-tabbarHeight + 49.0)
		}
		//构造数据
		configerDataSource()
    }
	//构造数据
	func configerDataSource() {
		dataSource.removeAll()
		for i in 0..<titles.count {
			dataSource.append(MineModel.mineModel(title: titles[i], iconName: icons[i]))
		}
		//刷新表
		tableView.reloadData()
	}
	func openCloseCallBack(_ callBack: @escaping (Bool) -> Void) {
		leftOpenCloseCallBack = callBack
	}
}

//TODO: 协议方法
extension MineViewController {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (section == 1) ? dataSource.count : 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let headerCell =	tableView.dequeueReusableCell(withIdentifier: (indexPath.section == 0) ? headerReuserIdentifier : mineActionIdentifier , for: indexPath)
		if indexPath.section == 1 {
			let itemCell = headerCell as! MineArrowCell
			itemCell.minemMdel = dataSource[indexPath.row]
		}
		headerCell.selectionStyle = .none
		return headerCell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return heightCache[indexPath] ?? 44.0
	}
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		heightCache[indexPath] = cell.frame.height
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return CGFloat.leastNormalMagnitude
	}

	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return CGFloat.leastNormalMagnitude
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return nil
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		leftOpenCloseCallBack?(false)
		delegate?.sendActionMessage?(message: titles[indexPath.row], tag: indexPath.row)
	}

	//左侧展开的协议 -----
	func viewWillOpen() {
		//更新数据
		print("将要打开")
	}
	func viewDidOpen() {
		//已经打开
		print("已经打开")
	}
	func viewWillClose() {
		print("将要关闭")
	}
	func viewDidClose() {
		print("已经关闭")
	}
	
}



