//
//  HomeViewController.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

	var openCallBack:((_ isOpen:Bool)->Void)?

	var heightCache = [IndexPath:CGFloat]()

	var dataSource = [MineModel]()
	var mj_header:MJRefreshHeader!

	let titles = ["美食诱惑","运动健身","山水达人","绘画","练字","海滩度假","飞机旅行"]
	let icons = ["chihaochide","dadalanqiu","dengshanma","huahua","lianshufa","quhaidaowan","shangtian"]

	lazy var mainScrollView: MainScrollView = {
		let scrollView = MainScrollView()
		scrollView.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height - tabbarHeight)
		view.addSubview(scrollView)
		return scrollView
	}()

	lazy var headerRefreshView: HomeTableHeaderView = {
		let v = HomeTableHeaderView()
		v.backgroundColor = .hexInt(0xfafafa)
		return v
	}()

	lazy var actionHeaderView: HomeTopHeaderView = {
		let v = HomeTopHeaderView()
		v.backgroundColor = .hexInt(0xfafafa)
		return v
	}()

	lazy var tableView: UITableView = {
		let tbv = UITableView(frame: CGRect.zero, style: .grouped)
		tbv.separatorStyle = .none
		tbv.backgroundColor = .hexInt(0xfafafa)
		tbv.register(HomeFoodCell.self, forCellReuseIdentifier: "cell")
		return tbv
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = ""
		view.backgroundColor = .hexInt(0xfafafa)
		if #available(iOS 11.0, *) {
			mainScrollView.contentInsetAdjustmentBehavior = .never
			tableView.contentInsetAdjustmentBehavior = .never
		}else{
			automaticallyAdjustsScrollViewInsets = false
		}
		mainScrollView.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		mainScrollView.addGestureRecognizer(tableView.panGestureRecognizer) //添加手势 ---
		headerRefreshView.frame = CGRect(x: 0, y: 0, width: screen_width, height: navBarHeight)
		tableView.tableHeaderView = headerRefreshView
		mainScrollView.addSubview(actionHeaderView)
		//添加上顶部的部分
		actionHeaderView.frame = CGRect(x: 0, y: 0, width: screen_width, height: navBarHeight)

		weak var weakSelf = self
		actionHeaderView.changeHeightBlock = { (height:CGFloat)->Void in
			weakSelf?.changeActionHeight(height: height)
		}

		mj_header =  MJRefreshHeader(refreshingTarget: self, refreshingAction: #selector(pullRefresh))
		mj_header.alpha = 0; //设置 mj 的下拉刷新为透明

		//kvo 监听 状态的变化 ---
		mj_header.addObserver(self, forKeyPath: "state", options: [.new,.old], context: nil)
		tableView.mj_header = mj_header

		dataSource.removeAll()

		for i in 0..<titles.count {
			dataSource.append(MineModel.mineModel(title: titles[i], iconName: icons[i]))
		}

		actionHeaderView.dataSource = dataSource
		actionHeaderView.didClickedBlock = {(index:Int) in
			weakSelf?.openCallBack?(true)
		}
		navView.isHidden = false
		navView.alpha = 0
		let userImgV = UIImageView()
		userImgV.layer.cornerRadius = 35/2.0
		userImgV.clipsToBounds = true
		userImgV.sd_setImage(with: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599739174107&di=02cf17ad3433b39bfef2954b8b11c671&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2018%2F0613%2F777CD76919E2510DF380FC834B774AD80F089912_size19_w414_h359.jpeg"), completed: nil)
		navView.addSubview(userImgV)
		userImgV.isUserInteractionEnabled = true
		userImgV.snp.makeConstraints { (make) in
			make.bottom.equalTo(-5)
			make.left.equalTo(15.f_pt)
			make.width.height.equalTo(35)
		}
		let tap = UITapGestureRecognizer(target: self, action: #selector(userImgOntap))
		userImgV.addGestureRecognizer(tap)
    }
	func changeActionHeight(height:CGFloat) {
		var rect = self.headerRefreshView.frame
		var topRect = self.actionHeaderView.frame
		rect.size.height = height
		topRect.size.height = height
		self.headerRefreshView.frame = rect
		tableView.beginUpdates()
		self.tableView.tableHeaderView = self.headerRefreshView
		tableView.endUpdates()
		self.actionHeaderView.frame = topRect
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		mainScrollView.frame = view.bounds
		mainScrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
		tableView.frame = mainScrollView.frame
	}

	@objc func userImgOntap(){
		openCallBack?(true)
	}

	@objc func pullRefresh(){
		//执行下拉刷新代码 …………
		weak var weakSelf = self
		GCD_After(time: 2) {
			weakSelf?.mj_header.endRefreshing()
		}
	}
	//左侧点击调用----
	func sendActionMessage(message: Any?, tag: Int) {
		print(message as! String)
	}
	deinit {
		mj_header.removeObserver(self, forKeyPath: "state")  //移除状态监听 只有 @objc 的 的属性可以进行 kvo
	}
	//状态监听回执
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "state" {
			self.headerRefreshView.mj_state = mj_header.state
		}else{
			super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
		}
	}
	func openCloseCallBack(_ callBack: @escaping (Bool) -> Void) {
		openCallBack = callBack //可以执行回调协议
	}
}

//MARK: 代理方法
extension HomeViewController {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let headerCell =	tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
		let vc = DetailViewController()
		navigationController?.pushViewController(vc, animated: true)
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		var rect =  actionHeaderView.frame
		rect.origin.y = min(-scrollView.contentOffset.y, 0)
		actionHeaderView.frame = rect
		let alpha  = -rect.origin.y / (100.f_pt)
		navView.alpha  = min(alpha, 1)
		actionHeaderView.scrollDidChangeOffSet(rect.origin.y)
		if navView.alpha > 0.6 {
			navigationItem.title = "精挑细选"
		}else{
			navigationItem.title = ""
		}
	}
}

//TODO : 构建指定的类
class MainScrollView: UIScrollView {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && gestureRecognizer.view!.isKind(of: UIScrollView.self)
	}
}

