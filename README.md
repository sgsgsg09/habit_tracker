<aside>

  ![image](https://github.com/user-attachments/assets/7d3d7dcc-1347-46f7-a238-ac23067cad81){: width="20%" height="20%"}

Modern Todo (습관/일정 관리 앱)**

습관 및 일정 관리에 필요한 다양한 기능을 직관적인 인터페이스로 제공하며, 로컬 데이터 저장소를 통해 오프라인 환경에서도 안정적으로 동작하는 앱입니다.

MVVM (Model-View-ViewModel) 패턴을 적용하여 UI(View)와 비즈니스 로직(ViewModel)을 명확하게 분리, 유지보수성과 확장성을 강화했습니다.

## 핵심 기능 ✨

✅ **습관 등록/수정/삭제**

원하는 습관(할 일)을 자유롭게 추가, 수정 및 삭제할 수 있습니다.

✅ **주간 빈도수 리스트 & Carousel 뷰**

하루 또는 한 주 단위로 데이터를 요일 빈도수(desc) 순으로 정렬해 확인할 수 있으며, 활성(`isActive == true`)과 비활성(`isActive == false`) 습관을 구분하여 관리의 효율성을 높였습니다.

✅ **HabitAttempt 기록 관리**

날짜별 성공/실패 여부를 기록하여 세부 진행 상황을 상세히 확인할 수 있습니다.

✅ **오프라인 우선 설계**

Hive를 활용한 로컬 데이터 저장소로 네트워크 연결이 없어도 안정적인 데이터 조회와 보존이 가능합니다.

> 💻 사용된 주요 패키지
>
> - 💡 **Hive**
> - 💡 **flutter_riverpod**
> - 💡 **build_runner / freezed / json_serializable**

</aside>
