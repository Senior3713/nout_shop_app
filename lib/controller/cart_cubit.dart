import 'package:bloc/bloc.dart';
import 'package:nout_shop_app/controller/cart_model.dart';

// class CartController {
//   CartState _cart = CartState(id: 1, items: []);
//   final StreamController<CartState> _controller = StreamController.broadcast();
//
//   void addToCard({required Product product, required int quantity}) {
//     final isExist = _cart.items.any((element) => element.id == product.id);
//     if (isExist) {
//       ///TODO: Warning
//       final item =
//           _cart.items.firstWhere((element) => element.id == product.id);
//       if (quantity == 1) {
//         item.quantity++;
//       } else if (quantity == -1 && item.quantity > 0) {
//         item.quantity--;
//       }
//
//       item.total = item.quantity * item.product.price;
//       if (item.quantity == 0) {
//         _cart.items.remove(item);
//       }
//     } else if (quantity == 1) {
//       final cartItem = CartItem(id: product.id, product: product);
//       _cart.items.add(cartItem);
//     }
//
//     _cart = _cart.copyWith(items: _cart.items);
//     _controller.sink.add(_cart);
//   }
//
//   Stream<CartState> get stream => _controller.stream;
//
//   CartState get cart => _cart;
// }



final cartCubit = CartCubit();

class CartCubit extends Cubit<CartState>{
  CartCubit() : super(CartState(id: 1, items: []));
  void addToCard({required Product product, required int quantity}) {
    final list = state.items;
    final isExist = list.any((element) => element.id == product.id);
    if(isExist) {
      ///TODO: Warning
      final item =list.firstWhere((element) => element.id == product.id);
      if(quantity == 1) {
        item.quantity++;
        emit(CartState(id: state.id, items: [...list]));
      } else if(quantity == -1 && item.quantity > 0){
        item.quantity--;
        emit(CartState(id: state.id, items: [...list]));
      }

      item.total = item.quantity * item.product.price;
      if(item.quantity == 0) {
        list.remove(item);
        emit(CartState(id: state.id, items: [...list]));
      }

    } else if(quantity == 1) {
      final cartItem = CartItem(id: product.id, product: product);
      list.add(cartItem);
      emit(CartState(id: state.id, items: [...list]));
    }
  }
}
