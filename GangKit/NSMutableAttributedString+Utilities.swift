// The MIT License (MIT)
//
// Copyright (c) 2015 you & the gang UG(haftungsbeschränkt)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


import UIKit

//infix operator += {associativity left precedence 140}
public func += (left: inout NSMutableAttributedString, right: String) {
    
    left.append(NSAttributedString(string: right))
}

public extension NSMutableAttributedString {
    
    public func setFont(_ font: UIFont) {
        self.setFont(font, subString:self.string)
    }
    
    public func setFont(_ font: UIFont, subString:String) {
        let range = (self.string as NSString).range(of: subString)
        self.addAttribute(NSFontAttributeName, value: font, range: range)
    }

    public func setColor(_ color: UIColor) {
        self.setColor(color, subString: self.string)
    }
    
    public func setColor(_ color: UIColor, subString:String) {
        let range = (self.string as NSString).range(of: subString)
        self.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
    }
    
    public func setAlignment(_ alignment:NSTextAlignment) {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = alignment
        let range = (self.string as NSString).range(of: self.string)
        self.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: range)
    }

    public func setLinespacing(_ spacing: CGFloat = 0) {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing

        self.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, self.length))
    }
    
    public func underline(subString string: String) {
        
        let range = (self.string as NSString).range(of: string)
        self.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
    }
    
}
