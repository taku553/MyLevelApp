import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/max_width_container.dart';

/// プライバシーポリシーの条文
class _PrivacySection {
  final String title;
  final String body;

  const _PrivacySection({required this.title, required this.body});
}

const _privacySections = <_PrivacySection>[
  _PrivacySection(
    title: '第1条（事業者情報）',
    body:
        'Takuのアトリエ（以下「運営者」）は、本アプリ「Mission Leveler」の提供にあたり、'
        '取得する個人情報を本ポリシーに従い適切に取り扱います。',
  ),
  _PrivacySection(
    title: '第2条（取得する情報）',
    body:
        '運営者は本アプリの提供にあたり、以下の情報を取得します。\n'
        '・アカウント情報：メールアドレス、パスワード（暗号化して管理）\n'
        '・ユーザーコンテンツ：ミッション名、タスク内容\n'
        '・AI励ましメッセージ機能の入力データ：ユーザーが入力する目標・現状に関する記述\n'
        '・利用状況データ：レベル、経験値、ミッション達成履歴等\n'
        '・課金状況：サブスクリプションの契約状態（決済情報自体は各アプリストアが管理し、'
        '運営者は保持しません）',
  ),
  _PrivacySection(
    title: '第3条（利用目的）',
    body:
        '取得した情報は以下の目的で利用します。\n'
        '・本アプリのアカウント管理およびサービス提供のため\n'
        '・AIによる個別の励ましメッセージを生成するため、入力データを外部AIサービス'
        '（Anthropic社のClaude API）へ送信するため\n'
        '・サブスクリプションの契約状況を確認し、有料機能の提供可否を判定するため\n'
        '・お問い合わせ対応のため',
  ),
  _PrivacySection(
    title: '第4条（第三者提供・外部送信）',
    body:
        '1. 運営者は、以下の外部事業者に対し、必要な範囲で情報を送信・委託します。\n'
        '・Google LLC（Firebase）：アカウント認証およびデータの保存基盤として\n'
        '・Anthropic社（Claude API）：AI励ましメッセージ生成のため、ユーザーが入力した'
        '目標・現状のテキストを送信します。送信されたデータはAnthropic社側で保持・処理され、'
        '運営者はそのデータを自社サーバーやアプリ内には保持しません。\n'
        '・Apple Inc. / Google LLC：サブスクリプションの決済処理のため（決済手段の登録・'
        '課金処理は各アプリストアの仕組みを利用し、運営者独自の決済プラットフォーム'
        '（Stripe等）は使用しません）\n'
        '2. 上記事業者の一部はユーザーの居住地国以外（米国等）にサーバーを設置している'
        '場合があります。',
  ),
  _PrivacySection(
    title: '第5条（サブスクリプションとデータの取り扱い）',
    body:
        '1. サブスクリプションの有無にかかわらず、ユーザーが作成したミッション・タスク・'
        'レベル・経験値等のデータの取り扱いに違いはありません。\n'
        '2. 有料プランの解約時は、AIによる励ましメッセージ等の有料機能が利用できなくなる'
        'のみで、これまでに達成したミッション・タスク・レベル等のデータは削除されず、'
        '引き続き保持されます。',
  ),
  _PrivacySection(
    title: '第6条（アカウント削除時のデータの取り扱い）',
    body:
        'アカウントを削除した場合、サブスクリプションの契約状況にかかわらず、登録された'
        'メールアドレス・パスワード、およびユーザーが本アプリ上で達成したミッション・'
        'タスク・レベル・経験値等のすべてのデータが削除されます。削除後のデータ復元は'
        'できませんので、あらかじめご了承ください。',
  ),
  _PrivacySection(
    title: '第7条（保存期間）',
    body:
        '運営者は、アカウントが存続する期間中、取得した情報を保持します。アカウント削除が'
        '行われた場合は前条に従いデータを削除します。',
  ),
  _PrivacySection(
    title: '第8条（ユーザーの権利）',
    body:
        'ユーザーは、運営者に対し自己の個人情報の開示・訂正・利用停止・削除を求めることが'
        'できます。お問い合わせ窓口までご連絡ください。また、アプリ内の「データを削除」'
        '「アカウント削除」機能からも削除操作が可能です。',
  ),
  _PrivacySection(
    title: '第9条（セキュリティ対策）',
    body:
        '運営者は、通信の暗号化（TLS）およびFirebaseの認証・アクセス制御機構を用いて、'
        '取得した情報への不正アクセス、漏えい、滅失またはき損の防止に努めます。',
  ),
  _PrivacySection(
    title: '第10条（未成年者の利用）',
    body: '未成年者が本アプリを利用する場合は、保護者の同意を得た上でご利用ください。',
  ),
  _PrivacySection(
    title: '第11条（本ポリシーの変更）',
    body:
        '運営者は必要と判断した場合、本ポリシーを変更できるものとします。変更後の内容は'
        'アプリ内での掲示をもって効力を生じるものとします。',
  ),
  _PrivacySection(
    title: '第12条（お問い合わせ）',
    body: '本ポリシーに関するお問い合わせは、以下までご連絡ください。\nメールアドレス：support@taku-atelier.com',
  ),
];

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'プライバシーポリシー',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: MaxWidthContainer(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _privacySections.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final section = _privacySections[index];
            return _buildSection(section);
          },
        ),
      ),
    );
  }

  Widget _buildSection(_PrivacySection section) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            section.body,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
