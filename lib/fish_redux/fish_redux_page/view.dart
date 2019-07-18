import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

//widget的构建，接受三个参数
//1、状态state  
//2、dispatch-用于发送操作数据的意图  
//3、viewService-一些扩展的服务
Widget buildView(FishReduxState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Center(
      child: Text(state.clone().toString(),style: TextStyle(color: Colors.deepPurple),),
    ),
  );
}
