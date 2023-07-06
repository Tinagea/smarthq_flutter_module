import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/recipe_details_cubit.dart';
import 'package:smarthq_flutter_module/models/recipe_details_model.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';

class FadingSliverAppBarPage extends StatefulWidget {
  final IconButton leading;
  final String title;
  final IconButton? rightIcon;
  final List<Widget>? children;
  final TextStyle? titleStyle;
  final String? imageUrl;
  final double? triggerHeight;
  final int? animationSpeedInMilliseconds;
  final Color? backgroundColor;

  const FadingSliverAppBarPage(
    {Key? key,
    required this.title,
    required this.leading,
    this.rightIcon,
    this.imageUrl,
    this.triggerHeight = 80,
    this.animationSpeedInMilliseconds = 300,
    this.children,
    this.titleStyle,
    this.backgroundColor
    }) : super(key: key);


  @override
  State<FadingSliverAppBarPage> createState() => _FadingSliverAppBarPageState();
}

class _FadingSliverAppBarPageState extends State<FadingSliverAppBarPage> {

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    //is the user at the top
    if (_scrollController.offset == 0) {
      BlocProvider.of<RecipeDetailsCubit>(context).setScrolled(false);
    }
    if(_scrollController.offset > widget.triggerHeight!){
      BlocProvider.of<RecipeDetailsCubit>(context).setScrolled(true);

    }
  }

  @override
  Widget build(BuildContext context) {
    bool smallScreen = MediaQuery.of(context).size.width < 800.w;
    return BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(
      builder: (context, state) {
        return Container(
            height: MediaQuery.of(context).size.height,
            color: widget.backgroundColor ?? Colors.black,
            child: Column(
              children: [
                Stack(
                  children: [
                  AnimatedContainer(
                    duration:  Duration(milliseconds: widget.animationSpeedInMilliseconds ?? 300),
                    height: state.contentModel!.isScrolled!? 115.h : 180.h,
                    clipBehavior: Clip.hardEdge,
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                        opacity: !state.contentModel!.isScrolled! ? 0.75 : 0,
                          fit: BoxFit.cover,
                          image: widget.imageUrl != null ?
                      NetworkImage(widget.imageUrl!) :
                      NetworkImage(ImagePath.PLACEHOLDER)
                       ),
                    ),
                  ),
    
                    AnimatedContainer(
                      duration: Duration(milliseconds: widget.animationSpeedInMilliseconds ?? 300),
                      height: state.contentModel!.isScrolled! ? 65.h : 125.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          widget.leading,
                           Text(smallScreen && widget.title.length > 20 ? widget.title.substring(0,18) + "..." : widget.title,
                               style: widget.titleStyle),
                          widget.rightIcon ?? Container(width: 40.w),
                        ],
                      ),
                    ),
                    IgnorePointer(
                      child: AnimatedContainer(
                        duration:  Duration(milliseconds: widget.animationSpeedInMilliseconds??300),
                        height: state.contentModel!.isScrolled!? 76.h: 180.h,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.7),
                                Colors.black
                              ],
                              stops: const [0,0.45,0.75,1.0],
                            )
    
                        ),
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(0, -50.h),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: widget.animationSpeedInMilliseconds ?? 300),
                    height: state.contentModel!.isScrolled! ? (MediaQuery.of(context).size.height) : 630.h,
                    child: ListView(
                      controller: _scrollController,
                      children: widget.children ?? [],
                  ),
                ),
              ),
            ],
          )
        );
      },
    );
  }
}