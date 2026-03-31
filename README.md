# YouNoter

A Flutter desktop app for monitoring and managing YouTube Live chat in real time — no API key required.

## Features

- **Live Chat Monitor** — Connects to any YouTube Live stream and polls chat messages in real time
- **Super Chat Management** — Tracks all Super Chats and Super Stickers with amount, currency, tier color, and read/processed status
- **Viewer Profiles** — Builds a local database of viewers with name history, notes, message count, and Super Chat totals
- **Dashboard** — Statistics overview: unique viewer count, message count, Super Chat distribution by currency and tier
- **Membership Events** — Captures new member joins, gifted memberships, and milestone messages
- **No API Key Required** — Works out of the box by scraping public chat data; optionally provide a YouTube Data API v3 key for higher rate limits
- **Multi-language UI** — English, 繁體中文, 日本語, 한국어, Español, Français, Deutsch, Português

## Download

Grab the latest release from the [Releases page](https://github.com/kitsunezu/younoter-livechat/releases):

| File | Description |
|------|-------------|
| `YouNoter-vX.X.X-windows-installer.msix` | Windows installer (double-click to install) |
| `YouNoter-vX.X.X-windows-portable.zip` | Portable version (extract & run, no install needed) |

> **Note:** The MSIX installer is self-signed. On first install, you may need to right-click → **Properties** → **Digital Signatures** → install the certificate to **Trusted People** store, then run the `.msix` again.

## Screenshots

> _Add screenshots here_

## Requirements

| Tool | Version |
|------|---------|
| Flutter | ≥ 3.27.0 |
| Dart SDK | ≥ 3.6.0 |
| Platform | Windows / macOS / Linux |

## Getting Started

### 1. Clone & install dependencies

```bash
git clone https://github.com/kitsunezu/younoter-livechat.git
cd younoter-livechat
flutter pub get
```

### 2. Generate code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Run

```bash
flutter run -d windows   # or -d macos / -d linux
```

## Usage

1. Launch the app and paste any YouTube Live URL into the top bar (e.g. `https://www.youtube.com/watch?v=VIDEO_ID`)
2. Click **Connect** — the app starts polling chat without any additional setup
3. Browse tabs:
   - **Chat** — live message feed; click a viewer to open their profile
   - **Super Chat** — filter, sort, and mark Super Chats
   - **Dashboard** — aggregated stats and charts
   - **Viewers** — search all known viewers across sessions
   - **Membership** — new members, gifts, milestones
4. Open **Settings** to optionally add a YouTube Data API v3 key, switch themes, change the display language, and more

### Supported URL Formats

```
https://www.youtube.com/watch?v=VIDEO_ID
https://youtu.be/VIDEO_ID
https://www.youtube.com/live/VIDEO_ID
```

## Architecture

```
lib/
├── main.dart
├── app/                  # App shell, theme, router (go_router)
├── core/
│   ├── database/         # drift (SQLite) tables, DAOs
│   ├── providers/        # Riverpod providers
│   ├── services/         # Settings persistence
│   └── youtube/          # LiveChatManager, API service, scrape service, models
└── features/
    ├── chat/             # Real-time chat feed
    ├── superchat/        # Super Chat list & management
    ├── dashboard/        # Statistics & charts
    ├── viewers/          # Viewer search & profiles
    ├── membership/       # Membership event feed
    └── settings/         # App settings
```

**Key dependencies:**

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State management |
| `drift` | SQLite ORM with reactive streams |
| `go_router` | Declarative routing |
| `fl_chart` | Dashboard charts |
| `window_manager` | Desktop window control (always-on-top, title) |
| `http` + `html` | YouTube chat scraping |
| `googleapis` | YouTube Data API v3 (optional) |

## Configuration

### YouTube Data API v3 Key (optional)

The app works without a key by scraping public chat data. To add a key for higher polling rate limits:

1. Go to [Google Cloud Console](https://console.cloud.google.com/) → **APIs & Services** → **Credentials**
2. Create an API key and enable the **YouTube Data API v3**
3. Paste the key in the app's **Settings** page

## Building a Release

### Manual build

```bash
# Build Windows executable
flutter build windows --release

# Create MSIX installer
dart run msix:create
```

Outputs:
- Executable: `build/windows/x64/runner/Release/`
- MSIX: `build/windows/x64/runner/Release/younoter.msix`

### Automated release (CI/CD)

This project uses GitHub Actions to automatically build and publish releases. To trigger a release:

```bash
git tag v1.0.0
git push origin v1.0.0
```

The workflow will:
1. Build the Windows release
2. Create an MSIX installer
3. Package a portable ZIP
4. Upload both to a new GitHub Release with auto-generated release notes

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License.
