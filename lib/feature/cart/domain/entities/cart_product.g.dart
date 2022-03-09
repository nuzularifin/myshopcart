// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartProductAdapter extends TypeAdapter<CartProduct> {
  @override
  final int typeId = 3;

  @override
  CartProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartProduct(
      prdNm: fields[0] as String,
      prdNo: fields[1] as String,
      selPrc: fields[2] as String,
      dispCtgrNm: fields[3] as String,
      qty: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartProduct obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.prdNm)
      ..writeByte(1)
      ..write(obj.prdNo)
      ..writeByte(2)
      ..write(obj.selPrc)
      ..writeByte(3)
      ..write(obj.dispCtgrNm)
      ..writeByte(4)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
