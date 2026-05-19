# MySQL 数据库初始化指南

## 📋 方式一：使用提供的 SQL 脚本（推荐）

### 1. 确保 MySQL 服务已启动

### 2. 执行 init.sql 脚本

#### 方法 A：使用命令行
```bash
mysql -u root -p < init.sql
```

#### 方法 B：使用 MySQL Workbench / Navicat 等图形工具
1. 打开你的 MySQL 管理工具
2. 连接到 MySQL 服务器
3. 打开 `init.sql` 文件
4. 点击「执行」或「运行」

---

## 📋 方式二：手动一步步创建

### 步骤 1: 连接到 MySQL
```bash
mysql -u root -p
```

### 步骤 2: 创建数据库
```sql
CREATE DATABASE IF NOT EXISTS `score_analysis` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `score_analysis`;
```

### 步骤 3: 创建表（复制 init.sql 中的内容执行）

---

## 📋 方式三：直接启动项目（最简单）

**项目会自动初始化数据库！**

1. 确保 `database-mysql.js` 中的配置正确：
```javascript
const DB_CONFIG = {
    host: '192.168.3.6',    // 改成你的 MySQL 地址
    port: 3306,
    user: 'root',           // 改成你的用户名
    password: 'Saodiseng1', // 改成你的密码
    database: 'score_analysis',
    ...
};
```

2. 直接启动项目：
```bash
node server.js
```

项目会自动：
- ✅ 创建数据库 `score_analysis`
- ✅ 创建所有表
- ✅ 插入默认管理员账号

---

## 🔑 默认登录账号

| 项目 | 值 |
|------|-----|
| 账号 | `admin` |
| 密码 | `admin123` |
| 角色 | 管理员 |

---

## 📝 修改数据库配置

编辑文件：`database-mysql.js`

```javascript
const DB_CONFIG = {
    host: 'localhost',      // MySQL 地址
    port: 3306,            // 端口
    user: 'root',          // 用户名
    password: '你的密码',   // 密码
    database: 'score_analysis',
    ...
};
```

---

## 📊 数据库表结构说明

| 表名 | 用途 |
|------|------|
| `users` | 用户账号 |
| `classes` | 班级信息 |
| `students` | 学生信息 |
| `exams` | 考试信息 |
| `scores` | 成绩记录 |
| `beauty_scores` | 德育评分 |
| `beauty_events` | 德育事件 |
| `beauty_score_events` | 德育记录 |
| `attendance` | 考勤记录 |
| `announcements` | 公告 |
| `homework` | 作业 |
| `homework_data` | 作业数据 |
