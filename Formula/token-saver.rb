class TokenSaver < Formula
  desc "Transparent CLI proxy that compresses verbose command output for LLM agents"
  homepage "https://github.com/noah-hrbth/token-saver"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-aarch64-apple-darwin.tar.gz"
      sha256 "aa8606cd0365e9ac75e828642cc3a11faab90c09bc5251c7c09fe88d2ab32d1e"
    end
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-apple-darwin.tar.gz"
      sha256 "a802d0b0d578ee51d1fb9a879e32623cda81961c80840c704e549544ae466b22"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4fae558cab325ef93dffa185b2e4e98ddc1f00ab30fb3003020cb284a20e028d"
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
