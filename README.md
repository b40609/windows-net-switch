# Windows Network Switcher (Net_Switch)

一個輕量、快速的 Windows 網路快速切換小工具。一鍵在「實體有線網路（Ethernet）」與「無線網路（Wi-Fi）」之間無縫切換，省去手動開啟「網路連線」控制台的麻煩。

---

## 💡 特色

- **一鍵快速切換**：透過 `Net_Switch.vbs` 靜默調用 PowerShell，後台快速完成切換。
- **自動適應硬體**：自動辨識電腦上的實體 Wi-Fi 與 Ethernet 網卡，不綁定特定廠牌或型號（支援 Intel、Realtek、Killer 等）。
- **多語系相容**：自動相容繁體中文（乙太網路）、簡體中文（以太网）與英文（Ethernet）系統介面名稱。
- **綠色免安裝**：解壓縮或下載即可直接使用，無需額外安裝執行檔。

---

## 📁 檔案結構

```text
Net_Switch/
├── Net_Switch.vbs       # 啟動腳本（雙擊此檔執行，會請求管理員權限並隱藏後台視窗）
├── switch_network.ps1   # 核心邏輯（自動偵測網卡狀態並執行切換）
└── README.md
```

---

## 🚀 使用方法

1. 將本專案下載至電腦任一目錄（例如 `D:\Tools\Net_Switch` 或桌面）。
2. 直接雙擊 **`Net_Switch.vbs`**：
   - 系統彈出 UAC（使用者帳戶控制）提示時，點選 **「是」**。
   - 工具會自動偵測目前的網路狀態：若當前連線為 Wi-Fi，則切換至有線網路；反之亦然。

### 💡 實用小撇步（建立桌面捷徑與熱鍵）
1. 對 `Net_Switch.vbs` 按右鍵 -> **「傳送到」->「桌面 (建立捷徑)」**。
2. 在桌面捷徑上按右鍵 -> **「內容」**：
   - 可以點擊 **「變更圖示」** 選擇網路相關圖示。
   - 可以在 **「快速鍵」** 設定快捷鍵（例如 `Ctrl + Alt + N`），實現隨時鍵盤一鍵切網。

---

## 🛠️ 命令列測試（檢查狀態）

若想在終端機查看當前網路卡狀態，可開啟 PowerShell 執行：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\switch_network.ps1 status
```

輸出範例：
```text
Wi-Fi   [Wi-Fi]: Up
Ethernet[乙太網路] : Disabled
```

---

## ⚙️ 系統需求

- 作業系統：Windows 10 / Windows 11
- 權限需求：切換網路卡需要本機系統管理員權限（UAC 提示）

---

## 📄 License

MIT License
