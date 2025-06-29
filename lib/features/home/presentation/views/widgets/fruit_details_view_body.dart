import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_hub/core/helper/app_responsive.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/core/utils/app_icons.dart';
import 'package:fruit_hub/core/utils/app_text_styles.dart';
import 'package:fruit_hub/core/utils/app_toast.dart';
import 'package:fruit_hub/core/utils/widgets/custom_app_loading.dart';
import 'package:fruit_hub/core/utils/widgets/custom_botton.dart';
import 'package:fruit_hub/core/utils/widgets/my_divider.dart';
import 'package:fruit_hub/features/home/domain/models/product_model.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_cubit.dart';
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_state.dart';

import '../../../../../core/utils/widgets/go_back_icon.dart';
import 'custom_counter_products.dart';

class ProductDetailsViewBody extends StatefulWidget {
  const ProductDetailsViewBody({super.key});

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  int counter = 1;

  ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is ProductDetailsError) {
          AppToast.showErrorToast(state.error);
        }else if (state is ProductAddToBasketSuccess) {
          AppToast.showSuccessToast(state.message);

        }else if (state is ProductAddToBasketFailure) {
          AppToast.showErrorToast(state.error);
        }
      },
      builder: (context, state) {
        if (ProductDetailsCubit.get(context).product != null) {
          productModel = ProductDetailsCubit.get(context).product;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: GoBackIcon(),
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.orangeColor,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(color: AppColors.orangeColor),
                    child: Image.network(productModel!.image, fit: BoxFit.none),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    height: 20,
                    width: double.infinity,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel!.name,
                        style: AppTextStyles.textStyle32,
                      ),
                      SizedBox(
                        height: AppResponsive.height(context, value: 24),
                      ),
                      CustomCounterProducts(
                        price: productModel!.price,
                        quantity: productModel!.quantity,
                        onCounterChanged: (counter) {
                          this.counter = counter;
                         },
                      ),
                      SizedBox(
                        height: AppResponsive.height(context, value: 24),
                      ),
                      MyDivider(),
                      SizedBox(
                        height: AppResponsive.height(context, value: 24),
                      ),
                      Text(
                        'One Pack Contains:',
                        style: AppTextStyles.textStyle20,
                      ),
                      SizedBox(height: AppResponsive.height(context, value: 6)),
                      MyDivider(
                        color: AppColors.orangeColor,
                        thickness: 2,
                        endIndent: AppResponsive.width(context, value: 153),
                      ),
                      SizedBox(height: AppResponsive.height(context, value: 8)),
                      Text(
                        productModel!.ingredients.join(', '),
                        style: AppTextStyles.textStyle16,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: AppResponsive.height(context, value: 24),
                      ),
                      MyDivider(),
                      Text(
                        productModel!.description,
                        style: AppTextStyles.textStyle16,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: AppResponsive.height(context, value: 24),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.orangeColor.withAlpha(
                              60,
                            ),
                            child: SvgPicture.asset(
                              AppIcons.favoriteIcon,
                              width: 25,
                              height: 25,
                            ),
                          ),
                          SizedBox(
                            width: AppResponsive.width(context, value: 16),
                          ),
                          CustomButton(
                            text: 'Add to basket',
                            ontap: () {
                              ProductDetailsCubit.get(context).addToBasket(productModel!.id, counter);
                            },
                            width: AppResponsive.width(context, value: 219),
                            height: AppResponsive.height(context, value: 56),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return CustomAppLoading();
      },
    );
  }
}
