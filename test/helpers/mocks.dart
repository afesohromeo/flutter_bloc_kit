import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockItemApiProvider extends Mock implements ItemApiProvider {}

class MockItemRepository extends Mock implements ItemRepository {}

class MockItemsBloc extends MockBloc<ItemsEvent, ItemsState>
    implements ItemsBloc {}
