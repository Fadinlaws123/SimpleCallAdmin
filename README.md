<div align="center">

# 🛡️ SimpleCallAdmin

### A lightweight standalone FiveM system that lets players request staff assistance in-game.

<p>
  <a href="https://simpledevelopments.org/store"><img src="https://img.shields.io/badge/Explore_Our_Store-5865F2?style=for-the-badge&logo=googlechrome&logoColor=white" /></a>
  <a href="https://discord.gg/RquDVTfDwu"><img src="https://img.shields.io/badge/Join_Our_Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white" /></a>
  <a href="https://github.com/Fadinlaws123/SimpleCallAdmin"><img src="https://img.shields.io/badge/View_on_GitHub-181717?style=for-the-badge&logo=github&logoColor=white" /></a>
</p>

<p>
  <img src="https://img.shields.io/badge/FiveM-Standalone-FF6B35?style=flat-square&logo=fivem&logoColor=white" />
  <img src="https://img.shields.io/badge/Permissions-ACE-238636?style=flat-square" />
  <img src="https://img.shields.io/badge/Status-Release_Ready-238636?style=flat-square" />
  <img src="https://img.shields.io/github/stars/Fadinlaws123/SimpleCallAdmin?style=flat-square&logo=github&label=Stars" />
</p>

</div>

---

## 📖 About

**SimpleCallAdmin** gives players a simple way to request staff assistance using `/calladmin <reason>`.

When a request is submitted, authorized staff can receive the message through the configured notification system and the request can also be logged to Discord for record keeping.

---

## ✨ Features

- `/calladmin <reason>` command
- ACE-based staff targeting
- Configurable staff permission string
- Standard chat notification support
- RTX Notify support
- okokNotify support
- Custom notification option for integrations
- Discord webhook logging
- Configurable webhook appearance
- Built-in version checking

---

## 🎮 Command

```text
/calladmin <reason>
```

Players must provide a reason when requesting staff assistance.

---

## ⚙️ Configuration

Configure the resource through `config.lua`, including:

- Notification system
- ACE permission usage
- Staff permission string
- Discord webhook name
- Webhook image
- Embed color
- Footer icon
- Logging webhook

Keep live webhook URLs private and do not commit them to a public repository.

---

## 📥 Installation

1. Place `SimpleCallAdmin` in your server's resources directory.
2. Configure `config.lua`.
3. Add the following to your `server.cfg`:

```cfg
ensure SimpleCallAdmin
```

4. Grant the configured ACE permission to your staff group when ACE permissions are enabled.
5. Restart the resource or server.

---

## 📋 Requirements

- FiveM server
- No framework required
- The selected external notification resource when using RTX Notify or okokNotify

---

## 🌐 SimpleDevelopments

SimpleCallAdmin is developed and maintained by **SimpleDevelopments**.

<div align="center">

### Keep it Simple. Keep it SimpleDevelopments.

</div>
