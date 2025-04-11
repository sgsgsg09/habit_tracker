// habit_model_adapter.dart

import 'package:hive/hive.dart';
import 'package:habits_tracker/models/habit_model.dart';

class HabitModelAdapter extends TypeAdapter<HabitModel> {
  @override
  final int typeId = 0; // 각 어댑터에 고유한 typeId를 부여 (다른 어댑터와 중복되지 않아야 합니다)

  @override
  HabitModel read(BinaryReader reader) {
    // 저장된 필드의 수를 읽습니다.
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // 각 필드에 해당하는 값을 이용해 HabitModel 객체 생성
    return HabitModel(
      id: fields[0] as String,
      title: fields[1] as String,
      frequency: (fields[2] as List).cast<int>(),
      targetCount: fields[3] as int,
      currentCount: fields[4] as int,
      isActive: fields[5] as bool,
      iconName: fields[6] as String?,
      colorHex: fields[7] as String?,
      notificationEnabled: fields[8] as bool,
      notificationTime: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HabitModel obj) {
    // 총 필드 수를 기록합니다. 여기서는 HabitModel의 모든 10개 필드를 사용합니다.
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.targetCount)
      ..writeByte(4)
      ..write(obj.currentCount)
      ..writeByte(5)
      ..write(obj.isActive)
      ..writeByte(6)
      ..write(obj.iconName)
      ..writeByte(7)
      ..write(obj.colorHex)
      ..writeByte(8)
      ..write(obj.notificationEnabled)
      ..writeByte(9)
      ..write(obj.notificationTime);
  }
}
