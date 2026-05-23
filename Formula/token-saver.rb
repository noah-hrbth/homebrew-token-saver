class TokenSaver < Formula
  desc "Transparent CLI proxy that compresses verbose command output for LLM agents"
  homepage "https://github.com/noah-hrbth/token-saver"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-aarch64-apple-darwin.tar.gz"
      sha256 "94ba86f3cf8c7ecf28a3888e73d3ba38ac5b83f204a1c7a2d6cdd81491f61d85"
    end
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-apple-darwin.tar.gz"
      sha256 "1db68849934ac8fd77133dd1304efcdb05fc8ff0bb6a6455e3b26c6ab5630b37"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a78d9b63b60fbc767f4b320c4dcdcaa2c11fdb871a72968a1d816d6d6baa56ce"
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
    assert_match "token-saver #{version}", shell_output("#{bin}/token-saver version")
  end
end
