class GitStandupRs < Formula
  desc "Recall what you did on the last working day - or see what someone else did"
  homepage "https://github.com/hollanddd/git-standup-rs"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.2.2/git-standup-aarch64-apple-darwin.tar.gz"
      sha256 "0e30373e630fa2fc8d318ca1cad831f8b01e4ca85a05abce162f95786f5fecd4"
    end
    on_intel do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.2.2/git-standup-x86_64-apple-darwin.tar.gz"
      sha256 "732ed3bd903e12206f642d22b379bddcdad6f1ff02d93f2ff3cad64deaae954b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.2.2/git-standup-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dc2862b841eadfc0dcb913611645f65a66c20ceddf59f5b259e46c2e5ee49168"
    end
    on_intel do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.2.2/git-standup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "47ab4511c9cf962e74d5003e4a6e2bf64a7efc23c7faf7ef964a590fca3906c4"
    end
  end

  def install
    bin.install "git-standup"
  end

  test do
    assert_match "git-standup", shell_output("#{bin}/git-standup --version")
  end
end
