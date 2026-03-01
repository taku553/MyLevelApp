# Mission Leveler

ミッション（タスク群）を作成・完了することで経験値を獲得し、レベルアップしていく習慣化アプリ。  
Firebase Auth + Firestore によるクロスプラットフォームのリアルタイムデータ同期に対応。

## 主な機能

- ミッション作成・編集・完了
- タスク完了による経験値獲得とレベルアップ
- ミッション完了履歴の閲覧
- メール/パスワード認証によるアカウント管理
- Android / Web 間のリアルタイムデータ同期

## 技術スタック

- **Flutter** (Dart)
- **Riverpod** - 状態管理
- **GoRouter** - ルーティング
- **Hive** - ローカルキャッシュ
- **Firebase Auth** - メール/パスワード認証
- **Cloud Firestore** - クラウドデータベース（リアルタイム同期）
- **Freezed / json_serializable** - データモデル

## セットアップ手順

### 前提条件

- Flutter SDK がインストール済みであること
- Firebase CLI がインストール済みであること（`npm install -g firebase-tools`）
- Firebase プロジェクトが作成済みであること

### 1. リポジトリのクローン

```bash
git clone https://github.com/<your-username>/mylevelapp.git
cd mylevelapp
```

### 2. Firebase プロジェクトの設定

このリポジトリにはFirebase設定ファイルが含まれていないため、自身のFirebaseプロジェクトを接続する必要があります。

```bash
# Firebase CLIにログイン
firebase login

# FlutterFire CLIのインストール（未インストールの場合）
dart pub global activate flutterfire_cli

# Firebase設定ファイルの生成
flutterfire configure
```

このコマンドにより以下のファイルが自動生成されます:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `macos/Runner/GoogleService-Info.plist`

### 3. Firebase サービスの有効化

Firebase Console（https://console.firebase.google.com）で以下を設定してください:

#### Authentication
1. 「Authentication」→「Sign-in method」を開く
2. 「メール/パスワード」を有効化

#### Cloud Firestore
1. 「Firestore Database」→「データベースを作成」
2. リージョンは `asia-northeast1`（東京）を推奨
3. セキュリティルールを以下に設定:

```
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
    }
  }
}
```

### 4. 依存関係のインストールと起動

```bash
flutter pub get
flutter run
```

## プロジェクト構成

```
lib/
├── main.dart                  # エントリーポイント・認証フロー
├── firebase_options.dart      # Firebase設定（.gitignore対象）
├── core/
│   ├── auth/                  # 認証（AuthService, LoginScreen）
│   ├── router/                # GoRouter設定
│   ├── theme/                 # テーマ・カラー定義
│   └── widgets/               # 共通ウィジェット
└── features/
    ├── home/                  # ホーム画面・レベル表示
    │   ├── data/              # UserStatsRepository（Hive + Firestore）
    │   ├── domain/            # UserStats モデル
    │   ├── providers/         # UserStatsNotifier
    │   └── presentation/      # ホーム画面UI
    ├── mission/               # ミッション機能
    │   ├── data/              # MissionRepository（Hive + Firestore）
    │   ├── domain/            # Mission, Task モデル
    │   ├── providers/         # MissionListNotifier
    │   └── presentation/      # ミッション関連画面
    └── settings/              # 設定画面（ログアウト等）
```

