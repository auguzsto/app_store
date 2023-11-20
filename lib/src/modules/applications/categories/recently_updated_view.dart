import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/card_applications.dart';
import 'package:flutter/material.dart';

class CategoriesRecentlyUpdatedView extends StatefulWidget {
  const CategoriesRecentlyUpdatedView({super.key});

  @override
  State<CategoriesRecentlyUpdatedView> createState() => _CategoriesRecentlyUpdatedViewState();
}

List _itemsWithIcon = [];

class _CategoriesRecentlyUpdatedViewState extends State<CategoriesRecentlyUpdatedView> {
  final String categoryName = "Populares";

  final String endpoint = "collection/recently-updated";


  @override
  void initState() {
    _getItemsWithIcon(endpoint);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _itemsWithIcon = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Http.get(endpoint),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          child: GridView.builder(
            
            shrinkWrap: true,
            itemCount: _itemsWithIcon.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                childAspectRatio: 2),
            itemBuilder: (context, index) {
              final applicationModel = ApplicationsModel.fromJson(_itemsWithIcon[index]);
              return CardApplicationsWiget(applicationModel: applicationModel);
            },
          ),
        );
      },
    );
  }
}

Future<List> _getItemsWithIcon(String endpoint) async {
  try {
    final data = await Http.get(endpoint);
    for (var element in data) { 
      if(element['iconDesktopUrl'] != null) {
       _itemsWithIcon.add(element);
      }
    }
    return _itemsWithIcon;
  } catch (e) {
    rethrow;
  }
}