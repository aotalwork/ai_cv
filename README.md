# AI CV — Arantzazu Otal Alberro

> Personal CV and professional portfolio powered by Ruby on Rails, with an interactive assistant to explore my professional and personal profile.

🌐 **Live:** https://ai-cv-v0nj.onrender.com/

💻 **GitHub:** https://github.com/aotalwork/ai_cv

---

## About the project

**AI CV** is my personal interactive CV and portfolio.

Instead of presenting my professional experience as a static document, I wanted to build a web application where visitors can explore my background and interact with an assistant that answers questions about my profile.

The goal is to combine **software engineering, project management and AI-oriented experiences** in a single project.

Visitors can ask questions such as:

* What is my experience with Ruby on Rails?
* What is my experience as a Technical Lead?
* What do I currently do as a PMO?
* What experience do I have in the financial sector?
* What technologies have I worked with?
* What certifications and education do I have?
* What languages do I speak?
* What are my professional interests?
* What do I enjoy outside of work?

The assistant uses the information stored in the application's database to generate responses about my profile.

---

## ✨ Features

### Interactive CV

The application presents my:

* Professional experience
* Technical skills
* Technical leadership experience
* Project management experience
* Education
* Certifications
* Languages
* Achievements
* Recommendations
* Personal interests

### 💬 CV Assistant

An interactive chat interface allows visitors to ask questions about my profile.

The assistant is integrated directly into the application and provides contextual answers based on the information stored in the CV.

### 📱 Responsive design

The interface is designed to work across:

* Desktop
* Tablet
* Mobile

### 🗄️ Database-driven profile

Professional information is stored in PostgreSQL rather than being hardcoded directly into the views.

The main profile is associated with different sections such as:

```text
Profile
├── Experiences
├── Projects
├── Skills
├── Certifications
├── Education
├── Languages
├── Achievements
└── Recommendations
```

---

## 🛠️ Tech Stack

### Backend

* Ruby
* Ruby on Rails 8
* PostgreSQL

### Frontend

* HTML
* Tailwind CSS
* Stimulus
* Turbo
* Importmap

### Infrastructure

* Render
* PostgreSQL
* Puma

### Development tools

* Git
* GitHub
* Docker
* Jira
* Confluence

---

## 🏗️ Architecture

The application follows a simple Rails architecture.

```text
Browser
   │
   ▼
Ruby on Rails
   │
   ├── Controllers
   │
   ├── Models
   │
   ├── Views
   │
   └── Stimulus
        │
        ▼
    Chat Assistant
        │
        ▼
    PostgreSQL
```

The application is intentionally kept simple, avoiding unnecessary infrastructure such as Redis or additional queue/cache databases.

---

## 🚀 Running locally

### Requirements

Make sure you have installed:

* Ruby
* Bundler
* PostgreSQL
* Node.js / required Rails tooling

Clone the repository:

```bash
git clone https://github.com/aotalwork/ai_cv.git
cd ai_cv
```

Install dependencies:

```bash
bundle install
```

Create and prepare the database:

```bash
bin/rails db:prepare
```

Build Tailwind:

```bash
bin/rails tailwindcss:build
```

Precompile assets:

```bash
bin/rails assets:precompile
```

Start the application:

```bash
bin/rails server
```

Then open:

```text
http://localhost:3000
```

---

## 🧪 Tests

Run the test suite with:

```bash
bin/rails test
```

---

## ☁️ Deployment

The application is deployed on **Render**.

The deployment process uses:

```text
GitHub
   │
   ▼
Render Web Service
   │
   ├── bundle install
   ├── database preparation
   ├── Tailwind build
   └── asset precompilation
        │
        ▼
      Puma
```

The production build is defined in:

```text
bin/render-build.sh
```

Current build process:

```bash
bundle install
bin/rails db:prepare
bin/rails tailwindcss:build
bin/rails assets:precompile
```

Production uses PostgreSQL through the `DATABASE_URL` environment variable.

---

## 🔐 Environment variables

For production, the application requires the appropriate Rails secrets and database configuration.

Typical variables include:

```text
DATABASE_URL
RAILS_MASTER_KEY
SECRET_KEY_BASE
RAILS_MAX_THREADS
WEB_CONCURRENCY
```

Secrets should never be committed to the repository.

---

## 📂 Project structure

```text
ai_cv/
├── app/
│   ├── controllers/
│   ├── javascript/
│   ├── models/
│   └── views/
├── bin/
│   └── render-build.sh
├── config/
│   ├── database.yml
│   ├── cable.yml
│   └── environments/
├── db/
│   ├── migrate/
│   └── seeds.rb
├── test/
├── Gemfile
├── Gemfile.lock
└── README.md
```

---

## 👩‍💻 About me

I'm **Arantzazu Otal Alberro**, a Senior Ruby on Rails Engineer, Technical Lead and PMO professional.

My career has evolved from software development to technical leadership and project management, giving me experience across:

* Ruby on Rails development
* Backend engineering
* REST APIs
* PostgreSQL
* Technical leadership
* Agile methodologies
* Project coordination
* PMO
* Delivery management
* Risk and dependency management
* Capacity planning
* Executive reporting
* Continuous improvement
* AI and emerging technologies

I have also worked on critical applications in the financial sector, combining technical expertise with coordination between Development, Operations and Business.

---

## 🎯 Why I built this

A traditional CV is useful, but it only tells part of the story.

I wanted to experiment with a different way of presenting a professional profile while using the technologies I enjoy working with.

**AI CV is both a portfolio and a technical project.**

It represents my interest in combining software engineering, project management and AI to create practical tools that make information easier to explore.

---

## 📌 Project status

🟢 **Live and deployed**

The project is continuously evolving as I experiment with new ideas around:

* AI-assisted professional profiles
* Personal knowledge systems
* Interactive portfolios
* Software architecture
* AI applied to useful everyday tools

---

## 📄 License

This project is a personal portfolio and CV application.

© Arantzazu Otal Alberro
