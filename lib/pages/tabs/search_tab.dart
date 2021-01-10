import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khophim/controllers/search_controller.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/widgets/custom_loading.dart';
import 'package:khophim/widgets/custom_movie_grid_view.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => _buildSearchList(context: context),
        ),
        SIZED_BOX_H05,
        Obx(
          () => _buildTextFormField(context: context),
        ),
        SIZED_BOX_H05,
      ],
    );
  }
}

Widget _buildSearchList({@required BuildContext context}) {
  final SearchController controller = Get.find<SearchController>();
  if (controller.first.value) {
    return Expanded(
      child: Center(
        child: Text(
          "Nhập tên phim cần tìm vào ô bên dưới.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  } else {
    if (controller.minText.value) {
      return Expanded(
        child: Center(
          child: Text(
            "Vui lòng nhập ít nhất 5 ký tự",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      );
    } else {
      if (controller.nameList.length > 0) {
        return Expanded(
          child: CustomMovieGridView(
            imageList: controller.imageList,
            linkList: controller.linkList,
            nameList: controller.nameList,
            itemCount: controller.nameList.length,
            name: "",
            scrollController: controller.scrollController,
          ),
        );
      } else {
        return Expanded(
          child: CustomLoading(),
        );
      }
    }
  }
}

Widget _buildTextFormField({@required BuildContext context}) {
  final SearchController controller = Get.find<SearchController>();
  return AnimatedOpacity(
    opacity: controller.showTextFormField.value ? 1.0 : 0.0,
    duration: Duration(milliseconds: 1000),
    child: Visibility(
      visible: controller.showTextFormField.value,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(05),
          topRight: Radius.circular(05),
        ),
        child: Padding(
          padding: PAD_SYM_H10,
          child: TextFormField(
            controller: controller.searchText,
            style: Theme.of(context).textTheme.bodyText1,
            onChanged: (v) => controller.loadSearchList(),
            maxLength: 50,
            decoration: InputDecoration(
              contentPadding: PAD_SYM_H10,
              hintText: STR_SEARCH_HINT,
              hintStyle: Theme.of(context).textTheme.bodyText1,
              helperStyle: Theme.of(context).textTheme.bodyText2,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.all(Radius.circular(05)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.all(Radius.circular(05)),
              ),
              suffixIcon: Visibility(
                visible: controller.showClearText.value,
                child: GestureDetector(
                  onTap: () => controller.onTapClearText(),
                  child: Icon(
                    Icons.cancel,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
