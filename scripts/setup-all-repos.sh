#!/bin/bash

# Setup script for all Kaiburr repositories
# This script sets up CI/CD for both backend and frontend repositories

echo "🚀 Setting up Kaiburr CICD Pipeline for All Repositories"
echo "========================================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d "workflows" ] || [ ! -d "scripts" ]; then
    print_error "Please run this script from the Kaiburr_CICD repository root"
    exit 1
fi

print_success "Found CICD repository structure"

# Get the parent directory
PARENT_DIR=$(dirname "$(pwd)")
BACKEND_DIR="$PARENT_DIR/Kaiburr_Task_1"
FRONTEND_DIR="$PARENT_DIR/Kaiburr_Task_3"

print_status "Parent directory: $PARENT_DIR"
print_status "Backend directory: $BACKEND_DIR"
print_status "Frontend directory: $FRONTEND_DIR"

# Function to setup backend
setup_backend() {
    print_status "Setting up Backend Repository..."
    
    if [ ! -d "$BACKEND_DIR" ]; then
        print_warning "Backend directory not found. Cloning from GitHub..."
        cd "$PARENT_DIR"
        git clone https://github.com/zeusXtruealpha/Kaiburr_Task_1.git
        cd Kaiburr_Task_1
    else
        print_status "Backend directory found. Updating..."
        cd "$BACKEND_DIR"
        git pull origin main
    fi
    
    # Copy CI/CD files
    print_status "Copying CI/CD files to backend..."
    cp ../Kaiburr_CICD/workflows/backend-ci-no-docker.yml .github/workflows/ci.yml
    cp ../Kaiburr_CICD/workflows/backend-deploy.yml .github/workflows/deploy.yml
    
    # Update .gitignore
    if ! grep -q "target/" .gitignore; then
        echo "" >> .gitignore
        echo "# Maven" >> .gitignore
        echo "target/" >> .gitignore
        echo ".mvn/wrapper/maven-wrapper.jar" >> .gitignore
        print_success "Updated .gitignore"
    fi
    
    # Test Maven build
    print_status "Testing Maven build..."
    if mvn -B clean compile -DskipTests; then
        print_success "Maven build successful"
    else
        print_error "Maven build failed"
        return 1
    fi
    
    # Test Maven tests (if MongoDB is running)
    print_status "Testing Maven tests..."
    if mvn -B test; then
        print_success "Maven tests successful"
    else
        print_warning "Maven tests failed (MongoDB might not be running)"
    fi
    
    print_success "Backend setup complete!"
    cd "$PARENT_DIR/Kaiburr_CICD"
}

# Function to setup frontend
setup_frontend() {
    print_status "Setting up Frontend Repository..."
    
    if [ ! -d "$FRONTEND_DIR" ]; then
        print_warning "Frontend directory not found. Cloning from GitHub..."
        cd "$PARENT_DIR"
        git clone https://github.com/zeusXtruealpha/Kaiburr_Task_3.git
        cd Kaiburr_Task_3
    else
        print_status "Frontend directory found. Updating..."
        cd "$FRONTEND_DIR"
        git pull origin main
    fi
    
    # Copy CI/CD files
    print_status "Copying CI/CD files to frontend..."
    cp ../Kaiburr_CICD/workflows/frontend-ci-no-docker.yml .github/workflows/ci.yml
    cp ../Kaiburr_CICD/workflows/frontend-deploy.yml .github/workflows/deploy.yml
    
    # Update .gitignore
    if ! grep -q "node_modules/" .gitignore; then
        echo "" >> .gitignore
        echo "# Dependencies" >> .gitignore
        echo "node_modules/" >> .gitignore
        echo "dist/" >> .gitignore
        echo ".env.local" >> .gitignore
        echo ".env.development.local" >> .gitignore
        echo ".env.test.local" >> .gitignore
        echo ".env.production.local" >> .gitignore
        print_success "Updated .gitignore"
    fi
    
    # Test npm build
    print_status "Testing npm build..."
    if npm ci && npm run build; then
        print_success "npm build successful"
    else
        print_error "npm build failed"
        return 1
    fi
    
    print_success "Frontend setup complete!"
    cd "$PARENT_DIR/Kaiburr_CICD"
}

# Main execution
echo ""
print_status "Starting setup process..."

# Setup backend
if setup_backend; then
    print_success "✅ Backend setup completed successfully"
else
    print_error "❌ Backend setup failed"
    exit 1
fi

echo ""

# Setup frontend
if setup_frontend; then
    print_success "✅ Frontend setup completed successfully"
else
    print_error "❌ Frontend setup failed"
    exit 1
fi

echo ""
echo "🎉 All repositories setup complete!"
echo ""
echo "Next steps:"
echo "1. Commit and push changes to both repositories:"
echo "   cd $BACKEND_DIR && git add . && git commit -m 'Add CI/CD pipeline' && git push origin main"
echo "   cd $FRONTEND_DIR && git add . && git commit -m 'Add CI/CD pipeline' && git push origin main"
echo ""
echo "2. Check GitHub Actions:"
echo "   - Backend: https://github.com/zeusXtruealpha/Kaiburr_Task_1/actions"
echo "   - Frontend: https://github.com/zeusXtruealpha/Kaiburr_Task_3/actions"
echo ""
echo "3. Configure secrets in repository settings if needed"
echo ""
echo "Happy coding! 🚀"
