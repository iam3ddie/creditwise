//
//  NSAttributedString+Concatenate.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/06.
//

import Foundation

func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
{
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}
