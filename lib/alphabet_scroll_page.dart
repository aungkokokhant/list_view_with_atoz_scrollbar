import 'dart:ui';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

class _AZItem extends ISuspensionBean{
  final String title;
  final String tag;
  
  _AZItem({
    required this.title,
    required this.tag
  });

  @override
  String getSuspensionTag() => tag;
}


class AlphabetScrollPage extends StatefulWidget {

  final List<String> items;
  final ValueChanged<String> onClickedItem;

  const AlphabetScrollPage({Key? key, required this.items,required this.onClickedItem}) : super(key: key);

  @override
  State<AlphabetScrollPage> createState() => _AlphabetScrollPageState();
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage> {

  List<_AZItem> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initList(widget.items);
  }

  void initList(List<String> items){
    this.items = items.map((item) => _AZItem(title: item, tag: item[0].toUpperCase())).toList();
    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      padding: const EdgeInsets.all(16),
      data: items,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildListItem(item);
      },
      indexHintBuilder: (context,hint) => Container(
        alignment: Alignment.center,
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue
        ),
        child: Text(
          hint,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
      ),
      indexBarMargin: const EdgeInsets.all(10),
      indexBarOptions: const IndexBarOptions(
        selectTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        selectItemDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue
        ),
        needRebuild: true,
        indexHintAlignment: Alignment.centerRight,
        indexHintOffset: Offset(-20,0),
      ),
    );
  }

  Widget _buildListItem(_AZItem item){

    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;

    return Column(
      children: [
        Offstage(offstage: offstage,child: buildHeader(tag)),
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: ListTile(
            title:  Text(item.title),
            onTap: ()=> widget.onClickedItem(item.title),
          ),
        ),
      ],
    );
  }

  Widget buildHeader (String tag)=>Container(
    height: 40,
    margin: const EdgeInsets.only(right: 16),
    padding: const EdgeInsets.only(left: 16),
    color: Colors.grey.shade300,
    alignment: Alignment.centerLeft,
    child: Text(
      tag,
      softWrap: false,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}
