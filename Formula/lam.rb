class Lam < Formula
  desc "Launch Agent Manager - Terminal UI for managing macOS LaunchAgent plist files"
  homepage "https://github.com/hollanddd/lam"
  url "https://github.com/hollanddd/lam/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "5bc94a58d35de0e7bf6800b70c89c38d55bd4021690c0802a8d4d703032e3560"
  license "MIT"
  head "https://github.com/hollanddd/lam.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Since this is a TUI app that requires macOS LaunchAgent directories,
    # we'll just test that the binary was installed and can show help/version
    assert_match "Launch Agent Manager", shell_output("#{bin}/lam --help 2>&1", 1)
  end

  def caveats
    <<~EOS
      LAM is designed specifically for macOS and requires access to LaunchAgent directories:
        - User: ~/Library/LaunchAgents
        - Global: /Library/LaunchAgents  
        - Apple: /System/Library/LaunchAgents

      Run with: lam

      Note: This application uses vim-style keybindings. Press 'q' to quit.
    EOS
  end
end
