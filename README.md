# 🛒👟 DILURI SNEAKER - Online Shopping System

A full-featured e-commerce web application for managing and purchasing sneakers, built with Java (JSP/Servlet), Apache Tomcat, SQL Server, and NetBeans IDE.

> Final Project for SE1814 – FPT University | July 2024  
> Group 2 – SWP391



---

## 📁 Deliverables

| File | Description |
|------|-------------|
| `SE1814_SWP_Group2_OSS_DB_final.sql` | SQL file for database schema and data |
| `SE1814_SWP_Group2_RDS Document.docx` | Full Requirement & Design Specification |
| `SE1814_Group2_OnlineShop_Final Product Backlog.xlsx` | Product backlog tracking features and iterations |
| `SE1814_SWP_Group2_OSSPresentation.pptx` | Project presentation slides |
| `SE1814_SWP_Group2_OSS_source code.zip` | Complete source code |

---

## 🚀 Features

- 👟 Product listing, filtering, and details
- 🛒 Cart, checkout, and order management
- 👤 User registration and authentication
- 🧑‍💼 Role-based access (Admin, Marketer, Sale, Shipper, Warehouse)
- 📦 Inventory, sales, and shipping flow
- 📈 Dashboards for Admin and Sale
- 📝 Blog system and feedback module

---

## 🧩 Technology Stack

- Java Servlet + JSP (Apache NetBeans IDE 17)
- Apache Tomcat 10
- Microsoft SQL Server 2022 + SSMS
- HTML, CSS, JavaScript

---

## ⚙️ Installation Guide

> 📖 Full setup instructions are detailed in the `README.md` and final document.

### 1. Requirements

- JDK 17
- Apache Tomcat 10.x
- Apache NetBeans IDE 17
- Microsoft SQL Server 2022 + SSMS

### 2. Setup Steps

- Install the tools above.
- Import `SE1814_SWP_Group2_OSS_DB_final.sql` into SQL Server.
- Open the project in NetBeans > Clean & Build > Deploy to Tomcat.
- Access the app via `http://localhost:9999/YourProjectName`.

📄 For full details, see the **Installation section** in the final release document.

---

## 👤 User Manual

### ✅ Successful Order Flow
1. Customer logs in, selects products and checks out.
2. Sale Manager assigns the order to a salesperson.
3. Order is confirmed → packed by Warehouse → shipped by Shipper.
4. Customer receives the order → marks as “Received” → order status becomes `Success`.

### ❌ Failed Order Flow
1. Customer places order, but doesn’t receive it.
2. Shipper retries 3 times → returns to warehouse.
3. Warehouse marks order as `Returned` based on reason (e.g., ghost order).

> 📘 Full details in the **User Manual section** of the final document.

---

## 📚 Documents

- [📄 Final RDS Document](https://docs.google.com/document/d/1kthAbwAf8xfrs69P1qpFT0fMRiEvfV98/)
- [📦 Final Product Backlog (Excel)](./SE1814_Group2_OnlineShop_Final%20Product%20Backlog.xlsx)
- [🖼️ Presentation Slides](./SE1814_SWP_Group2_OSSPresentation.pptx)

---

## 📄 License

This project is for academic use under FPT University's software engineering curriculum. Contact project members for more info.

---

## 👥 Team Members

| Name                     | Student ID     |
|--------------------------|----------------|
| Truong Nguyen Viet Quang | HE182422       |
| Nguyen Duc Anh           | HE180984       |
| Nguyen Bao Khanh         | HE             |
| Nguyen Tung Lam          | HE180410       |
| Hoang Tien Dung          | HE181547       |

---

> 🏁 Last Updated: July 2024 – Hanoi  
> 🎓 SWP391 – Software Development Project – Group 2
