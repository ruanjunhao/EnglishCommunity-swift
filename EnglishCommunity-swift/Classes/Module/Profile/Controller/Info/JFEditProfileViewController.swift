//
//  JFEditProfileViewController.swift
//  BaoKanIOS
//
//  Created by zhoujianfeng on 16/5/13.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFEditProfileViewController: JFBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "账号管理"
        
        let group1CellModel1 = JFProfileCellArrowModel(title: "修改资料", destinationVc: JFModifyInfoTableViewController.classForCoder())
        let group1CellModel2 = JFProfileCellArrowModel(title: "修改安全信息", destinationVc: JFModifySafeTableViewController.classForCoder())
        let group1 = JFProfileCellGroupModel(cells: [group1CellModel1, group1CellModel2])
        
        let group2CellModel1 = JFProfileCellLabelModel(title: "注册时间", text: JFAccountModel.shareAccount()!.registerTime!.timeStampToString())
        let group2CellModel2 = JFProfileCellLabelModel(title: "我的积分", text: "")
        let group2CellModel3 = JFProfileCellLabelModel(title: "我的等级", text: "")
        let group2 = JFProfileCellGroupModel(cells: [group2CellModel1, group2CellModel2, group2CellModel3])
        
        groupModels = [group1, group2]
        
        tableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        tableView.tableHeaderView = JFInfoHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 70))
    }
    
    private func prepareData() {
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 20
        } else {
            return 0.1
        }
    }
    
    /**
     退出登录点击
     */
    func didTappedLogoutButton(button: UIButton) -> Void {
        
        let alertC = UIAlertController(title: "确定注销登录状态？", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let action1 = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) in
            JFAccountModel.logout()
            JFProgressHUD.showSuccessWithStatus("退出成功")
            self.navigationController?.popViewControllerAnimated(true)
        }
        let action2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) in
            
        }
        alertC.addAction(action1)
        alertC.addAction(action2)
        presentViewController(alertC, animated: true) {}
    }
    
    // MARK: - 懒加载
    /// 尾部退出视图
    private lazy var footerView: UIView = {
        let logoutButton = UIButton(frame: CGRect(x: 20, y: 0, width: SCREEN_WIDTH - 40, height: 44))
        logoutButton.addTarget(self, action: #selector(didTappedLogoutButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        logoutButton.setTitle("退出登录", forState: UIControlState.Normal)
        logoutButton.backgroundColor = COLOR_NAV_BG
        logoutButton.layer.cornerRadius = CORNER_RADIUS
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        footerView.addSubview(logoutButton)
        return footerView
    }()
}
