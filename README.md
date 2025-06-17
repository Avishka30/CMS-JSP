
Complaint Management System (CMS)

 A web-based Complaint Management System built with Java Servlets and JSP.
 The system supports employee complaint tracking and admin complaint management.

🎯 Key Features

Employee

Register an account

Login securely

Submit new complaints

Edit or delete "Pending" complaints

View status updates & admin remarks


Admin

Admin login

View all employee complaints

Update complaint status (Pending → Resolved)

Add remarks to complaints

Delete any complaint


⚙️ Tech Stack

Java Servlet + JSP

MySQL 8.x

JDBC + DBCP2 Connection Pool

Maven Build Tool

Apache Tomcat 11+

HTML + CSS (Responsive UI)

JavaScript for form validation


📂 Project Structure

CMS-JSP/
├── src/main/java/lk/ijse/gdse/cmsjsp/

│   ├── controller/        
│   ├── model/             
│   ├── db/                 
│   ├── dto/               
├── src/main/webapp/

│   ├── css/               
│   ├── js/                 
│   ├── jsp/               
│   └── index.jsp

├── WEB-INF/
│   └── web.xml

├── pom.xml

🚀 Setup And Configuration Guide

1️⃣ Prerequisites

Java 17+

Apache Tomcat 11+

MySQL 8.x

Maven


2️⃣ Database Configuration

Create a MySQL database: cms

Add required tables (users, complaints)

Insert default Admin account:

sql
INSERT INTO users (username, password, role) VALUES ('admin', 'admin123', 'ADMIN');

Edit database config in:
 src/main/java/lk/ijse/gdse/cmsjsp/db/DBConnectionPool.java


3️⃣ Build & Deploy

run directly in IntelliJ / Eclipse using Tomcat server

4️⃣ Access Application

Employee dashboard
http://localhost:8080/CMS_JSP_war_exploded/ComplaintServlet?action=dashboard

admin dashboard
http://localhost:8080/CMS_JSP_war_exploded/jsp/adminDashboard.jsp


🌐 Links
🔗 GitHub Repo: https://github.com/Avishka30/CMS-JSP.git

