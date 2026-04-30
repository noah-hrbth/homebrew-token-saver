class TokenSaver < Formula
  desc "Transparent CLI proxy that compresses verbose command output for LLM agents"
  homepage "https://github.com/noah-hrbth/token-saver"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-aarch64-apple-darwin.tar.gz"
      sha256 "cce205ba7f32eb4d39902b6c8c18e52ab4d2f81350e6e1b2b6f47202208a947d"
    end
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-apple-darwin.tar.gz"
      sha256 "6ef7211a9b311cefea7894481a250732313fbc86c9fbb8d66026983ab819a5e8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c435fd2bf4832aff1eeca961db6b51bcaab734f01f31a9aac0f4ee089d13e089"
    end
  end

  def install
    bin.install "token-saver"
  end

  def caveats
    <<~EOS
      token-saver is installed, but the shell wrappers must be enabled
      per-shell. Add ONE of the following to your shell startup file:

        # zsh — use ~/.zshenv (NOT ~/.zshrc) so it loads in the
        # non-interactive subshells Claude Code spawns:
        eval "$(token-saver init zsh)"

        # bash — add to ~/.bashrc:
        eval "$(token-saver init bash)"

      Then enable compression in your AI tool. For Claude Code,
      add to ~/.claude/settings.json:

        "env": { "TOKEN_SAVER": "1" }

      The wrappers are guarded by TOKEN_SAVER=1, so they are a
      no-op in normal shells.
    EOS
  end

  test do
    assert_match "token-saver #{version}", shell_output("#{bin}/token-saver --version")
  end
end
