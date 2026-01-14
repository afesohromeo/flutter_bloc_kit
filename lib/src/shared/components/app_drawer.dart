import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.parentContext});
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    // final rootContext = Navigator.of(context, rootNavigator: true).context;


    return Drawer(
      elevation: 20,
      backgroundColor: customColors.background,
      child: ListView(
        // Important: Remo
        //ve any padding from the ListView.
        padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),

        children: [
          //   Container(
          //     height: 150,
          //     padding: const EdgeInsets.fromLTRB(16, kToolbarHeight, 16, 0),
          //     margin: const EdgeInsets.only(
          //       bottom: 16,
          //     ),
          //     child: Center(
          //         child: ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Image.asset(
          //         'assets/images/logo_ecommerce_4x.png',
          //         fit: BoxFit.contain,
          //       ),
          //     )),
          //   ),
          //   DrawerTile(
          //     selected: isCurrentIndex(0, currentIndex),
          //     onTap: () {
          //       context.pop();
          //       parentContext.goNamed(posRouteName);

          //       context
          //           .read<PosBloc>()
          //           .add(const PosEvent.homeMenuTapped(index: 0));
          //     },
          //     title: l10n.home,
          //     isVisible: true,
          //     // iconData: Icons.home_outlined,
          //   ),
          //   const Gap.vertical(
          //     height: 10,
          //   ),
          //   DrawerTile(
          //     selected: isCurrentIndex(1, currentIndex),
          //     onTap: () {
          //       context.pop();
          //       context.read<OrderBloc>().add(OrderEvent.init());
          //       parentContext.goNamed(orderListRouteName);

          //       context
          //           .read<PosBloc>()
          //           .add(const PosEvent.homeMenuTapped(index: 1));
          //     },
          //     title: l10n.orders,
          //     isVisible: true,
          //     // iconData: Icons.home_outlined,
          //   ),
          //   const Gap.vertical(
          //     height: 10,
          //   ),
          //   DrawerTile(
          //     selected: isCurrentIndex(2, currentIndex),
          //     onTap: () {
          //       context.pop();
          //       context.read<DraftOrderBloc>().add(DraftOrderEvent.init());

          //       parentContext.goNamed(draftOrderListRouteName);

          //       context
          //           .read<PosBloc>()
          //           .add(const PosEvent.homeMenuTapped(index: 2));
          //     },
          //     title: l10n.draftOrders,
          //     isVisible: true,
          //     // iconData: Icons.home_outlined,
          //   ),
          //   const Gap.vertical(
          //     height: 10,
          //   ),
          //   DrawerTile(
          //     selected: isCurrentIndex(3, currentIndex),
          //     onTap: () {
          //       context.pop();
          //       context.read<ReturnOrderBloc>().add(ReturnOrderEvent.init());

          //       parentContext.goNamed(returnOrderListRouteName);

          //       context
          //           .read<PosBloc>()
          //           .add(const PosEvent.homeMenuTapped(index: 3));
          //     },
          //     title: l10n.returns,
          //     isVisible: true,
          //     // iconData: Icons.home_outlined,
          //   ),
          //   // const Gap.vertical(
          //   //   height: 10,
          //   // ),
          //   // DrawerTile(
          //   //   selected: isCurrentIndex(4, currentIndex),
          //   //   onTap: () {
          //   //     context.pop();
          //   //     parentContext.goNamed(orderListRouteName);

          //   //     context
          //   //         .read<PosBloc>()
          //   //         .add(const PosEvent.homeMenuTapped(index: 4));
          //   //   },
          //   //   title: l10n.payments,
          //   //   isVisible: true,
          //   //   // iconData: Icons.home_outlined,
          //   // ),
          //   const Gap.vertical(
          //     height: 10,
          //   ),
          //   DrawerTile(
          //     selected: isCurrentIndex(5, currentIndex),
          //     onTap: () {
          //       context.pop();
          //       parentContext.goNamed(promoCodeUsageListRouteName);

          //       context
          //           .read<PosBloc>()
          //           .add(const PosEvent.homeMenuTapped(index: 5));
          //     },
          //     title: l10n.promoCodeManagement,
          //     isVisible: true,
          //     // iconData: Icons.home_outlined,
          //   ),
          //   const Gap.vertical(
          //     height: 10,
          //   ),
          //   DrawerTile(
          //     selected: isCurrentIndex(6, currentIndex),
          //     onTap: () {
          //       context.pop();
          //       parentContext.goNamed(giftCardListRouteName);

          //       context
          //           .read<PosBloc>()
          //           .add(const PosEvent.homeMenuTapped(index: 6));
          //     },
          //     title: l10n.giftCardManagement,
          //     isVisible: true,
          //     // iconData: Icons.home_outlined,
          //   ),
          //   const Gap.vertical(
          //     height: 10,
          //   ),
          //   DrawerTile(
          //     selected: isCurrentIndex(7, currentIndex),
          //     onTap: () {
          //       context.pop();
          //       parentContext.goNamed(fidelityPointUsageRouteName);

          //       context
          //           .read<PosBloc>()
          //           .add(const PosEvent.homeMenuTapped(index: 7));
          //     },
          //     title: l10n.fidelityPoints,
          //     isVisible: true,
          //     // iconData: Icons.stars_outlined,
          //   ),
          //   const Gap.vertical(
          //     height: 10,
          //   ),
          //   DrawerTile(
          //     onTap: () async {
          //       rootNavKey!.currentContext!.goNamed(logoutPosRouteName);
          //     },
          //     title: l10n.logout,
          //     iconData: Icons.logout_outlined,
          //     isVisible: true,
          //   ),
          //   const Gap.vertical(
          //     height: 10,
          //   ),
          //
        ],
      ),
    );
  }

  bool isCurrentIndex(int selectedIndex, int currentIndex) {
    return selectedIndex == currentIndex;
  }
}
