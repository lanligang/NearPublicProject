//
//  HomeTopHeaderView.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class HomeTopHeaderView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

	open var changeHeightBlock:((_ height:CGFloat)->Void)?
	open var didClickedBlock:((_ index:Int)->Void)?

	private var headerHeight:CGFloat!

	private let rowHeight = 130.f_pt

	private let item_space = 10.f_pt
	private let row_itemCount:Int = 5
	let homeTopCollectionReuserKey = "HomeTopHeaderView_tag"
	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.minimumLineSpacing = item_space
		flowLayout.minimumInteritemSpacing = item_space
		flowLayout.sectionInset = UIEdgeInsets(top: item_space, left: item_space, bottom: item_space, right: item_space)
		let clV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		clV.register(HomeTopItemCell.self, forCellWithReuseIdentifier: homeTopCollectionReuserKey)
		clV.isScrollEnabled = false
		clV.backgroundColor = .white
		return clV
	}()

	lazy var topView: UIView = {
		let v = UIView()
		v.backgroundColor = .hexInt(0x3c74f1)
		addSubview(v)
		v.clipsToBounds = true
		return v
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(collectionView)
		collectionView.delegate = self
		collectionView.dataSource = self
		//默认值
		headerHeight = navBarHeight

		topView.snp.makeConstraints { (make) in
			make.left.top.right.equalTo(0)
			make.height.equalTo(navBarHeight + 120.f_pt)
		}
		collectionView.snp.makeConstraints { (make) in
			make.left.right.equalTo(0)
			make.top.equalTo(topView.snp.bottom)
			make.height.equalTo(0)
		}

		let titles = ["扫一扫", "付钱", "收钱", "卡包"]
		let imgNames = ["qr_scan", "fuqian", "shouqian", "kabao"]
		let item_w = screen_width / CGFloat(titles.count)
		for i in 0..<titles.count {
			let btn = TopButton(type: .custom)
			btn.addTarget(self, action: #selector(itemDidClicked), for: .touchUpInside)
			topView.addSubview(btn)
			btn.img.image = UIImage(named: imgNames[i])
			btn.title.text = titles[i]
			btn.contentHorizontalAlignment = .center
			btn.contentVerticalAlignment = .top
			btn.titleLabel?.font = .systemFont(ofSize: 20.f_pt)
			btn.setTitleColor(.white, for: .normal)
			btn.frame = CGRect(x: item_w * CGFloat(i) , y: navBarHeight, width: item_w, height: 100.f_pt)
		}

		let searchView = UIView()
		searchView.backgroundColor = .white
		searchView.layer.cornerRadius = 30.0/2.0
		searchView.clipsToBounds = true
		addSubview(searchView)
		let searchTitle = UILabel()
		searchTitle.text = "盯！请输入你想想法……"
		searchTitle.textColor = .hexInt(0x888888)
		searchTitle.font = .systemFont(ofSize: 28.f_pt)
		searchView.addSubview(searchTitle)
		searchView.snp.makeConstraints { (make) in
			make.top.equalTo(statusHeight + 10.f_pt)
			make.left.equalTo(50.f_pt)
			make.right.equalTo(-50.f_pt)
			make.height.equalTo(30)
		}
		searchTitle.snp.makeConstraints { (make) in
			make.centerY.equalToSuperview()
			make.left.equalTo(30.f_pt)
			make.top.bottom.equalTo(0)
		}


	}

	@objc func itemDidClicked(){
		//按钮 点击效果
	}

	var dataSource:[Any]? {
		didSet{
			let count = (self.dataSource?.count ?? 0)
			let row = count / row_itemCount + ((count % row_itemCount > 0) ? 1 : 0)
			let height = CGFloat(row) * rowHeight + (CGFloat(row) - 1 ) * item_space + item_space * 2.0
			collectionView.snp.updateConstraints { (make) in
				make.height.equalTo(height)
			}
			collectionView.reloadData()
			changeHeightBlock?(height + navBarHeight + 120.f_pt)
		}
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func scrollDidChangeOffSet(_ offSetY:CGFloat)  {
		topView.subviews.forEach { (view) in
			view.frame.origin.y = min(-offSetY * 0.4 + navBarHeight, navBarHeight + 100.f_pt)
		}
	}
}

//TODO : 协议方法
extension HomeTopHeaderView {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.dataSource?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	   let item = collectionView.dequeueReusableCell(withReuseIdentifier: homeTopCollectionReuserKey, for: indexPath) as! HomeTopItemCell
		if let model:MineModel = dataSource?[indexPath.row] as? MineModel {
			item.titleLable.text = model.title
			item.iconImgV.image = UIImage(named: model.iconName ?? "")
		}
		return item
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (screen_width - item_space * CGFloat(row_itemCount  + 1))/CGFloat(row_itemCount)

		return CGSize(width: width, height: self.rowHeight)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		didClickedBlock?(indexPath.row)
	}

}

class HomeTopItemCell : UICollectionViewCell {

	lazy var titleLable: UILabel = {
		let l = UILabel()
		l.font = .systemFont(ofSize: 26.f_pt)
		l.textAlignment = .center
		l.text =  "实际情况"
		return l
	}()

	lazy var iconImgV: UIImageView = {
		let imgV = UIImageView()
		return imgV
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		contentView.addSubview(iconImgV)
		contentView.addSubview(titleLable)
		iconImgV.snp.makeConstraints { (make) in
			make.top.equalTo(10.f_pt)
			make.width.equalTo(50.f_pt)
			make.height.equalTo(50.f_pt)
			make.centerX.equalToSuperview()
		}

		titleLable.snp.makeConstraints { (make) in
			make.top.equalTo(iconImgV.snp_bottom).offset(10.f_pt)
			make.height.equalTo(20)
			make.centerX.equalToSuperview()
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


class TopButton: UIButton {
	let img:UIImageView = UIImageView()
	let title:UILabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(img)
		addSubview(title)
		title.textAlignment = .center
		title.font = .systemFont(ofSize: 26.f_pt)
		title.textColor = .white
		img.snp.makeConstraints { (make) in
			make.centerX.equalToSuperview()
			make.top.equalTo(10.f_pt)
			make.size.equalTo(CGSize(width: 40.f_pt, height: 40.f_pt))
		}

		title.snp.makeConstraints { (make) in
			make.top.equalTo(img.snp_bottom).offset(15.f_pt)
			make.height.equalTo(30.f_pt)
			make.centerX.equalToSuperview()
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}





