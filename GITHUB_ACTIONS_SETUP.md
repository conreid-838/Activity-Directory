# GitHub Actions Setup Guide

⚠️ **Permission Issue Detected**: The GitHub App currently doesn't have `workflows` permission.

## 🔧 Fix Required

To enable GitHub Actions workflows, you need to grant the necessary permissions:

### Option 1: Via GitHub Web Interface (Recommended)

1. **Go to Repository Settings:**
   ```
   https://github.com/conreid-838/Activity-Directory/settings
   ```

2. **Navigate to Actions:**
   - Click on **"Actions"** → **"General"** in the left sidebar

3. **Enable Actions:**
   - Under "Actions permissions", select:
     - ✅ **"Allow all actions and reusable workflows"**
   
4. **Grant Workflow Permissions:**
   - Scroll to "Workflow permissions"
   - Select: ✅ **"Read and write permissions"**
   - Check: ✅ **"Allow GitHub Actions to create and approve pull requests"**

5. **Save Changes**

### Option 2: Manual Workflow Upload

Since the GitHub App lacks workflow permissions, you can manually upload the workflows:

1. **Go to your repository:**
   ```
   https://github.com/conreid-838/Activity-Directory
   ```

2. **Create `.github/workflows/` directory:**
   - Click **"Add file"** → **"Create new file"**
   - In the filename field, type: `.github/workflows/build-and-release.yml`
   - This creates the directory structure

3. **Copy workflow files:**
   - Copy contents from the local files to GitHub web editor
   - Files to upload:
     - `.github/workflows/build-and-release.yml`
     - `.github/workflows/ci.yml`
     - `.github/SECRETS_SETUP.md`

---

## 📋 Workflow Files Ready to Upload

The following workflow files have been created locally and are ready to be manually uploaded:

### 1. Build and Release Workflow
**File:** `.github/workflows/build-and-release.yml`
**Purpose:** Automated builds and releases on version tags
**Triggers:** When you push a tag like `v1.0.0`

### 2. Continuous Integration Workflow
**File:** `.github/workflows/ci.yml`
**Purpose:** Automated testing and quality checks
**Triggers:** On every push and pull request

### 3. Secrets Setup Documentation
**File:** `.github/SECRETS_SETUP.md`
**Purpose:** Guide for setting up GitHub Secrets for Android signing

---

## 🚀 Quick Start (After Permission Fix)

Once permissions are granted, push the workflows:

```bash
cd /home/user/flutter_app
git push origin main
```

This will upload:
- GitHub Actions workflows
- CHANGELOG.md
- Secret generation script
- Updated .gitignore

---

## 🔐 Setting Up Secrets

After workflows are uploaded, set up the required secrets:

1. **Run the secret generator:**
   ```bash
   ./generate_github_secrets.sh
   ```

2. **Go to GitHub Secrets settings:**
   ```
   https://github.com/conreid-838/Activity-Directory/settings/secrets/actions
   ```

3. **Add two secrets:**
   - `KEYSTORE_BASE64` (from `.github-secrets/KEYSTORE_BASE64.txt`)
   - `KEY_PROPERTIES` (from `.github-secrets/KEY_PROPERTIES.txt`)

4. **Detailed instructions:** See `.github/SECRETS_SETUP.md`

---

## ✅ Testing the Workflow

After setup is complete, test the release workflow:

```bash
# Create a test tag
git tag -a v1.0.1-test -m "Test automated build"
git push origin v1.0.1-test

# Watch the workflow run
# https://github.com/conreid-838/Activity-Directory/actions
```

---

## 📚 Workflow Features

### Build and Release Workflow
- ✅ Builds Android APK (Direct Install)
- ✅ Builds Android AAB (Play Store)
- ✅ Builds Web Application
- ✅ Creates GitHub Release automatically
- ✅ Uploads all build artifacts
- ✅ Generates comprehensive release notes

### CI Workflow
- ✅ Flutter analyze (code quality)
- ✅ Dart format check (code style)
- ✅ Unit tests with coverage
- ✅ Android build verification
- ✅ Web build verification

---

## 🆘 Need Help?

If you encounter issues:

1. **Check Actions Tab:**
   ```
   https://github.com/conreid-838/Activity-Directory/actions
   ```

2. **Review Workflow Logs:**
   - Click on failed workflow run
   - Expand failed job to see error details

3. **Common Issues:**
   - Missing secrets → Follow SECRETS_SETUP.md
   - Build failures → Check Flutter/Android SDK versions
   - Permission errors → Verify Actions permissions in settings

---

**Status:** Workflows ready, pending permission grant  
**Next Step:** Enable Actions permissions in repository settings
