import 'dart:developer';

import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/pages/order/order_state.dart';
import 'package:dw9_delivery_app/app/repositories/order/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderController(this._orderRepository) : super(const OrderState.initial());

  Future<void> load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));

      final paymentTypes = await _orderRepository.getAllPaymentTypes();

      emit(
        state.copyWith(
          orderProducts: products,
          status: OrderStatus.loaded,
          paymentTypes: paymentTypes,
        ),
      );
    } on Exception catch (e, s) {
      String message = 'Erro ao carregar página';
      log(message, error: e, stackTrace: s);
      emit(state.copyWith(status: OrderStatus.error, errorMessage: message));
    }
  }

  void incrementProduct(int index) {
    List<OrderProductDto> orders = [...state.orderProducts];
    OrderProductDto order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(
      state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder),
    );
  }

  void decrementProduct(int index) {
    List<OrderProductDto> orders = [...state.orderProducts];
    OrderProductDto order = orders[index];
    int amount = order.amount;

    if (amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(OrderConfirmDeleteState(
            orderProductDto: order,
            index: index,
            status: OrderStatus.confirmRemoveProduct,
            orderProducts: state.orderProducts,
            paymentTypes: state.paymentTypes,
            errorMessage: state.errorMessage));
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }

    emit(
      state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder),
    );
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }
}
