
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {

List<Card> _buildGridCards(BuildContext context) {
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  if (products == null || products.isEmpty) {
    return const <Card>[];
  }

  final ThemeData theme = Theme.of(context);
  final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());

  return products.map((product) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              fit:BoxFit.fitWidth
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                // TODO: Change innermost Column (103)
                children: <Widget>[
                 // TODO: Handle overflowing labels (103)
                  Text(
                    product == null ? '' : product.name,
                    style: theme.textTheme.button,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    product == null ? '' : formatter.format(product.price),
                    style: theme.textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
}

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        title: Text("SHRINE"),
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Menu button');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, semanticLabel: 'search'),
            onPressed: (){ print('search button');},
          ),
          IconButton(
            icon: Icon(Icons.tune, semanticLabel: 'filter'),
            onPressed: (){print('filter button');}
          )
        ],
      ),
      body: AsymmetricView(products: ProductsRepository.loadProducts(Category.all)),
    );
  }
}
