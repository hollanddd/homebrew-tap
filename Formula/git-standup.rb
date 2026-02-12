class GitStandup < Formula
  desc "Recall what you did on the last working day - or see what someone else did"
  homepage "https://github.com/hollanddd/git-standup-rs"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.1.0/git-standup-aarch64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    end
    on_intel do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.1.0/git-standup-x86_64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.1.0/git-standup-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end
    on_intel do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.1.0/git-standup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "git-standup"
  end

  test do
    assert_match "git-standup", shell_output("#{bin}/git-standup --version")
  end
end
