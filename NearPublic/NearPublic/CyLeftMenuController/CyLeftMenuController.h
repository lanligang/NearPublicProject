//
//  CyLeftMenuController.h
//  SwiftDemo
//
//  Created by ios2 on 2020/9/7.
//  Copyright © 2020 lg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CyMenuControllerProtocol <NSObject>

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


@end


/**
 *  如果在地图 或者有横向滑动的View 中使用建议 将 View 上添加一个 宽度 为 15的 View 即可
 *  x = 0 y = 0 height = SCREENHEIGHT  width = 15
 *
 */
@interface CyLeftMenuController : UIViewController

//构建方法
+(instancetype)leftController:(id <CyMenuControllerProtocol>)left
			andMainController:(id <CyMenuControllerProtocol>)main
			  andLeftMaxWidth:(CGFloat)maxWidth;

-(instancetype)initWithLeftController:(id<CyMenuControllerProtocol>)left
					andMainController:(id<CyMenuControllerProtocol>)main
					  andLeftMaxWidth:(CGFloat)maxWidth;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

@end


NS_ASSUME_NONNULL_END
