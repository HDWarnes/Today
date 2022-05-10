//
//  ReminderStore.swift
//  Today
//
//  Created by Hamish Warnes on 2022/05/10.
//

import Foundation
import EventKit

class ReminderStore{
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
    var isAvalible: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    func readAll() async throws -> [Reminder]{
        guard isAvalible else{
            throw TodayError.accessDenied
        }
        
        let predicate = ekStore.predicateForReminders(in: nil)
        let ekReminders = try await ekStore.fetchReminders(matching: predicate)
        
        let reminders: [Reminder] = try ekReminders.compactMap{ ekReminder in
            do{
                return try Reminder(with: ekReminder)
            } catch TodayError.reminderHasNoDueDate{
                return nil
            }
        }
        return reminders
    }
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .notDetermined:
            let accessGranted = try await ekStore.requestAccess(to: .reminder)
            guard accessGranted else{
                throw TodayError.accessDenied
            }
        case .restricted:
            throw TodayError.accessRestricted
        case .denied:
            throw TodayError.accessDenied
        case .authorized:
            return
        @unknown default:
            throw TodayError.unknown
        }
    }
}
