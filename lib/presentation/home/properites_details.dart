
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../domain/preoperites/properites_response.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';
import '../../utils/utils.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/circular-card.dart';
import '../../widgets/dash_line.dart';
import '../payment/payment_screen.dart';

class ProperitesDetails extends StatelessWidget {
  final ProperitesData data;
  final PageController _controller = PageController();
  final bool isOpen;
  final RxBool isExpanded = false.obs;

  ProperitesDetails({required this.data, required this.isOpen});

  // ألوان من ColorHelper فقط
  Color get _ink => ColorHelper.primaryColor; // أسود
  Color get _subInk => ColorHelper.tertiryColor; // رمادي
  Color get _bg => ColorHelper.secondaryColor; // أبيض
  Color get _chipBg => ColorHelper.pr; // رمادي فاتح جداً
  Color get _line => const Color(0xFFE6E6E6); // حدود خفيفة

  @override
  Widget build(BuildContext context) {
    final heigh = MediaQuery.of(context).size.height;
    final progressValue = (data.progressPercentage ?? 0) / 100.0;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: cardWidget(
          context,
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // معرض الصور العلوي
                // =========================
                SizedBox(
                  height: heigh * 0.33,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        child: PageView.builder(
                          controller: _controller,
                          itemCount: data.images?.length ?? 0,
                          itemBuilder: (context, index) {
                            final url = Utils.IMAGE_PATH +
                                (data.images?[index].imageUrl ?? '');
                            return Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade300,
                                alignment: Alignment.center,
                                child:
                                    const Icon(CupertinoIcons.photo, size: 32),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                _bg.withOpacity(1),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  _ink.withOpacity(0.15),
                                  Colors.transparent,
                                  _ink.withOpacity(0.25),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // أزرار Back/Share زجاجية
                      Positioned(
                        top: 12,
                        left: 12,
                        right: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _GlassIconButton(
                              icon: CupertinoIcons.back,
                              onTap: () => Get.back(),
                            ),
                          ],
                        ),
                      ),
                      // مؤشر الصفحات
                      Positioned(
                        bottom: 14,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: data.images?.length ?? 0,
                            effect: WormEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 8,
                              activeDotColor: _ink,
                              dotColor: _bg.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // =========================
                // العنوان و Chips مختصرة
                // =========================
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
                  child: Text(
                    data.title ?? "",
                    style: TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      height: 1.2,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _InfoIcon(
                       "rooms.png",
                        data.rooms?.toString() ?? "0",
                      ),
                      const SizedBox(width: 6),
                      _InfoIcon(
                        "bath_room.png",
                        data.bathrooms?.toString() ?? "0",
                      ),
                      const SizedBox(width: 6),
                      _InfoIcon(
                        "area.png",
                        data.area?.toString() ?? "0",
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                  child: Row(
                    children: [
                      Text(S.of(context).aed,
                          style: TextStyle(fontSize: 20, color: _subInk)),
                      const SizedBox(width: 6),
                      Text(
                        "${data.basePrice ?? ''}",
                        style: TextStyle(
                            fontSize: 24,
                            color: _ink,
                            fontWeight: FontWeight.w800),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _chipBg,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: _line),
                        ),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.chart_bar,
                                size: 16, color: _ink),
                            const SizedBox(width: 6),
                            Text(
                              "${data.progressPercentage ?? 0}% ${S.of(context).funed}",
                              style: TextStyle(
                                  color: _ink, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: progressValue.clamp(0.0, 1.0),
                      backgroundColor: _line,
                      valueColor: AlwaysStoppedAnimation<Color>(_ink),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      Text("${S.of(context).avilable_shares}: ",
                          style: TextStyle(color: _subInk, fontSize: 14)),
                      Text(
                        (data.availableShares ?? '').toString(),
                        style: TextStyle(
                            color: _ink,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _SectionCard(
                    title: S.of(context).invenstment_summary,
                    ink: _ink,
                    border: _line,
                    child: Column(
                      children: [
                        _kvRow(
                            S.of(context).totsl_share,
                            (data.totalShares ?? '').toString(),
                            _ink,
                            _subInk,
                            _line),
                        _kvRow(
                            S.of(context).price_per_hare,
                            (data.pricePerShare ?? '').toString(),
                            _ink,
                            _subInk,
                            _line),
                        _kvRow(
                            S.of(context).total_investment,
                            (data.totalInvestment ?? '').toString(),
                            _ink,
                            _subInk,
                            _line),
                        _kvRow(
                            S.of(context).share_sold,
                            (data.sharesSold ?? '').toString(),
                            _ink,
                            _subInk,
                            Colors.transparent),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _Pill(text: "Freehold"),
                      _Pill(text: "Ready to Move"),
                      _Pill(text: "Furnished"),
                      _Pill(text: "Service Charges: —"),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.location_solid,
                          size: 18, color: _ink),
                      const SizedBox(width: 6),
                      Text(S.of(context).adress,
                          style: TextStyle(
                              color: _ink, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),

                // عملية الاستثمار (قابلة للطي)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Obx(
                    () => Column(
                      children: [
                        GestureDetector(
                          onTap: () => isExpanded.toggle(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).whats_process,
                                style: TextStyle(
                                    color: _ink,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                              Icon(
                                isExpanded.value
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 28,
                                color: _ink,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 250),
                          crossFadeState: isExpanded.value
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild:
                              _ProcessTimeline(ink: _ink, subInk: _subInk),
                          secondChild: const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),

                // لماذا تستثمر
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                  child: _SectionCard(
                    title: S.of(context).why_invest_property,
                    ink: _ink,
                    border: _line,
                    child: Column(
                      children: [
                        _Bullet(
                            title: S.of(context).modern_marina,
                            subtitle: S.of(context).modern_marena_desc,
                            inkColor: _ink,
                            subColor: _subInk),
                        _Bullet(
                            title: S.of(context).strong_rental_appeal,
                            subtitle: S.of(context).strong_rental_desc,
                            inkColor: _ink,
                            subColor: _subInk),
                        _Bullet(
                            title: S.of(context).premiuem_faciles,
                            subtitle: S.of(context).premiuem_fciltes_desc,
                            inkColor: _ink,
                            subColor: _subInk),
                        _Bullet(
                            title: S.of(context).market_value,
                            subtitle: S.of(context).market_value_desc,
                            inkColor: _ink,
                            subColor: _subInk),
                        _Bullet(
                            title: S.of(context).prime_location,
                            subtitle: S.of(context).prime_location_desc,
                            inkColor: _ink,
                            subColor: _subInk),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
          null,
        ),
      ),

      // زر الدفع السفلي
      bottomNavigationBar: isOpen
          ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _ink,
                    foregroundColor: _bg,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: () => Get.to(PaymentScreen(data: data)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).pay,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      const Icon(CupertinoIcons.arrow_right),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }

  // ===== Helpers
  Widget _kvRow(String k, String v, Color ink, Color sub, Color divider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(child: Text(k, style: TextStyle(color: sub))),
              Text(v,
                  style: TextStyle(color: ink, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        if (divider.opacity > 0) Divider(height: 1, color: divider),
      ],
    );
  }
}

// =========================
// Widgets مساعدة
// =========================

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorHelper.secondaryColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.9)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 14,
                offset: const Offset(0, 6)),
          ],
        ),
        child: Icon(icon, color: ColorHelper.primaryColor, size: 20),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final Color bg;
  final Color ink;
  final Color subInk;
  final Color border;

  const _InfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.subLabel,
    required this.bg,
    required this.ink,
    required this.subInk,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: ink),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(color: ink, fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
          Text(subLabel, style: TextStyle(color: subInk, fontSize: 12)),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Color ink;
  final Color border;

  const _SectionCard(
      {super.key,
      required this.title,
      required this.child,
      required this.ink,
      required this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.secondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: ink, fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}

class _ProcessTimeline extends StatelessWidget {
  final Color ink;
  final Color subInk;

  const _ProcessTimeline({super.key, required this.ink, required this.subInk});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StepTile(
            step: "1",
            title: S.of(context).found_property,
            subtitle: S.of(context).find_desc,
            inkColor: ink,
            subColor: subInk),
        _StepTile(
            step: "2",
            title: S.of(context).invest_long,
            subtitle: S.of(context).invest_long_desc,
            inkColor: ink,
            subColor: subInk),
        _StepTile(
            step: "3",
            title: S.of(context).setup_spv,
            subtitle: S.of(context).setup_spv_desc,
            inkColor: ink,
            subColor: subInk),
        _StepTile(
            step: "4",
            title: S.of(context).property_trnsfare,
            subtitle: S.of(context).property_trnsfare_desc,
            inkColor: ink,
            subColor: subInk),
        _StepTile(
            step: "5",
            title: S.of(context).earn_monthly,
            subtitle: S.of(context).earn_monthly,
            inkColor: ink,
            subColor: subInk,
            isLast: true),
      ],
    );
  }
}

class _StepTile extends StatelessWidget {
  final String step;
  final String title;
  final String subtitle;
  final Color inkColor;
  final Color subColor;
  final bool isLast;

  const _StepTile({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
    required this.inkColor,
    required this.subColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorHelper.primaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(step,
                  style: TextStyle(
                      color: ColorHelper.secondaryColor,
                      fontWeight: FontWeight.w700)),
            ),
            if (!isLast)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: const VerticalDashedLine(
                  height: 44,
                  color: Colors.grey,
                  thickness: 2,
                  dashHeight: 6,
                  dashGap: 4,
                ),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: 14),
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: inkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style:
                        TextStyle(color: subColor, fontSize: 14, height: 1.35)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color inkColor;
  final Color subColor;

  const _Bullet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.inkColor,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(CupertinoIcons.checkmark_seal_fill,
              size: 18, color: ColorHelper.primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: inkColor, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: subColor, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;

  const _Pill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorHelper.pr,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: ColorHelper.primaryColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// =========================
// و Widget المساعدة للأيقونات
// =========================
class _InfoIcon extends StatelessWidget {
  final String icon;
  final String value;

  const _InfoIcon(this.icon, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ColorHelper.pr, // خلفية رمادية فاتحة جدًا
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(width: 18,height: 18,
            child: Image.asset(Utils.getImgePath(icon)

             ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: ColorHelper.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
