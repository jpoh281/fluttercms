import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../flutterbase/etc/flutterbase.category.helper.dart';
import '../../flutterbase/etc/flutterbase.globals.dart';
import '../../flutterbase/models/flutterbase.category_list.model.dart';
import '../../flutterbase/widgets/flutterbase.text.dart';
import '../../services/app.defines.dart';
import '../../widgets/app.drawer.dart';
import 'package:provider/provider.dart';

class CategoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => FlutterbaseCategoryListModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: T('category list'),
        ),
        endDrawer: AppDrawer(),
        body: Consumer<FlutterbaseCategoryListModel>(
          builder: (context, model, child) {
            if (model.inLoading)
              return Center(
                child: PlatformCircularProgressIndicator(),
              );
            return Column(
              children: <Widget>[
                CreateCategoryButton(),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.categories.length,
                    itemBuilder: (context, i) {
                      FlutterbaseCategory cat = model.categories[i];
                      return ListTile(
                        title: Text(cat.id),
                        subtitle: Text('${cat.title}\n${cat.description}'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () async {
                          try {
                            await open(
                              Routes.categoryEdit,
                              arguments: {'category': cat},
                            );
                            // print('category edited or delete');
                            await model.loadCategories();
                          } catch (e) {
                            alert(e);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CreateCategoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        final re = await open(Routes.categoryEdit);
        if (re != null) {
          // print('created: $re');
          Provider.of<FlutterbaseCategoryListModel>(context, listen: false)
              .loadCategories();
        }
      },
      child: T('Create Category'),
    );
  }
}
