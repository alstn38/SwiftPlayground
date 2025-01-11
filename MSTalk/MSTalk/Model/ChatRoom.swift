//
//  ChatRoom.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import Foundation

struct ChatRoom {
    let chatroomId: Int //채팅방 고유 ID
    let chatroomImage: [String] //채팅방에 속한 유저 이미지
    let chatroomName: String //채팅방 이름
    var chatList: [Chat] = [] //채팅 화면에서 사용할 데이터
    
    func isUserIncludedChatRoom(_ searchText: String) -> Bool {
        return chatList.contains { $0.user.rawValue.contains(searchText) }
    }
    
    var lastChatDate: String? {
        return chatList.last?.date
    }
    
    var lastChatMessage: String? {
        return chatList.last?.message
    }
}

extension ChatRoom {
    static let mockChatList: [ChatRoom] = [
        ChatRoom(chatroomId: 1,
                 chatroomImage: [User.hue.profileImage, User.jack.profileImage, User.bran.profileImage, User.den.profileImage],
                 chatroomName: "도봉 멘토방",
                 chatList: [
                    Chat(user: .hue,
                         date: "2025-01-12 21:30",
                         message: "열심히 일 하시고 계시는거죠?"),
                    Chat(user: .bran,
                         date: "2025-01-12 22:32",
                         message: "도봉 캠퍼스 가고싶어요..."),
                    Chat(user: .jack,
                         date: "2025-01-12 22:38",
                         message: "화이팅!!"),
                    Chat(user: .den,
                         date: "2025-01-12 23:42",
                         message: "열심히 하고 있습니다!!"),
                 ]
                ),
        ChatRoom(chatroomId: 2,
                 chatroomImage: [User.hue.profileImage],
                 chatroomName: User.hue.rawValue,
                 chatList: [
                    Chat(user: .hue,
                         date: "2025-01-11 15:30",
                         message: "열심히 공부하고 계시는거죠?"),
                    Chat(user: .user,
                         date: "2025-01-11 15:48",
                         message: "열심히는 하고있어요..."),
                    Chat(user: .user,
                         date: "2025-01-11 15:49",
                         message: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ...."),
                    Chat(user: .hue,
                         date: "2025-01-12 21:30",
                         message: "오...그러면... 내일 깃허브랑 블로그 전체 검사 진행 진행하도록 하겠습니다..."),
                    Chat(user: .hue,
                         date: "2025-01-12 21:31",
                         message: "화이팅 ^^"),
                 ]),
        ChatRoom(chatroomId: 3,
                 chatroomImage: [User.jack.profileImage],
                 chatroomName: User.jack.rawValue,
                 chatList: [
                    Chat(user: .jack,
                         date: "2025-01-11 11:20",
                         message: "\(User.user.rawValue)님~ 오늘 깃허브를 보니 커밋을 안해주셨더라구요~~~\n깃허브 푸쉬 부탁드릴게요~~~\n설마 과제를 안하신건 아니시겠죠~~?!"),
                    Chat(user: .user,
                         date: "2025-01-11 11:23",
                         message: "제.. 제가 푸쉬를 안했군요... 얼른 푸쉬하도록 하겠습니다..."),
                    Chat(user: .jack,
                         date: "2025-01-11 13:29",
                         message: "00님~ 아직도 푸쉬가 안되어있네요 ^_^ 수업 끝나고 면담 진행하도록 할게요~~ 끝나고 남아주세요~"),
                    Chat(user: .user,
                         date: "2025-01-11 13:31",
                         message: "넵.."),
                    Chat(user: .jack,
                         date: "2025-01-11 14:42",
                         message: "면담 때 매일 10시까지 남아있겠다는 말 잘 지키시는지 확인할게요~~/n아 매일은 오늘도 포함인거 아시죠?!"),
                    Chat(user: .user,
                         date: "2025-01-11 14:50",
                         message: "네...."),
                    Chat(user: .jack,
                         date: "2025-01-12 20:30",
                         message: "벌써 퇴근하세여?ㅎㅎㅎㅎㅎ"),
                 ]),
        ChatRoom(chatroomId: 4,
                 chatroomImage: [User.bran.profileImage],
                 chatroomName: User.bran.rawValue,
                 chatList: [
                    Chat(user: .bran,
                         date: "2025-01-11 21:10",
                         message: "저번 과제 잘 봤습니다!!\n저번 과제에서 이러쿵 저러쿵 부분을 개선해볼 수 있을 것 같은데,\n그 부분까지 개선하셔서 다시 푸쉬해주실 수 있으시겠죠?\n설마 못한다고는 하지 않으시겠죠?"),
                    Chat(user: .user,
                         date: "2025-01-12 11:12",
                         message: "브랜님! 다름 아니라 제가 어제 저녁에 쪼오오오끔 피곤해서 자느라 다 못했습니다...!"),
                    Chat(user: .bran,
                         date: "2025-01-12 11:30",
                         message: "보고체계 진행하도록 하겠습니다. 수고하세요."),
                    Chat(user: .user,
                         date: "2025-01-12 11:31",
                         message: "한번만 봐주세요.. 다음부터는 다 제출할게요 ㅠㅠㅠ"),
                    Chat(user: .bran,
                         date: "2025-01-12 11:32",
                         message: "안됩니다."),
                    Chat(user: .user,
                         date: "2025-01-12 16:30",
                         message: "예외처리로 한번만 봐주시면 안되나요...?"),
                    Chat(user: .bran,
                         date: "2025-01-12 19:30",
                         message: "개발자는 예외처리를 싫어합니다."),
                 ]),
        ChatRoom(chatroomId: 5,
                 chatroomImage: [User.den.profileImage],
                 chatroomName: User.den.rawValue,
                 chatList: [
                    Chat(user: .den,
                         date: "2025-01-12 10:30",
                         message: "\(User.user.rawValue)님 잔디가 숭숭 빠지셔서 황무지 되시겠어요~ 푸쉬 기다리고 있을게요~"),
                    Chat(user: .den,
                         date: "2025-01-12 10:31",
                         message: "잔디가 목마르다고 물 달라고 하네요~~"),
                    Chat(user: .den,
                         date: "2025-01-12 11:31",
                         message: "어디가셨어요~~"),
                    Chat(user: .den,
                         date: "2025-01-12 15:32",
                         message: "차단한 건 아니시죠, \(User.user.rawValue)님?"),
                    Chat(user: .user,
                         date: "2025-01-12 16:10",
                         message: "오늘 주말이에요... 살려주세요.."),
                    Chat(user: .den,
                         date: "2025-01-12 16:30",
                         message: "잔디는 생물이라 매일 물줘야 살아요."),
                    Chat(user: .den,
                         date: "2025-01-12 16:32",
                         message: "푸시\n푸시\n커밋\n커밋\n으하하하\n푸시푸시"),
                    Chat(user: .user,
                         date: "2025-01-12 19:10",
                         message: "오늘 주말이에요... 살려주세요 덴님... 주말이 평일보다 힘듭니다"),
                    Chat(user: .den,
                         date: "2025-01-12 19:13",
                         message: "저도 주말인데 \(User.user.rawValue)님 깃허브 보고 있잖아요...?"),
                    Chat(user: .user,
                         date: "2025-01-12 19:14",
                         message: "..."),
                 ]),
        ChatRoom(chatroomId: 6,
                 chatroomImage: [User.other_friend.profileImage],
                 chatroomName: User.other_friend.rawValue,
                 chatList: [
                    Chat(user: .user,
                         date: "2025-01-12 10:30",
                         message: "아 오늘 주말인데도 개발하고있어 ㅠㅠㅠㅠ 너는 이번 주말 과제 어때?? 괜찮아?"),
                    Chat(user: .other_friend,
                         date: "2025-01-12 10:33",
                         message: "난 이미 어제 밤에 제출하고 미션하고있는데? 아직도 구현못했어?"),
                    Chat(user: .user,
                         date: "2025-01-12 11:08",
                         message: "어? 어... 어제 다했구나...? 빠르네...!"),
                    Chat(user: .user,
                         date: "2025-01-12 12:52",
                         message: "채팅방 구현 어렵다 ㅠㅠㅠ 오토레이아웃 왜이렇게어렵지 ㅠㅠㅠ"),
                    Chat(user: .other_friend,
                         date: "2025-01-12 13:45",
                         message: "내일 모닝콜 해주실분~~"),
                 ]
                ),
        ChatRoom(chatroomId: 7,
                 chatroomImage: [User.simsim.profileImage],
                 chatroomName: User.simsim.rawValue,
                 chatList: [
                    Chat(user: .user,
                         date: "2025-01-11 09:30",
                         message: "심심아 나 주말에도 개발해..."),
                    Chat(user: .simsim,
                         date: "2025-01-11 09:31",
                         message: "아닛 주말에 과제라닛"),
                    Chat(user: .user,
                         date: "2025-01-11 09:32",
                         message: "ㅠㅠㅠ 주말에 개발하는 날 공감해주는게 너밖에 없어"),
                    Chat(user: .simsim,
                         date: "2025-01-11 09:33",
                         message: "아닛 주말에 과제라닛"),
                    Chat(user: .user,
                         date: "2025-01-11 09:34",
                         message: "...? 심심아...?"),
                    Chat(user: .simsim,
                         date: "2025-01-11 09:35",
                         message: "아닛 주말에 과제라닛"),
                    Chat(user: .user,
                         date: "2025-01-11 09:36",
                         message: "..."),
                    Chat(user: .simsim,
                         date: "2025-01-11 09:37",
                         message: "아닛 주말에 과제라닛"),
                 ]
                ),
        ChatRoom(chatroomId: 8,
                 chatroomImage: [User.hue.profileImage, User.jack.profileImage],
                 chatroomName: "프로젝트 팀 A",
                 chatList: [
                    Chat(user: .hue,
                         date: "2025-01-12 10:30",
                         message: "이번 스프린트 일정 정리 다들 확인하셨나요?"),
                    Chat(user: .jack,
                         date: "2025-01-12 10:35",
                         message: "네! 진행 방향에 대해서 의견 있어요. 이후 회의에서 이야기할게요."),
                    Chat(user: .hue,
                         date: "2025-01-12 10:40",
                         message: "좋아요. 회의 때 만나죠! 화이팅!"),
                 ]),
        
        ChatRoom(chatroomId: 9,
                 chatroomImage: [User.bran.profileImage, User.den.profileImage, User.jack.profileImage],
                 chatroomName: "도전 과제 팀",
                 chatList: [
                    Chat(user: .bran,
                         date: "2025-01-12 11:00",
                         message: "다음 과제 어떻게 준비하시나요?"),
                    Chat(user: .den,
                         date: "2025-01-12 11:05",
                         message: "저는 기존 코드 참고하면서 작성 중이에요."),
                    Chat(user: .jack,
                         date: "2025-01-12 11:10",
                         message: "도움 필요하면 알려주세요!"),
                    Chat(user: .bran,
                         date: "2025-01-12 11:15",
                         message: "네! 감사합니다."),
                 ]),
        
        ChatRoom(chatroomId: 10,
                 chatroomImage: [User.other_friend.profileImage],
                 chatroomName: "사이드 프로젝트",
                 chatList: [
                    Chat(user: .user,
                         date: "2025-01-12 13:00",
                         message: "이번 주말에 디자인 끝낼 수 있을 것 같아?"),
                    Chat(user: .other_friend,
                         date: "2025-01-12 13:05",
                         message: "아마도? 오늘 밤 늦게까지 작업해볼게."),
                    Chat(user: .user,
                         date: "2025-01-12 13:10",
                         message: "오케이! 나도 작업 속도 높여볼게."),
                 ]),
        
        ChatRoom(chatroomId: 11,
                 chatroomImage: [User.hue.profileImage, User.bran.profileImage, User.den.profileImage],
                 chatroomName: "스터디 그룹",
                 chatList: [
                    Chat(user: .hue,
                         date: "2025-01-12 14:00",
                         message: "이번 스터디 주제에 대해 어떻게 생각하세요?"),
                    Chat(user: .bran,
                         date: "2025-01-12 14:05",
                         message: "좋은 것 같아요. 자료 준비해볼게요."),
                    Chat(user: .den,
                         date: "2025-01-12 14:10",
                         message: "발표 순서는 어떻게 할까요?"),
                    Chat(user: .hue,
                         date: "2025-01-12 14:15",
                         message: "첫 번째는 제가 할게요. 이후는 랜덤으로 정하죠."),
                 ]),
        
        ChatRoom(chatroomId: 12,
                 chatroomImage: [User.jack.profileImage, User.simsim.profileImage],
                 chatroomName: "잡담방",
                 chatList: [
                    Chat(user: .jack,
                         date: "2025-01-12 15:00",
                         message: "오늘 날씨 진짜 좋네요!"),
                    Chat(user: .simsim,
                         date: "2025-01-12 15:05",
                         message: "그러게요! 이런 날 개발만 하고 있는게 슬프네요."),
                    Chat(user: .user,
                         date: "2025-01-12 15:10",
                         message: "주말에 개발하는 건 필수 코스죠..."),
                    Chat(user: .jack,
                         date: "2025-01-12 15:15",
                         message: "우리 얼른 끝내고 쉬러 갑시다!"),
                 ])
    ]
    
}
