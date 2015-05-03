//
//  NSDate+SwiftUtils.swift
//  SwiftDateUtils
//
//  Created by Morgan Harris on 6/06/2014.
//  Copyright (c) 2014 Morgan Harris. All rights reserved.
//

import Foundation

let formatter: NSDateFormatter = NSDateFormatter()

extension NSDate {
    
    public func format(s:String) -> String {
        formatter.dateFormat = s
        return formatter.stringFromDate(self)
    }
    
    public func format(date: NSDateFormatterStyle = .NoStyle, time: NSDateFormatterStyle = .NoStyle) -> String {
        formatter.dateFormat = nil;
        formatter.timeStyle = time;
        formatter.dateStyle = date;
        return formatter.stringFromDate(self)
    }
    
    /**
    Returns a new NSDate object representing the absolute time calculated by adding given components to the passed date.
    
    :param: components Date components.
    
    :returns: Date by adding cumponents, otherwise pased date.
    */

    func add(components: NSDateComponents) -> NSDate {
        let cal = NSCalendar.currentCalendar()
        if let sum = cal.dateByAddingComponents(components, toDate: self, options: nil) {
            return sum
        }
        return self
    }
    
    func add(years: NSInteger = 0, months: NSInteger = 0, weeks:NSInteger = 0, days: NSInteger = 0, hours: NSInteger = 0, minutes: NSInteger = 0, seconds: NSInteger = 0) -> NSDate {
        var components = NSDateComponents()
        components.year = years
        components.month = months
        components.weekOfYear = weeks
        components.day = days
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        
        return self.add(components)
    }
    
    func subtract(years: NSInteger = 0, months: NSInteger = 0, weeks:NSInteger = 0, days: NSInteger = 0, hours: NSInteger = 0, minutes: NSInteger = 0, seconds: NSInteger = 0) -> NSDate {
        return self.add(years:-years, months:-months, weeks:-weeks, days:-days, hours:-hours, minutes:-minutes, seconds:-seconds)
    }
    
    func subtract(components: NSDateComponents) -> NSDate {
        
        func negateIfNeeded(i: NSInteger) -> NSInteger {
            if UInt(i) == NSDateComponentUndefined {
                return i
            }
            return -i
        }
        
        components.year         = negateIfNeeded(components.year)
        components.month        = negateIfNeeded(components.month)
        components.weekOfYear   = negateIfNeeded(components.weekOfYear)
        components.day          = negateIfNeeded(components.day)
        components.hour         = negateIfNeeded(components.hour)
        components.minute       = negateIfNeeded(components.minute)
        components.second       = negateIfNeeded(components.second)
        components.nanosecond   = negateIfNeeded(components.nanosecond)
        return self.add(components)
    }
}

public func + (left: NSDate, right:NSTimeInterval) -> NSDate {
    return left.dateByAddingTimeInterval(right)
}

public func + (left: NSDate, right:NSDateComponents) -> NSDate {
    return left.add(right);
}

public func - (left: NSDate, right:NSTimeInterval) -> NSDate {
    return left.dateByAddingTimeInterval(-right)
}

public func - (left: NSDate, right:NSDateComponents) -> NSDate {
    return left.subtract(right);
}

extension Int {

    public func seconds() -> NSDateComponents {
        var components = NSDateComponents()
        components.second = self
        return components
    }
    
    public func minutes() -> NSDateComponents {
        var components = NSDateComponents()
        components.minute = self
        return components
    }
    
    public func hour() -> NSDateComponents {
        var components = NSDateComponents()
        components.hour = self
        return components
    }
    
    public func days() -> NSDateComponents {
        var components = NSDateComponents()
        components.day = self
        return components
    }
    
    public func weeks() -> NSDateComponents {
        var components = NSDateComponents()
        components.weekOfYear = self
        return components
    }
    
    public func month() -> NSDateComponents {
        var components = NSDateComponents()
        components.month = self
        return components
    }
    
    public func years() -> NSDateComponents {
        var components = NSDateComponents()
        components.year = self
        return components
    }
    
}

public func + (left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
    func addIfPossible(left: NSInteger, right:NSInteger) -> NSInteger {
        if UInt(left) == NSDateComponentUndefined && UInt(right) == NSDateComponentUndefined {
            return 0
        }
        if UInt(left) == NSDateComponentUndefined {
            return right
        }
        if UInt(right) == NSDateComponentUndefined {
            return left
        }
        return left + right
    }
    
    var components = NSDateComponents()
    components.year         = addIfPossible(left.year, right.year)
    components.month        = addIfPossible(left.month, right.month)
    components.weekOfYear   = addIfPossible(left.weekOfYear, right.weekOfYear)
    components.day          = addIfPossible(left.day, right.day)
    components.hour         = addIfPossible(left.hour, right.hour)
    components.minute       = addIfPossible(left.minute, right.minute)
    components.second       = addIfPossible(left.second, right.second)
    components.nanosecond   = addIfPossible(left.nanosecond, right.nanosecond)

    return components
    
}
