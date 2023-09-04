// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocaleProductAdapter extends TypeAdapter<LocaleProduct> {
  @override
  final int typeId = 0;

  @override
  LocaleProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocaleProduct(
      productId: fields[0] as int,
      image: fields[1] as String,
      quantity: fields[2] as int,
      productName: fields[5] as String,
      totalSum: fields[3] as int,
      price: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocaleProduct obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.totalSum)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.productName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
