/// Created by wdx
/// on 2022-07-11
/// page hy_item_delegate

abstract class HYItemClickDelegate{

  /// item点击事件回调方法
  /// [section] 分区
  /// [row]     行数
  /// [clickType]  点击事件的类型
  /// [data]  传参
  /// [data1] 传参
  void didSelectCell({int? section, int? row, int? clickType, dynamic data, dynamic data1});

}

// typedef HYItemClickDelegate = Function({int section, int row, int clickType, dynamic data, dynamic data1});
