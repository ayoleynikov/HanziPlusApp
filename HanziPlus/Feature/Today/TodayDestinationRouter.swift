//
//  TodayDestinationRouter.swift
//  HanziPlus
//

import SwiftUI

enum TodayDestinationRouter {

    @ViewBuilder
    static func view(for destination: TodayDestination) -> some View {
        switch destination {
        case .study(let fileName, let sectionID):
            if let set = SampleStudySets.studySet(fileName: fileName) {
                if let sectionID,
                   let section = StudySetCatalog.section(fileName: fileName, id: sectionID) {
                    StudyView(studySet: set, studySection: section)
                } else if set.hasSections {
                    SectionedStudySetView(studySet: set)
                } else {
                    StudyView(studySet: set)
                }
            } else {
                ContentUnavailableView("Study set unavailable", systemImage: "book.closed")
            }

        case .smartReview(let fileName):
            if let set = SampleStudySets.studySet(fileName: fileName) {
                SmartReviewView(studySet: set)
            } else {
                SmartReviewView(studySet: SampleStudySets.hsk1)
            }

        case .dailyLesson:
            DailyLessonFlowView()

        case .travelHub, .travelEssentials:
            // Prefer tab deep-links from TodayView.open(_:). Fallback for safety.
            ContentUnavailableView(
                "Travel Toolkit",
                systemImage: "airplane",
                description: Text("Open the Travel tab to use offline phrases.")
            )

        case .journey, .learnTab, .gamesTab:
            ContentUnavailableView("Opening…", systemImage: "arrow.right.circle")
        }
    }
}
