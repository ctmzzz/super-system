-- =============================================
-- 成绩分析系统 - MySQL 数据库初始化脚本
-- 适用于全新的 MySQL 环境
-- =============================================

-- 1. 创建数据库
CREATE DATABASE IF NOT EXISTS `score_analysis` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `score_analysis`;

-- 2. 创建所有表

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    plain_password VARCHAR(255),
    name VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'teacher'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 班级表
CREATE TABLE IF NOT EXISTS classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    grade VARCHAR(50) DEFAULT '',
    user_id INT,
    created_by VARCHAR(100) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 学生表
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    class_id INT,
    user_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 考试表
CREATE TABLE IF NOT EXISTS exams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    date VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 成绩表
CREATE TABLE IF NOT EXISTS scores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    student_id INT NOT NULL,
    subject VARCHAR(100) DEFAULT '',
    total_score DECIMAL(10,2) NOT NULL,
    user_id INT,
    UNIQUE KEY uq_exam_student_subject (exam_id, student_id, subject)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 德育评分表
CREATE TABLE IF NOT EXISTS beauty_scores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    student_id VARCHAR(50) NOT NULL,
    row_index INT NOT NULL,
    month VARCHAR(20) DEFAULT '',
    score DECIMAL(10,2) DEFAULT 0,
    events TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id INT,
    entry_date VARCHAR(20) DEFAULT '',
    UNIQUE KEY uq_beauty (class_id, student_id, row_index, month)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 德育评分事件表
CREATE TABLE IF NOT EXISTS beauty_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    type VARCHAR(20) DEFAULT '扣学分',
    default_score DECIMAL(10,2) DEFAULT 1,
    category_index INT,
    item_index INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 考勤表
CREATE TABLE IF NOT EXISTS attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    student_id INT NOT NULL,
    date VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'present',
    remark TEXT,
    late_time VARCHAR(50) DEFAULT '',
    leave_time VARCHAR(50) DEFAULT '',
    leave_type VARCHAR(50) DEFAULT '',
    leave_with_note VARCHAR(10) DEFAULT '0',
    leave_duration VARCHAR(50) DEFAULT '',
    absent_time VARCHAR(50) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_attendance (class_id, student_id, date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 德育评分事件记录表
CREATE TABLE IF NOT EXISTS beauty_score_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    student_id VARCHAR(50) NOT NULL,
    row_index INT NOT NULL,
    month VARCHAR(20) NOT NULL,
    score DECIMAL(10,2) DEFAULT 0,
    event_name VARCHAR(200) DEFAULT '',
    entry_date VARCHAR(20) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 公告表
CREATE TABLE IF NOT EXISTS announcements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    start_date VARCHAR(20) DEFAULT '',
    end_date VARCHAR(20) DEFAULT '',
    is_active TINYINT(1) DEFAULT 1,
    created_by VARCHAR(100) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 作业表
CREATE TABLE IF NOT EXISTS homework (
    id INT AUTO_INCREMENT PRIMARY KEY,
    semester VARCHAR(50) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    content TEXT,
    class_id INT DEFAULT NULL,
    created_by VARCHAR(100) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_homework (semester, subject, class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 作业数据表
CREATE TABLE IF NOT EXISTS homework_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    semester VARCHAR(50) NOT NULL,
    class_id INT NOT NULL,
    subject VARCHAR(100) NOT NULL,
    date VARCHAR(20) NOT NULL,
    student_id INT NOT NULL,
    submitted TINYINT(1) DEFAULT 0,
    created_by VARCHAR(100) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_homework_data (semester, class_id, subject, date, student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. 插入默认管理员账号
-- 账号: admin
-- 密码: admin123
INSERT INTO users (employee_id, password, name, role) 
VALUES ('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '管理员', 'admin')
ON DUPLICATE KEY UPDATE name=name;

-- =============================================
-- 初始化完成！
-- 默认登录账号: admin / admin123
-- =============================================
