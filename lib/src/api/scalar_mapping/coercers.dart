import 'dart:convert';

DateTime fromGraphQLDateTimeToDartDateTime(String date) =>
    DateTime.parse(date).toLocal();

String fromDartDateTimeToGraphQLDateTime(DateTime date) =>
    date.toUtc().toIso8601String();

DateTime? fromGraphQLDateTimeToDartDateTimeNullable(String? date) =>
    date == null ? null : DateTime.parse(date).toLocal();

String? fromDartDateTimeToGraphQLDateTimeNullable(DateTime? date) =>
    date?.toUtc().toIso8601String();

DateTime? fromGraphQLUploadNullableToDartMultipartFileNullable(String? date) =>
    date == null ? null : DateTime.parse(date).toLocal();

String? fromDartMultipartFileNullableToGraphQLUploadNullable(DateTime? date) =>
    date?.toUtc().toIso8601String();

DateTime? fromGraphQLUploadToDartMultipartFile(String? date) =>
    date == null ? null : DateTime.parse(date).toLocal();

String? fromDartMultipartFileToGraphQLUpload(DateTime? date) =>
    date?.toUtc().toIso8601String();

DateTime?
    fromGraphQLListNullableUploadNullableToDartListNullableMultipartFileNullable(
            String? date) =>
        date == null ? null : DateTime.parse(date).toLocal();

String?
    fromDartListNullableMultipartFileNullableToGraphQLListNullableUploadNullable(
            DateTime? date) =>
        date?.toUtc().toIso8601String();

DateTime? fromGraphQLListUploadNullableToDartListMultipartFileNullable(
        String? date) =>
    date == null ? null : DateTime.parse(date).toLocal();

String? fromDartListMultipartFileNullableToGraphQLListUploadNullable(
        DateTime? date) =>
    date?.toUtc().toIso8601String();

DateTime? fromGraphQLListUploadToDartListMultipartFile(String? date) =>
    date == null ? null : DateTime.parse(date).toLocal();

String? fromDartListMultipartFileToGraphQLListUpload(DateTime? date) =>
    date?.toUtc().toIso8601String();

DateTime? fromGraphQLISO8601DateTimeNullableToDartDateTimeNullable(
        String? date) =>
    date == null ? null : DateTime.parse(date).toLocal();

String? fromDartDateTimeNullableToGraphQLISO8601DateTimeNullable(
        DateTime? date) =>
    date?.toIso8601String();

String fromGraphQLJsonToDartString(dynamic source) =>
    source == null ? '' : json.encode(source);

String? fromDartStringToGraphQLJson(String? source) => source;

//OLD
DateTime fromGraphQLISO8601DateTimeToDartDateTime(String date) =>
    DateTime.parse(date).toLocal();

String? fromDartDateTimeToGraphQLISO8601DateTime(DateTime? date) =>
    date?.toIso8601String();

DateTime? fromGraphQLISO8601DateNullableToDartDateTimeNullable(String? date) =>
    date == null ? null : DateTime.parse(date).toLocal();

String? fromDartDateTimeNullableToGraphQLISO8601DateNullable(DateTime? date) =>
    date?.toIso8601String();

DateTime fromGraphQLISO8601DateToDartDateTime(String date) =>
    DateTime.parse(date).toLocal();

String? fromDartDateTimeToGraphQLISO8601Date(DateTime? date) =>
    date?.toIso8601String();
