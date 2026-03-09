# Ahmed Essamedeen - Senior Android Developer Portfolio

A professional, responsive portfolio website built with Flutter showcasing expertise in mobile development (Android/iOS), Augmented Reality, and mobile architecture.

## 🚀 Features

- **Modern Professional Design**: Clean, minimalist layout with smooth animations
- **Fully Responsive**: Optimized for desktop, tablet, and mobile devices
- **Fast Performance**: Built with Flutter for optimal web performance
- **Comprehensive Sections**: About, Skills, Experience, Projects, Education, and Contact
- **Professional Content**: Showcasing 6+ years of mobile development experience
- **GitHub Pages Ready**: Easy deployment with automated CI/CD

## 💼 Professional Highlights

- **Senior Android Developer** at SameSystem - Retail Workforce Solutions
- **6+ Years** of professional mobile development experience
- **Specializations**: Android/iOS Development, Augmented Reality, Mobile Architecture
- **Technical Leadership**: Team management and talent development
- **Key Skills**: Java, Android, C++, REST APIs, Backend Integration, AR/VR Technologies

## 🛠️ Tech Stack

- **Framework**: Flutter 3.41.2
- **Language**: Dart 3.11.0
- **Styling**: Material Design 3
- **Deployment**: GitHub Pages with GitHub Actions
- **Web Launcher**: url_launcher for contact links

## 📱 Portfolio Sections

### Hero Section
Eye-catching introduction with professional title and call-to-action

### About Me
Professional summary highlighting expertise and key competencies

### Skills & Technologies
- **Top Skills**: Java (95%), Android (95%), Mobile Architecture (90%), AR/VR (85%), iOS (85%), Kotlin (80%)
- **Languages**: Arabic (Native), English (Fluent), French (Intermediate)

### Experience
- Senior Android Developer - SameSystem (2020-Present)
- Mobile Developer - Argaam Media (2019-2020)
- Mobile Developer - Code95 (2017-2019)
- Android Developer - magdsoft (2016-2017)

### Projects Gallery
Featured mobile applications including:
- Retail Workforce Solutions
- Augmented Reality Implementation
- Media Platform
- E-Commerce Solutions

### Education
- Bachelor of Computer Engineering - Zagazig University (2008-2013)
- Certifications: Management of Change, SQL, C++, Java, Networking Fundamentals

### Contact Section
Direct links to:
- Email: ahmedessamedeen@gmail.com
- Phone: +201069682782
- LinkedIn: linkedin.com/in/ahmedessamedeen

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0+ ([Install Flutter](https://flutter.dev/docs/get-started/install))
- Dart SDK 3.0+
- Web support enabled

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/portfolio.git
cd portfolio/portfolio
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app locally:
```bash
flutter run -d chrome
```

### Build for Production

```bash
flutter build web --release
```

The production-ready files will be in the `build/web` directory.

## 📦 Deployment to GitHub Pages

### Option 1: Manual Deployment

1. Build the web version:
```bash
flutter build web --release
```

2. Create a new branch for GitHub Pages:
```bash
git checkout --orphan gh-pages
```

3. Copy build files:
```bash
cp -r build/web/* .
```

4. Commit and push:
```bash
git add .
git commit -m "Deploy portfolio"
git push origin gh-pages
```

### Option 2: Automated with GitHub Actions

1. Create a new repository on GitHub
2. Push your code to main branch
3. Go to Settings > Pages
4. Select "Deploy from a branch" > "gh-pages"
5. The workflow will automatically build and deploy

The GitHub Actions workflow (`.github/workflows/deploy.yml`) handles building and deployment automatically.

## 🎨 Customization

### Update Personal Information
Edit `portfolio/lib/main.dart`:

- **Hero Section**: Name, title, profile image
- **About Section**: Professional summary and skills
- **Skills**: Add/modify skills and proficiency levels
- **Experience**: Update work experience entries
- **Projects**: Add your actual projects
- **Education**: Update educational background
- **Contact**: Update contact information

### Modify Color Scheme
Change the primary color in `main.dart`:
```dart
seedColor: const Color(0xFF1F2937), // Change this to your preferred color
```

### Update Links
Modify contact button handlers in the `_buildContactButton` method to launch actual URLs:
```dart
onPressed: () {
  launchUrl(Uri.parse('mailto:your.email@example.com'));
}
```

## 📱 Responsive Design

The portfolio is fully responsive with:
- Mobile-first design approach
- Adaptive layouts for different screen sizes
- Touch-friendly buttons and interactions
- Readable typography at all sizes

## 🔒 Best Practices Implemented

- ✅ Clean code architecture
- ✅ Material Design 3 compliance
- ✅ Performance optimized
- ✅ SEO-friendly HTML structure
- ✅ Accessibility considerations
- ✅ Fast load times with tree-shaken icons

## 🤝 Contributing

Feel free to fork this project and customize it for your own professional portfolio!

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 📞 Contact

- **Email**: ahmedessamedeen@gmail.com
- **Phone**: +201069682782
- **LinkedIn**: [Ahmed Essamedeen](https://linkedin.com/in/ahmedessamedeen)
- **Location**: Egypt

---

Built with ❤️ using Flutter | © 2026 Ahmed Essamedeen