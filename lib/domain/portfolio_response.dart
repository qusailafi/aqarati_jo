class PortfolioResponse {
  bool? success;
  PortfolioData? data;
  String? message;

  PortfolioResponse({this.success, this.data, this.message});

  factory PortfolioResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioResponse(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? PortfolioData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class PortfolioData {
  double? totalPortfolioValue;
  double? totalInvested;
  double? unrealisedAppreciation;
  double? totalRentalIncome;
  double? roi;
  double? annualisedRentalReturn;

  PortfolioData({
    this.totalPortfolioValue,
    this.totalInvested,
    this.unrealisedAppreciation,
    this.totalRentalIncome,
    this.roi,
    this.annualisedRentalReturn,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      totalPortfolioValue: (json['totalPortfolioValue'] as num?)?.toDouble(),
      totalInvested: (json['totalInvested'] as num?)?.toDouble(),
      unrealisedAppreciation:
      (json['unrealisedAppreciation'] as num?)?.toDouble(),
      totalRentalIncome: (json['totalRentalIncome'] as num?)?.toDouble(),
      roi: (json['roi'] as num?)?.toDouble(),
      annualisedRentalReturn:
      (json['annualisedRentalReturn'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPortfolioValue': totalPortfolioValue,
      'totalInvested': totalInvested,
      'unrealisedAppreciation': unrealisedAppreciation,
      'totalRentalIncome': totalRentalIncome,
      'roi': roi,
      'annualisedRentalReturn': annualisedRentalReturn,
    };
  }
}
