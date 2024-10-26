// import 'dart:async';
// import 'dart:developer';

// import 'package:alnekhba_blogs/core/common/app_user/app_user_cubit.dart';
// import 'package:alnekhba_blogs/features/Auth/presentation/pages/loginpage.dart';
// import 'package:alnekhba_blogs/features/plogs/presentation/pages/blog_page.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class EnterScreen extends StatelessWidget {
//   const EnterScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Future.delayed(
//         const Duration(seconds: 1000),
//       ),
//       builder: (context, snapshot) =>
//           BlocSelector<AppUserCubit, AppUserState, bool>(
//         selector: (state) {
//           log("the appuser state is $state");
//           return (state is AppUserLoggedIn);
//         },
//         builder: (context, isloogedin) {
//           log(" the  isloged in value is $isloogedin ");
//           if (isloogedin) {
//             log("when true there is a text ");
//             return const Center(
//               child: BlogPage(),
//             );
//           } else if (!isloogedin) {
//             log("now log in page renderd");
//             return const LoginPage();
//           }
//           return const Text("sdsdsdsdsdsdsdsd");
//         },
//       ),
//     );
//   }
// }



// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 
// // 