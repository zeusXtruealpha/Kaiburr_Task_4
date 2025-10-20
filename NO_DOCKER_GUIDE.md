# 🚀 CI/CD Pipeline Setup (No Docker)

This guide sets up CI/CD pipelines for your Task Management System without Docker. Perfect when Docker services are down or you prefer a simpler approach.

## 📋 What You Get

### **Backend CI/CD Features**
- ✅ **Maven Build & Test** - Java 21 with dependency caching
- ✅ **JUnit Test Reporting** - Detailed test results and coverage
- ✅ **Security Scanning** - OWASP Dependency Check for vulnerabilities
- ✅ **JAR Artifacts** - Upload built JAR files for download
- ✅ **Multiple Deploy Options** - AWS S3, Azure Storage, Google Cloud, GitHub Releases

### **Frontend CI/CD Features**
- ✅ **Node.js Build & Test** - TypeScript, ESLint, production build
- ✅ **Security Scanning** - npm audit and Snyk vulnerability scanning
- ✅ **Build Size Reporting** - Automatic size reports in PR comments
- ✅ **Multiple Deploy Options** - GitHub Pages, Netlify, Vercel, AWS S3, Azure Static Web Apps

## 🛠️ Quick Setup

### **Step 1: Backend Setup**

```bash
# Clone your backend repository
git clone https://github.com/zeusXtruealpha/Kaiburr_Task_1.git
cd Kaiburr_Task_1

# Copy and run setup script
cp ../CICD/setup-backend-no-docker.sh .
chmod +x setup-backend-no-docker.sh
./setup-backend-no-docker.sh

# Commit and push
git add .
git commit -m "Add CI/CD pipeline (no Docker)"
git push origin main
```

### **Step 2: Frontend Setup**

```bash
# Clone your frontend repository
git clone https://github.com/zeusXtruealpha/Kaiburr_Task_3.git
cd Kaiburr_Task_3

# Copy and run setup script
cp ../CICD/setup-frontend-no-docker.sh .
chmod +x setup-frontend-no-docker.sh
./setup-frontend-no-docker.sh

# Commit and push
git add .
git commit -m "Add CI/CD pipeline (no Docker)"
git push origin main
```

## 🔧 Manual Setup (Alternative)

### **Backend Manual Setup**

1. **Create directories**:
   ```bash
   mkdir -p .github/workflows
   ```

2. **Copy workflow files**:
   ```bash
   cp CICD/backend-ci-no-docker.yml .github/workflows/ci.yml
   cp CICD/backend-deploy.yml .github/workflows/deploy.yml
   ```

3. **Update .gitignore**:
   ```bash
   echo "target/" >> .gitignore
   echo ".mvn/wrapper/maven-wrapper.jar" >> .gitignore
   ```

### **Frontend Manual Setup**

1. **Create directories**:
   ```bash
   mkdir -p .github/workflows
   ```

2. **Copy workflow files**:
   ```bash
   cp CICD/frontend-ci-no-docker.yml .github/workflows/ci.yml
   cp CICD/frontend-deploy.yml .github/workflows/deploy.yml
   ```

3. **Update .gitignore**:
   ```bash
   echo "node_modules/" >> .gitignore
   echo "dist/" >> .gitignore
   ```

## 🚀 Deployment Options

### **Backend Deployment**

#### **Option 1: GitHub Releases (No Setup Required)**
- Automatically creates releases with JAR files
- Works out of the box with `GITHUB_TOKEN`

#### **Option 2: AWS S3**
Add secrets to GitHub:
```
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
```

#### **Option 3: Azure Storage**
Add secrets to GitHub:
```
AZURE_STORAGE_ACCOUNT=your_storage_account
AZURE_STORAGE_KEY=your_storage_key
```

#### **Option 4: Google Cloud Storage**
Add secrets to GitHub:
```
GCP_SA_KEY=your_service_account_key_json
```

### **Frontend Deployment**

#### **Option 1: GitHub Pages (No Setup Required)**
- Automatically deploys to GitHub Pages
- Works out of the box with `GITHUB_TOKEN`

#### **Option 2: Netlify**
Add secrets to GitHub:
```
NETLIFY_AUTH_TOKEN=your_netlify_token
NETLIFY_SITE_ID=your_site_id
```

#### **Option 3: Vercel**
Add secrets to GitHub:
```
VERCEL_TOKEN=your_vercel_token
ORG_ID=your_org_id
PROJECT_ID=your_project_id
```

#### **Option 4: AWS S3 + CloudFront**
Add secrets to GitHub:
```
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
```

#### **Option 5: Azure Static Web Apps**
Add secrets to GitHub:
```
AZURE_STATIC_WEB_APPS_API_TOKEN=your_token
```

## 📊 Monitoring & Artifacts

### **GitHub Actions Artifacts**
- **Backend**: JAR files, test results, security reports
- **Frontend**: Built dist folder, build size reports

### **Access Artifacts**
1. Go to your repository on GitHub
2. Click "Actions" tab
3. Click on any workflow run
4. Scroll down to "Artifacts" section
5. Download the files you need

### **Test Results**
- **Backend**: JUnit reports in Actions tab
- **Frontend**: Build size in PR comments

## 🔍 Security Features

### **Backend Security**
- **OWASP Dependency Check** - Scans for known vulnerabilities
- **Maven Security** - Checks dependencies for security issues
- **Fail on High CVSS** - Build fails if critical vulnerabilities found

### **Frontend Security**
- **npm audit** - Checks for vulnerable packages
- **Snyk Scanning** - Advanced vulnerability detection
- **Dependency Updates** - Suggests security updates

## 🧪 Testing Locally

### **Backend Testing**
```bash
# Run tests
mvn clean test

# Build JAR
mvn clean package

# Run application
java -jar target/*.jar
```

### **Frontend Testing**
```bash
# Install dependencies
npm ci

# Type check
npm run type-check

# Lint code
npm run lint

# Build for production
npm run build

# Serve locally
npx serve dist
```

## 🚨 Troubleshooting

### **Common Issues**

#### **Backend Issues**
1. **Maven build fails**
   - Check Java version (needs Java 21)
   - Verify all dependencies in pom.xml
   - Run `mvn clean compile` locally first

2. **Tests fail**
   - Check test database configuration
   - Verify MongoDB connection
   - Run `mvn test` locally first

3. **Security scan fails**
   - Check OWASP dependency check configuration
   - Review vulnerability reports
   - Update vulnerable dependencies

#### **Frontend Issues**
1. **npm build fails**
   - Check Node.js version (needs 18+)
   - Verify all dependencies in package.json
   - Run `npm ci && npm run build` locally first

2. **TypeScript errors**
   - Check tsconfig.json configuration
   - Fix type errors in code
   - Run `npm run type-check` locally first

3. **Deployment fails**
   - Verify deployment secrets are correct
   - Check target platform configuration
   - Review deployment logs in Actions

### **Debug Commands**
```bash
# Backend
mvn clean test -X  # Verbose test output
mvn dependency:tree  # Check dependencies

# Frontend
npm ci --verbose  # Verbose install
npm run build --verbose  # Verbose build
```

## 📈 Performance Tips

### **Faster Builds**
- **Maven**: Uses dependency caching
- **npm**: Uses package caching
- **Parallel Jobs**: CI runs tests in parallel

### **Smaller Artifacts**
- **Backend**: Only JAR files uploaded
- **Frontend**: Only dist folder uploaded
- **Retention**: 30-day artifact retention

## 🔄 Workflow Triggers

### **CI Workflows**
- **Trigger**: Push to any branch, Pull Requests
- **Purpose**: Build, test, and validate code quality

### **Deploy Workflows**
- **Trigger**: Push to main branch, Manual trigger
- **Purpose**: Deploy artifacts to chosen platforms

## 📝 Next Steps

1. **Set up the pipelines** using the scripts above
2. **Configure deployment secrets** for your chosen platform
3. **Monitor build status** in GitHub Actions
4. **Download artifacts** as needed
5. **Set up monitoring** for deployed applications

## 🆚 Docker vs No-Docker Comparison

| Feature | Docker | No-Docker |
|---------|--------|-----------|
| **Setup Complexity** | Medium | Low |
| **Build Time** | Slower | Faster |
| **Deployment** | Container-based | Artifact-based |
| **Portability** | High | Medium |
| **Resource Usage** | Higher | Lower |
| **Dependencies** | Docker required | None |

---

**Ready to deploy without Docker! 🚀**

This approach gives you full CI/CD capabilities without needing Docker services running.
