//
//  UIColor_Tool.swift
//  SwiftDemo
//
//  Created by flower on 2021/12/24.
//

import Foundation
import UIKit

extension UIColor {
    
    /// 根据RGB返回UIColor
    /// - Parameters:
    ///   - red: 红
    ///   - green: 绿
    ///   - blue: 篮
    ///   - alpha: 透明度
    /// - Returns: 返回UIColor
    static func lj_rgba(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha);
    }
    
    /// 随机颜色
    static var lj_randomColor: UIColor {
        let red = CGFloat(arc4random_uniform(256))
        let green = CGFloat(arc4random_uniform(256))
        let blue = CGFloat(arc4random_uniform(256))
        return UIColor.lj_rgba(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

extension UIColor {
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
         
        let multiplier = CGFloat(255.999999)
         
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
         
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}


// MARK: 通过16进制初始化UIColor
/**
 ** 用法如下：**
 let colorR = UIColor(hexStr: "0xf00f")
 let colorG = UIColor(hexStr: "0X0f0f")
 let colorB = UIColor(hexStr: "#0fff")

 let colorRR = UIColor(hexStr: "0xff0000ff")
 let colorGG = UIColor(hexStr: "0X00ff00ff")
 let colorBB = UIColor(hexStr: "#0000ffff")

 let colorRN = UIColor(hexNum: 0xf00f)
 let colorGN = UIColor(hexNum: 0x00ff00)
 let colorBN = UIColor(hexNum: 0x0000ff)
 */
extension UIColor {
    
    convenience init?(lj_hexNum: Int) {
        self.init(lj_hexStr: String(lj_hexNum, radix: 16))
    }
    
    convenience init?(lj_hexStr: String?) {
        guard let tempStr = lj_hexStr else {
            return nil
        }
        var hex = tempStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        if hex.hasPrefix("0x") || hex.hasPrefix(("0X")) {
            hex.removeSubrange((hex.startIndex ..< hex.index(hex.startIndex, offsetBy: 2)))
        }
        
        guard let hexNum = Int(hex, radix: 16) else {
            self.init()
            return nil
        }
        switch hex.count {
        case 3:
            self.init(red: CGFloat(((hexNum & 0xF00) >> 8).duplicate4bits) / 255.0,
                      green: CGFloat(((hexNum & 0x0F0) >> 4).duplicate4bits) / 255.0,
                      blue: CGFloat((hexNum & 0x00F).duplicate4bits) / 255.0,
                      alpha: 1.0)
        case 4:
            self.init(red: CGFloat(((hexNum & 0xF000) >> 12).duplicate4bits) / 255.0,
                      green: CGFloat(((hexNum & 0x0F00) >> 8).duplicate4bits) / 255.0,
                      blue: CGFloat(((hexNum & 0x00F0) >> 4).duplicate4bits) / 255.0,
                      alpha: CGFloat((hexNum & 0x000F).duplicate4bits) / 255.0)
        case 6:
            self.init(red: CGFloat((hexNum & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((hexNum & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat((hexNum & 0x0000FF) >> 0) / 255.0,
                      alpha: 1.0)
        case 8:
            self.init(red: CGFloat((hexNum & 0xFF000000) >> 24) / 255.0,
                      green: CGFloat((hexNum & 0x00FF0000) >> 16) / 255.0,
                      blue: CGFloat((hexNum & 0x0000FF00) >> 8) / 255.0,
                      alpha: CGFloat(hexNum & 0x000000FF) / 255.0)
        default:
            self.init()
            return nil
        }
    }
    
}

private extension Int {
    var duplicate4bits: Int {
        return self << 4 + self
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
