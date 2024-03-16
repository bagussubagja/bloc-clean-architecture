import 'package:bloc_clean_architecture/core/constant/colors.dart';
import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/presentation/blocs/search_product/search_product_bloc.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_spacing.dart';
import 'package:bloc_clean_architecture/presentation/widgets/custom_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/products/products.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  List<Products> productSearchResult = [];
  bool isLoading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchProductBloc, SearchProductState>(
      listener: (context, state) {
        if (state is SearchProductSuccess) {
          setState(() {
            productSearchResult = state.products;
            isLoading = false;
          });
        }
        if (state is SearchProductLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: AppColor.whiteColor,
        ),
        body: _mainBody(),
      ),
    );
  }

  _mainBody() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        customTextField(
          controller: controller,
          hintText: 'Search here',
          labelText: '',
          keyboardType: TextInputType.text,
          isPassword: false,
          isReadOnly: false,
          onChanged: (name) {
            context
                .read<SearchProductBloc>()
                .add(SearchProductByNameEvent(name));
            if (name.isEmpty) {
              context
                  .read<SearchProductBloc>()
                  .add(const SearchProductByNameEvent(''));
            }
          },
        ),
        Visibility(
          visible: productSearchResult.isNotEmpty,
          replacement: const Center(
            child: Text('Product Not Found'),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: productSearchResult.length,
            separatorBuilder: (context, index) => verticalSpacing(12),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.detailProduct,
                      arguments: productSearchResult[index].id!);
                },
                leading: CachedNetworkImage(
                    imageUrl: productSearchResult[index].images![0]),
                title: Text(
                  productSearchResult[index].title!,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
