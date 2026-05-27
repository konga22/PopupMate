import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapMockData {
  static const popups = [
    {'id': '1', 'title': '토코보(TOCOBO) In My Sun Era', 'pos': NLatLng(37.5420, 127.0555), 'cat': '뷰티', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?q=80&w=400', 'address': '성수이로 20길 12'},
    {'id': '2', 'title': '포켓몬 시크릿 포레스트', 'pos': NLatLng(37.5450, 127.0535), 'cat': '캐릭터', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=400', 'address': '성수동2가 314-1'},
    {'id': '3', 'title': '실바니안 40주년 숲속 비밀 파티', 'pos': NLatLng(37.5448, 127.0510), 'cat': '캐릭터', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1555505019-8c3f1c4aba5f?q=80&w=400', 'address': '라인프렌즈 스퀘어 성수'},
    {'id': '4', 'title': '라코스테 폴로 팩토리', 'pos': NLatLng(37.5440, 127.0515), 'cat': '패션', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1514989940723-e8e51635b782?q=80&w=400', 'address': '성수 베트윈'},
    {'id': '5', 'title': '박보영 20주년 기념 사진전', 'pos': NLatLng(37.5445, 127.0575), 'cat': '연예', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=400', 'address': '플라츠2'},
    {'id': '6', 'title': '브레게 창립 250주년 시간의 서랍', 'pos': NLatLng(37.5425, 127.0565), 'cat': '전시', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1533090161767-e6ffed986c88?q=80&w=400', 'address': '앤더슨씨 성수'},
    {'id': '7', 'title': '발베니 메이커스테이블', 'pos': NLatLng(37.5432, 127.0585), 'cat': '음식', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1622543925917-763c34d1a86e?q=80&w=400', 'address': '피치스 도원'},
    {'id': '8', 'title': '영감이 필요한 순간 팝업', 'pos': NLatLng(37.5410, 127.0580), 'cat': '복합', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=400', 'address': '성수동 카페거리'},
    {'id': '9', 'title': '후드후드(HOODHOOD) 팝업', 'pos': NLatLng(37.5425, 127.0520), 'cat': '패션', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=400', 'address': '성수 연무장길'},
    {'id': '10', 'title': '포레스트 X 무신사뷰티 팝업', 'pos': NLatLng(37.5410, 127.0565), 'cat': '뷰티', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1570554886111-e80fcca6a029?q=80&w=400', 'address': '무신사 뷰티 스페이스'},
    {'id': '11', 'title': '뉴클리드 팝업', 'pos': NLatLng(37.5455, 127.0545), 'cat': '패션', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1520006403909-838d6b92c22e?q=80&w=400', 'address': '맵달 SEOUL 성수 3F'},
    {'id': '12', 'title': '노빅딜 팝업 IN 성수', 'pos': NLatLng(37.5430, 127.0545), 'cat': '리빙', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1533090161767-e6ffed986c88?q=80&w=400', 'address': '이구홈 성수'},
    {'id': '13', 'title': 'PPULBATU 팝업', 'pos': NLatLng(37.5452, 127.0570), 'cat': '캐릭터', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=400', 'address': '성수이로 20길'},
    {'id': '14', 'title': '루메나 팝업', 'pos': NLatLng(37.5460, 127.0550), 'cat': '테크', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1520006403909-838d6b92c22e?q=80&w=400', 'address': '이구홈 성수'},
    {'id': '15', 'title': '모에뜨 팝업', 'pos': NLatLng(37.5475, 127.0545), 'cat': '패션', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=400', 'address': '맵달 SEOUL 성수'},
    {'id': '16', 'title': '스위치 팝업', 'pos': NLatLng(37.5480, 127.0580), 'cat': '패션', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1514989940723-e8e51635b782?q=80&w=400', 'address': '연무장 7길'},
    {'id': '17', 'title': '빌라봉 성수점 오픈', 'pos': NLatLng(37.5440, 127.0570), 'cat': '패션', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=400', 'address': '성수이로 7길 26'},
    {'id': '18', 'title': '디올 성수 어딕트 쇼룸', 'pos': NLatLng(37.5428, 127.0518), 'cat': '뷰티', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?q=80&w=400', 'address': '디올 성수'},
    {'id': '19', 'title': '탬버린즈 성수 플래그십', 'pos': NLatLng(37.5415, 127.0525), 'cat': '뷰티', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1570554886111-e80fcca6a029?q=80&w=400', 'address': '탬버린즈 성수'},
    {'id': '20', 'title': '아모레 성수 스페셜 팝업', 'pos': NLatLng(37.5465, 127.0530), 'cat': '뷰티', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?q=80&w=400', 'address': '아모레 성수'},
    {'id': '21', 'title': '이구홈(29CM) 라운지', 'pos': NLatLng(37.5458, 127.0565), 'cat': '리빙', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1533090161767-e6ffed986c88?q=80&w=400', 'address': '이구홈 성수'},
    {'id': '22', 'title': '피치스 도원 카 라운지', 'pos': NLatLng(37.5438, 127.0582), 'cat': '복합', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1520006403909-838d6b92c22e?q=80&w=400', 'address': '피치스 도원'},
    {'id': '23', 'title': '무신사 엠프티 성수', 'pos': NLatLng(37.5422, 127.0575), 'cat': '패션', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=400', 'address': '무신사 엠프티'},
    {'id': '24', 'title': '라인프렌즈 스퀘어 이벤트', 'pos': NLatLng(37.5418, 127.0535), 'cat': '캐릭터', 'res': false, 'imageUrl': 'https://images.unsplash.com/photo-1555505019-8c3f1c4aba5f?q=80&w=400', 'address': '라인프렌즈 스퀘어'},
    {'id': '25', 'title': '무신사 뷰티 스페이스', 'pos': NLatLng(37.5442, 127.0505), 'cat': '뷰티', 'res': true, 'imageUrl': 'https://images.unsplash.com/photo-1570554886111-e80fcca6a029?q=80&w=400', 'address': '무신사 성수'},
  ];
}
