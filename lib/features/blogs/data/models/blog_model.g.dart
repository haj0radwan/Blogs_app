// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlogModelAdapter extends TypeAdapter<BlogModel> {
  @override
  final int typeId = 0;

  @override
  BlogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte(); //7
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlogModel(
      id: fields[0] as String,
      posterId: fields[1] as String,
      title: fields[2] as String,
      content: fields[3] as String,
      imageUrl: fields[4] as String,
      updatedAt: fields[5] as DateTime,
      posterName: fields[6] as String?,
    );
  }

  List<BlogModel> readList(BinaryReader listReader) {
    final numOfItems =
        listReader.readInt(); // First, read the number of items in the list
    final blogModels = <BlogModel>[];

    for (int i = 0; i < numOfItems; i++) {
      blogModels.add(read(listReader));
    }
    return blogModels;
  }

  @override
  void write(BinaryWriter writer, BlogModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.posterId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.posterName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
