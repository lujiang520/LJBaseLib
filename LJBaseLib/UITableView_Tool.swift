//
//  UITableView_Tool.swift
//  SwiftDemo
//
//  Created by flower on 2021/12/24.
//

import Foundation
import UIKit

extension UITableView {
    
    /// 创建cell的时候写的一个分类(方便写cell)
    /// - Parameters:
    ///   - classT: 继承于UITableViewCell的类
    ///   - identifier: cell唯一标识
    ///   - style: cell类型
    ///   - initializeCell: 可以给cell做一些初始化
    /// - Returns: 返回cell
    func lj_DequeueReusableCell<T: UITableViewCell>(classT: T.Type, identifier: String, style: UITableViewCell.CellStyle = .default, initializeCell: ((_ initCell: T) -> ())?) -> T {
        guard let tempCell = self.dequeueReusableCell(withIdentifier: identifier),
              let lastCell = tempCell as? T else {
            let custCell = T(style: style, reuseIdentifier: identifier)
            if let tempInitializeCell = initializeCell {
                tempInitializeCell(custCell)
            }
            return custCell
        }
        return lastCell
    }
}
