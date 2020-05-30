
// import '../../widgets/app.padding.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:provider/provider.dart';

// import '../../services/app.defines.dart';

// import '../../widgets/app.drawer.dart';

// class PostListPage extends StatefulWidget {
//   @override
//   _PostListPageState createState() => _PostListPageState();
// }

// class _PostListPageState extends State<PostListPage> {
//   // EngineForum forum = EngineForum();

//   // EngineForumListModel forum = EngineForumListModel();

//   EngineFirestoreForumModel forum = EngineFirestoreForumModel();
//   @override
//   void initState() {
//     print('_PostListPageState::initState()');
//     Timer(
//       Duration(milliseconds: 100),
//       () {
//         var _args = routerArguments(context);

//         forum.init(
//           id: _args['id'],
//           cacheKey: 'forum-list-' + _args['id'],
//           limit: 10,
//           onLoad: (posts) {
//             print('loaded by firestore.');
//           },
//         );
//       },
//     );

//     super.initState();
//   }

//   String get title {
//     var _args = routerArguments(context);
//     return _args['id'];
//   }

//   @override
//   void dispose() {
//     forum.disposed = true;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _args = routerArguments(context);
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => forum),
//       ],
//       child: Scaffold(
//         appBar: EngineAppBar(
//           title: t(title),
//           actions: EnginePostCreateActionButton(
//             id: _args['id'],
//             forum: forum,
//           ),
//           onTapUserPhoto: () =>
//               open(ef.loggedIn ? Routes.register : Routes.login),
//         ),
//         endDrawer: AppDrawer(),
//         body: AppPadding(
//           child: SingleChildScrollView(
//             controller: forum.scrollController,
//             child: Consumer<EngineFirestoreForumModel>(
//               builder: (context, model, child) {
//                 return Column(
//                   children: <Widget>[
//                     if (model.inLoading && forum.pageNo == 1)

//                       /// 첫 페이지 로더는 맨 위에만
//                       PlatformCircularProgressIndicator(),
//                     ListView.builder(
//                       primary: false,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: model.posts.length,
//                       itemBuilder: (context, i) {
//                         return EnginePostView(model.posts[i]);
//                       },
//                     ),
//                     if (model.inLoading && forum.pageNo > 1) ...[
//                       /// 두번 째 페이지 부터 로더는 맨 아래만
//                       PlatformCircularProgressIndicator(),
//                       EngineBigSpace()
//                     ],
//                     if (model.noMorePosts) ...[
//                       T('no more posts'),
//                       EngineBigSpace(),
//                     ],
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
