//
//  TeacherView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/11/24
//

import Foundation
import SwiftUI
import DesignSystem
import ComposableArchitecture
import Domain

struct TeacherView: View {
    let store: StoreOf<TeacherFeature>
    @ObservedObject var viewStore: ViewStoreOf<TeacherFeature>

    public init(store: StoreOf<TeacherFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        TeacherBodyView(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gLoading(isPresent: viewStore.$isLoading)
    }
}

private struct TeacherBodyView: View {
    @ObservedObject var viewStore: ViewStoreOf<TeacherFeature>
    
    fileprivate init(viewStore: ViewStoreOf<TeacherFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        if (viewStore.classInformation?.classCount ?? 0) == 0 {
            ClassEmptyView(viewStore: viewStore)
        } else {
            ClassNormalView(viewStore: viewStore)
        }
    }
}

private struct ClassEmptyView: View {
    private let viewStore: ViewStoreOf<TeacherFeature>
    
    fileprivate init(viewStore: ViewStoreOf<TeacherFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GNavigationBar(title: "수업 목록")
            Spacer()
            GText(
                "아직 개설된 수업이 없어요",
                fontStyle: .Body_1_Normal_R,
                color: .labelAlternative
            ).padding(.bottom, 8)
            ClassAddButtonView
            Spacer()
        }.hPadding(16)
    }
    
    private var ClassAddButtonView: some View {
        Button {
            viewStore.send(.addClassButtonTapped)
        } label: {
            GText(
                "수업 추가하기",
                fontStyle: .Body_1_Normal_B,
                color: .staticWhite
            )
            .vPadding(8)
            .hPadding(16)
        }
        .background(Color.primaryNormal)
        .cornerRadius(8)
    }
}

private struct ClassNormalView: View {
    private let viewStore: ViewStoreOf<TeacherFeature>
    
    fileprivate init(viewStore: ViewStoreOf<TeacherFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GNavigationBar(title: "수업 목록").padding(.bottom, 24)
            if let classInfo = viewStore.classInformation {
                ForEach(classInfo.classInformationItems, id: \.self) { item in
                    Button {
                        viewStore.send(.navigateToClassDetail(item.id))
                    } label: {
                        ClassItem(item: item)
                    }.padding(.bottom, 16)
                }
            }
            GLeadingStrokeButton(
                title: "수업 추가하기",
                titleColor: .primaryNormal,
                backgroundColor: .staticWhite,
                leadingIcon: GImage.icAdd.swiftUIImage,
                buttonAction: { viewStore.send(.addClassButtonTapped) }
            )
            Spacer()
        }.hPadding(16)
    }
}

private struct ClassItem: View {
    let item: ClassInformationItem
    
    fileprivate init(item: ClassInformationItem) {
        self.item = item
    }
    
    fileprivate var body: some View  {
        VStack(spacing: 8) {
            HStack(alignment: .bottom, spacing: 8) {
                GText(
                    item.studentName + " 학생",
                    fontStyle: .Heading_1_B,
                    color: .labelNormal
                )
                GText(
                    item.grade + " / " + item.subject,
                    fontStyle: .Caption_1_R,
                    color: .labelNormal
                )
                .padding(.bottom, 4)
            }.greedyWidth(.leading)
            HStack(spacing: 0) {
                GBadge(
                    title: item.days.joined(separator: ","),
                    fontColor: .staticWhite,
                    style: .positive
                ).padding(.trailing, 4)
                GBadge(
                    title: "\(item.sessionDuration)시간",
                    fontColor: .staticWhite,
                    style: .cautionary
                )
                Spacer()
                GText(
                    "\(item.currentNumOfClass)/",
                    fontStyle: .Label_2_R,
                    color: .labelNormal
                )
                GText(
                    "\(item.maxNumOfClass)회",
                    fontStyle: .Label_2_R,
                    color: .labelNormal
                ).padding(.trailing, 20)
            }
        }
        .vPadding(8)
        .hPadding(16)
        .greedyWidth()
        .background(Color.backgroundElevatedAlternative)
        .cornerRadius(8)
    }
}
