# Waybar 配置 - Lambda 演算主题

一个为 niri 设计的精美 Waybar 配置，采用 Lambda 演算风格和 Gruvbox Dark 配色方案。

[English](./README.md)

> 本 `niri` 分支将原本的 Hyprland 配置适配到 niri。Hyprland 版本位于 `main` 分支。

## 截图预览

![Waybar 预览](./Screenshot.png)

- 底部栏，自定义工作区指示器
- MPRIS 媒体播放器与音频可视化
- 使用 lambda 符号的系统信息
- 自定义截屏和电源菜单

## 特性

### 🎨 设计
- **主题**: Gruvbox Dark 配色方案
- **风格**: Lambda 演算符号 (λ, τ, Σ, ∅ 等)
- **字体**: JetBrains Mono Nerd Font (推荐)
- **位置**: 底部边栏

### 📊 组件

**左侧:**
- 自定义工作区指示器 (λ1 - λ10)
- MPRIS 媒体播放器 (μ/π 符号)
- 实时音频可视化 (cava)

**中间:**
- 当前聚焦窗口标题

**右侧:**
- 音频音量 (α)
- 网络状态 (φ/η/χ)
- CPU 使用率 (ψ)
- 内存使用率 (ω)
- 电池状态 (β)
- 时钟 (τ)
- 截屏工具 (Σ)
- 系统托盘
- 电源菜单 (∅)

### ⚡ 功能

**截屏 (Σ):**
- 左键点击: 快速区域选择（最快的工作流程）
- 右键点击: 完整菜单（全屏 / 选择区域 / 当前窗口）
- 截图保存为 PNG 格式
- 文件命名格式：`Screenshot_YYYYMMDD_HHMMSS.png`
- 自动保存到：`~/Pictures/Screenshots/`
- 自动复制到剪切板（可用 Ctrl+V 粘贴）
- 全屏和区域截图使用 `grim`/`slurp`；“当前窗口”使用 niri 自带的截图动作（采用 niri 的文件命名格式）

**媒体播放器 (MPRIS):**
- 点击: 播放/暂停
- 向上滚动: 下一首
- 向下滚动: 上一首
- 无媒体播放时显示励志寄语

**系统组件:**
- 点击任意组件可打开相关配置工具

## 依赖项

### 必需
```bash
# 核心
waybar playerctl niri

# 截屏
grim slurp rofi wl-clipboard

# 音频可视化
cava

# 系统工具
pavucontrol nmtui htop notify-send
```

### 字体
```bash
# Arch Linux
sudo pacman -S ttf-jetbrains-mono-nerd

# 或从官网安装: https://www.nerdfonts.com/
```

## 安装

1. 备份现有的 waybar 配置:
```bash
mv ~/.config/waybar ~/.config/waybar.backup
```

2. 复制此配置:
```bash
cp -r /path/to/this/waybar ~/.config/
```

3. 安装依赖:
```bash
sudo pacman -S waybar playerctl grim slurp rofi cava \
               wl-clipboard pavucontrol nmtui htop \
               libnotify ttf-jetbrains-mono-nerd
```

4. 重启 Waybar:
```bash
killall waybar && waybar &
```

## 文件结构

```
~/.config/waybar/
├── config                    # 主配置文件
├── style.css                 # CSS 样式
├── cava-waybar.config        # 音频可视化配置
└── scripts/
    ├── cava-output.sh        # 音频可视化输出
    ├── powermenu.sh          # 电源菜单
    ├── powermenu.rasi        # 电源菜单主题
    ├── screenshot.sh         # 截屏菜单
    ├── screenshot-area.sh    # 快速区域截图
    ├── screenshot-menu.rasi  # 截屏菜单主题
    └── workspace-button.sh   # 工作区指示器
```

## 自定义

### 修改颜色
编辑 `style.css` 来修改 Gruvbox 配色:
- 背景色: `#282828`
- 前景色: `#ebdbb2`
- 强调色: `#98971a` (绿色), `#d79921` (黄色), `#458588` (蓝色)

### 调整组件
编辑 `config` 文件:
- 修改 `modules-left`, `modules-center`, `modules-right` 来重新排列组件
- 更改格式字符串中的符号
- 调整更新间隔
- 工作区按钮调用 `niri msg action focus-workspace <index>`；niri 的索引指聚焦显示器上的工作区位置

### 使用的 Lambda 符号
- λ (lambda) - 工作区编号
- τ (tau) - 时钟
- Σ (Sigma) - 截屏
- ∅ (emptyset) - 电源
- μ (mu) - 媒体播放中
- π (pi) - 媒体暂停
- ε (epsilon) - 媒体停止（显示："May your life bloom like a flower"）
- α (alpha) - 音频音量
- φ (phi) - WiFi
- η (eta) - 以太网
- χ (chi) - 网络断开
- ψ (psi) - CPU 使用率
- ω (omega) - 内存使用率
- β (beta) - 电池（β⁺ 充电中，β∞ 已插电）

## 故障排除

**符号显示不正确:**
- 安装 JetBrains Mono Nerd Font
- 安装字体后重启 Waybar

**截屏功能不工作:**
- 安装 `grim`、`slurp` 和 `wl-clipboard`
- 窗口截图需要 niri 会话正在运行（使用 niri 自带截图）
- 检查通知："Screenshot saved and copied to clipboard"

**音频可视化不显示:**
- 安装 `cava`
- 检查 PipeWire 是否运行

**媒体播放器不工作:**
- 安装 `playerctl`
- 确保你的媒体播放器支持 MPRIS

## 致谢

- 主题: Gruvbox Dark by morhetz
- 灵感来源: Lambda 演算和函数式编程
- 构建环境: Wayland 上的 niri

## 许可证

MIT License - 随意使用和修改
