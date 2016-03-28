//
//  RelativeDateTests.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/6/14.
//  Copyright (c) 2014 Conrad Stoll. All rights reserved.
//

import XCTest

class RelativeDateTests: XCTestCase {
    var calendar: NSCalendar!
    
    override func setUp() {
        super.setUp()
        
        calendar = NSCalendar.gregorianCalendar()
    }
    
    func testDateBeforeTodayIsOutOfBounds() {
        let date = calendar.dateWithYear(2000, month: 1, day: 1)
        let today = calendar.dateWithYear(2000, month: 1, day: 2)
        let relation = calendar.nearTermRelationForDate(date, relativeToToday: today)
        XCTAssertEqual(relation, NearTermDateRelation.OutOfRange, "\(date) should be out of range.")
    }
    
    func testTodayRelatesAsToday() {
        let date = calendar.dateWithYear(2000, month: 1, day: 1)
        let today = calendar.dateWithYear(2000, month: 1, day: 1)
        let relation = calendar.nearTermRelationForDate(date, relativeToToday: today)
        XCTAssertEqual(relation, NearTermDateRelation.Today, "\(date) should be today.")
    }
    
    func testTomorrowDuringTheSameWeekAsTodayRelatesAsTomorrow() {
        let date = calendar.dateWithYear(2004, month: 1, day: 3)
        let today = calendar.dateWithYear(2004, month: 1, day: 2)
        let relation = calendar.nearTermRelationForDate(date, relativeToToday: today)
        XCTAssertEqual(relation, NearTermDateRelation.Tomorrow, "\(date) should be tomorrow.")
    }
    
    func testTomorrowDuringNextWeekRelatesAsNextWeek() {
        let date = calendar.dateWithYear(2004, month: 10, day: 10)
        let today = calendar.dateWithYear(2004, month: 10, day: 9)
        let relation = calendar.nearTermRelationForDate(date, relativeToToday: today)
        XCTAssertEqual(relation, NearTermDateRelation.NextWeek, "\(date) should be next week.")
    }
    
    func testDateAfterTomorrowButDuringTheSameWeekAsTodayRelatesAsLaterThisWeek() {
        let date = calendar.dateWithYear(2004, month: 3, day: 6)
        let today = calendar.dateWithYear(2004, month: 3, day: 2)
        let relation = calendar.nearTermRelationForDate(date, relativeToToday: today)
        XCTAssertEqual(relation, NearTermDateRelation.LaterThisWeek, "\(date) should be later this week.")
    }
    
    func testDateDuringWeekAfterTodayRelatesAsNextWeek() {
        let date = calendar.dateWithYear(2004, month: 7, day: 11)
        let today = calendar.dateWithYear(2004, month: 7, day: 6)
        let relation = calendar.nearTermRelationForDate(date, relativeToToday: today)
        XCTAssertEqual(relation, NearTermDateRelation.NextWeek, "\(date) should be next week.")
    }
    
    func testDateDuringWeekAfterTodayThatFallsInNextYearRelatesAsNextWeek() {
        let date = calendar.dateWithYear(2006, month: 1, day: 2)
        let today = calendar.dateWithYear(2005, month: 12, day: 29)
        let relation = calendar.nearTermRelationForDate(date, relativeToToday: today)
        XCTAssertEqual(relation, NearTermDateRelation.NextWeek, "\(date) should be next week.")
    }
    
    func testDateBeyondNextWeekRelatesAsOutOfRange() {
        let date = calendar.dateWithYear(2005, month: 9, day: 25)
        let today = calendar.dateWithYear(2005, month: 9, day: 14)
        let relation = calendar.nearTermRelationForDate(date, relativeToToday: today)
        XCTAssertEqual(relation, NearTermDateRelation.OutOfRange, "\(date) should be next week.")
    }
}
