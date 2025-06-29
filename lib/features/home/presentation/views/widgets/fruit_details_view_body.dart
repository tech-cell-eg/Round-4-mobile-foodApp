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
import 'package:fruit_hub/features/home/presentation/manger/product_details/product_details_cubit.dart';

import '../../../../../core/utils/widgets/go_back_icon.dart';
import 'custom_counter_products.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is ProductDetailsError) {
          AppToast.showErrorToast(state.error);
        }
      },
      builder: (context, state) {
        if (state is ProductDetailsLoaded) {
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
                    child: Image.network(state.product.image, fit: BoxFit.none,),
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
                        state.product.name,
                        style: AppTextStyles.textStyle32,
                      ),
                      SizedBox(height: AppResponsive.height(context, value: 24)),
                      CustomCounterProducts(price: state.product.price, quantity: state.product.quantity ?? 1),
                      SizedBox(height: AppResponsive.height(context, value: 24)),
                      MyDivider(),
                      SizedBox(height: AppResponsive.height(context, value: 24)),
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
                        state.product.ingredients.join(', '),
                        style: AppTextStyles.textStyle16,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppResponsive.height(context, value: 24)),
                      MyDivider(),
                      Text(
                        state.product.description,
                        style: AppTextStyles.textStyle16,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppResponsive.height(context, value: 24)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.orangeColor.withAlpha(60),
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
