# CyLeftMenuController
> CyLeftMenuController 插件代码使用OC编写，内部创建和使用使用Swift 编写 。主要检查在swift 中的效果如何，此工程内容仅供参考。

> 当前版本 '1.0.0'

* 使用 pod 方便导入

> pod 'CyLeftMenuController'

* 创建方法 swift 
```
let rootVc = CyLeftMenuController.leftController(leftVc, andMainController: vc,andLeftMaxWidth: UIScreen.main.bounds.width * 0.8)
window?.rootViewController = rootVc

// mainController  和 leftController 都要实现 CyMenuControllerProtocol 协议

extension UIViewController : CyMenuControllerProtocol {
	//CyMenuControllerProtocol 协议返回控制器
	public func controller() -> UIViewController {
		return self
	}
}

```
* 如何从left 和 main 打开 可关闭
```
……
	func openCloseCallBack(_ callBack: @escaping (Bool) -> Void) {
		openCallBack = callBack //可以执行回调协议
	}

	openCallBack?(true) //打开
	openCallBack?(false)//关闭
……

```

* 如何设置当前是否允许开启
```
//是否允许打开 如果设置 true 为 开启 如果为 false 则 不能够侧滑展开
func isCanBegainMove() -> Bool {
	return true
}
```

* OC 使用方法

```
//构建方法
+(instancetype)leftController:(id <CyMenuControllerProtocol>)left
			andMainController:(id <CyMenuControllerProtocol>)main
			  andLeftMaxWidth:(CGFloat)maxWidth;

-(instancetype)initWithLeftController:(id<CyMenuControllerProtocol>)left
					andMainController:(id<CyMenuControllerProtocol>)main
					  andLeftMaxWidth:(CGFloat)maxWidth;
```

* 协议方法以及说明
```

@required

-(UIViewController *)controller; //获取控制器

@optional
//是否开启的回调
-(void)openCloseCallBack:(void(^)(BOOL isOpen))callBack;

/** 将要展开 -> 已经展开 -> 将要关闭 -> 已经关闭  */
-(void)viewWillOpen;  //将要打开
-(void)viewDidOpen;    //已经打开

-(void)viewWillClose;  //视图将要关闭
-(void)viewDidClose;   //视图已经关闭

//是否允许开始移动 例如我们的tabbar 只有点击第一个的时候才能用
-(BOOL)isCanBegainMove;
```




