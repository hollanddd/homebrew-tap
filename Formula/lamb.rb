class Lamb < Formula
  desc "Launch Agent Manager - Terminal UI for managing macOS LaunchAgent plist files"
  homepage "https://github.com/hollanddd/lam"
  url "https://github.com/hollanddd/lam/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "70d72d536ba3c31903e008e1cc194a288b070bb2b773caca510a1fb32fdc3cfb"
  license "MIT"
  head "https://github.com/hollanddd/lam.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    # Rename binary to avoid conflict with existing 'lam' command
    mv bin/"lam", bin/"lamb"
  end

  test do
    # Since this is a TUI app that requires macOS LaunchAgent directories,
    # we'll just test that the binary was installed and can show help/version
    assert_match "Launch Agent Manager", shell_output("#{bin}/lamb --help 2>&1", 1)
  end

  def caveats
    <<~EOS
      LAM is designed specifically for macOS and requires access to LaunchAgent directories:
        - User: ~/Library/LaunchAgents
        - Global: /Library/LaunchAgents  
        - Apple: /System/Library/LaunchAgents

      Run with: lamb

      Note: This application uses vim-style keybindings. Press 'q' to quit.
    EOS
  end
end
