// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_info_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IPInfoAdapter extends TypeAdapter<IPInfo> {
  @override
  final int typeId = 0;

  @override
  IPInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IPInfo(
      ip: fields[0] as String,
      city: fields[1] as String,
      countryName: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, IPInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.ip)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.countryName)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IPInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
