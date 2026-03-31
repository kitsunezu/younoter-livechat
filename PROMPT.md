# YouNoter

**YouTube Live Chat 專業管理工具**  
專為 YouTube 直播主設計的輕量 Desktop 應用程式

## 專案概述

YouNote Live 是一款純本機運行的跨平台 Desktop/Mobile APP 應用程式，旨在解決 YouTube 直播聊天室僅顯示 @handle 的問題，並提供完整的觀眾管理與 Super Chat 處理功能。

直播主只需貼上直播 URL，即可即時監聽聊天室、顯示原始顯示名稱（displayName@handle）、為觀眾新增永久備註，並將 Super Chat 獨立管理。所有資料均儲存於使用者本地裝置，無需任何雲端伺服器或外部後端，完全符合隱私與個人使用需求。

## 核心目標

- 解決官方聊天室僅顯示 handle 的閱讀不便
- 實現觀眾備註記憶功能（跨直播自動載入）
- 提供專業的 Super Chat 管理頁面（可標記已閱讀 / 已處理）
- 附帶即時統計儀表板
- 完全本機運行，適合長時間直播使用

## 技術棧（最高效推薦）

| 層級 | 技術 | 說明 |
|---|---|---|
| 框架 | Flutter 3.27+ (Dart 3.6+) | Desktop + Mobile 單一程式碼庫 |
| 資料庫 | drift ^2.22 + NativeDatabase | 類型安全 SQLite ORM，支援 Stream queries |
| YouTube API | googleapis ^14.0 + http | 官方 YouTube Data API v3 Dart client |
| 狀態管理 | flutter_riverpod ^2.6 | StreamProvider 原生支援即時串流 |
| 路由 | go_router ^14.8 | 聲明式路由，支援多頁籤 |
| 圖表 | fl_chart ^0.70 | 統計儀表板 |
| 視窗控制 | window_manager ^0.4 | Desktop 視窗置頂、大小調整 |
| i18n | flutter_localizations + intl | 官方 ARB 格式 |
| 打包 | msix (Win) / create-dmg (Mac) / fastforge (Linux) | 跨平台安裝檔 |

## 主要功能

### 1. 直播連線與聊天室顯示
- 貼上 YouTube 直播 URL 後自動解析 videoId 與 liveChatId
- 即時取得並顯示聊天訊息
- 預設顯示原始 `displayName`，可切換顯示 `@handle`
- 點擊觀眾名稱開啟側邊欄，快速新增 / 編輯備註，詳細資料

### 2. 觀眾管理系統（記憶功能）
- 以 `channelId` 作為唯一鍵，建立永久觀眾資料庫
- 儲存內容包括：displayName、handle、歷史名稱變更、自訂備註
- 跨不同直播自動載入同一觀眾的備註

### 3. Super Chat 獨立管理頁面
- 獨立頁籤顯示所有 Super Chat / Super Sticker
- 顯示欄位：金額、訊息內容、觀眾資訊、時間戳記
- 一鍵標記「已閱讀」或「已處理」（狀態永久保存）
- 支援搜尋、篩選與排序（依金額、時間、狀態等）

### 4. 統計儀表板
- 即時顯示：總訊息數、Super Chat 總額、Top 捐贈觀眾、活躍觀眾數
- 簡易圖表呈現

### 5. 其他功能
- 直播 URL 歷史記錄（快速重新載入）
- 深色 / 淺色模式、視窗置頂、可調整布局、i18n
- 應用程式自動更新支援
- 極簡操作流程：開啟 App → 貼上 URL → 開始使用
- 歷史聊天室則產生聊天記錄

## 非功能需求

- **完全本機運行**：無需安裝資料庫、無需登入、無需連線任何外部伺服器
- **效能優化**：低 CPU 與記憶體占用，適合長時間直播
- **資料隱私**：所有 SQLite 資料僅儲存於使用者本地裝置
- **打包發佈**：產生單一安裝檔，方便直播主直接下載使用

## 開發優先順序（MVP）

1. 基本聊天室連線與顯示（displayName + handle）
2. SQLite 觀眾備註系統
3. Super Chat 獨立頁面與標記功能
4. 統計儀表板
5. 跨平台打包與安裝檔產生