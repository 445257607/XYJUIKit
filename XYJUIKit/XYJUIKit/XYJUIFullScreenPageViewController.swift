//
//  XYJUIFullScreenPageViewController.swift
//  XYJUIKit
//
//  Created by 肖迎军 on 2021/2/24.
//

import UIKit

/*
 建立在UIViewController基础上的全屏页面。
 包括页眉\页脚\全屏内容\安全区内容的控制
 */
open class XYJUIFullScreenPageViewController: UIViewController {
    
    // MARK: - 页眉
    
    // MARK: 页眉是否隐藏
    open var isHeaderBarHidden: Bool = true {
        didSet {
            guard oldValue != isHeaderBarHidden else { return }
            headerBar?.isHidden = isHeaderBarHidden
            headerBarBackground?.isHidden = isHeaderBarHidden
            safeAreaView?.frame = safeArea
        }
    }
    
    // MARK: 页眉高度
    open var headerBarHeight: CGFloat = 44 {
        didSet {
            guard oldValue != headerBarHeight else { return }
            headerBar?.frame = headerBarFrame
            headerBarBackground?.frame = headerBarBackgroundFrame
            safeAreaView?.frame = safeArea
        }
    }

    // MARK: 页眉背景
    open var headerBarBackground: UIView? {
        didSet {
            guard oldValue != headerBarBackground else { return }
            oldValue?.removeFromSuperview()
            if headerBarBackground != nil {
                if headerBar != nil {
                    view.insertSubview(headerBarBackground!, belowSubview: headerBar!)
                }
                else {
                    view.addSubview(headerBarBackground!)
                }
                headerBarBackground?.frame = headerBarBackgroundFrame
                headerBarBackground?.isHidden = isHeaderBarHidden
            }
        }
    }
    
    // MARK: 页眉
    open var headerBar: UIView? {
        didSet {
            guard oldValue != headerBar else { return }
            oldValue?.removeFromSuperview()
            if headerBar != nil {
                if headerBarBackground != nil {
                    view.insertSubview(headerBar!, aboveSubview: headerBarBackground!)
                }
                else {
                    view.addSubview(headerBar!)
                }
                headerBar?.frame = headerBarFrame
                headerBar?.isHidden = isHeaderBarHidden
            }
        }
    }
    
    // MARK: 页眉框架
    open var headerBarBackgroundFrame: CGRect {
        if #available(iOS 11.0, *) {
            return CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.safeAreaInsets.top + headerBarHeight)
        } else if prefersStatusBarHidden {
            return CGRect(x: 0, y: 0, width: self.view.bounds.width, height: headerBarHeight)
        } else {
            return CGRect(x: 0, y: 0, width: self.view.bounds.width, height: headerBarHeight + UIApplication.shared.statusBarFrame.height)
        }
    }
    
    // MARK: 页眉框架
    open var headerBarFrame: CGRect {
        if #available(iOS 11.0, *) {
            return CGRect(x: self.view.safeAreaInsets.left, y: self.view.safeAreaInsets.top, width: self.view.bounds.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right, height: headerBarHeight)
        } else if prefersStatusBarHidden {
            return CGRect(x: 0, y: 0, width: self.view.bounds.width, height: headerBarHeight)
        } else {
            return CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.bounds.width, height: headerBarHeight)
        }
    }
    
    // MARK: - 页脚
    
    // MARK: 页脚是否隐藏
    open var isFooterBarHidden: Bool = true {
        didSet {
            guard oldValue != isFooterBarHidden else { return }
            footerBar?.isHidden = isFooterBarHidden
            footerBarBackground?.isHidden = isFooterBarHidden
            safeAreaView?.frame = safeArea
        }
    }
    
    // MARK: 页脚高度
    open var footerBarHeight: CGFloat = 44 {
        didSet {
            guard oldValue != footerBarHeight else { return }
            footerBar?.frame = footerBarFrame
            footerBarBackground?.frame = footerBarBackgroundFrame
            safeAreaView?.frame = safeArea
        }
    }

    // MARK: 页脚背景
    open var footerBarBackground: UIView? {
        didSet {
            guard oldValue != footerBarBackground else { return }
            oldValue?.removeFromSuperview()
            if footerBarBackground != nil {
                if footerBar != nil {
                    view.insertSubview(footerBarBackground!, belowSubview: footerBar!)
                }
                else {
                    view.addSubview(footerBarBackground!)
                }
                footerBarBackground?.frame = footerBarBackgroundFrame
                footerBarBackground?.isHidden = isFooterBarHidden
            }
        }
    }
    
    // MARK: 页脚
    open var footerBar: UIView? {
        didSet {
            guard oldValue != footerBar else { return }
            oldValue?.removeFromSuperview()
            if footerBar != nil {
                if footerBarBackground != nil {
                    view.insertSubview(footerBar!, aboveSubview: footerBarBackground!)
                }
                else {
                    view.addSubview(footerBar!)
                }
                footerBar?.frame = footerBarFrame
                footerBar?.isHidden = isFooterBarHidden
            }
        }
    }

    // MARK: 页脚背景框架
    open var footerBarBackgroundFrame: CGRect {
        if #available(iOS 11.0, *) {
            return CGRect(x: 0, y: view.bounds.height - view.safeAreaInsets.bottom - footerBarHeight, width: view.bounds.width, height: view.safeAreaInsets.bottom + footerBarHeight)
        } else {
            return CGRect(x: 0, y: view.bounds.height - footerBarHeight, width: view.bounds.width, height: footerBarHeight)
        }
    }
    
    // MARK: 页脚框架
    open var footerBarFrame: CGRect {
        if #available(iOS 11.0, *) {
            return CGRect(x: view.safeAreaInsets.left, y: view.bounds.height - view.safeAreaInsets.bottom - footerBarHeight, width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right, height: footerBarHeight)
        } else {
            return CGRect(x: 0, y: view.bounds.height - footerBarHeight, width: view.bounds.width, height: footerBarHeight)
        }
    }
    
    // MARK: - 内容
    open var contentView: UIView? {
        didSet {
            guard oldValue != contentView else { return }
            oldValue?.removeFromSuperview()
            if contentView != nil {
                view.insertSubview(contentView!, at: 0)
                contentView?.frame = view.bounds
            }
        }
    }
    
    // MARK: - 安全区视图
    
    open var safeAreaView: UIView? {
        didSet {
            guard oldValue != safeAreaView else { return }
            oldValue?.removeFromSuperview()
            if safeAreaView != nil {
                if contentView != nil {
                    view.insertSubview(safeAreaView!, aboveSubview: contentView!)
                }
                else {
                    view.insertSubview(contentView!, at: 0)
                }
                safeAreaView?.frame = safeArea
            }
        }
    }
    
    // MARK: 安全区框架
    open var safeArea: CGRect {
        var x1: CGFloat = 0
        var x2: CGFloat = view.bounds.width
        var y1: CGFloat = 0
        var y2: CGFloat = view.bounds.height
        if #available(iOS 11.0, *) {
            x1 += view.safeAreaInsets.left
            x2 -= view.safeAreaInsets.right
            if isHeaderBarHidden {
                y1 += view.safeAreaInsets.top
            }
            else {
                y1 = headerBarFrame.maxY
            }
            if isFooterBarHidden {
                y2 -= view.safeAreaInsets.bottom
            }
            else {
                y2 = footerBarFrame.minY
            }
            return CGRect(x: x1, y: y1, width: x2 - x1, height: y2 - y1)
        } else {
            if isHeaderBarHidden {
                if !prefersStatusBarHidden {
                    y1 = UIApplication.shared.statusBarFrame.maxY
                }
            } else {
                y1 = headerBarFrame.maxY
            }
            if !isFooterBarHidden {
                y2 = footerBarFrame.minY
            }
        }
        return CGRect(x: x1, y: y1, width: x2 - x1, height: y2 - y1)
    }
    
    // MARK: - 生命周期

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        headerBar?.frame = headerBarFrame
        headerBarBackground?.frame = headerBarBackgroundFrame
        footerBar?.frame = footerBarFrame
        footerBarBackground?.frame = footerBarBackgroundFrame
        contentView?.frame = view.bounds
        safeAreaView?.frame = safeArea
    }
    
    @available(iOS 11.0, *)
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        headerBar?.frame = headerBarFrame
        headerBarBackground?.frame = headerBarBackgroundFrame
        footerBar?.frame = footerBarFrame
        footerBarBackground?.frame = footerBarBackgroundFrame
        contentView?.frame = view.bounds
        safeAreaView?.frame = safeArea
    }
    
}
