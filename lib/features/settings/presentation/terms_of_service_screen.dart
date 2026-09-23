import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/max_width_container.dart';

/// 利用規約の条文
class _TermsSection {
  final String title;
  final String body;

  const _TermsSection({required this.title, required this.body});
}

const _termsSections = <_TermsSection>[
  _TermsSection(
    title: '第1条（適用）',
    body:
        '本規約は、Takuのアトリエ（以下「運営者」）が提供するアプリ「Mission Leveler」'
        '（以下「本アプリ」）の利用条件を定めるものです。ユーザーは本規約に同意の上、'
        '本アプリを利用するものとします。',
  ),
  _TermsSection(
    title: '第2条（アカウント登録）',
    body:
        '1. 本アプリの利用にはメールアドレスおよびパスワードによるアカウント登録が必要です。\n'
        '2. ユーザーは登録情報を最新かつ正確に保つものとし、パスワードの管理責任を負います。\n'
        '3. 未成年者が利用する場合、保護者の同意を得た上で利用するものとします。',
  ),
  _TermsSection(
    title: '第3条（禁止事項）',
    body:
        'ユーザーは以下の行為を行ってはなりません。\n'
        '・不正アクセス、リバースエンジニアリング等アプリの脆弱性を利用する行為\n'
        '・他者になりすます行為、複数アカウントを不正に取得する行為\n'
        '・本アプリの運営を妨害する行為\n'
        '・法令または公序良俗に違反する行為',
  ),
  _TermsSection(
    title: '第4条（ユーザー作成コンテンツ）',
    body:
        '1. ユーザーが作成するミッション名、タスク内容、目標・現状に関する入力データ等'
        '（以下「ユーザーコンテンツ」）の権利はユーザーに帰属します。\n'
        '2. 運営者は、本アプリの機能提供（表示・保存・バックアップ・AIメッセージ生成等）の'
        '目的の範囲内でのみユーザーコンテンツを利用します。',
  ),
  _TermsSection(
    title: '第5条（AIによる励ましメッセージ機能）',
    body:
        '1. 本アプリの有料機能として、ユーザーがあらかじめ入力した目標・現状等の情報をもとに、'
        '外部AIサービス（Anthropic社のClaude API）を利用して個別の励ましメッセージを'
        '生成・提供する機能があります。\n'
        '2. 当該機能の利用にあたり、ユーザーが入力した情報の一部が第三者であるAPI提供事業者に'
        '送信されることに、ユーザーはあらかじめ同意するものとします。送信されるデータの範囲は'
        'プライバシーポリシーに定めます。\n'
        '3. AIが生成するメッセージの内容は自動生成によるものであり、その正確性・完全性・'
        'ユーザーの目標達成や心身の状態への適合性を運営者は保証しません。\n'
        '4. 本機能は医療的・心理的な専門助言を目的としたものではなく、これに代わるものでは'
        'ありません。不適切な内容が生成された場合は、運営者所定の窓口までご報告ください。',
  ),
  _TermsSection(
    title: '第6条（有料機能・サブスクリプション）',
    body:
        '1. 本アプリは、AI励ましメッセージ機能、コンフェッティアニメーションパターンの'
        '選択機能等を含むサブスクリプションプラン（以下「本プラン」）を提供します。\n'
        '2. 本プランには7日間の無料試用期間を設けます。無料試用期間中に解約手続きを行わない'
        '場合、期間終了と同時に自動的に有料契約へ移行し、利用料金が課金されます。\n'
        '3. 課金・自動更新・解約は、ご利用のApp Store／Google Playの設定を通じて行うものとし、'
        '詳細な料金は各ストアの購入画面表示に従います。\n'
        '4. デジタルコンテンツの性質上、購入後の返金には応じられません。詳細は各アプリストアの'
        '規約に従います。',
  ),
  _TermsSection(
    title: '第7条（知的財産権）',
    body:
        '本アプリのソースコード、デザイン、アニメーション素材（コンフェッティパターンを含む）'
        'その他一切の著作権・知的財産権は運営者または正当な権利者に帰属します。',
  ),
  _TermsSection(
    title: '第8条（免責事項）',
    body:
        '1. 本アプリのレベルアップ・経験値等の仕組みは、ユーザーの目標達成を支援する'
        'モチベーションツールであり、実際の成果や能力向上を保証するものではありません。\n'
        '2. 通信障害、外部API（AI機能を含む）の障害・仕様変更、端末の故障等によりサービスの'
        '全部または一部が利用できない場合が生じ得ることを、ユーザーはあらかじめ了承するものとします。\n'
        '3. 運営者は、本アプリの利用によりユーザーに生じた損害について、運営者の故意または'
        '重過失による場合を除き、責任を負いません。',
  ),
  _TermsSection(
    title: '第9条（サービスの変更・中断・終了）',
    body: '運営者は、事前の予告をもって本アプリの内容の変更、提供の中断・終了を行うことができるものとします。',
  ),
  _TermsSection(
    title: '第10条（規約の変更）',
    body: '運営者は必要と判断した場合、本規約を変更できるものとします。変更後の規約はアプリ内での掲示をもって効力を生じるものとします。',
  ),
  _TermsSection(
    title: '第11条（準拠法・管轄裁判所）',
    body:
        '本規約の解釈にあたっては日本法を準拠法とし、本アプリに関して紛争が生じた場合には、'
        '東京地方裁判所を第一審の専属的合意管轄裁判所とします。',
  ),
  _TermsSection(
    title: '第12条（お問い合わせ）',
    body: '本規約に関するお問い合わせは、以下までご連絡ください。\nメールアドレス：support@taku-atelier.com',
  ),
];

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '利用規約',
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
          itemCount: _termsSections.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final section = _termsSections[index];
            return _buildSection(section);
          },
        ),
      ),
    );
  }

  Widget _buildSection(_TermsSection section) {
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
