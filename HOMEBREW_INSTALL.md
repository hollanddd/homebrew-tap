# Homebrew Installation Guide for LAM (Based)

This guide explains how to create and publish a Homebrew formula for LAM (Launch Agent Manager).

## Formula File

The `lamb.rb` file contains the Homebrew formula. Key points:

### Before Publishing

1. **Create a release on GitHub** with a proper tag (e.g., `v0.1.1`)
2. **Calculate the SHA256** of the release tarball:
   ```bash
   curl -sL https://github.com/hollanddd/lam/archive/refs/tags/v0.1.1.tar.gz | sha256sum
   ```
3. **Update the SHA256** in `lamb.rb` by replacing `REPLACE_WITH_ACTUAL_SHA256`

## Publishing Options

### Option 1: Personal Tap (Recommended for initial distribution)

1. Create a new GitHub repository named `homebrew-tap`
2. Add the `lam.rb` formula to the repository
3. Users can install with:
   ```bash
   brew tap hollanddd/homebrew-tap
   brew install lamb
   ```

### Option 2: Submit to Homebrew Core

For wider distribution, submit a PR to [Homebrew/homebrew-core](https://github.com/Homebrew/homebrew-core):

1. Fork the homebrew-core repository
2. Add `lam.rb` to `Formula/l/` directory
3. Submit a pull request

**Requirements for core inclusion:**
- Stable project with regular releases
- Notable user base or uniqueness
- Follows Homebrew guidelines
- No GUI applications (TUI is acceptable)

## Formula Features

- **Platform-specific**: macOS only (appropriate for LaunchAgent manager)
- **Rust build dependency**: Automatically handles Rust toolchain
- **Custom test**: Verifies installation without requiring LaunchAgent directories
- **Helpful caveats**: Explains usage and requirements to users

## Testing the Formula

Before publishing:

```bash
# Test syntax
ruby -c lam.rb

# Test installation (when you have a valid release)
brew install --build-from-source ./lam.rb

# Test uninstallation
brew uninstall lam
```

## Usage After Installation

Once published, users can install LAM with:

```bash
# If using a personal tap
brew tap hollanddd/tap
brew install lam

# If accepted into Homebrew core
brew install lam

# Run the application
lam
```

## Notes

- The formula includes helpful caveats explaining that LAM is macOS-specific
- Users will see vim-style keybinding information
- The test verifies the binary exists and can display help (exit code 1 is expected for --help)
