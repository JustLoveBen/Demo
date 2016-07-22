//: Playground - noun: a place where people can play

import UIKit

var regex = "((((\\+)|(00))?[- ]?\\d{1,9})[- ]?)?[0-9 \\-]{5,26}"
var str = "00 86 18301022300"
var str1 = "00 86 21 12345678"
var str2 = "+86 183-0102-2300"
var str3 = "0318 4351269"
var str4 = "+86 132 9999 9999"

var predicate = NSPredicate(format: "SELF MATCHES %@", regex)
if predicate.evaluateWithObject(str4) {
    print("OK")
} else {
    print("NO")
}
