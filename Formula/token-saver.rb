class TokenSaver < Formula
  desc "Transparent CLI proxy that compresses verbose command output for LLM agents"
  homepage "https://github.com/noah-hrbth/token-saver"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-aarch64-apple-darwin.tar.gz"
      sha256 "9cca0ef12fe209681be74a1aaf0fde783e0282fdda4a649620e09b3ea951b8d0"
    end
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-apple-darwin.tar.gz"
      sha256 "1444b1c2716b70ad0b5fd6d8e8577cfe554e847601ee6473aa8c5f7043cd0de1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/noah-hrbth/token-saver/releases/download/v#{version}/token-saver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ee80ec883c6b62a9128d09e727ba3a2e1090259bafc5158c0b16cef0e7e3ba88"
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
