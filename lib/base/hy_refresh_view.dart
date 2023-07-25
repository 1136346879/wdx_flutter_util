import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/define/hy_config.dart';
import 'package:hy_flutter_utils/widgets/hy_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HYRefreshView extends StatelessWidget {

  HYRefreshView({
    Key? key,
    required this.listView,
    required this.refreshController,
    this.onLoading,
    this.onRefresh,
    this.enableRefresh=true,
    this.enableLoading=true,
    this.idleWidget, this.failedWidget,
    this.canLoadingWidget,
    this.noMoreWidget,
    this.refreshHeader,
    this.loadFooter,
    this.idleTip,
    this.failedTip,
    this.canLoadingTip,
    this.noMoreTip,
    this.loadfailedOnTap,
  }): super(key: key);
  /// 上拉加载更多
  final VoidCallback? onLoading;
  /// 下拉刷新
  final VoidCallback? onRefresh;
  final RefreshController? refreshController;
  /// 是否可以下拉刷新
  final bool enableRefresh;
  /// 是否可以上啦加载更多
  final bool enableLoading;
  /// 加载控件
  final Widget listView;
  /// 未加载时候显示
  final Widget? idleWidget;
  /// 加载失败view
  final Widget? failedWidget;
  /// 正在加载中view
  final Widget? canLoadingWidget;
  /// 没有更多数据时候显示 不传显示默认
  final Widget? noMoreWidget;
  /// 顶部加载框 不传显示默认
  final Widget? refreshHeader;
  /// 底部加载框
  final Widget? loadFooter;
  /// 加载中提示
  final String? idleTip;
  /// 加载失败提示
  final String? failedTip;
  /// 正在加载
  final String? canLoadingTip;
  /// 没有更多数据
  final String? noMoreTip;
  /// 加载失败后点击显示提示文字点击事件
  final Function()? loadfailedOnTap;

  // header和footer暂时用默认的
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      // hideFooterWhenNotFull: true,
      child: SmartRefresher(
        controller: refreshController!,
        enablePullUp: enableLoading,
        enablePullDown: enableRefresh,
        onLoading: onLoading,
        onRefresh: onRefresh,
          header: (onRefresh != null)?(refreshHeader??WaterDropHeader(
            refresh: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: defaultTargetPlatform == TargetPlatform.iOS
                        ? const CupertinoActivityIndicator()
                        : const CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                  HyText.container('正在刷新数据中...',
                    margin: EdgeInsets.only(left: 8),
                    textColor: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
            completeDuration: Duration(milliseconds: 300) ,
            complete: Container(
              child: HyText.normal('下拉可以刷新',
                textColor: textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )) : SizedBox(width: 0,),
          footer: (onLoading != null)?(loadFooter??CustomFooter(
            builder: (BuildContext context,LoadStatus? mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                // body = SizedBox(width: 0, height: 0,);
                body =  idleWidget??Text(idleTip??"上拉加载更多", style: TextStyle(color: textColor, fontSize: 10),);
              }
              else if(mode==LoadStatus.loading){
                body =  CupertinoActivityIndicator();
              }
              else if(mode == LoadStatus.failed){
                body = failedWidget??HyText.container(failedTip??"加载失败!点击重试!", textColor: textColor, fontSize: 10, onTap: loadfailedOnTap, textAlign: TextAlign.center, alignment: Alignment.center,);
              }
              else if(mode == LoadStatus.canLoading){
                body = canLoadingWidget??Text(canLoadingTip??"释放加载更多", style: TextStyle(color: textColor, fontSize: 10),);
              }
              else{
                body = noMoreWidget??Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 50, right: 5),
                        height: 1.0,
                        color: noMoreTextColor,
                      ),
                    ),
                    Text(noMoreTip??"没有更多数据了", style: TextStyle(color: noMoreTextColor, fontSize: 10),),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 50),
                        height: 1.0,
                        color: noMoreTextColor,
                      ),
                    ),
                  ],
                );
              }
              return Container(
                height: 56,
                child: Center(child:body),
              );
            },
          )):null,
        child: listView
      ),
    );
  }


  Color get textColor => hyColor(light: Colors.black, dark: Colors.white);

  Color get noMoreTextColor => hyColor(light: Config.colorD3D3D3, dark: Colors.white);
}
