/// Created by wdx
/// on 2022/6/14
/// page hy_base_entity
/// desc

class BaseEntity<T> {

  T? data;
  T? list;
  String? code;
  String? message;
  dynamic? sub_code;
  String? sub_msg;
  dynamic? baseResponse;
  /// 统一处理的code,
  String? xfsCode;
  BaseEntity({this.data,this.code,this.message});


  BaseEntity.notNetwork({this.code='404', this.message="网络连接断开"});

  BaseEntity.error({this.code='-1000', this.message="未知错误"});

  BaseEntity.fromJson(Map<String, dynamic>? json) {

    if (json == null){
      return;
    }


    data = json['data'];
    list = json['list'];
    if (json['errorCode'] != null){
      code = '${json['errorCode']}';
    }
    else if (json['code'] != null){
      code = '${json['code']}';
    }
    String? errorString;
    if (json['errorMessage'] != null){
      errorString = json['errorMessage'];
    }
    if (json['message'] != null){
      errorString = json['message'];
    }
    if (json['msg'] != null){
      errorString = json['msg'];
    }
    message = errorString;
    sub_code = json['sub_code'];
    sub_msg = json['sub_msg'];
    baseResponse = json['baseResponse'];
    xfsCode = json['xfsCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['errorCode'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class HYPageModel<T> {

  /// 分页
  int? pageNumber;
  /// 分页数
  int? size;
  /// 总页
  int? totalPage;
  /// 总记录条数
  int? total;

  /// 是否有下一页
  bool get hasNext => pageNumber! >= totalPage! ? false : true;


  HYPageModel({this.pageNumber, this.size, this.totalPage,this.total,});

  /// 云采常用解析
  HYPageModel.fromJson(Map<dynamic, dynamic>? json) {
    if (json == null){
      return;
    }
    pageNumber = json['current'];
    size = json['size'];
    total = json['total'];
    totalPage = json['totalPage'];
  }
}