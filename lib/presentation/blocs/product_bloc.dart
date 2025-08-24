import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';

// Events
abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class ToggleFavorite extends ProductEvent {
  final String productId;
  ToggleFavorite(this.productId);
}

// States
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

// BLoC
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  ProductBloc({
    required this.getProductsUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await getProductsUseCase.execute();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<ProductState> emit) async {
    try {
      await toggleFavoriteUseCase.execute(event.productId);
      // Перезагружаем продукты после изменения
      add(LoadProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
