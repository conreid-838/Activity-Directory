# Manual GitHub Release Guide for KidsList v1.0.0

This guide walks you through creating a GitHub release manually since automated workflows require additional permissions.

## 📋 Prerequisites

You already have:
- ✅ Git tag `v1.0.0` pushed to GitHub
- ✅ APK file: `/home/user/flutter_app/build/app/outputs/flutter-apk/app-release.apk` (46 MB)
- ✅ AAB file: `/home/user/flutter_app/build/app/outputs/bundle/release/app-release.aab` (40 MB)
- ✅ Release notes: `RELEASE_v1.0.0.md`

## 🚀 Step-by-Step Release Creation

### Step 1: Access Releases Page

1. Go to your repository:
   ```
   https://github.com/conreid-838/Activity-Directory
   ```

2. Click on **"Releases"** (right sidebar, under "About")

3. Click **"Draft a new release"** button

### Step 2: Configure Release

1. **Choose a tag:**
   - Click "Choose a tag" dropdown
   - Select: `v1.0.0` (already exists)
   - Or type: `v1.0.0` if not listed

2. **Release title:**
   ```
   KidsList v1.0.0
   ```

3. **Description:**
   - Copy the entire contents of `RELEASE_v1.0.0.md`
   - Paste into the description field
   - GitHub will render it as Markdown

### Step 3: Upload Build Artifacts

1. **Scroll to "Attach binaries" section**

2. **Rename your local files first:**
   ```bash
   cp build/app/outputs/flutter-apk/app-release.apk kidslist-v1.0.0.apk
   cp build/app/outputs/bundle/release/app-release.aab kidslist-v1.0.0.aab
   ```

3. **Upload files:**
   - Click "Attach binaries by dropping them here or selecting them"
   - Upload: `kidslist-v1.0.0.apk` (46 MB)
   - Upload: `kidslist-v1.0.0.aab` (40 MB)

4. **Wait for upload to complete** (progress bar will show)

### Step 4: Configure Release Options

1. **Target branch:**
   - Select: `main` (should be pre-selected)

2. **Release options:**
   - ☐ Set as a pre-release (leave unchecked)
   - ☐ Set as the latest release (check this ✅)
   - ☐ Create a discussion for this release (optional)

### Step 5: Publish Release

1. **Review everything one last time:**
   - Tag: `v1.0.0`
   - Title: `KidsList v1.0.0`
   - Description: Complete release notes
   - Attachments: APK and AAB files

2. **Click "Publish release"**

3. **Confirmation:**
   - You'll be redirected to the release page
   - Files will be available for download immediately

---

## 📦 Download Links (After Publishing)

After publishing, your release will be available at:
```
https://github.com/conreid-838/Activity-Directory/releases/tag/v1.0.0
```

Download links will be:
```
https://github.com/conreid-838/Activity-Directory/releases/download/v1.0.0/kidslist-v1.0.0.apk
https://github.com/conreid-838/Activity-Directory/releases/download/v1.0.0/kidslist-v1.0.0.aab
```

---

## ✅ Verification Checklist

After publishing, verify:
- [ ] Release appears on main repository page
- [ ] Tag `v1.0.0` is linked to the release
- [ ] APK file is downloadable
- [ ] AAB file is downloadable
- [ ] Release notes are properly formatted
- [ ] Release is marked as "Latest"

---

## 📱 Sharing Your Release

Once published, you can share:

**Direct APK Download:**
```
https://github.com/conreid-838/Activity-Directory/releases/latest/download/kidslist-v1.0.0.apk
```

**Release Page:**
```
https://github.com/conreid-838/Activity-Directory/releases/latest
```

**Social Media Template:**
```
🎉 KidsList v1.0.0 is here!

Find camps, classes, childcare & activities for your kids across 12 major U.S. metros.

✨ Features:
- 10,000+ activities
- Advanced filtering
- Diversity-focused
- 100% free to search

📱 Download: https://github.com/conreid-838/Activity-Directory/releases/latest

#KidsList #Parenting #ChildActivities
```

---

## 🔄 Future Releases

### Automated Workflow (After Permission Fix)

Once GitHub Actions permissions are granted, future releases will be automatic:

```bash
# Create and push a new tag
git tag -a v1.0.1 -m "KidsList v1.0.1 - Bug fixes"
git push origin v1.0.1

# GitHub Actions will automatically:
# 1. Build APK and AAB
# 2. Build Web version
# 3. Create GitHub Release
# 4. Upload all artifacts
# 5. Generate release notes
```

### Manual Release (Current Method)

For now, follow this guide for each release:
1. Create and push tag
2. Build APK and AAB locally
3. Create release manually on GitHub
4. Upload artifacts
5. Publish

---

## 🆘 Troubleshooting

**Issue:** Can't find the "Releases" section

**Solution:** Make sure you're on the main repository page, look in the right sidebar under "About"

---

**Issue:** Upload fails or times out

**Solution:** Try uploading files one at a time, or check your internet connection

---

**Issue:** Release not showing as "Latest"

**Solution:** Edit the release and check the "Set as the latest release" option

---

## 📧 Need Help?

If you encounter issues during the release process:
1. Check GitHub's [release documentation](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository)
2. Create an issue: https://github.com/conreid-838/Activity-Directory/issues

---

**Last Updated:** 2024-12-10  
**For:** KidsList v1.0.0  
**Status:** Ready for manual release creation
